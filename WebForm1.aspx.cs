using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http;
using System.Text.Json;
using System.Net.Http.Headers;

namespace SEM
{
    public partial class WebForm1 : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                ddlCourse1.DataSource = GetCourses();
                ddlCourse1.DataTextField = "CourseName";
                ddlCourse1.DataValueField = "CourseID";
                ddlCourse1.DataBind();

                ddlCourse2.DataSource = GetCourses();
                ddlCourse2.DataTextField = "CourseName";
                ddlCourse2.DataValueField = "CourseID";
                ddlCourse2.DataBind();

            }
        }

        private DataTable GetCourses()
        {
            // This method should return a DataTable or other data source with course details
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT CourseID, CourseName FROM Courses";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    return dt;
                }
            }
        }

        protected void btnCompare_Click(object sender, EventArgs e)
        {
            string courseId1 = ddlCourse1.SelectedValue;
            string courseId2 = ddlCourse2.SelectedValue;

            if (!string.IsNullOrEmpty(courseId1) && !string.IsNullOrEmpty(courseId2))
            {
                DisplayCourseDetails(courseId1, "course1-details", litCourse1Details);
                DisplayCourseDetails(courseId2, "course2-details", litCourse2Details);
            }
        }

        private void DisplayCourseDetails(string courseId, string panelId, Literal literal)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "SELECT * FROM Courses WHERE courseID = @courseID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@courseID", courseId);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string courseDetails = $"<h3 class='text-2xl font-semibold'>{reader["courseName"]}</h3>" +
                                           $"<p>Requirement: {reader["AdmissionRequirement"]}</p>" +
                                           $"<p>Duration: {reader["duration"]}</p>" +
                                           $"<p>Price: RM{reader["price"]}</p>";
                    literal.Text = courseDetails;
                }
                else
                {
                    literal.Text = "<p>No details available.</p>";
                }
            }
        }

        private async Task<string> CreateSendbirdChannelAsync()
        {
            string appId = "E1E0C9B1-33F4-44C1-816D-E584FA7282DF"; // Your Sendbird App ID
            string apiToken = "cb4cd49ec94ede4687b8bc58358fb3ee9ad3eec7"; // Your Sendbird API Token

            string url = $"https://api-{appId}.sendbird.com/v3/group_channels";

            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", apiToken);
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                var channelData = new
                {
                    name = "Sample Channel",
                    user_ids = new string[] { "user1", "user2" } // Add valid user IDs
                };

                string jsonContent = JsonSerializer.Serialize(channelData);
                StringContent content = new StringContent(jsonContent, Encoding.UTF8, "application/json");

                try
                {
                    HttpResponseMessage response = await client.PostAsync(url, content);

                    if (response.IsSuccessStatusCode)
                    {
                        string result = await response.Content.ReadAsStringAsync();
                        var responseObject = JsonSerializer.Deserialize<JsonElement>(result);
                        string channelUrl = responseObject.GetProperty("channel_url").GetString();
                        return channelUrl;
                    }
                    else
                    {
                        string error = await response.Content.ReadAsStringAsync();
                        throw new Exception($"Error creating channel: {error}");
                    }
                }
                catch (Exception ex)
                {
                    // Log or handle exception
                    throw new Exception($"Exception occurred: {ex.Message}", ex);
                }
            }
        }
    }
}
