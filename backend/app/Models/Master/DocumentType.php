<?php

namespace App\Models\Master;

use Illuminate\Database\Eloquent\Model;

class DocumentType extends Model
{
    protected $table = 'master.document_types';


    protected $fillable = [
        'code',
        'name',
        'description',
        'allowed_extensions',
        'max_file_size',
        'is_required',
        'sort_order',
        'is_active',
    ];


    protected function casts(): array
    {
        return [
            'is_required' => 'boolean',
            'is_active' => 'boolean',
            'max_file_size' => 'integer',
        ];
    }
}