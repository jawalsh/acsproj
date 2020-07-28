# Swinburne's Library: READ ME

This file describes the swinburne_library.xml file. This file is part of the [Algernon Charles Swinburne Project](http://swinburnearchive.indiana.edu/swinburne/) about Victorian author Algernon Charles Swinburne.

## General Overview

The contents of the catalogue items were gathered from *Sales Catalogues of Libraries of Eminent Persons*, general editory A. N. L. Munby, Litt. D., Volume 6: Poets and Men of Letters, edited by John Wooldford, 1972, pages 247-336. The items were listed by the size, day, then lot in which they were sold, and the structure of the xml file follows this structure. All of the information given by the sales catalogue is included in the xml file, including but not limited to author, title, year(s)/location of publication, any notes given about the item, and inscriptions. The order of the items in the catalogue is maintained in the xml file. The xml file follows TEI's schema.

## relatedItem and Digital Texts

All available digital copies of each of the texts listed in the cataloge were added to the basic bibliographic information given by the catalogue. These items were added as `relatedItem`s in each biliographic entry. There were four main resources that we looked at to find the items, which were HathiTrust (ht), the Internet Archive (ia), Early English Books Online (eebo), Eighteenth Century Collections Online (ecco), and the Oxford Text Archive (ota) / Text Creation Partnership (tcp). Items found in EEBO were later replaced by the TCP item handles and identification numbers. The type of URL for each item, i.e. which resource it came from, is listed as the `@type` in each `relatedItem`. The majority of the corpus comes from HathiTrust. If an item was multipe volumes, then these items are listed and numbered one after another with `@n` in `relatedItem`. 

## note

Some bibliographic entries have `note`s, which have a few different types, but the most common one is `@type="fulltext"`. This refers to a note we made about the item mentioned in the bibliographic entry, such as a slightly different title or a different, closest year we could find. The other main type of `note` is `@type="description"` which are the notes made in the catalogue itself. This note type also includes information regrading whether or not the item was "uncut" or a "presentation copy."

One feature of note found in the catalogue is the "etc" which, as far as we know, represents a count of items that were also sold in each lot but were not listed in the sales catalogue. These "etc"s were tracked in order to have as accurate a count of the total number of items in Swinburne's library as possible, though this particular data was not necessarily relevant to the research. They are listed as a `@type` in `note`s and contain `@value` that holds the number if "etc"s. 

## XSL Files and Identifiers

XSL files have been written to collect each of the identifiers for each online resource (i.e. ht or tcp) and can be found in this same directory. The purpose of these XSL files is to simplify the ability to keep the text files as up to date as possible by making it easy to bulk download items in the corpus. Each of these files is prefixed with "swinburneLibrary" and then the type of identifiers it gathers from the library. For detailed descriptions of how to conduct bulk downloads from each resource, see the [github wiki](https://github.com/jawalsh/acsproj/wiki). 