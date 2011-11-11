import "rvm"
import "apache"
include rvm::system

    include apache
    
class lucid32
{
	exec { "apt-get_update":
		path => ["/usr/bin/","/usr/sbin/","/bin"],
		command => "apt-get update",
	}
 	if ! defined( Package["zlib1g"] )				{ package { "zlib1g": ensure => present, } }
	if ! defined( Package["zlib1g-dev"] )			{ package { "zlib1g-dev": ensure => present, } }
	if ! defined( Package["vim"] )					{ package { "vim": ensure => present, } }
	if ! defined( Package["byobu"] )				{ package { "byobu": ensure => present, } }
	if ! defined( Package["apache2"] )				{ package { "apache2": ensure => present, } }
	service { "apache2":
		ensure => running,
		require => Package["apache2"],
	}
	apache::vhost { 'localhost':
	    docroot => '/vagrant',
	}
	if ! defined( Package["git-core"] )				{ package { "git-core": ensure => present, } }
	if ! defined( Package["php-apc"] )				{ package { "php-apc": ensure => present, } }
	if ! defined( Package["libssl-dev"] )			{ package { "libssl-dev": ensure => present, } }
	if ! defined( Package["libapache2-mod-php5"] )	{ package { "libapache2-mod-php5": ensure => present, } }
	if ! defined( Package["php5-memcache"] )		{ package { "php5-memcache": ensure => present, } }
	if ! defined( Package["php-mysql"] )			{ package { "php5-mysql": ensure => present, } }
	if ! defined( Package["php5-xdebug"] )			{ package { "php5-xdebug": ensure => present, } }
	if ! defined( Package["memcached"] ) 			{ package { "memcached": ensure => present, } }
	service { "memcached":
		ensure => running,
		require => Package["memcached"]
	}
	if ! defined( Package["mysql-server"] )			{ package { "mysql-server": ensure => present, } }
	service { "mysql":
		ensure => running,
		require => Package["mysql-server"],
	}

	if ! defined( Package["curl"] )		{ package { "curl": ensure => present, } }

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
