<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class ChatController extends Controller
{
    public function ask(Request $request)
    {
        $request->validate(['message' => 'required|string']);

        $response = Http::post('http://python-api:8000/chat', [
            'message' => $request->message
        ]);

        return $response->json();
    }
}
