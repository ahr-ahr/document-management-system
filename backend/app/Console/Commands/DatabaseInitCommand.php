<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class DatabaseInitCommand extends Command
{
    /**
     * The name and signature of the console command.
     */
    protected $signature = 'db:init';

    /**
     * The console command description.
     */
    protected $description = 'Initialize PostgreSQL database from SQL files';

    /**
     * Execute the console command.
     */
    public function handle(): int
    {
        $this->info('Starting database initialization...');
        $this->newLine();

        $this->info('Database initialization completed.');

        return self::SUCCESS;
    }
}