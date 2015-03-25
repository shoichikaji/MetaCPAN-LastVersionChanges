package MetaCPAN::LastVersionChanges;
use 5.008001;
use strict;
use warnings;
use Web::Scraper;
use URI;
use LWP::Protocol::https;

our $VERSION = "0.01";

our $_HTML = 0;

my $scraper = scraper {
    process 'div.last-changes', last_changes => scraper {
        process '//ul', entries => sub {
            my $e = shift;
            process_ul($e);
        };
        process '#whatsnew', whatsnew => 'TEXT';
    };
};

sub process_li {
    my $li = shift;
    my %out;
    for my $e ($li->content_list) {
        if (lc($e->tag) eq "span") {
            $out{text} = $_HTML ? $e->as_HTML : $e->as_text;
        } elsif (lc($e->tag) eq "ul") {
            $out{entries} = process_ul($e);
        } else {
            warn "unexpected";
        }
    }
    \%out;
}

sub process_ul {
    my $ul = shift;
    my @out;
    for my $li ($ul->content_list) {
        push @out, process_li($li);
    }
    \@out;
}

sub new { bless {}, shift }

sub last_changes {
    my ($self, $url, $option) = @_;
    local $_HTML = $option && $option->{html};
    $url = URI->new($url) unless ref $url;
    my $res = $scraper->scrape($url);
    my $last_changes = $res->{last_changes};
    my $whatsnew = $last_changes->{whatsnew};
    my ($version) = $whatsnew =~ m{Changes for version (.+)};
    { version => $version, entries => $last_changes->{entries} };
}

1;
__END__

=encoding utf-8

=head1 NAME

MetaCPAN::LastVersionChanges - get last version changes from MetaCPAN

=head1 SYNOPSIS

    use MetaCPAN::LastVersionChanges;

    my $cpan = MetaCPAN::LastVersionChanges->new;
    my $chages = $cpan->last_changes("https://metacpan.org/release/Mojolicious");
    # {
    #   'entries' => [
    #     {
    #       'text' => 'Improved Mojo::Reactor::EV and Mojo::Reactor::Poll to fail more consistently.'
    #     },
    #     {
    #       'text' => 'Improved Mojo::Base performance slightly.'
    #     },
    #     {
    #       'text' => 'Fixed a few bugs in Mojo::DOM::CSS that required class, id and attribute selectors, as well as pseudo-classes, to be in a specific order.'
    #     }
    #   ],
    #   'version' => '6.04'
    # }

=head1 DESCRIPTION

MetaCPAN::LastVersionChanges is ...

=head1 LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Shoichi Kaji E<lt>skaji@cpan.orgE<gt>

=cut

