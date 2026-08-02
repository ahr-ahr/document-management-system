<?php

namespace App\Services\Database;

class DatabaseInstaller
{
    public function __construct(
        protected SqlScanner $scanner,
        protected SqlExecutor $executor,
    ) {
    }

    public function initialize(): void
    {
        $files = $this->scanner->scan();

        foreach ($files as $file) {
            $sql = $this->executor->execute($file);

            dump([
                'file' => $file,
                'length' => strlen($sql),
            ]);
        }
    }
}