# StudentSubjectsAPI by Buberwa Jesse 🙂

A simple **Laravel** API that returns student details and subjects for a Software Engineering course.

This API allows you to retrieve data on students enrolled in the Software Engineering program and the subjects they are enrolled in together with their academic years.

## Features
- Fetch a list of students.
- Fetch subjects grouped by their academic year (Year 1, Year 2, Year 3, Year 4).
- Easily extendable to include other student details or subject data in the future.

## Endpoints

### `GET /api/students`
- Returns a list of students enrolled in the Software Engineering program.
- Example response:
```json
[
    {
        "id": 1,
        "name": "John Doe",
        "program": "Software Engineering",
        "created_at": "2025-03-01T12:00:00Z",
        "updated_at": "2025-03-01T12:00:00Z"
    },
    ...
]
```

### `GET /api/subjects`
- Returns subjects grouped by academic year for Software Engineering students.
- Example response:
```json
{
    "year_1": [
        {
            "id": 1,
            "name": "Principles of Programming Languages(CP 111)",
            "year": 1
        },
        ...
    ],
    "year_2": [
        {
            "id": 16,
            "name": "Computer Networking Protocols(CN 211)",
            "year": 2
        },
        ...
    ]
}
```

---


## Setup

### Prerequisites

1. **PHP** - Ensure that PHP (>= 7.3) is installed on your system.
2. **Composer** - You need **Composer** to manage your PHP dependencies. If Composer is not installed, follow the installation guide at: [Install Composer](https://getcomposer.org/download/).
3. **MySQL** - This project uses MySQL as the database. Install MySQL if you don't have it already.

### 1. Clone the Repository

Clone the project to your local machine using Git:

```bash
git clone https://github.com/yourusername/StudentSubjectsAPI.git
cd StudentSubjectsAPI
```

### 2. Install PHP Dependencies

Run the following command to install all the necessary dependencies using Composer:

```bash
composer install
```

### 3. Configure Environment File

Copy the `.env.example` file to `.env`:

```bash
cp .env.example .env
```

Then open the `.env` file in your text editor and update the database settings with your MySQL credentials:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=student_subjects
DB_USERNAME=root
DB_PASSWORD=your_password
```

Make sure the database you specify (`student_subjects_db`) exists in MySQL.

### 4. Generate Application Key

Laravel requires an application key for encryption. Run the following command to generate it:

```bash
php artisan key:generate
```

This will generate a new `APP_KEY` in your `.env` file.

### 5. Run Migrations

To create the required database tables (`students`, `subjects`, and any pivot tables), run the migrations with:

```bash
php artisan migrate
```

### 6. Seed the Database

To generate fake data for students and subjects, run the seeder commands:

```bash
php artisan db:seed
```

This will populate your database with 100 fake students and the list of subjects for the Software Engineering program.

### 7. Run the Development Server

Now, start the Laravel development server:

```bash
php artisan serve
```

This will start the server at `http://127.0.0.1:8000`.

---

## Testing the API

Once the server is up and running, you can test the endpoints.

- To get a list of students:
  - Open your browser or use a tool like **Postman** or **cURL** and send a `GET` request to `http://127.0.0.1:8000/api/students`.

- To get the subjects grouped by academic year:
  - Send a `GET` request to `http://127.0.0.1:8000/api/subjects`.

Example cURL request:

```bash
curl http://127.0.0.1:8000/api/students
```

## Common Commands

### Start Laravel Development Server

```bash
php artisan serve
```

### Run Migrations

```bash
php artisan migrate
```

### Seed the Database

```bash
php artisan db:seed
```

### Rollback Migrations

If you need to rollback migrations:

```bash
php artisan migrate:rollback
```

### Create New Model & Migration

For example, to create a new `Course` model and its migration:

```bash
php artisan make:model Course -m
```

### View Laravel Logs

If you encounter any issues, you can check the application logs for errors:

```bash
tail -f storage/logs/laravel.log
```

---

### docker_setup:
prerequisites:
- Docker installed: https://docs.docker.com/get-docker/
- Docker Compose installed: https://docs.docker.com/compose/install/

### Steps:
Build and start containers
```bash
docker-compose up -d --build
```
Install PHP dependencies inside the app container
```bash
docker exec -it student-subjects-api-app composer install
```
Copy the environment file
```bash
cp .env.example .env"
```
Generate application key
```bash
docker exec -it student-subjects-api-app php artisan key:generate
```
Run database migrations
```bash
docker exec -it student-subjects-api-app php artisan migrate
```
Seed the database
```bash
docker exec -it student-subjects-api-app php artisan db:seed
```
Access API
url: "http://localhost/api/students and http://localhost/api/subjects"

### bash_scripts:
"bash_scripts/"
```bash
chmod +x bash_scripts/*.sh"
```

### Scripts:
"update.sh"
Updates Ubuntu server and packages
```bash
bash bash_scripts/update.sh
```

"backup.sh"
Backs up the MySQL database with timestamp
```bash
bash bash_scripts/backup.sh
```

"health_check.sh"
Checks CPU, Memory, and Disk usage
```bash
bash bash_scripts/health_check.sh
```

notes:
- Make sure scripts are executable.
- Edit 'backup.sh' if your database credentials differ from the .env file.
- Using Docker and Bash scripts makes deployment much cleaner and professional.
- Scripts can be connected to cron jobs for automation if hosting on servers like AWS.


## Conclusion

This API allows you to manage and fetch student and subject data for the Software Engineering program. It is built on Laravel, which provides a powerful framework for building modern, scalable web applications. The setup process is simple, and the provided endpoints will help you get started with working with students and subjects.

Enjoy retrieving student names and the available courses. I hope you build something useful 😅😅😅
