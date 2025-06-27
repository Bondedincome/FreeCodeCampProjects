CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  description TEXT,
  galaxy_type TEXT,
  apparent_magnitude INT,
  distance_from_earth INT,
  age_in_millions_of_years INT,
  red_shift NUMERIC,
  star_formation_rate NUMERIC,
  number_of_stars NUMERIC, -- changed from INT to NUMERIC
  approx_area NUMERIC,
  mass NUMERIC, -- already NUMERIC
  dominant_star_type TEXT,
  has_black_hole BOOLEAN
);

CREATE TABLE solar_system (
  solar_system_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  description TEXT,
  solar_system_type TEXT,
  age_in_millions_of_years INT,
  approx_area NUMERIC,
  mass NUMERIC,
  number_of_planets INT,
  distance_from_earth INT,
  galaxy_id INT REFERENCES galaxy(galaxy_id)
);

CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  description TEXT,
  star_type TEXT,
  stellar_phase TEXT,
  distance_from_earth INT,
  age_in_millions_of_years INT,
  approx_area NUMERIC,
  luminosity NUMERIC,
  temperature NUMERIC,
  mass NUMERIC,
  radius NUMERIC,
  is_spherical BOOLEAN,
  galaxy_id INT REFERENCES galaxy(galaxy_id)
);

CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  description TEXT,
  planet_type TEXT,
  distance_from_earth INT,
  age_in_millions_of_years INT,
  orbital_period NUMERIC,
  rotation_period NUMERIC,
  radius NUMERIC,
  gravity NUMERIC,
  mass NUMERIC,
  has_life BOOLEAN,
  has_magnetic_field BOOLEAN,
  star_id INT REFERENCES star(star_id),
  solar_system_id INT REFERENCES solar_system(solar_system_id)
);

CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  description TEXT,
  orbital_distance INT,
  age_in_millions_of_years INT,
  orbital_period NUMERIC,
  rotation_period NUMERIC,
  surface_temperature NUMERIC,
  radius NUMERIC,
  approx_area NUMERIC,
  gravity NUMERIC,
  mass NUMERIC,
  has_life BOOLEAN,
  has_tidal_lock_status BOOLEAN,
  is_spherical BOOLEAN,
  has_atmosphere BOOLEAN,
  planet_id INT REFERENCES planet(planet_id)
);

CREATE TABLE species (
  species_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  description TEXT,
  species_type TEXT,
  communication_method TEXT,
  reproduction_method TEXT,
  known_interaction TEXT,
  average_lifespan INT,
  has_intelligence BOOLEAN,
  has_technology BOOLEAN,
  is_endangered BOOLEAN,
  planet_id INT REFERENCES planet(planet_id)
);

-- Insert at least six rows into galaxy
INSERT INTO galaxy (galaxy_id, name, description, galaxy_type, apparent_magnitude, distance_from_earth, age_in_millions_of_years, red_shift, star_formation_rate, number_of_stars, approx_area, mass, dominant_star_type, has_black_hole) VALUES
(1, 'Milky Way', 'Our home galaxy', 'Spiral', 4, 0, 13600, 0.0009, 1.65, 100000000000, 100000, 1500000000000, 'G', TRUE),
(2, 'Andromeda', 'Nearest major galaxy', 'Spiral', 3, 2537000, 10000, 0.001, 1.0, 1000000000000, 220000, 1200000000000, 'A', TRUE),
(3, 'Triangulum', 'Third largest in Local Group', 'Spiral', 6, 3000000, 12000, 0.0007, 0.5, 40000000000, 60000, 50000000000, 'F', FALSE),
(4, 'Whirlpool', 'Famous interacting galaxy', 'Spiral', 8, 23000000, 400, 0.002, 0.8, 160000000000, 60000, 160000000000, 'B', TRUE),
(5, 'Sombrero', 'Unusual bright galaxy', 'Elliptical', 9, 29000000, 900, 0.0015, 0.6, 80000000000, 50000, 80000000000, 'K', FALSE),
(6, 'Pinwheel', 'Face-on spiral galaxy', 'Spiral', 7, 21000000, 1000, 0.0012, 0.7, 100000000000, 70000, 100000000000, 'F', FALSE);

INSERT INTO solar_system (solar_system_id, name, description, solar_system_type, age_in_millions_of_years, approx_area, mass, number_of_planets, distance_from_earth, galaxy_id) VALUES
(1, 'Solar System', 'Our solar system', 'Main Sequence', 4600, 287.46, 1.0014, 8, 0, 1),
(2, 'Alpha Centauri System', 'Closest star system', 'Binary', 6000, 100.0, 2.0, 3, 43000, 1),
(3, 'TRAPPIST-1 System', 'System with 7 Earth-size planets', 'Red Dwarf', 8000, 50.0, 0.08, 7, 39000000, 1);

-- Insert at least six rows into star
INSERT INTO star (star_id, name, description, star_type, stellar_phase, distance_from_earth, age_in_millions_of_years, approx_area, luminosity, temperature, mass, radius, is_spherical, galaxy_id) VALUES
(1, 'Sun', 'The star at the center of our solar system', 'G-type', 'Main Sequence', 0, 4600, 6.09, 1.0, 5778, 1.0, 1.0, TRUE, 1),
(2, 'Alpha Centauri A', 'Closest star to the Sun', 'G-type', 'Main Sequence', 43000, 6000, 5.9, 1.519, 5790, 1.1, 1.2, TRUE, 1),
(3, 'TRAPPIST-1', 'Ultra-cool red dwarf', 'M-type', 'Main Sequence', 39000000, 8000, 0.5, 0.0005, 2550, 0.08, 0.12, TRUE, 1),
(4, 'Betelgeuse', 'Red supergiant in Orion', 'M-type', 'Supergiant', 642, 10000, 1000, 126000, 3500, 20, 950, TRUE, 1),
(5, 'Sirius', 'Brightest star in the night sky', 'A-type', 'Main Sequence', 8600, 242, 1.711, 25.4, 9940, 2.02, 1.71, TRUE, 1),
(6, 'Vega', 'Bright star in Lyra', 'A-type', 'Main Sequence', 25000, 455, 2.726, 40.12, 9602, 2.1, 2.36, TRUE, 1);

-- Insert at least 12 rows into planet
INSERT INTO planet (planet_id, name, description, planet_type, distance_from_earth, age_in_millions_of_years, orbital_period, rotation_period, radius, gravity, mass, has_life, has_magnetic_field, star_id, solar_system_id) VALUES
(1, 'Earth', 'Our home planet', 'Terrestrial', 0, 4540, 365.25, 1.0, 6371, 9.8, 1.0, TRUE, TRUE, 1, 1),
(2, 'Mars', 'The red planet', 'Terrestrial', 225, 4500, 687, 1.03, 3389, 3.7, 0.107, FALSE, TRUE, 1, 1),
(3, 'TRAPPIST-1e', 'Potentially habitable exoplanet', 'Terrestrial', 39000000, 8000, 6.1, 1.0, 5810, 9.1, 0.62, FALSE, FALSE, 3, 3),
(4, 'Venus', 'Second planet from the Sun', 'Terrestrial', 41, 4500, 224.7, -243, 6052, 8.87, 0.815, FALSE, FALSE, 1, 1),
(5, 'Jupiter', 'Largest planet in the Solar System', 'Gas Giant', 778, 4500, 4332.6, 0.41, 69911, 24.79, 317.8, FALSE, TRUE, 1, 1),
(6, 'Saturn', 'Ringed gas giant', 'Gas Giant', 1430, 4500, 10759, 0.45, 58232, 10.44, 95.2, FALSE, TRUE, 1, 1),
(7, 'Uranus', 'Ice giant', 'Ice Giant', 2871, 4500, 30687, -0.72, 25362, 8.87, 14.5, FALSE, TRUE, 1, 1),
(8, 'Neptune', 'Farthest planet from the Sun', 'Ice Giant', 4495, 4500, 60190, 0.67, 24622, 11.15, 17.1, FALSE, TRUE, 1, 1),
(9, 'Mercury', 'Closest planet to the Sun', 'Terrestrial', 58, 4500, 87.97, 58.6, 2439, 3.7, 0.055, FALSE, FALSE, 1, 1),
(10, 'Proxima b', 'Exoplanet orbiting Proxima Centauri', 'Terrestrial', 43000, 4800, 11.2, 1.0, 7160, 10.0, 1.27, FALSE, FALSE, 2, 2),
(11, 'Kepler-22b', 'Exoplanet in habitable zone', 'Super-Earth', 600, 6000, 289.9, 1.0, 24500, 9.8, 36.0, FALSE, FALSE, 4, 2),
(12, 'HD 209458 b', 'Hot Jupiter', 'Gas Giant', 150, 5000, 3.5, 1.0, 143000, 9.4, 220, FALSE, FALSE, 5, 2);

-- Insert at least 20 rows into moon
INSERT INTO moon (moon_id, name, description, orbital_distance, age_in_millions_of_years, orbital_period, rotation_period, surface_temperature, radius, approx_area, gravity, mass, has_life, has_tidal_lock_status, is_spherical, has_atmosphere, planet_id) VALUES
(1, 'Moon', 'Earth''s only natural satellite', 384400, 4500, 27.3, 27.3, 220, 1737, 37932000, 1.62, 0.0123, FALSE, TRUE, TRUE, FALSE, 1),
(2, 'Phobos', 'Largest moon of Mars', 9376, 4500, 0.319, 0.319, -40, 11.1, 154, 0.0057, 10659000000000000, FALSE, TRUE, FALSE, FALSE, 2),
(3, 'Deimos', 'Smallest moon of Mars', 23460, 4500, 1.263, 1.263, -40, 6.2, 121, 0.003, 1476200000000000, FALSE, TRUE, FALSE, FALSE, 2),
(4, 'Io', 'Volcanically active moon of Jupiter', 421700, 4500, 1.769, 1.769, -143, 1821, 41500000, 1.796, 0.015, FALSE, TRUE, TRUE, FALSE, 5),
(5, 'Europa', 'Icy moon of Jupiter', 670900, 4500, 3.551, 3.551, -160, 1560, 30600000, 1.314, 0.008, FALSE, TRUE, TRUE, FALSE, 5),
(6, 'Ganymede', 'Largest moon in the Solar System', 1070400, 4500, 7.155, 7.155, -163, 2634, 87000000, 1.428, 0.025, FALSE, TRUE, TRUE, FALSE, 5),
(7, 'Callisto', 'Heavily cratered moon of Jupiter', 1882700, 4500, 16.689, 16.689, -139, 2410, 73000000, 1.235, 0.018, FALSE, TRUE, TRUE, FALSE, 5),
(8, 'Titan', 'Largest moon of Saturn', 1221870, 4500, 15.945, 15.945, -179, 2575, 83000000, 1.352, 0.022, FALSE, TRUE, TRUE, TRUE, 6),
(9, 'Rhea', 'Second largest moon of Saturn', 527040, 4500, 4.518, 4.518, -174, 764, 7330000, 0.264, 0.00023, FALSE, TRUE, TRUE, FALSE, 6),
(10, 'Iapetus', 'Two-toned moon of Saturn', 3561300, 4500, 79.321, 79.321, -143, 734, 6760000, 0.223, 0.00018, FALSE, TRUE, TRUE, FALSE, 6),
(11, 'Dione', 'Icy moon of Saturn', 377400, 4500, 2.737, 2.737, -186, 561, 990000, 0.232, 0.00011, FALSE, TRUE, TRUE, FALSE, 6),
(12, 'Tethys', 'Bright moon of Saturn', 294660, 4500, 1.888, 1.888, -187, 531, 890000, 0.145, 0.00062, FALSE, TRUE, TRUE, FALSE, 6),
(13, 'Enceladus', 'Geyser moon of Saturn', 238040, 4500, 1.370, 1.370, -201, 252, 800000, 0.113, 0.00018, FALSE, TRUE, TRUE, FALSE, 6),
(14, 'Miranda', 'Smallest major moon of Uranus', 129900, 4500, 1.413, 1.413, -187, 236, 700000, 0.079, 0.00007, FALSE, TRUE, TRUE, FALSE, 7),
(15, 'Ariel', 'Brightest moon of Uranus', 191020, 4500, 2.520, 2.520, -213, 579, 1050000, 0.269, 0.00013, FALSE, TRUE, TRUE, FALSE, 7),
(16, 'Umbriel', 'Dark moon of Uranus', 266000, 4500, 4.144, 4.144, -214, 584, 1070000, 0.238, 0.00012, FALSE, TRUE, TRUE, FALSE, 7),
(17, 'Titania', 'Largest moon of Uranus', 436300, 4500, 8.706, 8.706, -203, 789, 1960000, 0.379, 0.00035, FALSE, TRUE, TRUE, FALSE, 7),
(18, 'Oberon', 'Second largest moon of Uranus', 583500, 4500, 13.463, 13.463, -203, 761, 1820000, 0.346, 0.00030, FALSE, TRUE, TRUE, FALSE, 7),
(19, 'Triton', 'Largest moon of Neptune', 354800, 4500, 5.877, 5.877, -235, 1353, 2300000, 0.779, 0.0036, FALSE, TRUE, TRUE, TRUE, 8),
(20, 'Nereid', 'Outer moon of Neptune', 5513400, 4500, 360.13, 360.13, -220, 170, 90000, 0.033, 0.00003, FALSE, TRUE, TRUE, FALSE, 8);

INSERT INTO species (species_id, name, description, species_type, communication_method, reproduction_method, known_interaction, average_lifespan, has_intelligence, has_technology, is_endangered, planet_id) VALUES
(1, 'Homo sapiens', 'Modern humans', 'Mammal', 'Speech', 'Sexual', 'Global', 79, TRUE, TRUE, FALSE, 1),
(2, 'Canis lupus', 'Gray wolf', 'Mammal', 'Vocalization', 'Sexual', 'Pack hunting', 8, FALSE, FALSE, TRUE, 1),
(3, 'Martian Microbe', 'Hypothetical life on Mars', 'Microbe', 'Chemical', 'Asexual', 'Unknown', 1, FALSE, FALSE, TRUE, 2);