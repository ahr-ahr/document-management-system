<?php

namespace App\Services\Database;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class SqlExecutor
{
    /**
     * Execute SQL file.
     */
    public function execute(string $file): void
    {
        $sql = File::get($file);

        DB::unprepared($sql);
    }
}