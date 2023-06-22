-- CRIANCO E RELACIONANDO TABELAS

CREATE TABLE tb_carga (
  id_carga serial PRIMARY KEY NOT NULL,
  id_remetente integer NOT NULL,
  id_destinatario integer NOT NULL,
  carga_sensivel boolean NOT NULL,
  carga_perecivel boolean NOT NULL,
  UNIQUE (id_remetente),
  UNIQUE (id_destinatario)
);

CREATE TABLE tb_tipo_carga (
  id_carga integer NOT NULL PRIMARY KEY,
  peso_carga numeric NOT NULL,
  temp_limite numeric,
  data_vencimento date
);
ALTER TABLE tb_tipo_carga
ADD CONSTRAINT fk_id_carga FOREIGN KEY (id_carga)
REFERENCES tb_carga (id_carga)
ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE tb_remetente (
  id_remetente integer NOT NULL PRIMARY KEY,
  nome_remetente varchar(60) NOT NULL,
  porto_remetente varchar(60) NOT NULL
);

ALTER TABLE tb_remetente
ADD CONSTRAINT fk_id_remetente FOREIGN KEY (id_remetente)
REFERENCES tb_carga (id_remetente)
ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE tb_destinatario (
  id_destinatario integer NOT NULL PRIMARY KEY,
  nome_destinatario varchar(60) NOT NULL,
  porto_destinatario varchar(60) NOT NULL
);
ALTER TABLE tb_destinatario
ADD CONSTRAINT fk_id_destinatario FOREIGN KEY (id_destinatario)
REFERENCES tb_carga (id_destinatario)
ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE tb_embarcacao (
  id_carga integer NOT NULL PRIMARY KEY,
  id_rota integer NOT NULL,
  data_saida date NOT NULL,
  data_previsao_chegada date NOT NULL,
  data_chegada date NOT NULL
);
ALTER TABLE tb_embarcacao
ADD CONSTRAINT fk_id_embarcacao FOREIGN KEY (id_carga)
REFERENCES tb_carga (id_carga)
ON DELETE CASCADE ON UPDATE CASCADE;

--INSERINDO DADOS

INSERT INTO tb_carga (id_remetente, id_destinatario, carga_sensivel, carga_perecivel)
  VALUES ('100', '2509', 'no', 'yes'),
  ('101', '2211', 'no', 'yes'),
  ('102', '1811', 'no', 'yes'),
  ('103', '2306', 'no', 'yes'),
  ('104', '1608', 'no', 'yes'),
  ('105', '1902', 'yes', 'no'),
  ('106', '3312', 'yes', 'yes'),
  ('107', '2712', 'yes', 'no'),
  ('108', '2706', 'no', 'yes'),
  ('109', '2312', 'no', 'no'),
  ('110', '1810', 'yes', 'yes'),
  ('111', '2609', 'no', 'yes'),
  ('112', '1206', 'no', 'yes');

INSERT INTO tb_tipo_carga
  VALUES ('1', '20', NULL, '31/12/2023'),
  ('2', '15', NULL, '20/10/2023'),
  ('3', '1.5', NULL, '31/12/2023'),
  ('4', '7', NULL, '30/07/2023'),
  ('5', '10', NULL, '15/10/2023'),
  ('6', '1', '50', NULL),
  ('7', '0.5', '30', '30/11/2024'),
  ('8', '15', '60', NULL),
  ('9', '2.5', NULL, '20/10/2023'),
  ('10', '5', NULL, NULL),
  ('11', '2', '40', '30/11/2023'),
  ('12', '1', NULL, '31/07/2023'),
  ('13', '5', NULL, '15/09/2023');

INSERT INTO tb_remetente
  VALUES ('100', 'Tiago Vettorazzi', 'Fortaleza'),
  ('101', 'Hendrika Oliveira', 'Fortaleza'),
  ('102', 'Calos Tomaz', 'Fortaleza'),
  ('103', 'Davi da Silva', 'Fortaleza'),
  ('104', 'Angela Teneorio', 'Fortaleza'),
  ('105', 'Mariana Madeira', 'Fortaleza'),
  ('106', 'Badu Pereira', 'Fortaleza'),
  ('107', 'Thor da Costa', 'Fortaleza'),
  ('108', 'Adam Sandler', 'Fortaleza'),
  ('109', 'Chris Martin', 'Fortaleza'),
  ('110', 'Arrascaeta', 'Fortaleza'),
  ('111', 'Everton Ribeiro', 'Fortaleza'),
  ('112', 'Vinicius Jr', 'Fortaleza');

INSERT INTO tb_destinatario
  VALUES ('2509', 'Ted Mosby', 'Recife'),
  ('2211', 'Barney Stinson', 'Recife'),
  ('1811', 'Robin Mosby', 'Recife'),
  ('2306', 'Phil Dunphy', 'Recife'),
  ('1608', 'Gloria Delgado', 'Recife'),
  ('1902', 'Jake Peralta', 'Recife'),
  ('3312', 'Jon Snow', 'Rio de janeiro'),
  ('2712', 'Sansa Stark', 'Rio de janeiro'),
  ('2706', 'Harry Potter', 'Rio de janeiro'),
  ('2312', 'Hermione Potter', 'Rio de janeiro'),
  ('1810', 'Percy Jackson', 'Rio de janeiro'),
  ('2609', 'Max Verstappen', 'Rio de janeiro'),
  ('1206', 'Lewis Hamilton', 'Rio de janeiro');

INSERT INTO tb_embarcacao
  VALUES ('1', '500', '15/04/2023', '18/04/2023', '17/04/2023'),
  ('2', '500', '15/04/2023', '18/04/2023', '17/04/2023'),
  ('3', '500', '15/04/2023', '18/04/2023', '17/04/2023'),
  ('4', '500', '15/04/2023', '18/04/2023', '17/04/2023'),
  ('5', '500', '15/04/2023', '18/04/2023', '17/04/2023'),
  ('6', '500', '15/04/2023', '18/04/2023', '17/04/2023'),
  ('7', '501', '20/04/2023', '24/04/2023', '24/04/2023'),
  ('8', '501', '20/04/2023', '24/04/2023', '24/04/2023'),
  ('9', '501', '20/04/2023', '24/04/2023', '24/04/2023'),
  ('10', '501', '20/04/2023', '24/04/2023', '24/04/2023'),
  ('11', '501', '20/04/2023', '24/04/2023', '24/04/2023'),
  ('12', '501', '20/04/2023', '24/04/2023', '24/04/2023'),
  ('13', '501', '20/04/2023', '24/04/2023', '24/04/2023');

SELECT * FROM tb_carga
SELECT * FROM tb_tipo_carga
SELECT * FROM tb_remetente
SELECT * FROM tb_destinatario
SELECT * FROM tb_embarcacao 

--CRIANDO VIEWS
CREATE VIEW remetente AS
SELECT
  id_carga,
  tb_carga.id_remetente,
  nome_remetente,
  porto_remetente
FROM tb_carga
JOIN tb_remetente
  ON tb_remetente.id_remetente = tb_carga.id_remetente;

CREATE VIEW cargas_sensiveis AS
SELECT
  tb_tipo_carga.id_carga,
  id_remetente,
  id_destinatario,
  peso_carga AS peso_kg,
  temp_limite AS temperatura_max_C°
FROM tb_tipo_carga
JOIN tb_carga ON tb_carga.id_carga = tb_tipo_carga.id_carga
WHERE temp_limite IS NOT NULL;

CREATE VIEW cargas_pereciveis AS
SELECT
  tb_tipo_carga.id_carga,
  id_remetente,
  id_destinatario,
  peso_carga AS peso_kg,
  data_vencimento
FROM tb_tipo_carga
JOIN tb_carga ON tb_carga.id_carga = tb_tipo_carga.id_carga
WHERE data_vencimento IS NOT NULL;

CREATE VIEW remetente_destinatario AS
SELECT
  id_carga,
  nome_remetente,
  porto_remetente,
  nome_destinatario,
  porto_destinatario
FROM tb_carga
JOIN tb_remetente
  ON tb_remetente.id_remetente = tb_carga.id_remetente
JOIN tb_destinatario
  ON tb_destinatario.id_destinatario = tb_carga.id_destinatario;

CREATE VIEW informacoes_gerais AS
SELECT
  tb_carga.id_carga,
  id_rota,
  porto_remetente AS porto_saída,
  nome_remetente AS remetente,
  porto_destinatario AS porto_destino,
  nome_destinatario AS destinatario,
  peso_carga AS peso_kg,
  temp_limite AS sensibilidade_C°,
  data_vencimento AS vencimento,
  data_saida AS saída,
  data_chegada AS chegada
FROM tb_carga
JOIN tb_embarcacao
  ON tb_embarcacao.id_carga = tb_carga.id_carga
JOIN tb_remetente
  ON tb_remetente.id_remetente = tb_carga.id_remetente
JOIN tb_destinatario
  ON tb_destinatario.id_destinatario = tb_carga.id_destinatario
JOIN tb_tipo_carga
  ON tb_tipo_carga.id_carga = tb_carga.id_carga;

CREATE VIEW rota_informacoes AS
SELECT
  id_rota,
  ROUND(AVG(sensibilidade_C°),2) AS temperatura_media,
  SUM(peso_kg) AS peso_total
  FROM informacoes_gerais
GROUP BY id_rota;

SELECT * FROM remetente
SELECT * FROM cargas_sensiveis
SELECT * FROM cargas_pereciveis
SELECT * FROM remetente_destinatario
SELECT * FROM informacoes_gerais
SELECT * FROM rota_informacoes

-- Consultas com views

SELECT * FROM informacoes_gerais
WHERE porto_destino = 'Recife'
AND id_carga BETWEEN 1 AND 5
AND sensibilidade_C IS NULL
ORDER BY peso_kg DESC;

SELECT
  remetente,
  peso_kg,
  id_rota
FROM informacoes_gerais
WHERE peso_kg > 5

SELECT
  id_carga,
  id_remetente,
  id_destinatario,
  date_part('month', data_vencimento) AS mes_vencimento
FROM cargas_pereciveis
ORDER BY mes_vencimento;

SELECT * FROM remetente_destinatario
WHERE porto_destinatario = 'Rio de janeiro'
UNION
SELECT * FROM remetente_destinatario
WHERE porto_destinatario = 'Recife';

SELECT * FROM informacoes_gerais
WHERE remetente LIKE '%a'






