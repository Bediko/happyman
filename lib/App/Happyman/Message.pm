package App::Happyman::Message;
use v5.16;
use Moose;

has [qw(full_text text sender_nick)] => (
  is => 'ro',
  isa => 'Str',
  required => 1,
);

has 'addressed_nick' => (
  is => 'ro',
  isa => 'Str',
);

has 'conn' => (
  is => 'ro',
  isa => 'App::Happyman::Connection',
  required => 1,
);

sub BUILDARGS {
  my ($self, $conn, $sender_nick, $full_text) = @_;
    
  if ($full_text =~ /^(\w+)[:,]\s+(.+)$/) {
    return {
      conn => $conn,
      sender_nick => $sender_nick,
      full_text => $full_text,
      addressed_nick => $1,
      text => $2,
    };
  }
  else {
    return {
      conn => $conn,
      sender_nick => $sender_nick,
      full_text => $full_text,
      text => $full_text,
    };
  }  
}

sub addressed_me {
  my ($self) = @_;
  
  return (defined $self->addressed_nick and $self->addressed_nick eq $self->conn->nick);
}

sub reply {
  my ($self, $text) = @_;
  
  $self->conn->send_message($self->sender_nick . ': ' . $text);
}

1;