# Documentation for Recording Letter References
## Intro
In __letter_refs.csv__ we are recording references to written works that are mentioned in the General Index to Swinburne's letters found in vol. 6 of *The Swinburne Letters* edited by Cecil Lang. Down the line, our intention is to check these references to see if they contain information about what books Swinburne owned, when or how he acquired them, and how he is using them (such as quoting them in his letters, for example).

## Fields
- **First Level** (req, string): the keyword that is a main entry in the index. In other words, the phrase that is alphabetized in the index. This is often an author, but it could be a work ("Aesop, Fables of"), editor ("Ainger, Alfred, ed."), or translator ("Amiot, J., translator"). All entries will have a first level
- **Second Level** (req if present, string): the next level of distinction in an index entry. Where the __first level__ is an author, this is often one of their works. Not all entries will have a second level, but if they have a second level, there must be a first level.
    - If there is no second level, leave it blank
- __Third Level__(req if present, string): One more level of distinction down from the __second level__. See for example, "Aeschylus (first level), _Agamemnon_ (second level), Browning's translation (third level). Not all entries will have a third level. If they have a third level, there must be a second level.
    - If there is no third level, leave it blank
- __Volume__(req, integer): Number of the volume in the Lang edition that the reference appears in. Given in roman numerals in the index (II), but we record in arabic numberals (2). 
- __Page__(req, integer, range, or integer*n*): Page numbers in the Lang edition that the reference appears on. Some pages have an "n" next to them that indicates they are footnotes. Record the "n" with the page number (e.g., 163n). 
- __Quote__(req, yes/no): Indicates that the work is quoted by Swinburne or the editor.
    - Record "yes" if the reference has an asterisk (\*) next to the page number.
    - Record "no" if the reference does _not_ have an asterisk next to the page number
- __Notes__(optional, string): Enter an additional information about the reference in the notes field if necessary. Otherwise leave blank.

## Topics to Record
- Works with or without an author, editor, translator (Titles of works are italicized in the index)
- Under the first level heading of "Swinburne, Algernon Charles" (begins p. 411)
    - France?
        - literature of (second level)
    - Greek literature?
    - History?
    - ~~__Library__~~ Done
    - Literary criticism?
    - Newspapers and magazines

## Topics _not_ to Record
- Translations of Swinburne's own work
    - e.g. "Albrecht, Graf von Wickenburg, tr., _Atalanta in Calydon_" 
    - **Can use index (p. 420-429) to determine titles of Swinburne's works
- Reviews of Swinburne's own work

## Workflow
1. Go to the place in the General Index that you are working on
2. Begin to scan through the first level alphabetized entries looking for the names of authors, editors, or translators that have works under them or titles of works that are themselves first level entries. 
    - _Titles are italicized which should help with skimming._
3. When you find a first level entry that should be recorded, input the text of the index entry into the __First Level__ field of the CSV file. 
4. If there is a second level entry, record that in __Second Level__. If not, leave it blank.
5. If there is a third level entry, record that in __Third Level__. If not, leave it blank.
6. Next, record the volume number for the reference which will be in roman numerals. 
    - I = 1
    - II = 2
    - III = 3
    - IV = 4
    - V = 5
    - VI = 6
7. Record the page number for the reference. If it is a range, input the range. If it is a footnote (meaning there is an "n" next to the page number), record it as Xn (e.g., 39n).
8. If there is no asterisk after the page number (e.g., 80\*), record "no" in __Quote__. If there is, record "yes" in __Quote__.
9. Finally, add any notes if necessary in __Notes__
10. Repeat these steps, recording every reference that seems relevant.

## Example
Taken from p. 319 of vol. 6
"Aeschylus, ...[several second level headings]..., _Agamemnon_, II, 191\*, 302\*, IV, 122, V, 163-64, 171, 196, Browning's tr. of, IV, 26\*, 27, 31, 73, VI, 84, FitzGerald's tr. of, IV, 31 VI, 84, 187, Headlam's tr. of, VI, 147; _Oresteia_, IV, 26; _The Persae_, V, 163-64, 171; VI, 295"

In this example:
- first level = Aeschylus
- second level headings = 
    - Agamemnon
    - Oresteia
    - The Persae
- third level headings = 
    - Browning's tr(anslation). of (Agamemnon)
    - FitzGerald's tr(anslation). of (Agamemnon)
    - Headlam's tr(anslation). of (Agamemnon)
The references would be recorded as in the following table:

| First Level | Second Level | Third Level                 | Volume | Page    | Quote | Notes |
|-------------|--------------|-----------------------------|--------|---------|-------|-------|
| Aeschylus   | Agamemnon    |                             | 2      | 191     | yes   |       |
| Aeschylus   | Agamemnon    |                             | 2      | 302     | yes   |       |
| Aeschylus   | Agamemnon    |                             | 4      | 122     | no    |       |
| Aeschylus   | Agamemnon    |                             | 5      | 163-164 | no    |       |
| Aeschylus   | Agamemnon    |                             | 5      | 171     | no    |       |
| Aeschylus   | Agamemnon    |                             | 5      | 196     | no    |       |
| Aeschylus   | Agamemnon    | Browning's translation of   | 4      | 26      | yes   |       |
| Aeschylus   | Agamemnon    | Browning's translation of   | 4      | 27      | no    |       |
| Aeschylus   | Agamemnon    | Browning's translation of   | 4      | 31      | no    |       |
| Aeschylus   | Agamemnon    | Browning's translation of   | 4      | 73      | no    |       |
| Aeschylus   | Agamemnon    | Browning's translation of   | 5      | 84      | no    |       |
| Aeschylus   | Agamemnon    | FitzGerald's translation of | 4      | 31      | no    |       |
| Aeschylus   | Agamemnon    | FitzGerald's translation of | 6      | 84      | no    |       |
| Aeschylus   | Agamemnon    | FitzGerald's translation of | 6      | 187     | no    |       |
| Aeschylus   | Agamemnon    | Headlam's translation of    | 6      | 147     | no    |       |
| Aeschylus   | Oresteia     |                             | 4      | 26      | no    |       |
| Aeschylus   | The Persae   |                             | 5      | 163-164 | no    |       |
| Aeschylus   | The Persae   |                             | 5      | 171     | no    |       |
| Aeschylus   | The Persae   |                             | 6      | 295     | no    |       |
