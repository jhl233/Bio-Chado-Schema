package Bio::Chado::Schema::Mage::Study;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Bio::Chado::Schema::Mage::Study

=cut

__PACKAGE__->table("study");

=head1 ACCESSORS

=head2 study_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'study_study_id_seq'

=head2 contact_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 dbxref_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "study_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "study_study_id_seq",
  },
  "contact_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "dbxref_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "description",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("study_id");
__PACKAGE__->add_unique_constraint("study_c1", ["name"]);

=head1 RELATIONS

=head2 pub

Type: belongs_to

Related object: L<Bio::Chado::Schema::Pub::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "Bio::Chado::Schema::Pub::Pub",
  { pub_id => "pub_id" },
  {
    cascade_copy   => 0,
    cascade_delete => 0,
    is_deferrable  => 1,
    join_type      => "LEFT",
    on_delete      => "CASCADE",
    on_update      => "CASCADE",
  },
);

=head2 contact

Type: belongs_to

Related object: L<Bio::Chado::Schema::Contact::Contact>

=cut

__PACKAGE__->belongs_to(
  "contact",
  "Bio::Chado::Schema::Contact::Contact",
  { contact_id => "contact_id" },
  {
    cascade_copy   => 0,
    cascade_delete => 0,
    is_deferrable  => 1,
    on_delete      => "CASCADE",
    on_update      => "CASCADE",
  },
);

=head2 dbxref

Type: belongs_to

Related object: L<Bio::Chado::Schema::General::Dbxref>

=cut

__PACKAGE__->belongs_to(
  "dbxref",
  "Bio::Chado::Schema::General::Dbxref",
  { dbxref_id => "dbxref_id" },
  {
    cascade_copy   => 0,
    cascade_delete => 0,
    is_deferrable  => 1,
    join_type      => "LEFT",
    on_delete      => "CASCADE",
    on_update      => "CASCADE",
  },
);

=head2 study_assays

Type: has_many

Related object: L<Bio::Chado::Schema::Mage::StudyAssay>

=cut

__PACKAGE__->has_many(
  "study_assays",
  "Bio::Chado::Schema::Mage::StudyAssay",
  { "foreign.study_id" => "self.study_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studydesigns

Type: has_many

Related object: L<Bio::Chado::Schema::Mage::Studydesign>

=cut

__PACKAGE__->has_many(
  "studydesigns",
  "Bio::Chado::Schema::Mage::Studydesign",
  { "foreign.study_id" => "self.study_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studyprops

Type: has_many

Related object: L<Bio::Chado::Schema::Mage::Studyprop>

=cut

__PACKAGE__->has_many(
  "studyprops",
  "Bio::Chado::Schema::Mage::Studyprop",
  { "foreign.study_id" => "self.study_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.06001 @ 2010-04-16 14:33:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RMMCAvWl3IS8XLyAwR1ADg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
