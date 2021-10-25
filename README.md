# hitobito skv
A hitobito wagon defining the organization hierarchy and additional features for Swiss Canoe.
(Schweizerischer Kanu-Verband)


## Organization Hierarchy

* Schweizerischer Kanu-Verband
* Kantonalverband
* Verein
    * Verein
        * Leiter*in: [:layer_full]
        * Mitglied: [:layer_read]
* Global
    * Vorstand
        * Präsident*in: [:layer_and_below_full]
        * Kassier*in: [:layer_and_below_read]
        * Mitglied: [:layer_read]


(Output of rake app:hitobito:roles)