# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.


require Rails.root.join('db', 'seeds', 'support', 'group_seeder')

seeder = GroupSeeder.new

root = Group.roots.first
srand(42)

if root.address.blank?
  root.update_attributes(seeder.group_attributes)
  root.default_children.each do |child_class|
    child_class.first.update_attributes(seeder.group_attributes)
  end
end

kantonalverbaende = Group::Kantonalverband.seed(:name, :parent_id,
                                                {
                                                  name: 'Bern',
                                                  short_name: 'BE',
                                                  address: "Klostergasse 3",
                                                  zip_code: "3333",
                                                  town: "Bern",
                                                  country: "CH",
                                                  email: "bern@be.ch",
                                                  parent_id: root.id},


                                                  {name: 'Zürich',
                                                   short_name: 'ZH',
                                                   address: "Tellgasse 3",
                                                   zip_code: "8888",
                                                   town: "Zürich",
                                                   country: "CH",
                                                   email: "zuerich@zh.ch",
                                                   parent_id: root.id },

                                                   {name: 'Waadt',
                                                    short_name: 'VD',
                                                    address: "Nordostgasse 3",
                                                    zip_code: "2000",
                                                    town: "Lausanne",
                                                    country: "CH",
                                                    email: "vaud@vd.ch",
                                                    parent_id: root.id }
                                               )

Group::Mitglieder.seed(:name, :parent_id,
                       { name: 'Mitglieder',
                         parent_id: root.id }
                      )

Group::Sektion.seed(:name, :parent_id,
                         {name: 'Kanu Club Bern',
                          country: "CH",
                          parent_id: kantonalverbaende[0].id },

                         {name: 'Kanu Club Zürich',
                          country: "CH",
                          parent_id: kantonalverbaende[1].id },

                         {name: 'Kanu Club Rapperswil',
                          country: "CH",
                          parent_id: kantonalverbaende[1].id },

                         {name: 'Kayak Club Lausanne',
                          country: "CH",
                          parent_id: kantonalverbaende[2].id },

                         {name: 'Basilisk Paddler',
                          country: "CH",
                          parent_id: root.id },
                        )

Group::Fachkommission.seed(:name, :parent_id,
                           {name: 'FAKO Abfahrt',
                            parent_id: root.id },
                           {name: 'FAKO Tourenwesen',
                            parent_id: root.id },
                           {name: 'FAKO Slalom',
                            parent_id: root.id },
                          )

Group::Nationalmannschaft.seed(:name, :parent_id,
                           {name: 'Nati Abfahrt',
                            parent_id: root.id },
                           {name: 'Nati Kanupolo',
                            parent_id: root.id },
                           {name: 'Nati Slalom',
                            parent_id: root.id },
                          )

Group.rebuild!
