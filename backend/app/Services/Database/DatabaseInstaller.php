<?php

namespace App\Services\Database;

use Illuminate\Console\Command;

class DatabaseInstaller
{
    public function __construct(
        protected SqlScanner $scanner,
        protected SqlExecutor $executor,
    ) {
    }

    public function initialize(Command $command): void
    {
        $files = $this->scanner->scan();

        $databasePath = base_path('../database/');

        foreach ($files as $file) {
            $relativePath = str_replace($databasePath, '', $file);

            $command->line("Executing: {$relativePath}");

            $this->executor->execute($file);
        }
    }
}