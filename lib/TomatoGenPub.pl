#!/usr/bin/perl

use strict;
use warnings;

use Bio::Chado::Schema;

#---arrays of pubmed ids and titles of publications---
my @pmid = (18254380, 18317508, 17565940, 16830097, 16524981, 16489216, 16208505, 16010005, 10645957, 10382301, 10224272, 18469880, 8662247, 8653264, 8647403);

my @title = ('A Snapshot of the Emerging Tomato Genome Sequence', 'Estimation of nuclear DNA content of plants by flow cytometry');

my $item;



#---connect to schema---
my $schema = Bio::Chado::Schema->connect("dbi:Pg:dbname='cxgn'; host='localhost'", 'postgres', 'c0d3r!!', { AutoCommit => 1, RaiseError => 1 });


#---add pubmed publications to pubprop---
my ($db) = $schema->resultset('General::Db')->find({name => 'PMID'});

print $db->db_id."\n";


foreach $item(@pmid){
my ($dbxref) = $db->find_related('dbxrefs', {accession => $item});
print $dbxref->accession."\n";

my $pub = $dbxref->find_related('pub_dbxrefs', {})->find_related('pub', {});
print $pub->title."\n";

$pub->create_pubprops({'tomato genome publication' => '1'}, {autocreate => 1});

}

#---add other publications manually---
$pub = $schema->resultset("Pub::Pub")->find({title => $title[0]});



