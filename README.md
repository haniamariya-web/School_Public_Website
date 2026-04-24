School Public Website

A public-facing website for a school franchise with an integrated admin panel for managing content, announcements, and other dynamic features. Built with Ruby on Rails, containerized with Docker, and designed for scalability and maintainability.

🚀 Features

Public website for showcasing school information, events, and announcements.

Admin dashboard for managing:

Content (pages, posts, announcements)

Media and assets

User roles and permissions

Responsive design for accessibility across devices.

Modular architecture with clear separation of concerns.

🛠️ Tech Stack

Backend: Ruby on Rails

Frontend: HTML, SCSS, JavaScript

Database: PostgreSQL

Containerization: Docker

Deployment: Procfile for Heroku/Dev environments

⚙️ Setup Instructions

1. Clone the Repository

git clone https://github.com/haniamariya-web/School_Public_Website.git
cd School_Public_Website

2. Install Dependencies

Ensure you have Ruby (version in .ruby-version) and Bundler installed.

bundle install

3. Database Setup

This project uses PostgreSQL.

Create the database:

rails db:create

Run migrations:

rails db:migrate

(Optional) Seed initial data:

rails db:seed

4. Run the Application

rails server

Visit http://localhost:3000 in your browser.

5. Docker Setup (Alternative)

If you prefer Docker:

docker build -t school_public_website .
docker-compose up

📄 Pages Flow & Navigation

Public Side

Home Page → Overview of the school franchise, mission, and highlights.

About Us → School history, vision, and staff.

Announcements → Latest updates and notices.

Events → Upcoming and past events.

Contact Page → Inquiry form and contact details.

Admin Side

Dashboard → Quick stats and overview.

Manage Announcements → Create, edit, delete announcements.

Manage Events → Add and update school events.

Content Management → Edit static pages (About, Contact, etc.).

User Management → Assign roles and permissions.

🏗️ Architectural Decisions

MVC Pattern (Rails): Clear separation of models, views, and controllers for maintainability.

Dockerized Environment: Ensures consistent setup across development and production.

Procfile.dev: Supports easy local development with multiple processes.

Database-first Design: PostgreSQL chosen for reliability and scalability.

Admin vs Public Separation: Distinct namespaces/routes for admin and public-facing pages.

Asset Pipeline: Rails pipeline used for managing SCSS, JS, and images.

✅ Testing

Run the test suite:

rails test

📦 Deployment

Designed for Heroku or similar platforms.

Use Procfile.dev for local multi-process development.

Dockerfile included for containerized deployment.

👩‍💻 Contributors

Maintained by haniamariya-web.