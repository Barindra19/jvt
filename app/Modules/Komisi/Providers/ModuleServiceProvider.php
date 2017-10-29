<?php

namespace App\Modules\Komisi\Providers;

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
        $this->loadTranslationsFrom(__DIR__.'/../Resources/Lang', 'komisi');
        $this->loadViewsFrom(__DIR__.'/../Resources/Views', 'komisi');
        $this->loadMigrationsFrom(__DIR__.'/../Database/Migrations', 'komisi');
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
