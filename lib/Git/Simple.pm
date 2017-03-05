use v6;
use Git::Simple::Parse;

class Git::Simple {

    has Str $.cwd = '.';

    method branch-info {
        my $proc = run <git -C>, $.cwd, <status --porcelain -b>, :out, :err;
        Git::Simple::Parse.new.status(out => $proc.out.slurp-rest);
    }

}
