Feature: Give language group facilitators extra group permissions

  As a language group facilitator
  So that I can lead language groups
  I want to have extra permissions
  
Background: student has been added to a group
  Given the following facilitators exist:
   | first_name | sid     |        email        | first_lang_preference | fluent_languages | id |
   |  Billy     | 1234566 |  billy@berkeley.edu |  english              | [English]        | 1  |

  Given the following groups exist:
  | language | day      | time  | location  | facilitator | id |
  | Spanish  | Tuesday  | 2-3PM | 1 Evans   | 1           | 4  |
  | Mandarin | Monday   | 5-6PM | 1 Evans   | 2           | 5  |
  | German   | Friday   | 3-4PM | 10 Chavez | 3           | 6  |


Scenario: Facilitator views/creates/edits/deletes group info
  Then Chris says this passes













