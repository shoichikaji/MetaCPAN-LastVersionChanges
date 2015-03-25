# NAME

MetaCPAN::LastVersionChanges - get last version changes from MetaCPAN

# SYNOPSIS

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

# DESCRIPTION

MetaCPAN::LastVersionChanges is ...

# LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Shoichi Kaji <skaji@cpan.org>
