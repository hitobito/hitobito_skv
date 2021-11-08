# hitobito skv

A hitobito wagon defining the organization hierarchy and additional features for Swiss Canoe.
(Schweizerischer Kanu-Verband)

## Organization Hierarchy

- Schweizerischer Kanu-Verband
  - Vorstand
    - Präsident\*in: [:group_full]
    - Finanzchef\*in: [:group_full, :finance]
    - Vorstandsmitglied: [:group_read]
  - Geschäftsleitung
    - Mitarbeitende\*r: [:layer_and_below_full]
  - Mitarbeitende
    - Trainer\*in: [:group_full]
    - Mitarbeitende\*r: [:group_read]
  - Externe Kontakte
    - Externer Kontakt: []
    - Swiss Canoe Partner: []
  - Fachkommission
    - Chef\*in: [:group_full]
    - Mitglied: [:group_read]
  - Mitglieder
    - Mitglied: [:group_read]
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
- Kantonalverband
  - Vorstand
    - Präsident\*in: [:layer_and_below_full]
    - Vorstandsmitglied: [:layer_and_below_full]
    - Finanzchef\*in: [:group_read, :finance]
- Global
  - Sektion
    - Vorstand
      - Präsident:in [:group_full]
      - Kassier:in [:finance]
      - Sekretär:in [:group_full]
      - Vorstandsmitglied [:group_full]
    - Projektgruppe
      - Mitglied [:group_read]
      - Leitung [:group_full]
    - Finanzchef\*in: [:group_read, :finance]
    - J+S Coach: [:group_full]
    - Junior\*in: [:group_read]
    - Aktivmitglied: [:group_read]
    - Passivmitglied: [:group_read]
    - Ehrenmitglied: []
