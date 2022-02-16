/* Database schema to keep the structure of entire database. */

/* MILESTONE 1 */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

/* MILESTONE 2 */

/* ADD SPECIES COLUMN TO ANIMALS TABLE */
ALTER TABLE animals ADD COLUMN species VARCHAR;

/* MILESTONE 3 */

/* CREATE OWNERS TABLE */
CREATE TABLE owners (id SERIAL PRIMARY KEY, full_name VARCHAR(250), age INTEGER);

/* CREATE SPECIES TABLE */
CREATE TABLE species (id SERIAL PRIMARY KEY, name VARCHAR(250));

/* CHANGE ANIMALS TABLE */
ALTER TABLE animals ADD PRIMARY KEY(id);
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT species_constraint FOREIGN KEY (species_id) REFERENCES species;
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT owner_constraint FOREIGN KEY (owner_id) REFERENCES owners;

/* MILESTONE 4 */

/* CREATE VETS TABLE */
CREATE TABLE vets (id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, name VARCHAR(250), age INT, date_of_graduation DATE);

/* CREATE SPECIALIZATIONS TABLE */
CREATE TABLE specializations (vet_id INT, species_id INT, FOREIGN KEY(vet_id) REFERENCES vets(id), FOREIGN KEY(species_id) REFERENCES species(id), PRIMARY KEY(vet_id, species_id));

/* CREATE VISITS TABLE */
CREATE TABLE visits (animal_id INT, vet_id INT, date_of_visit DATE, FOREIGN KEY(animal_id) REFERENCES animals(id), FOREIGN KEY(vet_id) REFERENCES vets(id), PRIMARY KEY(animal_id, vet_id));