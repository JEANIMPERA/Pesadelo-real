-- Criando a tabela de usuários
CREATE TABLE IF NOT EXISTS usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    senha TEXT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Criando a tabela de histórias
CREATE TABLE IF NOT EXISTS historias (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    conteudo TEXT NOT NULL,
    usuario_id INTEGER NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Criando a tabela de eventos
CREATE TABLE IF NOT EXISTS eventos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    descricao TEXT NOT NULL,
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP NOT NULL,
    localizacao TEXT NOT NULL,
    ativo BOOLEAN DEFAULT 1, -- Se o evento está ativo (1) ou inativo (0)
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Criando a tabela de participação em eventos (para registrar quais usuários se inscreveram)
CREATE TABLE IF NOT EXISTS participacoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER NOT NULL,
    evento_id INTEGER NOT NULL,
    data_inscricao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (evento_id) REFERENCES eventos(id),
    UNIQUE(usuario_id, evento_id) -- Impede que o mesmo usuário se inscreva mais de uma vez no mesmo evento
);

-- Criando a tabela de comentários nas histórias
CREATE TABLE IF NOT EXISTS comentarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER NOT NULL,
    historia_id INTEGER NOT NULL,
    comentario TEXT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (historia_id) REFERENCES historias(id)
);

-- Criando a tabela de curtidas nas histórias (para ver quais histórias são mais populares)
CREATE TABLE IF NOT EXISTS curtidas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER NOT NULL,
    historia_id INTEGER NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (historia_id) REFERENCES historias(id),
    UNIQUE(usuario_id, historia_id) -- Impede que o mesmo usuário curta mais de uma vez a mesma história
);

-- Adicionando alguns dados de exemplo

-- Inserindo usuários de exemplo
INSERT INTO usuarios (nome, email, senha) VALUES 
('Jeanludres', 'jeanludresg2@gmail.com', 'senhaexemplo123'),
('Maria', 'maria@example.com', 'senha123'),
('João', 'joao@example.com', 'senha456');

-- Inserindo histórias de exemplo
INSERT INTO historias (titulo, conteudo, usuario_id) VALUES
('A Noite Sombria', 'Uma história sobre uma noite fria e sombria, onde nada parecia estar no lugar...', 1),
('O Terror do Escuro', 'Uma criatura escura vive nas sombras, aguardando a próxima vítima...', 2);

-- Inserindo eventos de exemplo
INSERT INTO eventos (titulo, descricao, data_inicio, data_fim, localizacao) VALUES
('Noite de Terror', 'Uma experiência imersiva assustadora.', '2025-03-10 20:00:00', '2025-03-10 23:59:59', 'Rua das Trevas, 101'),
('Escape Room Sombrio', 'Desafios aterrorizantes para sobreviver a uma situação extrema.', '2025-03-25 18:00:00', '2025-03-25 21:00:00', 'Centro da Cidade');

-- Inserindo participações de exemplo
INSERT INTO participacoes (usuario_id, evento_id) VALUES 
(1, 1),
(2, 1),
(3, 2);

-- Inserindo comentários de exemplo
INSERT INTO comentarios (usuario_id, historia_id, comentario) VALUES 
(1, 1, 'Muito arrepiante! Uma história de dar calafrios.'),
(2, 2, 'Adorei! O suspense é incrível.');

-- Inserindo curtidas de exemplo
INSERT INTO curtidas (usuario_id, historia_id) VALUES
(1, 1),
(2, 2),
(3, 1);