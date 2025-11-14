CREATE TABLE Photographer (
    id_photographer VARCHAR(20) PRIMARY KEY,
    Experiencie_time VARCHAR(20) NOT NULL
);

CREATE TABLE Magazine (
    id_magazine VARCHAR(20) PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    name VARCHAR(150) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Cameras_model (
    model VARCHAR(100) PRIMARY KEY,
    release_year VARCHAR(10) NOT NULL,
    brand VARCHAR(50) NOT NULL
);

CREATE TABLE Photographer_Camera (
    id_photographer VARCHAR(20) NOT NULL,
    model VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_photographer, model),
    FOREIGN KEY (id_photographer) REFERENCES Photographer(id_photographer),
    FOREIGN KEY (model) REFERENCES Cameras_model(model)
);

CREATE TABLE Lens (
    id_lens VARCHAR(20) PRIMARY KEY,
    mm VARCHAR(20) NOT NULL
);

CREATE TABLE Use_2 (
    model VARCHAR(100) NOT NULL,
    id_lens VARCHAR(20) NOT NULL,
    PRIMARY KEY (model, id_lens),
    FOREIGN KEY (id_lens) REFERENCES Lens(id_lens),
    FOREIGN KEY (model) REFERENCES Cameras_model(model)
);

CREATE TABLE Photos_Style (
    id_style VARCHAR(20) PRIMARY KEY,
    name_style VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Work (
    id_photographer VARCHAR(20) NOT NULL,
    id_magazine VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_photographer, id_magazine),
    FOREIGN KEY (id_photographer) REFERENCES Photographer(id_photographer),
    FOREIGN KEY (id_magazine) REFERENCES Magazine(id_magazine)
);

CREATE TABLE Style (
    id_photographer VARCHAR(20) NOT NULL,
    id_style VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_photographer, id_style),
    FOREIGN KEY (id_photographer) REFERENCES Photographer(id_photographer),
    FOREIGN KEY (id_style) REFERENCES Photos_Style(id_style)
);

-- Data

INSERT INTO Photographer (id_photographer, Experiencie_time) VALUES
('4F69', '4 anos'),
('4861', '2 anos'),
('4C7569', '10 anos'),
('48616861', '1 mês'),
('4569536F72', '3 anos');

INSERT INTO Magazine (id_magazine, city, name) VALUES
('436172726F', 'Porto Alegre', 'Top das Photos'),
('4D6F746F', 'Sapucaia', 'Photos do dia'),
('426F6D', 'Rolante', 'Rolante revistas'),
('48455841', 'Taquara', 'Taquara fotos'),
('53696D', 'Parobé', 'Photos & Fotos');

INSERT INTO Work (id_photographer, id_magazine) VALUES
('4F69', '436172726F'),
('4861', '4D6F746F'),
('4C7569', '426F6D'),
('48616861', '48455841'),
('4569536F72', '53696D');

INSERT INTO Cameras_model (model, release_year, brand) VALUES
('PowerShot Sx510 Hs', '2013', 'Canon'),
('Cybershot dsc-w530', '2010', 'Sony'),
('SL2', '2019', 'Leica'),
('X-t5 Silver Silver', '2022', 'Fujifilm'),
('T3i', '2011', 'Canon');

INSERT INTO Photographer_Camera (id_photographer, model) VALUES
('4F69', 'PowerShot Sx510 Hs'),
('4861', 'Cybershot dsc-w530'),
('4C7569', 'SL2'),
('48616861', 'X-t5 Silver Silver'),
('4569536F72', 'T3i');

INSERT INTO Lens (id_lens, mm) VALUES
('556D', '50'),
('446F6973', '35'),
('5472656973', '75-300'),
('4E7874', '16'),
('46696D', '24-70');

INSERT INTO Use_2 (model, id_lens) VALUES
('PowerShot Sx510 Hs', '556D'),
('Cybershot dsc-w530', '446F6973'),
('SL2', '5472656973'),
('X-t5 Silver Silver', '4E7874'),
('T3i', '46696D');

INSERT INTO Photos_Style (id_style, name_style) VALUES
('487264', 'Street photography'),
('54686973', 'Architectural photography'),
('586F726B', 'Animal photography'),
('427574', 'Event photography'),
('4F6B', 'Bird photography');

INSERT INTO Style (id_photographer, id_style) VALUES
('4F69', '487264'),
('4861', '54686973'),
('4C7569', '586F726B'),
('48616861', '427574'),
('4569536F72', '4F6B');

-- Action

SELECT -- Photographer and his camera
    p.id_photographer,
    p.Experiencie_time,
    m.model,
    m.brand,
    m.release_year
FROM Photographer p
JOIN Photographer_Camera pc ON p.id_photographer = pc.id_photographer
JOIN Cameras_model m ON pc.model = m.model;

SELECT -- Magazine, photographer and style
    p.id_photographer,
    ps.name_style,
    mg.name AS magazine_name,
    mg.city
FROM Photographer p
JOIN Style s ON p.id_photographer = s.id_photographer
JOIN Photos_Style ps ON s.id_style = ps.id_style
JOIN Work w ON p.id_photographer = w.id_photographer
JOIN Magazine mg ON w.id_magazine = mg.id_magazine;
