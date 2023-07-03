CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome_usuario VARCHAR(100)
);

CREATE TABLE Viagem (
    id_viagem SERIAL PRIMARY KEY,
    destino VARCHAR(100),
    data_viagem DATE,
    valor_passagem DECIMAL(10, 2)
);

CREATE TABLE Reserva (
    id_usuario INTEGER,
    id_viagem INTEGER,
    data_reserva DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_viagem) REFERENCES Viagem(id_viagem)
);

/*inserir dados*/
INSERT INTO Usuario (id_usuario, nome_usuario)
VALUES
  (1, 'João'),
  (2, 'Maria'),
  (3, 'Pedro');

INSERT INTO Viagem (id_viagem, destino, data_viagem, valor_passagem)
VALUES
  (1, 'Rio de Janeiro', '2023-07-10', 500),
  (2, 'São Paulo', '2023-07-15', 400),
  (3, 'Salvador', '2023-07-20', 600),
  (4, 'Porto Alegre', '2023-07-25', 300);

INSERT INTO Reserva (id_usuario, id_viagem, data_reserva)
VALUES
  (1, 1, '2023-07-05'),
  (1, 2, '2023-07-10'),
  (2, 1, '2023-07-08'),
  (2, 3, '2023-07-15'),
  (3, 2, '2023-07-12'),
  (3, 4, '2023-07-20');


SELECT U.nome_usuario, SUM(V.valor_passagem) AS total_gasto
FROM Usuario U
JOIN Reserva R ON U.id_usuario = R.id_usuario
JOIN Viagem V ON R.id_viagem = V.id_viagem
WHERE EXTRACT(MONTH FROM R.data_reserva) = 7
GROUP BY U.id_usuario, U.nome_usuario
ORDER BY total_gasto DESC;