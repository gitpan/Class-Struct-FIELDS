# Emacs, this is -*-perl-*- code.

BEGIN { use Test; plan tests => 25 }

require 5.005_64;
use strict;
use warnings;

use Test;

# Test 1:
eval "use Class::Struct::FIELDS v0.8";
ok (not $@);
use Class::Struct::FIELDS;

# Tests 2-3:
$::ps = struct 'Fred';
ok ($::ps eq 'Fred');
package Fred; # get rid of compile-time warning
package main;
$::po = Fred::->new;
ok ($::po);

# Tests 4-5:
$::ps = struct Barney => [qw(Fred)];
ok ($::ps eq 'Barney');
package Barney; # get rid of compile-time warning
package main;
$::po = Barney::->new;
ok ($::po);

# Tests 6-7:
$::ps = struct Wilma => { a => '$' };
ok ($::ps = 'Wilma');
package Wilma;
package main;
$::po = Wilma::->new;
ok ($::po);

# Tests 8-9:
$::ps = struct Betty => [qw(Fred)], { a => '$' };
ok ($::ps = 'Betty');
package Betty;
package main;
$::po = Betty::->new;
ok ($::po);

# Tests 10-11:
$::ps = struct 'Pebbles', a => '$'; # docs say no-no
ok ($::ps = 'Pebbles');
package Pebbles;
package main;
$::po = Pebbles::->new;
ok ($::po);

# Tests 12-13:
$::ps = struct BammBamm => [qw(Fred)], a => '$';
ok ($::ps = 'BammBamm');
package BammBamm;
package main;
$::po = BammBamm::->new;
ok ($::po);

# Tests 14-15:
package Dino;
use Class::Struct::FIELDS;
$::ps = struct;
package main;
ok ($::ps = 'Dino');
$::po = Dino::->new;
ok ($::po);

# Tests 16-17:
package Hoppy;
use Class::Struct::FIELDS;
$::ps = struct [qw(Fred)];
package main;
ok ($::ps = 'Hoppy');
$::po = Hoppy::->new;
ok ($::po);

# Tests 18-19:
package BabyPuss;
use Class::Struct::FIELDS;
$::ps = struct { a => '$' };
package main;
ok ($::ps = 'BabyPuss');
$::po = BabyPuss::->new;
ok ($::po);

# Tests 20-21:
package MrSlate;
use Class::Struct::FIELDS;
$::ps = struct [qw(Fred)], { a => '$' };
package main;
ok ($::ps = 'MrSlate');
$::po = MrSlate::->new;
ok ($::po);

# Tests 22-23:
package MrsSlate;
use Class::Struct::FIELDS;
$::ps = struct [qw(Fred)], a => '$';
package main;
ok ($::ps = 'MrsSlate');
$::po = MrsSlate::->new;
ok ($::po);

1;
