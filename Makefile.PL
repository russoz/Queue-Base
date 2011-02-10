use inc::Module::Install;

name     'Queue-Base';
all_from 'lib/Queue/Base.pm';
author   q{Alexei Znamensky <russoz@cpan.org>};
license  'perl';

requires 'version' => 0.77;

build_requires 'Test::More';

auto_install;

WriteAll;

