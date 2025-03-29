<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\Student;
use App\Models\Subject;

Route::get('/students', function () {
    return response()->json(Student::all());
});

Route::get('/subjects', function () {
    return response()->json(Subject::all()->groupBy('year'));
});
