<?php

namespace App\Models\Master;

use Illuminate\Database\Eloquent\Model;

class DocumentStatus extends Model
{
    protected $table = 'master.master_document_statuses';


    protected $fillable = [
        'code',
        'name',
        'description',
        'color',
        'sort_order',
        'is_active',
    ];


    protected function casts(): array
    {
        return [
            'is_active' => 'boolean',
        ];
    }
}