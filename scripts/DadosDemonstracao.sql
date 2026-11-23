-- Dados exclusivamente ficticios para demonstracao.
INSERT INTO public.produto (codigo, nome, marca, preco) VALUES
  (1001, 'Notebook Demonstracao', 'Marca Demo', 3499.90),
  (1002, 'Mouse Sem Fio', 'Marca Demo', 89.90),
  (1003, 'Teclado Compacto', 'Marca Demo', 129.90),
  (1004, 'Monitor 24 Pol.', 'Marca Demo', 899.00),
  (1005, 'Headset USB', 'Marca Demo', 159.90)
ON CONFLICT (codigo) DO UPDATE SET
  nome = EXCLUDED.nome,
  marca = EXCLUDED.marca,
  preco = EXCLUDED.preco;
