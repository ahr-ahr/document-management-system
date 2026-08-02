<?php

namespace App\Services\Database;

use Illuminate\Support\Facades\File;

class SqlExecutor
{
    /**
     * Read SQL file contents.
     */
    public function execute(string $file): string
    {
        return File::get($file);
    }
}