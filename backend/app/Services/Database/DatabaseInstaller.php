<?php

namespace App\Services\Database;

class DatabaseInstaller
{
    public function __construct(
        protected SqlScanner $scanner,
    ) {
    }

    public function initialize(): void
    {
        $files = $this->scanner->scan();

        dump($files);
    }
}