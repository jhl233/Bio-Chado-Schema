package Bio::Chado::Schema::Composite::Gff3view;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Bio::Chado::Schema::Composite::Gff3view

=cut

__PACKAGE__->table("gff3view");

=head1 ACCESSORS

=head2 feature_id

  data_type: 'integer'
  is_nullable: 1

=head2 ref

  data_type: 'character varying'
  is_nullable: 1
  size: 255

=head2 source

  data_type: 'character varying'
  is_nullable: 1
  size: 255

=head2 type

  data_type: 'character varying'
  is_nullable: 1
  size: 1024

=head2 fstart

  data_type: 'integer'
  is_nullable: 1

=head2 fend

  data_type: 'integer'
  is_nullable: 1

=head2 score

  data_type: 'double precision'
  is_nullable: 1

=head2 strand

  data_type: 'smallint'
  is_nullable: 1

=head2 phase

  data_type: 'integer'
  is_nullable: 1

=head2 seqlen

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'character varying'
  is_nullable: 1
  size: 255

=head2 organism_id

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "feature_id",
  { data_type => "integer", is_nullable => 1 },
  "ref",
  { data_type => "character varying", is_nullable => 1, size => 255 },
  "source",
  { data_type => "character varying", is_nullable => 1, size => 255 },
  "type",
  { data_type => "character varying", is_nullable => 1, size => 1024 },
  "fstart",
  { data_type => "integer", is_nullable => 1 },
  "fend",
  { data_type => "integer", is_nullable => 1 },
  "score",
  { data_type => "double precision", is_nullable => 1 },
  "strand",
  { data_type => "smallint", is_nullable => 1 },
  "phase",
  { data_type => "integer", is_nullable => 1 },
  "seqlen",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "character varying", is_nullable => 1, size => 255 },
  "organism_id",
  { data_type => "integer", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.06001 @ 2010-04-16 14:33:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:de1T5DAkJyL79Vmik68yKg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
