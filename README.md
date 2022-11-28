# hitobito skv

A hitobito wagon defining the organization hierarchy and additional features for Swiss Canoe.
(Schweizerischer Kanu-Verband)

## Organization Hierarchy

- Schweizerischer Kanu-Verband
  - Vorstand
    - Präsident\*in: [:layer_and_below_read]
    - Finanzchef\*in: [:layer_and_below_read, :finance]
    - Vorstandsmitglied: [:layer_and_below_read]
  - Geschäftsleitung
    - Mitarbeitende\*r: [:layer_and_below_full, :admin]
  - Mitarbeitende
    - Trainer\*in: [:group_read]
    - Mitarbeitende\*r: [:group_read]
    - Back-Office: [:layer_and_below_full, :admin]
  - Externe Kontakte
    - Externer Kontakt: []
    - Swiss Canoe Partner: []
  - Fachkommission
    - Chef\*in: [:group_full]
    - Mitglied: [:group_read]
  - Mitglieder
    - Mitglied: []
    - Ehrenmitglied: []
    - Nachwuchsmitglied: []
  - Paddle Level
    - Anbieter\*in: [:group_read]
    - Assessor\*in: [:group_read]
    - Koordinator\*in: [:group_read]
  - Nationalmannschaft
    - Trainer\*in: [:group_full]
    - Kaderathlet\*in: [:group_read]
  - Regionale Leistungszentrum
    - Leitung: [:group_full]
    - Mitglied: [:group_read]
- Sektion
  - Sektion
    - J+S Coach: [:group_full]
    - Junior\*in: [:group_read]
    - Aktivmitglied: [:group_read]
    - Passivmitglied: [:group_read]
    - Ehrenmitglied: []
  - Projektgruppe
    - Mitglied: [:group_read]
    - Leitung: [:group_full]
  - Vorstand
    - Präsident\*in: [:layer_and_below_full]
    - Vorstandsmitglied: [:layer_and_below_full]
    - Sekretär\*in: [:layer_and_below_full]
    - Kassier\*in: [:layer_and_below_full, :finance]
- Kantonalverband
  - Vorstand
    - Präsident\*in: [:layer_and_below_full]
    - Vorstandsmitglied: [:layer_and_below_full]
    - Finanzchef\*in: [:group_read, :finance]
