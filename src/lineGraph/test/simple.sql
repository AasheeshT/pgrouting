DROP TABLE IF EXISTS edge_table11;
Create Table edge_table11(
    id BIGINT,
    source BIGINT,
    target BIGINT,
    cost FLOAT,
    reverse_cost FLOAT
);

INSERT INTO edge_table11(id, source, target, cost, reverse_cost) VALUES
(1, 1, 2, 7, 7),
(2, 1, 3, 6, 9),
(3, 1, 6, 14, 14),
(4, 2, 3, 10, 10),
(5, 2, 4, 15, 15),
(6, 3, 4, 11, 11),
(7, 3, 6, 2, 2),
(8, 4, 5, 6, 6),
(9, 5, 6, 9, 9);

WITH the_unique_vertices_of_the_graph AS (
(SELECT DISTINCT source AS id from edge_table11)
UNION
(SELECT DISTINCT source from edge_table11))
SELECT * INTO edge_table11_vertices_pgr
FROM the_unique_vertices_of_the_graph;

SELECT * FROM pgr_dijkstra(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table11',
    2, 3
);

UPDATE edge_table11 SET cost = cost + 0.001*id*id, reverse_cost = reverse_cost + 0.001*id*id;

SELECT * FROM pgr_dijkstra(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table11',
    2, 3
);
