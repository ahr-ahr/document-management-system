<?php

namespace App\Console\Commands;

use App\Services\Database\DatabaseInstaller;
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
    public function handle(DatabaseInstaller $installer): int
    {
        $this->info('Starting database initialization...');
        $this->newLine();

        try {
            $installer->initialize($this);

            $this->newLine();
            $this->info('Database initialization completed successfully.');

            return self::SUCCESS;
        } catch (\Throwable $e) {
            $this->newLine();
            $this->error($e->getMessage());

            return self::FAILURE;
        }
    }
}