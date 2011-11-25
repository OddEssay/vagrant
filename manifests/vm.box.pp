stage {"pre": before => Stage["main"]}

class initbasic
{
	exec { "apt-get_update":
		path => ["/usr/bin/","/usr/sbin/","/bin"],
		command => "apt-get update",
	}

}
# Rather then use include, this loads the class and notifies which stage to run at.
class {"initbasic": stage=>"pre"}


import "rvm"
include rvm::system

    
class lucid32
{

 	if ! defined( Package["zlib1g"] )				{ package { "zlib1g": ensure => present, } }
	if ! defined( Package["zlib1g-dev"] )			{ package { "zlib1g-dev": ensure => present, } }
	if ! defined( Package["vim"] )					{ package { "vim": ensure => present, } }
	if ! defined( Package["byobu"] )				{ package { "byobu": ensure => present, } }
	if ! defined( Package["apache2"] )				{ package { "apache2": ensure => present, } }
	if ! defined( Package["git-core"] )				{ package { "git-core": ensure => present, } }
	if ! defined( Package["php-apc"] )				{ package { "php-apc": ensure => present, } }
	if ! defined( Package["libssl-dev"] )			{ package { "libssl-dev": ensure => present, } }
	if ! defined( Package["libapache2-mod-php5"] )	{ package { "libapache2-mod-php5": ensure => present, } }
	if ! defined( Package["php5-memcache"] )		{ package { "php5-memcache": ensure => present, } }
	if ! defined( Package["php-mysql"] )			{ package { "php5-mysql": ensure => present, } }
	if ! defined( Package["php5-xdebug"] )			{ package { "php5-xdebug": ensure => present, } }
	if ! defined( Package["memcached"] ) 			{ package { "memcached": ensure => present, } }
	if ! defined( Package["mysql-server"] )			{ package { "mysql-server": ensure => present, } }
	if ! defined( Package["curl"] )					{ package { "curl": ensure => present, } }

	service { "apache2":
		ensure => running,
		require => Package["apache2"],
	}
	service { "memcached":
		ensure => running,
		require => Package["memcached"]
	}
	
	service { "mysql":
		ensure => running,
		require => Package["mysql-server"],
	}


	group { "puppet": 
    	ensure => "present", 
	}

	user { "vagrant": }
	rvm::system_user { vagrant: ; }
	if $rvm_installed == "true" {
		rvm_system_ruby { 'ruby-1.9.2-p290':
			ensure => 'present',
			default_use => true;
		}
	}
}

include lucid32
