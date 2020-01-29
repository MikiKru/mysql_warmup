#MS4
CREATE TABLE skocznie (
    id_skoczni integer,
    miasto text,
    kraj_s text,
    nazwa text,
    k integer,
    sedz integer
);
#MS5
CREATE TABLE trenerzy (
    kraj text,
    imie_t text,
    nazwisko_t text,
    data_ur_t date
);
#MS6
CREATE TABLE zawodnicy (
    id_skoczka integer,
    imie text,
    nazwisko text,
    kraj character(3),
    data_ur date,
    wzrost integer,
    waga integer
);
#MS7
CREATE TABLE zawody (
    id_zawodow integer,
    id_skoczni integer,
    data date
);
#MS8
CREATE TABLE kibice (
    imie_k TEXT,
    nazwisko_k TEXT,
    data_ur_k DATE,
    kraj TEXT,
    wzrost INTEGER
);