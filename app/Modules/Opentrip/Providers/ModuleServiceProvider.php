<?php

namespace App\Modules\Opentrip\Providers;

use Caffeinated\Modules\Support\ServiceProvider;

class ModuleServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap the module services.
     *
     * @return void
     */
    public function boot()
    {
        $this->loadTranslationsFrom(__DIR__.'/../Resources/Lang', 'opentrip');
        $this->loadViewsFrom(__DIR__.'/../Resources/Views', 'opentrip');
        $this->loadMigrationsFrom(__DIR__.'/../Database/Migrations', 'opentrip');
    }

    /**
     * Register the module services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->register(RouteServiceProvider::class);
    }
}
