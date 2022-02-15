/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

/* ADD SPECIES COLUMN TO ANIMALS TABLE */
ALTER TABLE animals ADD COLUMN species VARCHAR;
