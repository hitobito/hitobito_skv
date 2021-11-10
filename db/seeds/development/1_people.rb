# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.


require Rails.root.join('db', 'seeds', 'support', 'person_seeder')

class SkvPersonSeeder < PersonSeeder

  def amount(role_type)
    case role_type.name.demodulize
    when 'Member' then 5
    else 1
    end
  end

end

puzzlers = [
  'Andreas Maierhofer',
  'Carlo Beltrame',
  'Luca Brügger',
  'Mathis Hofer',
  'Matthias Viehweger',
  'Nils Rauch',
  'Olivier Brian',
  'Pascal Simon',
  'Pascal Zumkehr',
  'Roland Studer',
  'Tobias Hinderling'
]

devs = {
  # 'Customer Name' => 'customer@email.com'
}
puzzlers.each do |puz|
  devs[puz] = "#{puz.split.last.downcase}@puzzle.ch"
end

seeder = SkvPersonSeeder.new

seeder.seed_all_roles

root = Group.root
devs.each do |name, email|
  seeder.seed_developer(name, email, root, Group::Geschaeftsleitung::Mitarbeitende)
end
