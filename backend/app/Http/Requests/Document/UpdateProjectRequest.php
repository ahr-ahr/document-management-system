<?php

namespace App\Http\Requests\Document;

use Illuminate\Foundation\Http\FormRequest;

class UpdateProjectRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }


    public function rules(): array
    {
        return [
            'project_name' => [
                'sometimes',
                'string',
                'max:255',
            ],

            'description' => [
                'sometimes',
                'nullable',
                'string',
            ],
        ];
    }


    public function messages(): array
    {
        return [
            'project_name.string' => 'Project name must be a string.',
            'project_name.max' => 'Project name must not exceed 255 characters.',

            'description.string' => 'Description must be a string.',
        ];
    }
}