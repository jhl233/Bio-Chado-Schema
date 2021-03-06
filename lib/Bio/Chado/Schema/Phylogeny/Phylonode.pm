package Bio::Chado::Schema::Phylogeny::Phylonode;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Bio::Chado::Schema::Phylogeny::Phylonode

=head1 DESCRIPTION

This is the most pervasive
       element in the phylogeny module, cataloging the "phylonodes" of
       tree graphs. Edges are implied by the parent_phylonode_id
       reflexive closure. For all nodes in a nested set implementation the left and right index will be *between* the parents left and right indexes.

=cut

__PACKAGE__->table("phylonode");

=head1 ACCESSORS

=head2 phylonode_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'phylonode_phylonode_id_seq'

=head2 phylotree_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 parent_phylonode_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

Root phylonode can have null parent_phylonode_id value.

=head2 left_idx

  data_type: 'integer'
  is_nullable: 0

=head2 right_idx

  data_type: 'integer'
  is_nullable: 0

=head2 type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

Type: e.g. root, interior, leaf.

=head2 feature_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

Phylonodes can have optional features attached to them e.g. a protein or nucleotide sequence usually attached to a leaf of the phylotree for non-leaf nodes, the feature may be a feature that is an instance of SO:match; this feature is the alignment of all leaf features beneath it.

=head2 label

  data_type: 'character varying'
  is_nullable: 1
  size: 255

=head2 distance

  data_type: 'double precision'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "phylonode_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "phylonode_phylonode_id_seq",
  },
  "phylotree_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "parent_phylonode_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "left_idx",
  { data_type => "integer", is_nullable => 0 },
  "right_idx",
  { data_type => "integer", is_nullable => 0 },
  "type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "feature_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "label",
  { data_type => "character varying", is_nullable => 1, size => 255 },
  "distance",
  { data_type => "double precision", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("phylonode_id");
__PACKAGE__->add_unique_constraint("phylonode_phylotree_id_key1", ["phylotree_id", "right_idx"]);
__PACKAGE__->add_unique_constraint("phylonode_phylotree_id_key", ["phylotree_id", "left_idx"]);

=head1 RELATIONS

=head2 feature

Type: belongs_to

Related object: L<Bio::Chado::Schema::Sequence::Feature>

=cut

__PACKAGE__->belongs_to(
  "feature",
  "Bio::Chado::Schema::Sequence::Feature",
  { feature_id => "feature_id" },
  {
    cascade_copy   => 0,
    cascade_delete => 0,
    is_deferrable  => 1,
    join_type      => "LEFT",
    on_delete      => "CASCADE",
    on_update      => "CASCADE",
  },
);

=head2 type

Type: belongs_to

Related object: L<Bio::Chado::Schema::Cv::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type",
  "Bio::Chado::Schema::Cv::Cvterm",
  { cvterm_id => "type_id" },
  {
    cascade_copy   => 0,
    cascade_delete => 0,
    is_deferrable  => 1,
    join_type      => "LEFT",
    on_delete      => "CASCADE",
    on_update      => "CASCADE",
  },
);

=head2 parent_phylonode

Type: belongs_to

Related object: L<Bio::Chado::Schema::Phylogeny::Phylonode>

=cut

__PACKAGE__->belongs_to(
  "parent_phylonode",
  "Bio::Chado::Schema::Phylogeny::Phylonode",
  { phylonode_id => "parent_phylonode_id" },
  {
    cascade_copy   => 0,
    cascade_delete => 0,
    is_deferrable  => 1,
    join_type      => "LEFT",
    on_delete      => "CASCADE",
    on_update      => "CASCADE",
  },
);

=head2 phylonodes

Type: has_many

Related object: L<Bio::Chado::Schema::Phylogeny::Phylonode>

=cut

__PACKAGE__->has_many(
  "phylonodes",
  "Bio::Chado::Schema::Phylogeny::Phylonode",
  { "foreign.parent_phylonode_id" => "self.phylonode_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylotree

Type: belongs_to

Related object: L<Bio::Chado::Schema::Phylogeny::Phylotree>

=cut

__PACKAGE__->belongs_to(
  "phylotree",
  "Bio::Chado::Schema::Phylogeny::Phylotree",
  { phylotree_id => "phylotree_id" },
  {
    cascade_copy   => 0,
    cascade_delete => 0,
    is_deferrable  => 1,
    on_delete      => "CASCADE",
    on_update      => "CASCADE",
  },
);

=head2 phylonode_dbxrefs

Type: has_many

Related object: L<Bio::Chado::Schema::Phylogeny::PhylonodeDbxref>

=cut

__PACKAGE__->has_many(
  "phylonode_dbxrefs",
  "Bio::Chado::Schema::Phylogeny::PhylonodeDbxref",
  { "foreign.phylonode_id" => "self.phylonode_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylonode_organism

Type: might_have

Related object: L<Bio::Chado::Schema::Phylogeny::PhylonodeOrganism>

=cut

__PACKAGE__->might_have(
  "phylonode_organism",
  "Bio::Chado::Schema::Phylogeny::PhylonodeOrganism",
  { "foreign.phylonode_id" => "self.phylonode_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylonodeprops

Type: has_many

Related object: L<Bio::Chado::Schema::Phylogeny::Phylonodeprop>

=cut

__PACKAGE__->has_many(
  "phylonodeprops",
  "Bio::Chado::Schema::Phylogeny::Phylonodeprop",
  { "foreign.phylonode_id" => "self.phylonode_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylonode_pubs

Type: has_many

Related object: L<Bio::Chado::Schema::Phylogeny::PhylonodePub>

=cut

__PACKAGE__->has_many(
  "phylonode_pubs",
  "Bio::Chado::Schema::Phylogeny::PhylonodePub",
  { "foreign.phylonode_id" => "self.phylonode_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylonode_relationship_objects

Type: has_many

Related object: L<Bio::Chado::Schema::Phylogeny::PhylonodeRelationship>

=cut

__PACKAGE__->has_many(
  "phylonode_relationship_objects",
  "Bio::Chado::Schema::Phylogeny::PhylonodeRelationship",
  { "foreign.object_id" => "self.phylonode_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylonode_relationship_subjects

Type: has_many

Related object: L<Bio::Chado::Schema::Phylogeny::PhylonodeRelationship>

=cut

__PACKAGE__->has_many(
  "phylonode_relationship_subjects",
  "Bio::Chado::Schema::Phylogeny::PhylonodeRelationship",
  { "foreign.subject_id" => "self.phylonode_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.06001 @ 2010-04-16 14:33:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GTZL/H9UZnPTZwLK5eX/xw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
