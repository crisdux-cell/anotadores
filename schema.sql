-- Script de Creación de Base de Datos y Tablas para el Sistema Anotador de Béisbol

-- 1. Tabla de Juegos / Anotaciones
CREATE TABLE IF NOT EXISTS juegos (
    id SERIAL PRIMARY KEY,
    numero_juego VARCHAR(20) NOT NULL,
    fecha DATE NOT NULL,
    categoria VARCHAR(50) NOT NULL, -- Semillero, Preparatorio, Preinfantil, etc.
    nivel VARCHAR(50),
    grupo VARCHAR(50),
    campo VARCHAR(100),
    tipo_resultado VARCHAR(20) DEFAULT 'Ganado / Perdedor', -- 'Ganado / Perdedor' o 'Empate'
    
    -- Equipos y Carreras
    equipo_ganador VARCHAR(100) NOT NULL,
    carreras_ganador INT DEFAULT 0,
    equipo_perdedor VARCHAR(100) NOT NULL,
    carreras_perdedor INT DEFAULT 0,
    
    -- Pago e Incidencias
    pago_ganador BOOLEAN DEFAULT FALSE,
    comprobante_ganador_url TEXT,
    pago_perdedor BOOLEAN DEFAULT FALSE,
    comprobante_perdedor_url TEXT,
    evento_tipo VARCHAR(100),
    descripcion_evento TEXT,
    
    -- Datos del Anotador y Jugador MVP
    mvp_nombre VARCHAR(100),
    mvp_foto_url TEXT,
    anotador_nombre VARCHAR(100) NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabla de Lanzadores por Juego
CREATE TABLE IF NOT EXISTS lanzadores (
    id SERIAL PRIMARY KEY,
    juego_id INT REFERENCES juegos(id) ON DELETE CASCADE,
    equipo_rol VARCHAR(20) NOT NULL, -- 'GANADOR' o 'PERDEDOR' (o 'EQUIPO 1' / 'EQUIPO 2')
    nombre VARCHAR(100) NOT NULL,
    lanzamientos INT DEFAULT 0
);

-- 3. Tabla de Receptores por Juego
CREATE TABLE IF NOT EXISTS receptores (
    id SERIAL PRIMARY KEY,
    juego_id INT REFERENCES juegos(id) ON DELETE CASCADE,
    equipo_rol VARCHAR(20) NOT NULL, -- 'GANADOR' o 'PERDEDOR'
    nombre VARCHAR(100) NOT NULL,
    outs INT DEFAULT 0
);

-- Índices recomendados para consultas rápidas
CREATE INDEX IF NOT EXISTS idx_juegos_fecha ON juegos(fecha DESC);
CREATE INDEX IF NOT EXISTS idx_juegos_numero ON juegos(numero_juego);
CREATE INDEX IF NOT EXISTS idx_juegos_categoria ON juegos(categoria);
CREATE INDEX IF NOT EXISTS idx_lanzadores_juego ON lanzadores(juego_id);
CREATE INDEX IF NOT EXISTS idx_receptores_juego ON receptores(juego_id);
