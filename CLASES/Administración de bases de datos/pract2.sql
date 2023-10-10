3-------------------

    CREATE TABLE country (
  country_id SERIAL(15) PRIMARY KEY,
  name character varying(15),
  region_id character varying(25),
  FOREIGN KEY (region_id) REFERENCES region(region_id)
)

ALTER TABLE ONLY orders
    ADD CONSTRAINT region_id PRIMARY KEY (region_id);

country_id  (PK),
 country_name 
 region_id 
 (FK de Region)