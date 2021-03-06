package App::Happyman::Plugin;
use v5.18;
use Moose::Role;
use Method::Signatures;
use namespace::autoclean;

has 'conn' => (
    is  => 'rw',
    isa => 'App::Happyman::Connection',
);

has logger => (
    is  => 'rw',
    isa => 'Log::Dispatchouli::Proxy',
);

has '_ua' => (
    is      => 'ro',
    isa     => 'Mojo::UserAgent',
    builder => '_build_ua',
    lazy    => 1,
);

method _build_ua {
    return Mojo::UserAgent->new();
}

1;
