# Emacs, this is -*-perl-*- code.

BEGIN { use Test; plan tests => 45 }

require 5.005_64;
use strict;
use warnings;

use Test;

# Test 1:
eval "use Class::Struct::FIELDS v0.9";
ok (not $@);
use Class::Struct::FIELDS;

# Tests 2-3:
$::ps = struct 'Fred';
ok ($::ps eq 'Fred');
package Fred; # get rid of compile-time warning
package main;
ok ($::po = Fred::->new);

# Tests 4-5:
$::ps = struct Barney => [qw(Fred)];
ok ($::ps eq 'Barney');
package Barney; # get rid of compile-time warning
package main;
ok ($::po = Barney::->new);

# Tests 6-7:
$::ps = struct Wilma => { aa => '$' };
ok ($::ps eq 'Wilma');
package Wilma;
package main;
ok ($::po = Wilma::->new);

# Tests 8-9:
$::ps = struct Betty => [qw(Fred)], { aa => '$' };
ok ($::ps eq 'Betty');
package Betty;
package main;
ok ($::po = Betty::->new);

# Tests 10-11:
$::ps = struct 'Pebbles', aa => '$'; # docs say no-no
ok ($::ps eq 'Pebbles');
package Pebbles;
package main;
ok ($::po = Pebbles::->new);

# Tests 12-13:
$::ps = struct BammBamm => [qw(Fred)], aa => '$';
ok ($::ps eq 'BammBamm');
package BammBamm;
package main;
ok ($::po = BammBamm::->new);

# Tests 14-15:
package Dino;
use Class::Struct::FIELDS;
$::ps = struct;
package main;
ok ($::ps eq 'Dino');
ok ($::po = Dino::->new);

# Tests 16-17:
package Hoppy;
use Class::Struct::FIELDS;
$::ps = struct [qw(Fred)];
package main;
ok ($::ps eq 'Hoppy');
ok ($::po = Hoppy::->new);

# Tests 18-19:
package BabyPuss;
use Class::Struct::FIELDS;
$::ps = struct { aa => '$' };
package main;
ok ($::ps eq 'BabyPuss');
ok ($::po = BabyPuss::->new);

# Tests 20-21:
package MrSlate;
use Class::Struct::FIELDS;
$::ps = struct [qw(Fred)], { aa => '$' };
package main;
ok ($::ps eq 'MrSlate');
ok ($::po = MrSlate::->new);

# Tests 22-23:
package MrsSlate;
use Class::Struct::FIELDS;
$::ps = struct [qw(Fred)], aa => '$';
package main;
ok ($::ps eq 'MrsSlate');
ok ($::po = MrsSlate::->new);

# Test 24:
use Class::Struct::FIELDS qw(Akron);
ok ($::po = Akron::->new);

# Test 25:
use Class::Struct::FIELDS Baltimore => [];
ok ($::po = Baltimore::->new);

# Test 26:
use Class::Struct::FIELDS Cleveland => {};
ok ($::po = Cleveland::->new);

# Tests 27:
use Class::Struct::FIELDS Dayton => [], {};
ok ($::po = Dayton::->new);

# Test 28:
use Class::Struct::FIELDS Elements =>
  { aa => '$',
    bb => '\$',
    cc => '@',
    dd => '\@',
    ee => '%',
    ff => '\%',
    gg => '&',
    hh => '\&',
    ii => '/',
    jj => '\/',
    kk => 'Wilma',
    ll => '\Wilma' };
ok ($::po = Elements::->new);

# Test 29:
ok (not defined $::po->aa);

# Test 30:
ok (ref $::po->bb eq 'SCALAR');

# Test 31:
ok (ref $::po->cc eq 'ARRAY');

# Tests 32-33:
push @{$::po->dd}, 'larry wall';
ok (ref $::po->dd (0) eq 'SCALAR');
ok ($::po->dd->[0] eq 'larry wall');

# Test 34:
ok (ref $::po->ee eq 'HASH');

# Test 35-36:
${$::po->ff}{larry} = 'wall';
ok (ref $::po->ff ('larry') eq 'SCALAR');
ok ($::po->ff->{larry} eq 'wall');

# Test 37:
ok (not defined $::po->gg);

# Test 38-39:
ok (ref ${$::po->hh (sub { 1 })} eq 'CODE');
ok (${$::po->hh}->( ) == 1);

# Test 40:
ok (not defined $::po->ii);

# Test 41-42;
ok (ref ${$::po->jj (qr/^$/)} eq 'Regexp');
ok ('' =~ ${$::po->jj});

# Test 43:
ok (ref $::po->kk eq 'Wilma');

# Test 44-45:
${$::po->ll}->aa (1);
ok (ref ${$::po->ll} eq 'Wilma');
ok (${$::po->ll}->aa == 1);

1;
