#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use lib "$FindBin::RealBin/../lib";

use Test::More tests => 8;
use Test::Exception;
use BCSTest;

my $schema = BCSTest->init_schema();

my $sf = $schema->resultset('Sequence::Feature');
isa_ok( $sf, 'DBIx::Class::ResultSet' );

$schema->txn_do(sub{
    # try a joined query through one of the longer has_many rels
    lives_ok {
        $sf->search_related('feature_relationship_objects')->count;
    } 'join through a long has_many name does not die';
    $schema->txn_rollback;
});

$schema->txn_do(sub{
    my $dbx = $schema->resultset('General::Db')
                ->find_or_create({ name => 'test db' })
                ->find_or_create_related('dbxrefs',
                            { accession => 'made_up',
                            },
                            );

    # insert a feature with some sequence
    my $cvterm = $schema->resultset('Cv::Cv')
                ->find_or_create({ name => 'testing cv' })
                ->find_or_create_related('cvterms',
                                { name => 'tester',
                                dbxref => $dbx,
                                },
                            );

    my $test_seq = 'ACTAGCATCATGCCGCTAGCTAATATGCTG';
    $schema->resultset('Organism::Organism')
            ->find_or_create({ genus => 'test', species => 'testus' })
            ->create_related( 'features',
                    { residues => $test_seq,
                    seqlen   => length( $test_seq ),
                    name     => 'BCS_test_seq_deleteme',
                    uniquename => 'BCS_test_seq_deleteme',
                    type     => $cvterm,
                    });

    # find a feature with some sequence. might be the one we just
    # inserted.
    my $feature = $sf->search({
                        'residues' => {'!=', undef},
                        'seqlen'   => {'!=', undef},
                    }, { 'rows' => 1 })->single;

    $schema->resultset('Sequence::Featureloc')
        ->find_or_create({
        srcfeature => $feature,
        feature_id => 5,
        rank       => 1,
        fmin       => 42,
        fmax       => 69,
    });

    # test some Bio::SeqI methods for it
    for (
        [qw[ length      seqlen    ]],
        [qw[ id          name      ]],
        [qw[ primary_id  name      ]],
        [qw[ residues    seq       ]],
        ) {
        my ($m1,$m2) = @$_;
        is( $feature->$m1, $feature->$m2,
        "$m1() returns same thing as $m2()" );
    }

    can_ok($feature,'child_features');
    can_ok($feature,'parent_features');

    $schema->txn_rollback;
});
