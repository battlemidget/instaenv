package instaenv::Command::i;

# ABSTRACT: play that funky music

use instaenv -command;
use Class::Load ':all';

use Moo;
use namespace::clean;

sub opt_spec {
    return (["all", "install all environments [pl,py,rb]envs"]);
}

sub abstract {'Install all or any supported environments.'}

sub usage_desc {'%c i {py,pl,rb}env'}

sub validate_args {
    my ($self, $opt, $args) = @_;
    $self->usage_error("Don't understand that environment :(")
      unless $opt->{all} || $args->[0] =~ /^plenv|rbenv|pyenv/;
}

sub execute {
    my ($self, $opt, $args) = @_;

    if ($opt->{all}) {
        printf("Installing all envs\n");
    }
    else {
        my $ie = load_class(sprintf('instaenv::Role::%s', ucfirst $args->[0]))->new
          or die "Oh noes! something is wrong with the ship captain: $!\n";
        $ie->install_env;
    }
}

1;
