/*Queries that provide answers to the questions from all projects.*/

/* MILESTONE 1 */

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE (neutered = TRUE AND escape_attempts < 3);
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = FALSE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.3 AND 17.4;

/* MILESTONE 2 */

/* ADD TRANSACTIONS */

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;
SELECT * FROM animals; /*CHECK THAT CHANGES WERE REVERTED*/

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE name NOT LIKE '%mon';
COMMIT;
SELECT * FROM animals; /* CHCEK IF CHANGES PERSIST AFTER COMMIT */

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT (*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, date_of_birth, AVG(escape_attempts) FROM animals GROUP BY species, date_of_birth HAVING date_of_birth > '1990-01-01' AND date_of_birth < '2000-12-31';

/* MILESTONE 3 */

SELECT name, full_name FROM owners INNER JOIN animals ON owners.id = animals.owner_id WHERE owners.full_name = 'Melody Pond';
SELECT COUNT (name) FROM owners INNER JOIN animals ON owners.id = animals.owner_id WHERE owners.full_name = 'Melody Pond';
SELECT species.name, animals.name FROM species INNER JOIN animals ON species.id = animals.species_id WHERE species.name = 'Pokemon';
SELECT name, full_name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;
SELECT COUNT(animals.name) FROM species INNER JOIN animals ON species.id = animals.species_id WHERE species.name = 'Pokemon';
SELECT COUNT(animals.name) FROM species INNER JOIN animals ON species.id = animals.species_id WHERE species.name = 'Digimon';
SELECT name FROM animals INNER JOIN owners ON owners.id = animals.owner_id WHERE owners.full_name = 'Jennifer Orwell' AND animals.species_id = 2;
SELECT animals.name, full_name FROM owners INNER JOIN animals ON owners.id = animals.owner_id WHERE full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
SELECT COUNT(animals.name), owners.full_name FROM owners INNER JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name;

/* MILESTONE 4 */

/* Who was the last animal seen by William Tatcher? */
SELECT animals.name, date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE vet_id = 1 ORDER BY date_of_visit DESC LIMIT 1;

/* How many different animals did Stephanie Mendez see? */
SELECT COUNT(animals.name) FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE vet_id = 3;

/* List all vets and their specialties, including vets with no specialties. */
SELECT vets.name, species.name FROM vets FULL OUTER JOIN specializations ON vets.id = specializations.vet_id FULL OUTER JOIN species ON species.id = specializations.species_id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT animals.name, date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE vet_id = 3 AND date_of_visit > '2020-04-01' AND date_of_visit < '2020-08-30';

/* What animal has the most visits to vets? */
SELECT animals.name, COUNT (*) AS visits FROM animals JOIN visits ON animals.id = visits.animal_id GROUP BY animals.name HAVING COUNT (*) = (SELECT MAX (visits) FROM (SELECT animals.name, COUNT (*) AS visits FROM animals JOIN visits ON animals.id = visits.animal_id GROUP BY animals.name) animals);

/* Who was Maisy Smith's first visit? */
SELECT animals.name, date_of_visit, vets.name FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Maisy Smith' ORDER BY date_of_visit LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit. */
SELECT animals.name, date_of_birth, weight_kg, vets.name, date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id ORDER BY date_of_visit DESC LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT vets.name, COUNT (*) AS treatment FROM vets JOIN visits ON vets.id = visits.vet_id JOIN specializations ON vets.id = specializations.vet_id WHERE specializations.species_id is NULL GROUP BY vets.name;

/* What specialty should Maisy Smith consider getting? */
SELECT COUNT (*), species.name FROM animals JOIN species ON animals.species_id = species_id JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Maisy Smith' GROUP BY species.name LIMIT 1;