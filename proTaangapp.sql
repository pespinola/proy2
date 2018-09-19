--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.8
-- Dumped by pg_dump version 9.4.8
-- Started on 2018-09-14 16:43:00

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2217 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 178 (class 1259 OID 44202)
-- Name: abogado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE abogado (
    id_abogado integer NOT NULL,
    id_usuario integer NOT NULL,
    nombre character varying NOT NULL,
    apellido character varying NOT NULL,
    direccion character varying NOT NULL,
    telefono character varying NOT NULL,
    ci numeric(10,0) NOT NULL,
    registro_profesional character varying
);


ALTER TABLE abogado OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 44200)
-- Name: abogado_id_abogado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE abogado_id_abogado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abogado_id_abogado_seq OWNER TO postgres;

--
-- TOC entry 2218 (class 0 OID 0)
-- Dependencies: 177
-- Name: abogado_id_abogado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE abogado_id_abogado_seq OWNED BY abogado.id_abogado;


--
-- TOC entry 181 (class 1259 OID 44235)
-- Name: clase; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE clase (
    nro_clase numeric NOT NULL,
    descripcion character varying NOT NULL,
    version numeric NOT NULL
);


ALTER TABLE clase OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 44218)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cliente (
    id_cliente integer NOT NULL,
    id_usuario integer NOT NULL,
    estado character varying NOT NULL,
    nombre character varying,
    apellido character varying,
    direccion character varying NOT NULL,
    telefono character varying NOT NULL,
    ci numeric(8,0),
    ruc character varying,
    razon_social character varying,
    tipo_cliente character varying(1) NOT NULL,
    CONSTRAINT ck_estado_cliente CHECK ((((estado)::text ~~ 'ACTIVO'::text) OR ((estado)::text ~~ 'INACTIVO'::text))),
    CONSTRAINT ck_tipo_cliente CHECK ((((tipo_cliente)::text ~~ 'F'::text) OR ((tipo_cliente)::text ~~ 'J'::text)))
);


ALTER TABLE cliente OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 44216)
-- Name: cliente_id_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cliente_id_cliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cliente_id_cliente_seq OWNER TO postgres;

--
-- TOC entry 2219 (class 0 OID 0)
-- Dependencies: 179
-- Name: cliente_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cliente_id_cliente_seq OWNED BY cliente.id_cliente;


--
-- TOC entry 196 (class 1259 OID 44357)
-- Name: documento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE documento (
    id_documento integer NOT NULL,
    id_expediente integer NOT NULL,
    id_tipo_documento integer NOT NULL,
    descripcion character varying NOT NULL,
    fecha date NOT NULL,
    documento bytea NOT NULL,
    orden numeric,
    nombre_documento character varying NOT NULL
);


ALTER TABLE documento OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 44355)
-- Name: documento_id_documento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE documento_id_documento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documento_id_documento_seq OWNER TO postgres;

--
-- TOC entry 2220 (class 0 OID 0)
-- Dependencies: 195
-- Name: documento_id_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE documento_id_documento_seq OWNED BY documento.id_documento;


--
-- TOC entry 184 (class 1259 OID 44254)
-- Name: estado_marca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE estado_marca (
    id_estado integer NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE estado_marca OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 44252)
-- Name: estado_marca_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE estado_marca_id_estado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estado_marca_id_estado_seq OWNER TO postgres;

--
-- TOC entry 2221 (class 0 OID 0)
-- Dependencies: 183
-- Name: estado_marca_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE estado_marca_id_estado_seq OWNED BY estado_marca.id_estado;


--
-- TOC entry 198 (class 1259 OID 44378)
-- Name: evento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE evento (
    id_evento integer NOT NULL,
    id_expediente integer NOT NULL,
    descripcion character varying NOT NULL,
    fecha date NOT NULL,
    nombre character varying NOT NULL
);


ALTER TABLE evento OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 44376)
-- Name: evento_id_evento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE evento_id_evento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evento_id_evento_seq OWNER TO postgres;

--
-- TOC entry 2222 (class 0 OID 0)
-- Dependencies: 197
-- Name: evento_id_evento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE evento_id_evento_seq OWNED BY evento.id_evento;


--
-- TOC entry 194 (class 1259 OID 44319)
-- Name: expediente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE expediente (
    id_expediente integer NOT NULL,
    id_cliente integer NOT NULL,
    id_abogado integer NOT NULL,
    id_estado integer,
    nro_clase numeric NOT NULL,
    id_marca integer NOT NULL,
    nro_expediente numeric NOT NULL,
    fecha_solicitud date NOT NULL,
    fecha_estado date NOT NULL,
    producto character varying,
    tipo_expediente integer NOT NULL,
    observacion character varying
);


ALTER TABLE expediente OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 44317)
-- Name: expediente_id_expediente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE expediente_id_expediente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expediente_id_expediente_seq OWNER TO postgres;

--
-- TOC entry 2223 (class 0 OID 0)
-- Dependencies: 193
-- Name: expediente_id_expediente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE expediente_id_expediente_seq OWNED BY expediente.id_expediente;


--
-- TOC entry 200 (class 1259 OID 44394)
-- Name: historial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE historial (
    id_historial integer NOT NULL,
    id_abogado integer NOT NULL,
    id_expediente integer NOT NULL,
    fecha date NOT NULL,
    operacion character varying NOT NULL,
    detalle character varying NOT NULL
);


ALTER TABLE historial OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 44392)
-- Name: historial_id_historial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE historial_id_historial_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE historial_id_historial_seq OWNER TO postgres;

--
-- TOC entry 2224 (class 0 OID 0)
-- Dependencies: 199
-- Name: historial_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE historial_id_historial_seq OWNED BY historial.id_historial;


--
-- TOC entry 190 (class 1259 OID 44287)
-- Name: marca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE marca (
    id_marca integer NOT NULL,
    id_tipo_marca integer NOT NULL,
    id_pais numeric NOT NULL,
    denominacion character varying,
    imagen_marca bytea
);


ALTER TABLE marca OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 44285)
-- Name: marca_id_marca_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE marca_id_marca_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE marca_id_marca_seq OWNER TO postgres;

--
-- TOC entry 2225 (class 0 OID 0)
-- Dependencies: 189
-- Name: marca_id_marca_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE marca_id_marca_seq OWNED BY marca.id_marca;


--
-- TOC entry 182 (class 1259 OID 44243)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pais (
    id_pais numeric NOT NULL,
    pais character varying NOT NULL,
    iso2 character varying(2) DEFAULT NULL::character varying
);


ALTER TABLE pais OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 44507)
-- Name: permiso; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE permiso (
    id_permiso integer NOT NULL,
    id_rol integer NOT NULL,
    id_ventana integer NOT NULL
);


ALTER TABLE permiso OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 44505)
-- Name: permiso_id_permiso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permiso_id_permiso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permiso_id_permiso_seq OWNER TO postgres;

--
-- TOC entry 2226 (class 0 OID 0)
-- Dependencies: 203
-- Name: permiso_id_permiso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permiso_id_permiso_seq OWNED BY permiso.id_permiso;


--
-- TOC entry 174 (class 1259 OID 44175)
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rol (
    id_rol integer NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE rol OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 44173)
-- Name: rol_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rol_id_rol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rol_id_rol_seq OWNER TO postgres;

--
-- TOC entry 2227 (class 0 OID 0)
-- Dependencies: 173
-- Name: rol_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rol_id_rol_seq OWNED BY rol.id_rol;


--
-- TOC entry 186 (class 1259 OID 44265)
-- Name: tipo_documento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_documento (
    id_tipo_documento integer NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE tipo_documento OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 44263)
-- Name: tipo_documento_id_tipo_documento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_documento_id_tipo_documento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_documento_id_tipo_documento_seq OWNER TO postgres;

--
-- TOC entry 2228 (class 0 OID 0)
-- Dependencies: 185
-- Name: tipo_documento_id_tipo_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_documento_id_tipo_documento_seq OWNED BY tipo_documento.id_tipo_documento;


--
-- TOC entry 192 (class 1259 OID 44308)
-- Name: tipo_expediente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_expediente (
    id_tipo_expediente integer NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE tipo_expediente OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 44306)
-- Name: tipo_expediente_id_tipo_expediente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_expediente_id_tipo_expediente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_expediente_id_tipo_expediente_seq OWNER TO postgres;

--
-- TOC entry 2229 (class 0 OID 0)
-- Dependencies: 191
-- Name: tipo_expediente_id_tipo_expediente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_expediente_id_tipo_expediente_seq OWNED BY tipo_expediente.id_tipo_expediente;


--
-- TOC entry 188 (class 1259 OID 44276)
-- Name: tipo_marca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_marca (
    id_tipo_marca integer NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE tipo_marca OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 44274)
-- Name: tipo_marca_id_tipo_marca_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_marca_id_tipo_marca_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_marca_id_tipo_marca_seq OWNER TO postgres;

--
-- TOC entry 2230 (class 0 OID 0)
-- Dependencies: 187
-- Name: tipo_marca_id_tipo_marca_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_marca_id_tipo_marca_seq OWNED BY tipo_marca.id_tipo_marca;


--
-- TOC entry 176 (class 1259 OID 44186)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    id_usuario integer NOT NULL,
    id_rol integer NOT NULL,
    cuenta character varying NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE usuario OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 44184)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuario_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE usuario_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 2231 (class 0 OID 0)
-- Dependencies: 175
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuario_id_usuario_seq OWNED BY usuario.id_usuario;


--
-- TOC entry 202 (class 1259 OID 44490)
-- Name: ventana; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ventana (
    id_ventana integer NOT NULL,
    nivel integer NOT NULL,
    id_ventana_superior integer,
    nombre character varying NOT NULL
);


ALTER TABLE ventana OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 44488)
-- Name: ventana_id_ventana_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ventana_id_ventana_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ventana_id_ventana_seq OWNER TO postgres;

--
-- TOC entry 2232 (class 0 OID 0)
-- Dependencies: 201
-- Name: ventana_id_ventana_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ventana_id_ventana_seq OWNED BY ventana.id_ventana;


--
-- TOC entry 1991 (class 2604 OID 44205)
-- Name: id_abogado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abogado ALTER COLUMN id_abogado SET DEFAULT nextval('abogado_id_abogado_seq'::regclass);


--
-- TOC entry 1992 (class 2604 OID 44221)
-- Name: id_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente ALTER COLUMN id_cliente SET DEFAULT nextval('cliente_id_cliente_seq'::regclass);


--
-- TOC entry 2002 (class 2604 OID 44360)
-- Name: id_documento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documento ALTER COLUMN id_documento SET DEFAULT nextval('documento_id_documento_seq'::regclass);


--
-- TOC entry 1996 (class 2604 OID 44257)
-- Name: id_estado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estado_marca ALTER COLUMN id_estado SET DEFAULT nextval('estado_marca_id_estado_seq'::regclass);


--
-- TOC entry 2003 (class 2604 OID 44381)
-- Name: id_evento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento ALTER COLUMN id_evento SET DEFAULT nextval('evento_id_evento_seq'::regclass);


--
-- TOC entry 2001 (class 2604 OID 44322)
-- Name: id_expediente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente ALTER COLUMN id_expediente SET DEFAULT nextval('expediente_id_expediente_seq'::regclass);


--
-- TOC entry 2004 (class 2604 OID 44397)
-- Name: id_historial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial ALTER COLUMN id_historial SET DEFAULT nextval('historial_id_historial_seq'::regclass);


--
-- TOC entry 1999 (class 2604 OID 44290)
-- Name: id_marca; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marca ALTER COLUMN id_marca SET DEFAULT nextval('marca_id_marca_seq'::regclass);


--
-- TOC entry 2006 (class 2604 OID 44510)
-- Name: id_permiso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permiso ALTER COLUMN id_permiso SET DEFAULT nextval('permiso_id_permiso_seq'::regclass);


--
-- TOC entry 1989 (class 2604 OID 44178)
-- Name: id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rol ALTER COLUMN id_rol SET DEFAULT nextval('rol_id_rol_seq'::regclass);


--
-- TOC entry 1997 (class 2604 OID 44268)
-- Name: id_tipo_documento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_documento ALTER COLUMN id_tipo_documento SET DEFAULT nextval('tipo_documento_id_tipo_documento_seq'::regclass);


--
-- TOC entry 2000 (class 2604 OID 44311)
-- Name: id_tipo_expediente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_expediente ALTER COLUMN id_tipo_expediente SET DEFAULT nextval('tipo_expediente_id_tipo_expediente_seq'::regclass);


--
-- TOC entry 1998 (class 2604 OID 44279)
-- Name: id_tipo_marca; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_marca ALTER COLUMN id_tipo_marca SET DEFAULT nextval('tipo_marca_id_tipo_marca_seq'::regclass);


--
-- TOC entry 1990 (class 2604 OID 44189)
-- Name: id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario ALTER COLUMN id_usuario SET DEFAULT nextval('usuario_id_usuario_seq'::regclass);


--
-- TOC entry 2005 (class 2604 OID 44493)
-- Name: id_ventana; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ventana ALTER COLUMN id_ventana SET DEFAULT nextval('ventana_id_ventana_seq'::regclass);


--
-- TOC entry 2183 (class 0 OID 44202)
-- Dependencies: 178
-- Data for Name: abogado; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2233 (class 0 OID 0)
-- Dependencies: 177
-- Name: abogado_id_abogado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('abogado_id_abogado_seq', 6, true);


--
-- TOC entry 2186 (class 0 OID 44235)
-- Dependencies: 181
-- Data for Name: clase; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO clase VALUES (1, 'Productos químicos para la industria, la ciencia y la fotografía, así como para la agricultura, la horticultura y la silvicultura; resinas artificiales en bruto, materias plásticas en bruto; abonos para el suelo; composiciones extintoras; preparaciones para templar y soldar metales; productos químicos para conservar alimentos; materias curtientes; adhesivos (pegamentos) para la industria.', 10);
INSERT INTO clase VALUES (2, 'Pinturas, barnices, lacas; productos contra la herrumbre y el deterioro de la madera; materias tintóreas; mordientes; resinas naturales en bruto; metales en hojas y en polvo para la pintura, la decoración, la imprenta y trabajos artísticos.', 10);
INSERT INTO clase VALUES (3, 'Preparaciones para blanquear y otras sustancias para lavar la ropa; preparaciones para limpiar, pulir, desengrasar y raspar; jabones; productos de perfumería, aceites esenciales, cosméticos, lociones capilares; dentífricos.', 10);
INSERT INTO clase VALUES (4, 'Aceites y grasas para uso industrial; lubricantes; composiciones para absorber, rociar y asentar el polvo; combustibles (incluida la gasolina para motores) y materiales de alumbrado; velas y mechas de iluminación.', 10);
INSERT INTO clase VALUES (5, 'Productos farmacéuticos, preparaciones para uso médico y veterinario; productos higiénicos y sanitarios para uso médico; alimentos y sustancias dietéticas para uso médico o veterinario, alimentos para bebés; complementos alimenticios para personas o animales; emplastos, material para apósitos; material para empastes e improntas dentales; desinfectantes; productos para eliminar animales dañinos; fungicidas, herbicidas.', 10);
INSERT INTO clase VALUES (6, 'Metales comunes y sus aleaciones; materiales de construcción metálicos; construcciones transportables metálicas; materiales metálicos para vías férreas; cables e hilos metálicos no eléctricos; artículos de cerrajería y ferretería metálicos; tubos y tuberías metálicos; cajas de caudales; minerales metalíferos.', 10);
INSERT INTO clase VALUES (7, 'Máquinas y máquinas herramientas; motores (excepto motores para vehículos terrestres); acoplamientos y elementos de transmisión (excepto para vehículos terrestres); instrumentos agrícolas que no sean accionados manualmente; incubadoras de huevos; distribuidores automáticos.', 10);
INSERT INTO clase VALUES (8, 'Herramientas e instrumentos de mano accionados manualmente; artículos de cuchillería, tenedores y cucharas; armas blancas; maquinillas de afeitar.', 10);
INSERT INTO clase VALUES (9, 'Aparatos e instrumentos científicos, náuticos, geodésicos, fotográficos, cinematográficos, ópticos, de pesaje, de medición, de señalización, de control (inspección), de salvamento y de enseñanza; aparatos e instrumentos de conducción, distribución, transformación, acumulación, regulación o control de la electricidad; aparatos de grabación, transmisión o reproducción de sonido o imágenes; soportes de registro magnéticos, discos acústicos; discos compactos, DVD y otros soportes de grabación digitales; mecanismos para aparatos de previo pago; cajas registradoras, máquinas de calcular, equipos de procesamiento de datos, ordenadores; software; extintores.', 10);
INSERT INTO clase VALUES (10, 'Aparatos e instrumentos quirúrgicos, médicos, odontológicos y veterinarios; miembros, ojos y dientes artificiales; artículos ortopédicos; material de sutura.', 10);
INSERT INTO clase VALUES (11, 'Aparatos de alumbrado, calefacción, producción de vapor, cocción, refrigeración, secado, ventilación y distribución de agua, así como instalaciones sanitarias.', 10);
INSERT INTO clase VALUES (12, 'Vehículos; aparatos de locomoción terrestre, aérea o acuática.', 10);
INSERT INTO clase VALUES (13, 'Armas de fuego; municiones y proyectiles; explosivos; fuegos artificiales.', 10);
INSERT INTO clase VALUES (14, 'Metales preciosos y sus aleaciones; artículos de joyería, bisutería, piedras preciosas; artículos de relojería e instrumentos cronométricos.', 10);
INSERT INTO clase VALUES (15, 'Instrumentos musicales.', 10);
INSERT INTO clase VALUES (16, 'Papel y cartón; productos de imprenta; material de encuadernación; fotografías; artículos de papelería; adhesivos (pegamentos) de papelería o para uso doméstico; material para artistas; pinceles; máquinas de escribir y artículos de oficina (excepto muebles); material de instrucción o material didáctico (excepto aparatos); materias plásticas para embalar; caracteres de imprenta; clichés de imprenta.', 10);
INSERT INTO clase VALUES (17, 'Caucho, gutapercha, goma, amianto y mica en bruto o semielaborados, así como sucedáneos de estos materiales; productos de materias plásticas semielaborados; materiales para calafatear, estopar y aislar; tubos flexibles no metálicos.', 10);
INSERT INTO clase VALUES (18, 'Cuero y cuero de imitación; pieles de animales; baúles y maletas; paraguas y sombrillas; bastones; fustas y artículos de guarnicionería.', 10);
INSERT INTO clase VALUES (19, 'Materiales de construcción no metálicos; tubos rígidos no metálicos para la construcción; asfalto, pez y betún; construcciones transportables no metálicas; monumentos no metálicos.', 10);
INSERT INTO clase VALUES (20, 'Muebles, espejos, marcos; hueso, cuerno, marfil, ballena o nácar, en bruto o semielaborados; conchas; espuma de mar; ámbar amarillo.', 10);
INSERT INTO clase VALUES (21, 'Utensilios y recipientes para uso doméstico y culinario; peines y esponjas; cepillos; materiales para fabricar cepillos; material de limpieza; lana de acero; vidrio en bruto o semielaborado (excepto el vidrio de construcción); artículos de cristalería, porcelana y loza.', 10);
INSERT INTO clase VALUES (22, 'Cuerdas y cordeles; redes; tiendas de campaña y lonas; velas de navegación; sacos y bolsas; materiales de acolchado y relleno (excepto el papel, el cartón, el caucho o las materias plásticas); materias textiles fibrosas en bruto.', 10);
INSERT INTO clase VALUES (23, 'Hilos para uso textil.', 10);
INSERT INTO clase VALUES (24, 'Tejidos y sustitutivos de tejidos; ropa de cama; ropa de mesa.', 10);
INSERT INTO clase VALUES (25, 'Prendas de vestir, calzado, artículos de sombrerería.', 10);
INSERT INTO clase VALUES (26, 'Encajes y bordados, cintas y cordones; botones, ganchos y ojetes, alfileres y agujas; flores artificiales.', 10);
INSERT INTO clase VALUES (27, 'Alfombras, felpudos, esteras, linóleo y otros revestimientos de suelos; tapices murales que no sean de materias textiles.', 10);
INSERT INTO clase VALUES (28, 'Juegos y juguetes; artículos de gimnasia y deporte; adornos para árboles de Navidad.', 10);
INSERT INTO clase VALUES (29, 'Carne, pescado, carne de ave y carne de caza; extractos de carne; frutas y verduras, hortalizas y legumbres en conserva, congeladas, secas y cocidas; jaleas, confituras, compotas; huevos; leche y productos lácteos; aceites y grasas comestibles.', 10);
INSERT INTO clase VALUES (30, 'Café, té, cacao y sucedáneos del café; arroz; tapioca y sagú; harinas y preparaciones a base de cereales; pan, productos de pastelería y confitería; helados; azúcar, miel, jarabe de melaza; levadura, polvos de hornear; sal; mostaza; vinagre, salsas (condimentos); especias; hielo.', 10);
INSERT INTO clase VALUES (31, 'Productos agrícolas, hortícolas y forestales; granos y semillas en bruto o sin procesar; frutas y verduras, hortalizas y legumbres frescas; plantas y flores naturales; animales vivos; alimentos para animales; malta.', 10);
INSERT INTO clase VALUES (32, 'Cervezas; aguas minerales y otras bebidas sin alcohol; bebidas a base de frutas y zumos de frutas; siropes y otras preparaciones para elaborar bebidas.', 10);
INSERT INTO clase VALUES (33, 'Bebidas alcohólicas (excepto cervezas).', 10);
INSERT INTO clase VALUES (34, 'Tabaco; artículos para fumadores; cerillas.', 10);
INSERT INTO clase VALUES (35, 'Publicidad; gestión de negocios comerciales; administración comercial; trabajos de oficina.', 10);
INSERT INTO clase VALUES (36, 'Servicios de seguros; operaciones financieras; operaciones monetarias; negocios inmobiliarios.', 10);
INSERT INTO clase VALUES (37, 'Servicios de construcción; servicios de reparación; servicios de instalación.', 10);
INSERT INTO clase VALUES (38, 'Telecomunicaciones.', 10);
INSERT INTO clase VALUES (39, 'Transporte; embalaje y almacenamiento de mercancías; organización de viajes.', 10);
INSERT INTO clase VALUES (40, 'Tratamiento de materiales.', 10);
INSERT INTO clase VALUES (41, 'Educación; formación; servicios de entretenimiento; actividades deportivas y culturales.', 10);
INSERT INTO clase VALUES (42, 'Servicios científicos y tecnológicos, así como servicios de investigación y diseño en estos ámbitos; servicios de análisis e investigación industriales; diseño y desarrollo de equipos informáticos y de software.', 10);
INSERT INTO clase VALUES (43, 'Servicios de restauración (alimentación); hospedaje temporal.', 10);
INSERT INTO clase VALUES (44, 'Servicios médicos; servicios veterinarios; tratamientos de higiene y de belleza para personas o animales; servicios de agricultura, horticultura y silvicultura.', 10);
INSERT INTO clase VALUES (45, 'Servicios jurídicos; servicios de seguridad para la protección de bienes y personas; servicios personales y sociales prestados por terceros para satisfacer necesidades individuales.', 10);


--
-- TOC entry 2185 (class 0 OID 44218)
-- Dependencies: 180
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2234 (class 0 OID 0)
-- Dependencies: 179
-- Name: cliente_id_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cliente_id_cliente_seq', 26, true);


--
-- TOC entry 2201 (class 0 OID 44357)
-- Dependencies: 196
-- Data for Name: documento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2235 (class 0 OID 0)
-- Dependencies: 195
-- Name: documento_id_documento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('documento_id_documento_seq', 17, true);


--
-- TOC entry 2189 (class 0 OID 44254)
-- Dependencies: 184
-- Data for Name: estado_marca; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO estado_marca VALUES (1, 'Concedida');
INSERT INTO estado_marca VALUES (2, 'Esperando recurso rechazo');
INSERT INTO estado_marca VALUES (3, 'Con rechazo a notificar');
INSERT INTO estado_marca VALUES (4, 'Con resol. apel. a notificar');
INSERT INTO estado_marca VALUES (5, 'A imprimir acta de registro');
INSERT INTO estado_marca VALUES (6, 'Abandonada');
INSERT INTO estado_marca VALUES (7, 'Archivada');
INSERT INTO estado_marca VALUES (8, 'Con observaciones de Forma');
INSERT INTO estado_marca VALUES (9, 'Con vista a notificar');
INSERT INTO estado_marca VALUES (10, 'Para dictamenes de marcas');
INSERT INTO estado_marca VALUES (11, 'Informe de fondo inicial');
INSERT INTO estado_marca VALUES (12, 'En resolucion de concesión');
INSERT INTO estado_marca VALUES (13, 'En espera plazo oposición');
INSERT INTO estado_marca VALUES (14, 'En espera de publicaciones');
INSERT INTO estado_marca VALUES (15, 'Desistida');
INSERT INTO estado_marca VALUES (16, 'En Apelación en Dirección General');
INSERT INTO estado_marca VALUES (17, 'En Asuntos litigiosos');
INSERT INTO estado_marca VALUES (18, 'En Despacho para Firma');


--
-- TOC entry 2236 (class 0 OID 0)
-- Dependencies: 183
-- Name: estado_marca_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('estado_marca_id_estado_seq', 18, true);


--
-- TOC entry 2203 (class 0 OID 44378)
-- Dependencies: 198
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2237 (class 0 OID 0)
-- Dependencies: 197
-- Name: evento_id_evento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('evento_id_evento_seq', 5, true);


--
-- TOC entry 2199 (class 0 OID 44319)
-- Dependencies: 194
-- Data for Name: expediente; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2238 (class 0 OID 0)
-- Dependencies: 193
-- Name: expediente_id_expediente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('expediente_id_expediente_seq', 7, true);


--
-- TOC entry 2205 (class 0 OID 44394)
-- Dependencies: 200
-- Data for Name: historial; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2239 (class 0 OID 0)
-- Dependencies: 199
-- Name: historial_id_historial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('historial_id_historial_seq', 1, false);


--
-- TOC entry 2195 (class 0 OID 44287)
-- Dependencies: 190
-- Data for Name: marca; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2240 (class 0 OID 0)
-- Dependencies: 189
-- Name: marca_id_marca_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('marca_id_marca_seq', 32, true);


--
-- TOC entry 2187 (class 0 OID 44243)
-- Dependencies: 182
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO pais VALUES (1, 'Afganistán', 'AF');
INSERT INTO pais VALUES (3, 'Albania', 'AL');
INSERT INTO pais VALUES (4, 'Alemania', 'DE');
INSERT INTO pais VALUES (5, 'Andorra', 'AD');
INSERT INTO pais VALUES (6, 'Angola', 'AO');
INSERT INTO pais VALUES (7, 'Anguila', 'AI');
INSERT INTO pais VALUES (8, 'Antártida', 'AQ');
INSERT INTO pais VALUES (9, 'Antigua y Barbuda', 'AG');
INSERT INTO pais VALUES (10, 'Antillas Holandesas', 'AN');
INSERT INTO pais VALUES (11, 'Arabia Saudí', 'SA');
INSERT INTO pais VALUES (12, 'Argelia', 'DZ');
INSERT INTO pais VALUES (13, 'Argentina', 'AR');
INSERT INTO pais VALUES (14, 'Armenia', 'AM');
INSERT INTO pais VALUES (15, 'Aruba', 'AW');
INSERT INTO pais VALUES (16, 'Australia', 'AU');
INSERT INTO pais VALUES (17, 'Austria', 'AT');
INSERT INTO pais VALUES (18, 'Azerbaiyán', 'AZ');
INSERT INTO pais VALUES (19, 'Bahamas', 'BS');
INSERT INTO pais VALUES (20, 'Bahréin', 'BH');
INSERT INTO pais VALUES (21, 'Bangladesh', 'BD');
INSERT INTO pais VALUES (22, 'Barbados', 'BB');
INSERT INTO pais VALUES (23, 'Bielorrusia', 'BY');
INSERT INTO pais VALUES (24, 'Bélgica', 'BE');
INSERT INTO pais VALUES (25, 'Belice', 'BZ');
INSERT INTO pais VALUES (26, 'Benin', 'BJ');
INSERT INTO pais VALUES (27, 'Bermudas', 'BM');
INSERT INTO pais VALUES (28, 'Bhután', 'BT');
INSERT INTO pais VALUES (29, 'Bolivia', 'BO');
INSERT INTO pais VALUES (30, 'Bosnia y Herzegovina', 'BA');
INSERT INTO pais VALUES (31, 'Botsuana', 'BW');
INSERT INTO pais VALUES (32, 'Isla Bouvet', 'BV');
INSERT INTO pais VALUES (33, 'Brasil', 'BR');
INSERT INTO pais VALUES (34, 'Brunéi', 'BN');
INSERT INTO pais VALUES (35, 'Bulgaria', 'BG');
INSERT INTO pais VALUES (36, 'Burkina Faso', 'BF');
INSERT INTO pais VALUES (37, 'Burundi', 'BI');
INSERT INTO pais VALUES (38, 'Cabo Verde', 'CV');
INSERT INTO pais VALUES (39, 'Islas Caimán', 'KY');
INSERT INTO pais VALUES (40, 'Camboya', 'KH');
INSERT INTO pais VALUES (41, 'Camerún', 'CM');
INSERT INTO pais VALUES (42, 'Canadá', 'CA');
INSERT INTO pais VALUES (43, 'República Centroafricana', 'CF');
INSERT INTO pais VALUES (44, 'Chad', 'TD');
INSERT INTO pais VALUES (45, 'República Checa', 'CZ');
INSERT INTO pais VALUES (46, 'Chile', 'CL');
INSERT INTO pais VALUES (47, 'China', 'CN');
INSERT INTO pais VALUES (48, 'Chipre', 'CY');
INSERT INTO pais VALUES (49, 'Isla de Navidad', 'CX');
INSERT INTO pais VALUES (50, 'Ciudad del Vaticano', 'VA');
INSERT INTO pais VALUES (51, 'Islas Cocos', 'CC');
INSERT INTO pais VALUES (52, 'Colombia', 'CO');
INSERT INTO pais VALUES (53, 'Comoras', 'KM');
INSERT INTO pais VALUES (54, 'República Democrática del Congo', 'CD');
INSERT INTO pais VALUES (55, 'Congo', 'CG');
INSERT INTO pais VALUES (56, 'Islas Cook', 'CK');
INSERT INTO pais VALUES (57, 'Corea del Norte', 'KP');
INSERT INTO pais VALUES (58, 'Corea del Sur', 'KR');
INSERT INTO pais VALUES (59, 'Costa de Marfil', 'CI');
INSERT INTO pais VALUES (60, 'Costa Rica', 'CR');
INSERT INTO pais VALUES (61, 'Croacia', 'HR');
INSERT INTO pais VALUES (62, 'Cuba', 'CU');
INSERT INTO pais VALUES (63, 'Dinamarca', 'DK');
INSERT INTO pais VALUES (64, 'Dominica', 'DM');
INSERT INTO pais VALUES (65, 'República Dominicana', 'DO');
INSERT INTO pais VALUES (66, 'Ecuador', 'EC');
INSERT INTO pais VALUES (67, 'Egipto', 'EG');
INSERT INTO pais VALUES (68, 'El Salvador', 'SV');
INSERT INTO pais VALUES (69, 'Emiratos Árabes Unidos', 'AE');
INSERT INTO pais VALUES (70, 'Eritrea', 'ER');
INSERT INTO pais VALUES (71, 'Eslovaquia', 'SK');
INSERT INTO pais VALUES (72, 'Eslovenia', 'SI');
INSERT INTO pais VALUES (73, 'España', 'ES');
INSERT INTO pais VALUES (74, 'Islas ultramarinas de Estados Unidos', 'UM');
INSERT INTO pais VALUES (75, 'Estados Unidos', 'US');
INSERT INTO pais VALUES (76, 'Estonia', 'EE');
INSERT INTO pais VALUES (77, 'Etiopía', 'ET');
INSERT INTO pais VALUES (78, 'Islas Feroe', 'FO');
INSERT INTO pais VALUES (79, 'Filipinas', 'PH');
INSERT INTO pais VALUES (80, 'Finlandia', 'FI');
INSERT INTO pais VALUES (81, 'Fiyi', 'FJ');
INSERT INTO pais VALUES (82, 'Francia', 'FR');
INSERT INTO pais VALUES (83, 'Gabón', 'GA');
INSERT INTO pais VALUES (84, 'Gambia', 'GM');
INSERT INTO pais VALUES (85, 'Georgia', 'GE');
INSERT INTO pais VALUES (86, 'Islas Georgias del Sur y Sandwich del Sur', 'GS');
INSERT INTO pais VALUES (87, 'Ghana', 'GH');
INSERT INTO pais VALUES (88, 'Gibraltar', 'GI');
INSERT INTO pais VALUES (89, 'Granada', 'GD');
INSERT INTO pais VALUES (90, 'Grecia', 'GR');
INSERT INTO pais VALUES (91, 'Groenlandia', 'GL');
INSERT INTO pais VALUES (92, 'Guadalupe', 'GP');
INSERT INTO pais VALUES (93, 'Guam', 'GU');
INSERT INTO pais VALUES (94, 'Guatemala', 'GT');
INSERT INTO pais VALUES (95, 'Guayana Francesa', 'GF');
INSERT INTO pais VALUES (96, 'Guinea', 'GN');
INSERT INTO pais VALUES (97, 'Guinea Ecuatorial', 'GQ');
INSERT INTO pais VALUES (98, 'Guinea-Bissau', 'GW');
INSERT INTO pais VALUES (99, 'Guyana', 'GY');
INSERT INTO pais VALUES (100, 'Haití', 'HT');
INSERT INTO pais VALUES (101, 'Islas Heard y McDonald', 'HM');
INSERT INTO pais VALUES (102, 'Honduras', 'HN');
INSERT INTO pais VALUES (103, 'Hong Kong', 'HK');
INSERT INTO pais VALUES (104, 'Hungría', 'HU');
INSERT INTO pais VALUES (105, 'India', 'IN');
INSERT INTO pais VALUES (106, 'Indonesia', 'ID');
INSERT INTO pais VALUES (107, 'Irán', 'IR');
INSERT INTO pais VALUES (108, 'Iraq', 'IQ');
INSERT INTO pais VALUES (109, 'Irlanda', 'IE');
INSERT INTO pais VALUES (110, 'Islandia', 'IS');
INSERT INTO pais VALUES (111, 'Israel', 'IL');
INSERT INTO pais VALUES (112, 'Italia', 'IT');
INSERT INTO pais VALUES (113, 'Jamaica', 'JM');
INSERT INTO pais VALUES (114, 'Japón', 'JP');
INSERT INTO pais VALUES (115, 'Jordania', 'JO');
INSERT INTO pais VALUES (116, 'Kazajstán', 'KZ');
INSERT INTO pais VALUES (117, 'Kenia', 'KE');
INSERT INTO pais VALUES (118, 'Kirguistán', 'KG');
INSERT INTO pais VALUES (119, 'Kiribati', 'KI');
INSERT INTO pais VALUES (120, 'Kuwait', 'KW');
INSERT INTO pais VALUES (121, 'Laos', 'LA');
INSERT INTO pais VALUES (122, 'Lesotho', 'LS');
INSERT INTO pais VALUES (123, 'Letonia', 'LV');
INSERT INTO pais VALUES (124, 'Líbano', 'LB');
INSERT INTO pais VALUES (125, 'Liberia', 'LR');
INSERT INTO pais VALUES (126, 'Libia', 'LY');
INSERT INTO pais VALUES (127, 'Liechtenstein', 'LI');
INSERT INTO pais VALUES (128, 'Lituania', 'LT');
INSERT INTO pais VALUES (129, 'Luxemburgo', 'LU');
INSERT INTO pais VALUES (130, 'Macao', 'MO');
INSERT INTO pais VALUES (131, 'ARY Macedonia', 'MK');
INSERT INTO pais VALUES (132, 'Madagascar', 'MG');
INSERT INTO pais VALUES (133, 'Malasia', 'MY');
INSERT INTO pais VALUES (134, 'Malawi', 'MW');
INSERT INTO pais VALUES (135, 'Maldivas', 'MV');
INSERT INTO pais VALUES (136, 'Malí', 'ML');
INSERT INTO pais VALUES (137, 'Malta', 'MT');
INSERT INTO pais VALUES (138, 'Islas Malvinas', 'FK');
INSERT INTO pais VALUES (139, 'Islas Marianas del Norte', 'MP');
INSERT INTO pais VALUES (140, 'Marruecos', 'MA');
INSERT INTO pais VALUES (141, 'Islas Marshall', 'MH');
INSERT INTO pais VALUES (142, 'Martinica', 'MQ');
INSERT INTO pais VALUES (143, 'Mauricio', 'MU');
INSERT INTO pais VALUES (144, 'Mauritania', 'MR');
INSERT INTO pais VALUES (145, 'Mayotte', 'YT');
INSERT INTO pais VALUES (146, 'México', 'MX');
INSERT INTO pais VALUES (147, 'Micronesia', 'FM');
INSERT INTO pais VALUES (148, 'Moldavia', 'MD');
INSERT INTO pais VALUES (149, 'Mónaco', 'MC');
INSERT INTO pais VALUES (150, 'Mongolia', 'MN');
INSERT INTO pais VALUES (151, 'Montserrat', 'MS');
INSERT INTO pais VALUES (152, 'Mozambique', 'MZ');
INSERT INTO pais VALUES (153, 'Myanmar', 'MM');
INSERT INTO pais VALUES (154, 'Namibia', 'NA');
INSERT INTO pais VALUES (155, 'Nauru', 'NR');
INSERT INTO pais VALUES (156, 'Nepal', 'NP');
INSERT INTO pais VALUES (157, 'Nicaragua', 'NI');
INSERT INTO pais VALUES (158, 'Níger', 'NE');
INSERT INTO pais VALUES (159, 'Nigeria', 'NG');
INSERT INTO pais VALUES (160, 'Niue', 'NU');
INSERT INTO pais VALUES (161, 'Isla Norfolk', 'NF');
INSERT INTO pais VALUES (162, 'Noruega', 'NO');
INSERT INTO pais VALUES (163, 'Nueva Caledonia', 'NC');
INSERT INTO pais VALUES (164, 'Nueva Zelanda', 'NZ');
INSERT INTO pais VALUES (165, 'Omán', 'OM');
INSERT INTO pais VALUES (166, 'Países Bajos', 'NL');
INSERT INTO pais VALUES (167, 'Pakistán', 'PK');
INSERT INTO pais VALUES (168, 'Palau', 'PW');
INSERT INTO pais VALUES (169, 'Palestina', 'PS');
INSERT INTO pais VALUES (170, 'Panamá', 'PA');
INSERT INTO pais VALUES (171, 'Papúa Nueva Guinea', 'PG');
INSERT INTO pais VALUES (172, 'Paraguay', 'PY');
INSERT INTO pais VALUES (173, 'Perú', 'PE');
INSERT INTO pais VALUES (174, 'Islas Pitcairn', 'PN');
INSERT INTO pais VALUES (175, 'Polinesia Francesa', 'PF');
INSERT INTO pais VALUES (176, 'Polonia', 'PL');
INSERT INTO pais VALUES (177, 'Portugal', 'PT');
INSERT INTO pais VALUES (178, 'Puerto Rico', 'PR');
INSERT INTO pais VALUES (179, 'Qatar', 'QA');
INSERT INTO pais VALUES (180, 'Reino Unido', 'GB');
INSERT INTO pais VALUES (181, 'Reunión', 'RE');
INSERT INTO pais VALUES (182, 'Ruanda', 'RW');
INSERT INTO pais VALUES (183, 'Rumania', 'RO');
INSERT INTO pais VALUES (184, 'Rusia', 'RU');
INSERT INTO pais VALUES (185, 'Sahara Occidental', 'EH');
INSERT INTO pais VALUES (186, 'Islas Salomón', 'SB');
INSERT INTO pais VALUES (187, 'Samoa', 'WS');
INSERT INTO pais VALUES (188, 'Samoa Americana', 'AS');
INSERT INTO pais VALUES (189, 'San Cristóbal y Nevis', 'KN');
INSERT INTO pais VALUES (190, 'San Marino', 'SM');
INSERT INTO pais VALUES (191, 'San Pedro y Miquelón', 'PM');
INSERT INTO pais VALUES (192, 'San Vicente y las Granadinas', 'VC');
INSERT INTO pais VALUES (193, 'Santa Helena', 'SH');
INSERT INTO pais VALUES (194, 'Santa Lucía', 'LC');
INSERT INTO pais VALUES (195, 'Santo Tomé y Príncipe', 'ST');
INSERT INTO pais VALUES (196, 'Senegal', 'SN');
INSERT INTO pais VALUES (197, 'Serbia y Montenegro', 'CS');
INSERT INTO pais VALUES (198, 'Seychelles', 'SC');
INSERT INTO pais VALUES (199, 'Sierra Leona', 'SL');
INSERT INTO pais VALUES (200, 'Singapur', 'SG');
INSERT INTO pais VALUES (201, 'Siria', 'SY');
INSERT INTO pais VALUES (202, 'Somalia', 'SO');
INSERT INTO pais VALUES (203, 'Sri Lanka', 'LK');
INSERT INTO pais VALUES (204, 'Suazilandia', 'SZ');
INSERT INTO pais VALUES (205, 'Sudáfrica', 'ZA');
INSERT INTO pais VALUES (206, 'Sudán', 'SD');
INSERT INTO pais VALUES (207, 'Suecia', 'SE');
INSERT INTO pais VALUES (208, 'Suiza', 'CH');
INSERT INTO pais VALUES (209, 'Surinam', 'SR');
INSERT INTO pais VALUES (210, 'Svalbard y Jan Mayen', 'SJ');
INSERT INTO pais VALUES (211, 'Tailandia', 'TH');
INSERT INTO pais VALUES (212, 'Taiwán', 'TW');
INSERT INTO pais VALUES (213, 'Tanzania', 'TZ');
INSERT INTO pais VALUES (214, 'Tayikistán', 'TJ');
INSERT INTO pais VALUES (215, 'Territorio Británico del Océano Índico', 'IO');
INSERT INTO pais VALUES (216, 'Territorios Australes Franceses', 'TF');
INSERT INTO pais VALUES (217, 'Timor Oriental', 'TL');
INSERT INTO pais VALUES (218, 'Togo', 'TG');
INSERT INTO pais VALUES (219, 'Tokelau', 'TK');
INSERT INTO pais VALUES (220, 'Tonga', 'TO');
INSERT INTO pais VALUES (221, 'Trinidad y Tobago', 'TT');
INSERT INTO pais VALUES (222, 'Túnez', 'TN');
INSERT INTO pais VALUES (223, 'Islas Turcas y Caicos', 'TC');
INSERT INTO pais VALUES (224, 'Turkmenistán', 'TM');
INSERT INTO pais VALUES (225, 'Turquía', 'TR');
INSERT INTO pais VALUES (226, 'Tuvalu', 'TV');
INSERT INTO pais VALUES (227, 'Ucrania', 'UA');
INSERT INTO pais VALUES (228, 'Uganda', 'UG');
INSERT INTO pais VALUES (229, 'Uruguay', 'UY');
INSERT INTO pais VALUES (230, 'Uzbekistán', 'UZ');
INSERT INTO pais VALUES (231, 'Vanuatu', 'VU');
INSERT INTO pais VALUES (232, 'Venezuela', 'VE');
INSERT INTO pais VALUES (233, 'Vietnam', 'VN');
INSERT INTO pais VALUES (234, 'Islas Vírgenes Británicas', 'VG');
INSERT INTO pais VALUES (235, 'Islas Vírgenes de los Estados Unidos', 'VI');
INSERT INTO pais VALUES (236, 'Wallis y Futuna', 'WF');
INSERT INTO pais VALUES (237, 'Yemen', 'YE');
INSERT INTO pais VALUES (238, 'Yibuti', 'DJ');
INSERT INTO pais VALUES (239, 'Zambia', 'ZM');
INSERT INTO pais VALUES (240, 'Zimbabue', 'ZW');


--
-- TOC entry 2209 (class 0 OID 44507)
-- Dependencies: 204
-- Data for Name: permiso; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO permiso VALUES (38, 1, 1);
INSERT INTO permiso VALUES (39, 1, 2);
INSERT INTO permiso VALUES (40, 1, 3);
INSERT INTO permiso VALUES (41, 1, 4);
INSERT INTO permiso VALUES (42, 1, 5);
INSERT INTO permiso VALUES (43, 1, 6);
INSERT INTO permiso VALUES (44, 1, 7);
INSERT INTO permiso VALUES (45, 1, 8);
INSERT INTO permiso VALUES (46, 1, 19);
INSERT INTO permiso VALUES (47, 1, 20);
INSERT INTO permiso VALUES (48, 1, 9);
INSERT INTO permiso VALUES (49, 1, 10);
INSERT INTO permiso VALUES (50, 1, 11);
INSERT INTO permiso VALUES (51, 1, 12);
INSERT INTO permiso VALUES (52, 1, 13);
INSERT INTO permiso VALUES (53, 1, 14);
INSERT INTO permiso VALUES (54, 1, 15);
INSERT INTO permiso VALUES (55, 1, 16);
INSERT INTO permiso VALUES (56, 1, 17);
INSERT INTO permiso VALUES (57, 1, 18);
INSERT INTO permiso VALUES (58, 1, 21);
INSERT INTO permiso VALUES (59, 1, 22);
INSERT INTO permiso VALUES (60, 1, 23);
INSERT INTO permiso VALUES (61, 1, 24);
INSERT INTO permiso VALUES (62, 1, 25);
INSERT INTO permiso VALUES (63, 1, 26);
INSERT INTO permiso VALUES (64, 1, 27);
INSERT INTO permiso VALUES (65, 1, 28);
INSERT INTO permiso VALUES (66, 1, 29);
INSERT INTO permiso VALUES (67, 1, 30);
INSERT INTO permiso VALUES (68, 1, 31);
INSERT INTO permiso VALUES (69, 1, 32);
INSERT INTO permiso VALUES (70, 1, 33);
INSERT INTO permiso VALUES (71, 1, 34);
INSERT INTO permiso VALUES (72, 1, 35);
INSERT INTO permiso VALUES (73, 1, 36);
INSERT INTO permiso VALUES (74, 1, 37);
INSERT INTO permiso VALUES (75, 1, 38);
INSERT INTO permiso VALUES (76, 1, 39);
INSERT INTO permiso VALUES (77, 1, 40);
INSERT INTO permiso VALUES (78, 1, 41);
INSERT INTO permiso VALUES (79, 1, 42);


--
-- TOC entry 2241 (class 0 OID 0)
-- Dependencies: 203
-- Name: permiso_id_permiso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permiso_id_permiso_seq', 166, true);


--
-- TOC entry 2179 (class 0 OID 44175)
-- Dependencies: 174
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO rol VALUES (1, 'Administrador');
INSERT INTO rol VALUES (2, 'Abogado');
INSERT INTO rol VALUES (3, 'Cliente');


--
-- TOC entry 2242 (class 0 OID 0)
-- Dependencies: 173
-- Name: rol_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rol_id_rol_seq', 8, true);


--
-- TOC entry 2191 (class 0 OID 44265)
-- Dependencies: 186
-- Data for Name: tipo_documento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipo_documento VALUES (1, 'Informe de Fondo');
INSERT INTO tipo_documento VALUES (2, 'Informe de Forma');
INSERT INTO tipo_documento VALUES (3, 'Acta de registro');
INSERT INTO tipo_documento VALUES (6, 'Dictamen Marca');
INSERT INTO tipo_documento VALUES (5, 'Publicación');
INSERT INTO tipo_documento VALUES (4, 'Orden publicación');


--
-- TOC entry 2243 (class 0 OID 0)
-- Dependencies: 185
-- Name: tipo_documento_id_tipo_documento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_documento_id_tipo_documento_seq', 6, true);


--
-- TOC entry 2197 (class 0 OID 44308)
-- Dependencies: 192
-- Data for Name: tipo_expediente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipo_expediente VALUES (1, 'Registro de marcas');
INSERT INTO tipo_expediente VALUES (2, 'Renovación de marcas');


--
-- TOC entry 2244 (class 0 OID 0)
-- Dependencies: 191
-- Name: tipo_expediente_id_tipo_expediente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_expediente_id_tipo_expediente_seq', 2, true);


--
-- TOC entry 2193 (class 0 OID 44276)
-- Dependencies: 188
-- Data for Name: tipo_marca; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipo_marca VALUES (1, 'Denominativo');
INSERT INTO tipo_marca VALUES (3, 'Mixto');
INSERT INTO tipo_marca VALUES (2, 'Figurativo');


--
-- TOC entry 2245 (class 0 OID 0)
-- Dependencies: 187
-- Name: tipo_marca_id_tipo_marca_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_marca_id_tipo_marca_seq', 3, true);


--
-- TOC entry 2181 (class 0 OID 44186)
-- Dependencies: 176
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuario VALUES (20, 1, 'Administrador', '0a7a07b6ac126ff9f241dcd9435de655');


--
-- TOC entry 2246 (class 0 OID 0)
-- Dependencies: 175
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuario_id_usuario_seq', 20, true);


--
-- TOC entry 2207 (class 0 OID 44490)
-- Dependencies: 202
-- Data for Name: ventana; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ventana VALUES (36, 1, NULL, 'Menú Rol');
INSERT INTO ventana VALUES (37, 2, 36, 'Agregar Rol');
INSERT INTO ventana VALUES (2, 2, 1, 'Agregar Marca');
INSERT INTO ventana VALUES (3, 2, 1, 'Ver Marca');
INSERT INTO ventana VALUES (4, 2, 1, 'Editar Marca');
INSERT INTO ventana VALUES (5, 2, 1, 'Eliminar Marca');
INSERT INTO ventana VALUES (7, 2, 6, 'Agregar Expediente');
INSERT INTO ventana VALUES (8, 2, 6, 'Ver Expediente');
INSERT INTO ventana VALUES (38, 2, 36, 'Editar Rol');
INSERT INTO ventana VALUES (10, 4, 9, 'Agregar Documento');
INSERT INTO ventana VALUES (11, 4, 9, 'Ver Documento');
INSERT INTO ventana VALUES (12, 4, 9, 'Editar Documento');
INSERT INTO ventana VALUES (13, 4, 9, 'Eliminar Documento');
INSERT INTO ventana VALUES (15, 4, 14, 'Agregar Evento');
INSERT INTO ventana VALUES (16, 4, 14, 'Ver Evento');
INSERT INTO ventana VALUES (17, 4, 14, 'Editar Evento');
INSERT INTO ventana VALUES (18, 4, 14, 'Eliminar Evento');
INSERT INTO ventana VALUES (19, 2, 6, 'Editar Expediente');
INSERT INTO ventana VALUES (20, 2, 6, 'Eliminar Expediente');
INSERT INTO ventana VALUES (21, 1, NULL, 'Menú Agente');
INSERT INTO ventana VALUES (22, 2, 21, 'Agregar Agente');
INSERT INTO ventana VALUES (23, 2, 21, 'Ver Agente');
INSERT INTO ventana VALUES (24, 2, 21, 'Editar Agente');
INSERT INTO ventana VALUES (25, 2, 21, 'Eliminar Agente');
INSERT INTO ventana VALUES (26, 1, NULL, 'Menú Titular');
INSERT INTO ventana VALUES (27, 2, 26, 'Agregar Titular');
INSERT INTO ventana VALUES (28, 2, 26, 'Ver Titular');
INSERT INTO ventana VALUES (29, 2, 26, 'Editar Titular');
INSERT INTO ventana VALUES (30, 2, 26, 'Eliminar Titular');
INSERT INTO ventana VALUES (31, 1, NULL, 'Menú Usuario');
INSERT INTO ventana VALUES (32, 2, 31, 'Agregar Usuario');
INSERT INTO ventana VALUES (33, 2, 31, 'Ver Usuario');
INSERT INTO ventana VALUES (34, 2, 31, 'Editar Usuario');
INSERT INTO ventana VALUES (35, 2, 31, 'Eliminar Usuario');
INSERT INTO ventana VALUES (1, 1, NULL, 'Menú Marca');
INSERT INTO ventana VALUES (6, 1, NULL, 'Menú Expediente');
INSERT INTO ventana VALUES (9, 3, 8, 'Menú Documento');
INSERT INTO ventana VALUES (14, 3, 8, 'Menú Evento');
INSERT INTO ventana VALUES (39, 2, 36, 'Eliminar Rol');
INSERT INTO ventana VALUES (40, 1, NULL, 'Menú Permiso');
INSERT INTO ventana VALUES (42, 2, 40, 'Ver Permiso');
INSERT INTO ventana VALUES (41, 2, 40, 'Editar Permiso');


--
-- TOC entry 2247 (class 0 OID 0)
-- Dependencies: 201
-- Name: ventana_id_ventana_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ventana_id_ventana_seq', 2, true);


--
-- TOC entry 2014 (class 2606 OID 44468)
-- Name: abogado_ci_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY abogado
    ADD CONSTRAINT abogado_ci_key UNIQUE (ci);


--
-- TOC entry 2016 (class 2606 OID 44210)
-- Name: abogado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY abogado
    ADD CONSTRAINT abogado_pkey PRIMARY KEY (id_abogado);


--
-- TOC entry 2024 (class 2606 OID 44242)
-- Name: clase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clase
    ADD CONSTRAINT clase_pkey PRIMARY KEY (nro_clase);


--
-- TOC entry 2018 (class 2606 OID 44229)
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 2042 (class 2606 OID 44365)
-- Name: documento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT documento_pkey PRIMARY KEY (id_documento);


--
-- TOC entry 2028 (class 2606 OID 44262)
-- Name: estado_marca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estado_marca
    ADD CONSTRAINT estado_marca_pkey PRIMARY KEY (id_estado);


--
-- TOC entry 2044 (class 2606 OID 44386)
-- Name: evento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 2038 (class 2606 OID 44466)
-- Name: expediente_nro_expediente_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_nro_expediente_key UNIQUE (nro_expediente);


--
-- TOC entry 2040 (class 2606 OID 44327)
-- Name: expediente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_pkey PRIMARY KEY (id_expediente);


--
-- TOC entry 2046 (class 2606 OID 44402)
-- Name: historial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY historial
    ADD CONSTRAINT historial_pkey PRIMARY KEY (id_historial);


--
-- TOC entry 2034 (class 2606 OID 44295)
-- Name: marca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY marca
    ADD CONSTRAINT marca_pkey PRIMARY KEY (id_marca);


--
-- TOC entry 2026 (class 2606 OID 44251)
-- Name: pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (id_pais);


--
-- TOC entry 2050 (class 2606 OID 44512)
-- Name: permiso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY permiso
    ADD CONSTRAINT permiso_pkey PRIMARY KEY (id_permiso);


--
-- TOC entry 2020 (class 2606 OID 44474)
-- Name: restriccion_ci_unico; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT restriccion_ci_unico UNIQUE (ci);


--
-- TOC entry 2022 (class 2606 OID 44476)
-- Name: restriccion_ruc_unico; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT restriccion_ruc_unico UNIQUE (ruc);


--
-- TOC entry 2008 (class 2606 OID 44183)
-- Name: rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (id_rol);


--
-- TOC entry 2030 (class 2606 OID 44273)
-- Name: tipo_documento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_documento
    ADD CONSTRAINT tipo_documento_pkey PRIMARY KEY (id_tipo_documento);


--
-- TOC entry 2036 (class 2606 OID 44316)
-- Name: tipo_expediente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_expediente
    ADD CONSTRAINT tipo_expediente_pkey PRIMARY KEY (id_tipo_expediente);


--
-- TOC entry 2032 (class 2606 OID 44284)
-- Name: tipo_marca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_marca
    ADD CONSTRAINT tipo_marca_pkey PRIMARY KEY (id_tipo_marca);


--
-- TOC entry 2010 (class 2606 OID 44470)
-- Name: usuario_cuenta_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_cuenta_key UNIQUE (cuenta);


--
-- TOC entry 2012 (class 2606 OID 44194)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 2048 (class 2606 OID 44495)
-- Name: ventana_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ventana
    ADD CONSTRAINT ventana_pkey PRIMARY KEY (id_ventana);


--
-- TOC entry 2052 (class 2606 OID 44211)
-- Name: abogado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abogado
    ADD CONSTRAINT abogado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


--
-- TOC entry 2053 (class 2606 OID 44230)
-- Name: cliente_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT cliente_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


--
-- TOC entry 2063 (class 2606 OID 44366)
-- Name: documento_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT documento_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expediente(id_expediente);


--
-- TOC entry 2062 (class 2606 OID 44371)
-- Name: documento_id_tipo_documento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT documento_id_tipo_documento_fkey FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documento(id_tipo_documento);


--
-- TOC entry 2064 (class 2606 OID 44387)
-- Name: evento_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT evento_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expediente(id_expediente);


--
-- TOC entry 2060 (class 2606 OID 44335)
-- Name: expediente_id_abogado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_id_abogado_fkey FOREIGN KEY (id_abogado) REFERENCES abogado(id_abogado);


--
-- TOC entry 2061 (class 2606 OID 44330)
-- Name: expediente_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);


--
-- TOC entry 2059 (class 2606 OID 44340)
-- Name: expediente_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES estado_marca(id_estado);


--
-- TOC entry 2057 (class 2606 OID 44350)
-- Name: expediente_id_marca_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_id_marca_fkey FOREIGN KEY (id_marca) REFERENCES marca(id_marca);


--
-- TOC entry 2056 (class 2606 OID 44435)
-- Name: expediente_id_tipo_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_id_tipo_expediente_fkey FOREIGN KEY (tipo_expediente) REFERENCES tipo_expediente(id_tipo_expediente);


--
-- TOC entry 2058 (class 2606 OID 44345)
-- Name: expediente_nro_clase_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT expediente_nro_clase_fkey FOREIGN KEY (nro_clase) REFERENCES clase(nro_clase);


--
-- TOC entry 2066 (class 2606 OID 44403)
-- Name: historial_id_abogado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial
    ADD CONSTRAINT historial_id_abogado_fkey FOREIGN KEY (id_abogado) REFERENCES abogado(id_abogado);


--
-- TOC entry 2065 (class 2606 OID 44408)
-- Name: historial_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial
    ADD CONSTRAINT historial_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expediente(id_expediente);


--
-- TOC entry 2054 (class 2606 OID 44301)
-- Name: marca_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marca
    ADD CONSTRAINT marca_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES pais(id_pais);


--
-- TOC entry 2055 (class 2606 OID 44296)
-- Name: marca_id_tipo_marca_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marca
    ADD CONSTRAINT marca_id_tipo_marca_fkey FOREIGN KEY (id_tipo_marca) REFERENCES tipo_marca(id_tipo_marca);


--
-- TOC entry 2068 (class 2606 OID 44513)
-- Name: permiso_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permiso
    ADD CONSTRAINT permiso_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES rol(id_rol);


--
-- TOC entry 2067 (class 2606 OID 44518)
-- Name: permiso_id_ventana_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permiso
    ADD CONSTRAINT permiso_id_ventana_fkey FOREIGN KEY (id_ventana) REFERENCES ventana(id_ventana);


--
-- TOC entry 2051 (class 2606 OID 44195)
-- Name: usuario_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES rol(id_rol);


--
-- TOC entry 2216 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-09-14 16:43:02

--
-- PostgreSQL database dump complete
--

