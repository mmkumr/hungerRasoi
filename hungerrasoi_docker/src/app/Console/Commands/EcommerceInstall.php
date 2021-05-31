<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;
use Symfony\Component\Process\Process;
use Symfony\Component\Process\Exception\ProcessFailedException;
use DB;
 class EcommerceInstall extends Command
 {
     /**
      * The name and signature of the console command.
      *
      * @var string
      */
     protected $signature = 'ecommerce:install {--force : Do not ask for user confirmation}';

     /**
      * The console command description.
      *
      * @var string
      */
     protected $description = 'Install dummy data for the Ecommerce Application';
 
     /**
      * Create a new command instance.
      *
      * @return void
      */
     public function __construct()
     {
         parent::__construct();
     }
 
     /**
      * Execute the console command.
      *
      * @return mixed
      */
     public function handle()
     {
         if ($this->option('force')) {
             $this->proceed();
         } else {
             if ($this->confirm('This will delete ALL your current data and install the default dummy data. Are you sure?')) {
                 $this->proceed();
             }
         }
     }
 
     protected function proceed()
     {
        try {
            $this->call('migrate:fresh', [
                '--force' => true,
            ]);
//       $process = new Process('./restoredb.sh');
//   	$process->run();
//   	if (!$process->isSuccessful()) {
//       throw new ProcessFailedException($process);
//   	}
//   	echo $process->getOutput();

        } catch (\Exception $e) {
            $this->error($e);
        }
        try {
            $this->call('scout:clear', [
                'model' => 'App\\Product',
            ]);

            $this->call('scout:import', [
                'model' => 'App\\Product',
            ]);
        } catch (\Exception $e) {
            $this->error('Algolia credentials incorrect. Check your .env file. Make sure ALGOLIA_APP_ID and ALGOLIA_SECRET are correct.');
        }

        $this->info('Dummy data installed');
    }
}
