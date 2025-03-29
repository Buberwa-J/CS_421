<?php

use App\Models\Student;
use App\Models\Subject;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('api/students', function () {
    return response()->json(Student::all());
});

Route::get('api/subjects', function () {
    return response()->json(Subject::all()->groupBy('year'));
});
