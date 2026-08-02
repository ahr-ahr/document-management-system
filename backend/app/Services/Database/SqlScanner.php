<?php

namespace App\Services\Database;

use Illuminate\Support\Facades\File;

class SqlScanner
{
    /**
     * Scan SQL files from project database directory.
     *
     * @return array<string>
     */
    public function scan(): array
    {
        $files = [];

        $databasePath = base_path('../database');

        // Root SQL files
        foreach (File::files($databasePath) as $file) {
            if ($file->getExtension() === 'sql') {
                $files[] = $file->getRealPath();
            }
        }

        $directories = [
            'core',
            'master',
            'document',
            'security',
            'functions',
            'views',
            'triggers',
            'indexes',
            'seed',
            'audit',
        ];

        foreach ($directories as $directory) {
            $path = $databasePath.'/'.$directory;

            if (! File::exists($path)) {
                continue;
            }

            foreach (File::files($path) as $file) {
                if ($file->getExtension() === 'sql') {
                    $files[] = $file->getRealPath();
                }
            }
        }

        return $files;
    }
}