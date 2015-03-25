requires 'perl', '5.008001';
requires 'LWP::Protocol::https';
requires 'URI';
requires 'Web::Scraper';

on 'test' => sub {
    requires 'Test::More', '0.98';
};
