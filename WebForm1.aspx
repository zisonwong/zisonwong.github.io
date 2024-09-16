<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SEM.WebForm1" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advanced UI - Course & Appointment System</title>
    <!-- Tailwind CSS v2.2.19 -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        body {
            background: linear-gradient(to right, #f3f4f6, #e5e7eb);
            font-family: 'Inter', sans-serif;
        }

        .hero-bg {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
        }

        .course-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        }

        .sticky-button {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #039BE5;
            color: white;
            padding: 14px 24px;
            border-radius: 50px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            z-index: 1000;
            transition: all 0.3s ease;
        }

            .sticky-button:hover {
                background-color: #026ba1;
            }

        #chatbot-button {
            bottom: 1rem;
            right: 1rem;
        }

        #chatbot-modal {
            bottom: 4rem;
            right: 1rem;
            max-width: 80vw;
            max-height: 80vh;
            overflow: hidden;
            transition: transform 0.3s ease, opacity 0.3s ease;
        }

            #chatbot-modal.show {
                transform: scale(1);
                opacity: 1;
            }

            #chatbot-modal.hidden {
                transform: scale(0.9);
                opacity: 0;
            }

        #close-chatbot {
            background: transparent;
            border: none;
            cursor: pointer;
        }

        .fade-in {
            animation: fadeIn 1s ease-in;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        .dashboard-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 16px;
        }

            .dashboard-card h3 {
                margin-bottom: 8px;
            }
    </style>
</head>
<body>
    <!-- Main Form -->
    <form id="form1" runat="server">
        <header class="hero-bg py-8">
            <div class="container mx-auto p-6 flex flex-col md:flex-row justify-between items-center">
                <h1 class="text-3xl lg:text-5xl font-bold mb-4 md:mb-0 text-white fade-in">Faculty of Computing & Information Technology</h1>
                <nav>
                    <ul class="flex flex-col md:flex-row space-y-2 md:space-y-0 md:space-x-6 text-lg">
                        <li><a href="#about" class="text-white hover:underline">About</a></li>
                        <li><a href="#courses" class="text-white hover:underline">Courses</a></li>
                        <li><a href="#contact" class="text-white hover:underline">Contact</a></li>
                        <li><a href="#appointment" class="text-white hover:underline">Appointment</a></li>
                    </ul>
                </nav>
            </div>
        </header>

        <main class="container mx-auto py-12 px-6">
            <!-- About Us Section -->
            <section id="about" class="bg-gray-100 py-16 px-6">
                <div class="container mx-auto max-w-7xl">
                    <!-- Title -->
                    <h2 class="text-4xl font-extrabold text-gray-900 mb-12 text-center">About Us</h2>

                    <!-- Content -->
                    <div class="flex flex-col md:flex-row gap-12 items-center justify-between">
                        <!-- Left Column -->
                        <div class="flex-1 bg-white rounded-xl shadow-2xl p-8 md:p-12 transform transition-transform duration-300 hover:scale-105 hover:shadow-3xl">
                            <h3 class="text-3xl font-bold text-gray-800 mb-6">Welcome to FOCS</h3>
                            <p class="text-lg leading-relaxed text-gray-700 mb-6">
                                At the Faculty of Computing & Information Technology, we offer cutting-edge programs designed to prepare students for success in the tech industry. Our cutting-edge curriculum and dedicated faculty provide a rich educational experience.
                            </p>
                            <a href="#contact" class="inline-block bg-blue-600 text-white py-3 px-6 rounded-lg shadow-md hover:bg-blue-700 transition duration-300 transform hover:scale-105">Contact Us</a>
                        </div>

                        <!-- Right Column -->
                        <div class="flex-1 flex flex-col gap-8">
                            <!-- Vision Card -->
                            <div class="bg-white rounded-xl shadow-2xl p-8 transform transition-transform duration-300 hover:scale-105 hover:shadow-3xl">
                                <h3 class="text-2xl font-semibold text-blue-800 mb-4">Our Vision</h3>
                                <p class="text-base leading-relaxed text-gray-600">
                                    Our vision is to lead in computing education by inspiring innovation and equipping students with the knowledge and skills necessary to excel in a rapidly evolving tech landscape.
                                </p>
                            </div>

                            <!-- Mission Card -->
                            <div class="bg-white rounded-xl shadow-2xl p-8 transform transition-transform duration-300 hover:scale-105 hover:shadow-3xl">
                                <h3 class="text-2xl font-semibold text-green-800 mb-4">Our Mission</h3>
                                <p class="text-base leading-relaxed text-gray-600">
                                    Our mission is to deliver exceptional education, foster groundbreaking research, and build robust industry partnerships to address technological challenges and advance knowledge.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>


            <!-- Compare Courses Section -->
            <section id="compare-section" class="py-16 bg-gray-50">
                <div class="container mx-auto px-6">
                    <!-- Title -->
                    <h2 class="text-4xl font-extrabold text-gray-900 mb-12 text-center">Compare Courses</h2>

                    <!-- Course Selection Dropdowns -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-8">
                        <div class="space-y-4">
                            <label for="course1" class="block text-lg font-medium text-gray-800">Select Course 1:</label>
                            <asp:DropDownList ID="ddlCourse1" runat="server" CssClass="border border-gray-300 p-3 rounded-lg w-full shadow-sm focus:ring-2 focus:ring-blue-500 transition duration-300 ease-in-out" />
                        </div>
                        <div class="space-y-4">
                            <label for="course2" class="block text-lg font-medium text-gray-800">Select Course 2:</label>
                            <asp:DropDownList ID="ddlCourse2" runat="server" CssClass="border border-gray-300 p-3 rounded-lg w-full shadow-sm focus:ring-2 focus:ring-blue-500 transition duration-300 ease-in-out" />
                        </div>
                    </div>

                    <!-- Comparison Display -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                        <div id="course1-details" class="p-8 border border-gray-300 rounded-lg bg-white shadow-lg hover:shadow-xl transition-shadow duration-300">
                            <h3 class="text-2xl font-semibold text-gray-900 mb-4">Course 1</h3>
                            <asp:Literal ID="litCourse1Details" runat="server" />
                        </div>
                        <div id="course2-details" class="p-8 border border-gray-300 rounded-lg bg-white shadow-lg hover:shadow-xl transition-shadow duration-300">
                            <h3 class="text-2xl font-semibold text-gray-900 mb-4">Course 2</h3>
                            <asp:Literal ID="litCourse2Details" runat="server" />
                        </div>
                    </div>

                    <!-- Compare Button -->
                    <div class="flex justify-center mt-8">
                        <asp:Button ID="btnCompare" runat="server" Text="Compare" CssClass="bg-blue-500 text-white py-3 px-6 rounded-lg shadow-md hover:bg-blue-600 hover:shadow-lg transition duration-300 ease-in-out" OnClick="btnCompare_Click" />
                    </div>
                </div>
            </section>

            <!-- Booking Appointment Section -->
            <section id="appointment" class="mb-12 py-16 bg-gray-100">
                <div class="container mx-auto px-6">
                    <!-- Title -->
                    <h2 class="text-4xl font-extrabold mb-6 text-gray-900 text-center">Book an Appointment</h2>

                    <!-- Description -->
                    <p class="text-lg text-gray-700 mb-8 text-center">
                        Schedule a meeting with one of our advisors to discuss your academic goals. Click the button below to select a suitable time from our calendar.
                    </p>

                    <!-- Booking Card -->
                    <div class="flex justify-center">
                        <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md border border-gray-200">
                            <div class="text-center mb-8">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-16 h-16 text-blue-600 mx-auto" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M16 3h5a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-5m-7 0H6a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h3m7 0v18m-7 0v-6"></path>
                                </svg>
                                <h3 class="text-2xl font-semibold mt-4 text-gray-800">Schedule Your Meeting</h3>
                            </div>

                            <!-- Google Calendar Booking Button -->
                            <div class="text-center">
                                <a href="https://calendar.google.com/calendar/appointments/schedules/AcZssZ2C1dbwHt-EUX75g0GnBqVqmBEDs8f9es8QSiKPorEtlggEgaSXrEsaa8up1KBOLSM9Z02gO1uD?gv=true"
                                    target="_blank"
                                    class="bg-blue-500 text-white py-3 px-6 rounded-lg shadow-md hover:bg-blue-600 transition duration-300">Book Now
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Contact Section -->
            <section id="contact" class="mb-12 py-16 bg-gray-100">
                <div class="container mx-auto px-6">
                    <!-- Title -->
                    <h2 class="text-4xl font-extrabold mb-6 text-gray-900 text-center">Contact Us</h2>

                    <!-- Description -->
                    <p class="text-lg text-gray-700 mb-6 text-center">
                        Have any questions? Feel free to reach out to us through the contact details below or drop us a message.
                    </p>

                    <!-- Contact Cards -->
                    <div class="flex flex-col md:flex-row justify-center items-center gap-8">
                        <!-- Email Card -->
                        <div class="bg-white p-6 rounded-lg shadow-lg border border-gray-200 max-w-sm mx-auto text-center">
                            <div class="mb-4">
                                <div class="inline-flex items-center justify-center w-16 h-16 bg-blue-100 text-blue-600 rounded-full">
                                    <span class="text-3xl font-bold">@</span>
                                </div>
                            </div>
                            <h3 class="text-xl font-semibold text-gray-800 mb-2">Email Us</h3>
                            <p class="text-gray-600 mb-4">
                                For any inquiries, please email us at:
                    <a href="mailto:info@focs.edu" class="text-blue-600 hover:underline">info@focs.edu</a>
                            </p>
                        </div>

                        <!-- Phone Card -->
                        <div class="bg-white p-6 rounded-lg shadow-lg border border-gray-200 max-w-sm mx-auto text-center">
                            <div class="mb-4">
                                <div class="inline-flex items-center justify-center w-16 h-16 bg-yellow-100 text-yellow-600 rounded-full">
                                    <span class="text-3xl font-bold">📞</span>
                                </div>
                            </div>
                            <h3 class="text-xl font-semibold text-gray-800 mb-2">Call Us</h3>
                            <p class="text-gray-600">
                                Reach us by phone at:
                    <a href="tel:+60312345678" class="text-blue-600 hover:underline">+60 3-1234 5678</a>
                            </p>
                        </div>
                    </div>
                </div>
            </section>


        </main>


        <!-- Chatbot Sticky Button -->
        <div id="chatbot-button" class="fixed bottom-4 right-4 bg-blue-500 text-white p-3 rounded-full shadow-lg cursor-pointer flex items-center justify-center z-50">
            <span class="text-sm font-medium">Chat With Us</span>
        </div>

        <!-- Chatbot Modal -->
        <div id="chatbot-modal" class="fixed bottom-16 right-4 bg-white rounded-lg shadow-lg w-80 h-full max-h-96 overflow-hidden z-50">

            <!-- Chatbot iframe -->
            <iframe
                src="https://aichatbot.sendbird.com/playground/index.html?app_id=E1E0C9B1-33F4-44C1-816D-E584FA7282DF&bot_id=onboarding_bot&region=ap-5"
                width="100%"
                style="height: 100%; min-height: 400px; overflow-y: scroll;"
                frameborder="0"></iframe>
        </div>




        <!-- Footer -->
        <footer class="hero-bg text-center text-white py-6 mt-12">
            <p>&copy; 2024 Faculty of Computing & Information Technology. All rights reserved.</p>
        </footer>


        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const chatbotButton = document.getElementById('chatbot-button');
                const chatbotModal = document.getElementById('chatbot-modal');
                const closeChatbot = document.getElementById('close-chatbot');

                // Toggle chat modal visibility
                chatbotButton.addEventListener('click', function () {
                    chatbotModal.classList.toggle('hidden');
                    chatbotModal.classList.toggle('show');
                });

                // Close the chat modal when clicking the close button
                closeChatbot.addEventListener('click', function () {
                    chatbotModal.classList.add('hidden');
                    chatbotModal.classList.remove('show');
                });

                // Close the chat modal when clicking outside of it
                window.addEventListener('click', function (event) {
                    if (event.target === chatbotModal) {
                        chatbotModal.classList.add('hidden');
                        chatbotModal.classList.remove('show');
                    }
                });
            });

            $('#compareButton').click(function (event) {
                event.preventDefault();
            });
        </script>



    </form>
</body>
</html>
