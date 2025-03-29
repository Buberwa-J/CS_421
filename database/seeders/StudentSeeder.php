<?php

namespace Database\Seeders;

use App\Models\Student;
use Illuminate\Database\Seeder;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Faker\Factory as Faker;

class StudentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        $faker = Faker::create();

        $students = [];
        for ($i = 0; $i < 100; $i++) {
            $students[] = [
                'name' => $faker->firstName . ' ' . $faker->lastName,
                'program' => 'Software Engineering',
                'created_at' => now(),
                'updated_at' => now(),
            ];
        }

        Student::insert($students);
    }
}
