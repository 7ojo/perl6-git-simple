use v6;
use lib 'lib';
use Test;
use Git::Simple::Parse;

plan 10;

my %res = Git::Simple::Parse.new.status(out => '## foo...bar');
is %res<local>, 'foo', "got local branch";
is %res<remote>, 'bar', "got remote branch";

%res = Git::Simple::Parse.new.status(out => '## foo...bar [ahead 3]');
is %res<local>, 'foo', "got local branch";
is %res<remote>, 'bar', "got remote branch";
is %res<ahead>, '3', "got correct ahead";

%res = Git::Simple::Parse.new.status(out => '## foo...bar [ahead 3, behind 5]');
is %res<local>, 'foo', "got local branch";
is %res<remote>, 'bar', "got remote branch";
is %res<ahead>, '3', "got correct ahead";
is %res<behind>, '5', "got correct behind";

use Git::Simple;

my $dir = '/tmp/.test-git-simple-basic';
mkdir $dir;
%res = Git::Simple.new(cwd => $dir).branch-info;
is %res.keys.elems, 0, 'no .git seen here';
rmdir $dir;
