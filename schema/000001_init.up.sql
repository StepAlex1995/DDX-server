CREATE TABLE trainers
(
    id    serial primary key,
    name  varchar(255) not null,
    phone varchar(255) not null,
    photo varchar(255) not null
);

CREATE TABLE clients
(
    id         serial primary key,
    name       varchar(255)                                   not null,
    is_man     boolean                                        not null,
    phone      varchar(255)                                   not null,
    birthdate  date                                           not null,
    trainer_id int references trainers (id) on delete cascade not null
);

CREATE TABLE users
(
    id            serial primary key,
    login         varchar(255)                                   not null,
    password_hash varchar(255)                                   not null,
    role          int                                            not null,
    client_id     int references clients (id) on delete cascade  not null,
    trainer_id    int references trainers (id) on delete cascade not null
);

CREATE TABLE client_statuses
(
    id           serial primary key,
    client_id    int references clients (id) on delete cascade not null,
    date_create  date                                          not null,
    weight       float                                         not null,
    height       float                                         not null,
    fat_percent  float                                         not null,
    breast       float                                         not null,
    waist        float                                         not null,
    neck         float                                         not null,
    left_biceps  float                                         not null,
    right_biceps float                                         not null
);

CREATE TABLE muscle
(
    id   serial primary key,
    name varchar(255) not null
);

CREATE TABLE equipment
(
    id   serial primary key,
    name varchar(255) not null
);

CREATE TABLE exercise
(
    id          serial primary key,
    title       varchar(255)                                   not null,
    muscle      varchar(255)                                   not null,
    type        varchar(255)                                   not null,
    equipment   varchar(255)                                   not null,
    difficulty  int                                            not null,
    is_public   boolean                                        not null,
    description varchar(255) default 'no_data'                 not null,
    trainer_id  int references trainers (id) on delete cascade not null,
    state       int                                            not null
);

CREATE TABLE photo_exercise
(
    id          serial primary key,
    exercise_id int references exercise (id) on delete cascade not null,
    url         varchar(255)                                   not null,
    number      int                                            not null
);

CREATE TABLE param
(
    id   serial primary key,
    name varchar(255) not null
);

CREATE TABLE task
(
    id                serial primary key,
    date              date                                           not null,
    trainer_id        int references trainers (id) on delete cascade not null,
    client_id         int references clients (id) on delete cascade  not null,
    exercise_id       int references exercise (id) on delete cascade not null,
    file_feedback_url varchar(255) default 'no_data'                 not null,
    feedback_client   int          default '-1'                      not null,
    feedback_trainer  int          default '-1'                      not null,
    description       varchar(255) default 'no_data'                 not null,
    state             int                                            not null
);

CREATE TABLE task_param
(
    id         serial primary key,
    task_id    int references task (id) on delete cascade not null,
    param_name varchar(255)                               not null,
    target     int                                        not null,
    value      int default 0                              not null
);

CREATE TABLE msg
(
    id             serial primary key,
    task_id        int references task (id) on delete cascade     not null,
    trainer_id     int references trainers (id) on delete cascade not null,
    client_id      int references clients (id) on delete cascade  not null,
    text           varchar(255)                                   not null,
    is_send_client boolean                                        not null,
    date           timestamp                                      not null
);



INSERT INTO trainers (name, phone, photo)
VALUES ('Иванов Кирилл Валерьевич', '+79876543211', 'image/trainer_photo1.jpg');
INSERT INTO clients (name, is_man, phone, birthdate, trainer_id)
VALUES ('Иванов Кирилл Валерьевич', true, '+79876543210', '1996-02-09T00:00:00Z', 1);
INSERT INTO users (login, password_hash, role, client_id, trainer_id)
VALUES ('Train01', '6b776572666a6e6c3334726837383965726637387736810ed90aa5de17cbc1b471b999ec6b53b7c602', 1, 1, 1);

INSERT INTO trainers (name, phone, photo)
VALUES ('Ушаков Семен Васильевич', '+79865432107', 'image/trainer_photo2.jpg');
INSERT INTO clients (name, is_man, phone, birthdate, trainer_id)
VALUES ('Ушаков Семен Васильевич', true, '+79865432107', '1983-08-04T00:00:00Z', 2);
INSERT INTO users (login, password_hash, role, client_id, trainer_id)
VALUES ('Train02', '6b776572666a6e6c3334726837383965726637387736810ed90aa5de17cbc1b471b999ec6b53b7c602', 1, 2, 2);


INSERT INTO muscle (name)
VALUES ('Абдукторы');
INSERT INTO muscle (name)
VALUES ('Аддукторы');
INSERT INTO muscle (name)
VALUES ('Бедра');
INSERT INTO muscle (name)
VALUES ('Бицепс');
INSERT INTO muscle (name)
VALUES ('Грудь');
INSERT INTO muscle (name)
VALUES ('Грудь,Квадрицепсы');
INSERT INTO muscle (name)
VALUES ('Грудь,Трицепсы');
INSERT INTO muscle (name)
VALUES ('Грудь,Широчайшие мышцы спины');
INSERT INTO muscle (name)
VALUES ('Другое');
INSERT INTO muscle (name)
VALUES ('Икры');
INSERT INTO muscle (name)
VALUES ('Квадрицепсы');
INSERT INTO muscle (name)
VALUES ('Нижняя часть спины');
INSERT INTO muscle (name)
VALUES ('Плечи');
INSERT INTO muscle (name)
VALUES ('Плечи,Трицепсы,Широчайшие мышцы спины');
INSERT INTO muscle (name)
VALUES ('Предплечья');
INSERT INTO muscle (name)
VALUES ('Пресс');
INSERT INTO muscle (name)
VALUES ('Средняя часть спины');
INSERT INTO muscle (name)
VALUES ('Трапеции');
INSERT INTO muscle (name)
VALUES ('Трицепсы');
INSERT INTO muscle (name)
VALUES ('Шея');
INSERT INTO muscle (name)
VALUES ('Широчайшие мышцы спины');
INSERT INTO muscle (name)
VALUES ('Ягодицы');


INSERT INTO equipment (name)
VALUES ('Гантели');
INSERT INTO equipment (name)
VALUES ('Гири');
INSERT INTO equipment (name)
VALUES ('Другое');
INSERT INTO equipment (name)
VALUES ('Другое,Фитбол');
INSERT INTO equipment (name)
VALUES ('Машина Смита');
INSERT INTO equipment (name)
VALUES ('Отсутствует');
INSERT INTO equipment (name)
VALUES ('Силовая рама,Штанга');
INSERT INTO equipment (name)
VALUES ('Тренажер');
INSERT INTO equipment (name)
VALUES ('Тросовые тренажеры');
INSERT INTO equipment (name)
VALUES ('Турник');
INSERT INTO equipment (name)
VALUES ('Фитбол');
INSERT INTO equipment (name)
VALUES ('Штанга');
INSERT INTO equipment (name)
VALUES ('Эспандер');


INSERT INTO param (name)
VALUES ('Вес снаряда');
INSERT INTO param (name)
VALUES ('Кол-во повторов');
INSERT INTO param (name)
VALUES ('Кол-во подходов');
INSERT INTO param (name)
VALUES ('Нужен фото или видео отчет');
INSERT INTO param (name)
VALUES ('Уложиться по времени');
INSERT INTO param (name)
VALUES ('Продержаться по времени');



INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('«Велосипед»', 'Пресс', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('«Восьмерки» с гирей', 'Пресс', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('«Кошачья» растяжка', 'Нижняя часть спины', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('«Мельница» с гирей (сложный уровень)', 'Пресс', 'Изолирующее', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('«Мельница» с двумя гирями', 'Пресс', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('«Мельница» с одной гирей', 'Пресс', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('«Ножницы»', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('«Складной нож» в положении лежа на спине', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('«Складной нож» в положении на боку', 'Пресс', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('JM-жим', 'Трицепсы', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('W — вариант восьмерок с гирей', 'Пресс', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Армейский жим стоя', 'Плечи', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Баттерфляй', 'Плечи,Трицепсы,Широчайшие мышцы спины', 'Базовое', 'Отсутствует', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Бег на беговой дорожке', 'Квадрицепсы', 'Базовое', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Бег на улице', 'Квадрицепсы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Боковые выпады со штангой', 'Квадрицепсы', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Боковые прыжки через платформу', 'Квадрицепсы', 'Базовое', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Боковые скручивания', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Брасс', 'Грудь,Широчайшие мышцы спины', 'Базовое', 'Отсутствует', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Бурпи', 'Грудь,Квадрицепсы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Быстрые приседания со штангой', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Вертикальная тяга гантелей', 'Трапеции', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Вертикальная тяга нижнего блока', 'Трапеции', 'Базовое', 'Тросовые тренажеры', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Вертикальная тяга штанги', 'Плечи', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Вертикальный жим ногами', 'Квадрицепсы', 'Базовое', 'Машина Смита', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Взятие гири на грудь двумя руками', 'Бедра', 'Базовое', 'Гири', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Взятие штанги на грудь с выпадом', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Вис на одной руке', 'Широчайшие мышцы спины', 'Изолирующее', 'Турник', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Вращение плеча внутрь', 'Плечи', 'Базовое', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Выпады назад с гантелями (обратные выпады)', 'Квадрицепсы', 'Базовое', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Выпады с гантелями', 'Квадрицепсы', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Выпады со штангой', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Выпрямление ног в тренажере', 'Квадрицепсы', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Гакк-приседания', 'Квадрицепсы', 'Базовое', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Гакк-приседания с узкой постановкой стоп', 'Квадрицепсы', 'Базовое', 'Тренажер', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Гиперэкстензия', 'Нижняя часть спины', 'Базовое', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Гиперэкстензия на фитболе', 'Нижняя часть спины', 'Базовое', 'Фитбол', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Гиперэкстензия с напарником', 'Нижняя часть спины', 'Базовое', 'Отсутствует', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Глубокие приседания с гирями', 'Квадрицепсы', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Глубокие приседания со штангой', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Глубокие приседания со штангой на груди', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Горизонтальные подтягивания', 'Средняя часть спины', 'Базовое', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Гребной тренажер', 'Квадрицепсы', 'Базовое', 'Тренажер', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Езда на велосипеде', 'Квадрицепсы', 'Базовое', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Езда на велотренажере', 'Квадрицепсы', 'Базовое', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Езда на лежачем велотренажере', 'Квадрицепсы', 'Базовое', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим в подъеме туловища из положения лежа', 'Пресс', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим в тренажере', 'Грудь', 'Базовое', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим в тренажере с отрицательным наклоном', 'Грудь', 'Базовое', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим в тренажере с положительным наклоном', 'Грудь', 'Базовое', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гантелей лежа', 'Грудь', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гантелей лежа на полу', 'Грудь,Трицепсы', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гантелей лежа на скамье с отрицательным наклоном', 'Грудь', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гантелей лежа на скамье с положительным наклоном', 'Грудь', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гантелей лежа на скамье с положительным наклоном хватом молоток', 'Грудь', 'Базовое', 'Гантели', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гантелей от Арнольда Шварценеггера', 'Плечи', 'Базовое', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гантелей плечами на наклонной скамье', 'Плечи', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гантелей сидя', 'Плечи', 'Базовое', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гантелей стоя', 'Плечи', 'Базовое', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гантели одной рукой', 'Плечи', 'Базовое', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гири в ладони', 'Бедра', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гири в наклоне', 'Пресс', 'Базовое', 'Гири', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гири к плечу', 'Бедра', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гири лежа одной рукой', 'Грудь', 'Базовое', 'Гири', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гири лежа со скрещенными ногами', 'Грудь', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гири одной рукой', 'Плечи', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гири одной рукой лежа на полу', 'Грудь', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гири от Арнольда Шварценеггера', 'Плечи', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим гирь над собой', 'Плечи', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим лежа в машине Смита', 'Грудь', 'Базовое', 'Машина Смита', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим лежа на наклонной скамье в машине Смита', 'Грудь', 'Базовое', 'Машина Смита', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим лежа на полу', 'Трицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим лежа на полу используя цепи', 'Трицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим лежа на скамье с эспандером', 'Грудь', 'Базовое', 'Эспандер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим лежа узким хватом в машине Смита', 'Трицепсы', 'Базовое', 'Машина Смита', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим лежа широким хватом', 'Грудь', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим на верхнем блоке стоя', 'Грудь', 'Базовое', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим на шею лежа на горизонтальной скамье', 'Грудь', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим нижнего блока на трицепс лежа', 'Трицепсы', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим ногами', 'Квадрицепсы', 'Базовое', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим ногами с узкой постановкой стоп', 'Квадрицепсы', 'Базовое', 'Тренажер', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим одной рукой в положении лежа', 'Трицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим одной рукой лежа на горизонтальной скамье', 'Грудь', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим плечами лежа на наклонной скамье', 'Грудь', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим с цепью лежа', 'Грудь', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим Свенда', 'Грудь', 'Базовое', 'Другое', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим сидя в тренажере', 'Плечи', 'Базовое', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим со стоек в положении лежа', 'Трицепсы', 'Базовое', 'Силовая рама,Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим стоя с эспандером', 'Плечи', 'Базовое', 'Эспандер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим Тейта', 'Трицепсы', 'Изолирующее', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим штанги в силовой раме с эспандерами', 'Трицепсы', 'Базовое', 'Силовая рама,Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим штанги лежа', 'Грудь', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим штанги лежа на скамье', 'Трицепсы', 'Базовое', 'Силовая рама,Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим штанги лежа на скамье используя бруски', 'Трицепсы', 'Базовое', 'Силовая рама,Штанга', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим штанги лежа на скамье используя цепи', 'Трицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим штанги лежа на скамье с отрицательным наклоном', 'Грудь', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим штанги лежа на скамье с положительным наклоном', 'Грудь', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим штанги лежа узким хватом', 'Трицепсы', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим штанги сидя', 'Плечи', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим штанги сидя в машине Смита', 'Плечи', 'Базовое', 'Машина Смита', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим штанги сидя широким хватом', 'Плечи', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим штанги стоя из-за головы', 'Плечи', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Жим штанги широким хватом лежа на скамье с отрицательным наклоном', 'Грудь', 'Базовое', 'Штанга', '1', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Заход на скамью с гантелями', 'Квадрицепсы', 'Базовое', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Заход на скамью со штангой', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Изолированное разведение гантелей в стороны', 'Плечи', 'Изолирующее', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Изолированное разведение гантелей в стороны двумя руками', 'Плечи', 'Изолирующее', 'Гантели', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Касания стоп', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Катание на роликовых коньках', 'Квадрицепсы', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Комплексная растяжка дельт', 'Плечи', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Комплексное упражнение на трицепс на наклонной скамье', 'Трицепсы', 'Базовое', 'Штанга', '2', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Комплексный жим гантелей', 'Плечи', 'Базовое', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Комплексный жим штанги сидя', 'Плечи', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Концентрированные сгибания на бицепс сидя', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Косые скручивания', 'Пресс', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Косые скручивания на наклонной скамье', 'Пресс', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Кроль  (вольный стиль)', 'Плечи,Трицепсы,Широчайшие мышцы спины', 'Базовое', 'Отсутствует', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Кроссовер с эспандером', 'Грудь', 'Базовое', 'Эспандер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Круговые движения коленями', 'Икры', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Круговые движения локтями', 'Плечи', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Круговые движения плечами', 'Плечи', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Круговые движения руками', 'Плечи', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Кубинский жим', 'Плечи', 'Базовое', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Махи гирей одной рукой', 'Бедра', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Махи назад', 'Квадрицепсы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Махи назад согнутой ногой', 'Ягодицы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Махи ногами лежа на скамье', 'Ягодицы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Махи ногой', 'Ягодицы', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Махи ногой на нижнем блоке', 'Ягодицы', 'Изолирующее', 'Тросовые тренажеры', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Махи руками с эспандером', 'Плечи', 'Базовое', 'Эспандер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Мощный рывок штанги над головой', 'Бедра', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Наклон в сторону на мяче с отягощением', 'Пресс', 'Изолирующее', 'Фитбол', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Наклоны в сторону с гантелей', 'Пресс', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Наклоны в сторону со штангой', 'Пресс', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Обратная гиперэкстензия', 'Бедра', 'Базовое', 'Тренажер', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Обратное скручивание лежа на животе', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Обратные скручивания в положении лежа', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Обратный жим лежа на скамье', 'Трицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Олимпийские приседания', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отведение гантелей назад в наклоне', 'Трицепсы', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отведение гантелей через стороны лежа', 'Грудь', 'Базовое', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отведение ноги в сторону', 'Аддукторы', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отведение руки в сторону в наклоне на блоке', 'Плечи', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отведение руки в сторону на нижнем блоке', 'Плечи', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания', 'Грудь', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания «Пика»', 'Плечи', 'Базовое', 'Отсутствует', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания в наклоне', 'Грудь', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания в тренажере', 'Трицепсы', 'Базовое', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания на брусьях', 'Трицепсы', 'Базовое', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания на брусьях – вариант для проработки грудных мышц', 'Грудь', 'Базовое', 'Другое', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания на одной руке', 'Грудь', 'Базовое', 'Отсутствует', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания от скамьи из-за спины', 'Трицепсы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания от скамьи с весом', 'Трицепсы', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания с ногами на мяче', 'Грудь', 'Базовое', 'Фитбол', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания с поднятыми ногами', 'Грудь', 'Базовое', 'Другое,Фитбол', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания с узким упором', 'Трицепсы', 'Базовое', 'Отсутствует', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания с широким упором', 'Грудь', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Отжимания стоя на руках', 'Плечи', 'Базовое', 'Отсутствует', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Перекрёстная тяга на блоках', 'Широчайшие мышцы спины', 'Базовое', 'Тросовые тренажеры', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Плавание на спине', 'Широчайшие мышцы спины', 'Базовое', 'Отсутствует', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Планка', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Плиометрические отжимания', 'Грудь', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Плиометрические отжимания с гирей', 'Грудь', 'Базовое', 'Гири', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Плиометрические отжимания с опорами', 'Грудь', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Плиометрическое упражнение на укрепление мышц шеи', 'Шея', 'Изолирующее', 'Отсутствует', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Повороты с блином', 'Пресс', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Повороты с фитболом', 'Пресс', 'Базовое', 'Фитбол', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Повороты со штангой сидя на скамье', 'Пресс', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Поднятие диска, лежа головой вверх на скамье', 'Шея', 'Изолирующее', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Поднятие диска, лежа головой вниз на скамье', 'Шея', 'Изолирующее', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивание коленей к груди', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивание на перекладине (горилла кранч)', 'Пресс', 'Базовое', 'Турник', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивание ног к груди на горизонтальной скамье', 'Пресс', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивание ног к груди на фитболе', 'Пресс', 'Базовое', 'Фитбол', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивания', 'Широчайшие мышцы спины', 'Базовое', 'Турник', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивания в стороны', 'Широчайшие мышцы спины', 'Базовое', 'Турник', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивания на одной руке', 'Средняя часть спины', 'Базовое', 'Турник', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивания нейтральным хватом', 'Широчайшие мышцы спины', 'Базовое', 'Турник', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивания ног к груди сидя на горизонтальной скамье', 'Пресс', 'Базовое', 'Отсутствует', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивания обратным хватом', 'Широчайшие мышцы спины', 'Базовое', 'Турник', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивания от Винса Жиронды', 'Широчайшие мышцы спины', 'Базовое', 'Турник', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивания от Рокки', 'Широчайшие мышцы спины', 'Базовое', 'Турник', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивания с отягощением', 'Широчайшие мышцы спины', 'Базовое', 'Турник', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивания смешанным хватом', 'Средняя часть спины', 'Базовое', 'Турник', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивания широким хватом', 'Широчайшие мышцы спины', 'Базовое', 'Турник', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подтягивания широким хватом за голову', 'Широчайшие мышцы спины', 'Базовое', 'Турник', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем EZ-штанги на бицепс на скамье Скотта', 'Бицепс', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем EZ-штанги на бицепс на скамье Скотта обратным хватом', 'Бицепс', 'Изолирующее', 'Штанга', '1', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем EZ-штанги на бицепс стоя', 'Бицепс', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем EZ-штанги на бицепс стоя узким хватом', 'Бицепс', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъём блина перед собой', 'Плечи', 'Изолирующее', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гантелей', 'Плечи', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гантелей на бицепс в наклоне', 'Бицепс', 'Изолирующее', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гантелей на бицепс на наклонной скамье хватом «молоток»', 'Бицепс', 'Изолирующее', 'Гантели', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гантелей на бицепс на скамье Скотта', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гантелей на бицепс пронированным хватом стоя', 'Бицепс', 'Изолирующее', 'Гантели', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гантелей на бицепс сидя', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гантелей на бицепс стоя', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гантелей на бицепс хватом «молоток»', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гантелей на бицепс через стороны сидя', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гантелей на бицепс через стороны стоя', 'Бицепс', 'Изолирующее', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъём гантелей над головой', 'Плечи', 'Изолирующее', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гантелей перед собой', 'Плечи', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъём гантелей перед собой на наклонной скамье', 'Плечи', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъём гантели одной рукой в сторону', 'Плечи', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъём гантели одной рукой лежа на боку', 'Плечи', 'Изолирующее', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъём гантели одной рукой на наклонной скамье', 'Плечи', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гири на грудь', 'Бедра', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гири на грудь (гиря на уровне бедер)', 'Бедра', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем гири одной рукой', 'Средняя часть спины', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъём гирь на плечи', 'Плечи', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем и удержание гири перед собой', 'Предплечья', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем изогнутой штанги лежа на скамье', 'Средняя часть спины', 'Изолирующее', 'Штанга', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем на носки в тренажере сидя', 'Икры', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем на носки в тренажере стоя', 'Икры', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем на носки на одной ноге', 'Икры', 'Изолирующее', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем на носки с гантелей сидя', 'Икры', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем на носки с гантелями стоя', 'Икры', 'Изолирующее', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем на носки со штангой', 'Икры', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем на носки со штангой сидя', 'Икры', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем на пятки в машине Смита', 'Икры', 'Изолирующее', 'Машина Смита', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем ног в висе на перекладине', 'Пресс', 'Изолирующее', 'Турник', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем ног в положении лежа', 'Пресс', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем ног в тренажере с упорами для локтей', 'Пресс', 'Изолирующее', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем ног к перекладине', 'Пресс', 'Базовое', 'Турник', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем ног лежа на горизонтальной скамье', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем ног на наклонной скамье', 'Пресс', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем ноги перед собой', 'Бедра', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем носков в тренажере для жима ногами', 'Икры', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъём плеч', 'Плечи', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъём рук перед собой в тросовом тренажере', 'Плечи', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъём рук с эспандером стоя', 'Плечи', 'Изолирующее', 'Эспандер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем согнутых в коленях ног', 'Пресс', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем туловища в тренажере', 'Бедра', 'Базовое', 'Тренажер', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем туловища из положения лежа', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем туловища из положения лежа по методу Янда', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем туловища на наклонной скамье с отягощением', 'Пресс', 'Изолирующее', 'Эспандер', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем штанги на бицепс', 'Бицепс', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем штанги на бицепс на наклонной скамье', 'Бицепс', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем штанги на бицепс обратным хватом', 'Бицепс', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем штанги на бицепс узким хватом', 'Бицепс', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем штанги на бицепс узким хватом в положении сидя', 'Бицепс', 'Изолирующее', 'Штанга', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем штанги на бицепс широким хватом', 'Бицепс', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем штанги на грудь', 'Бедра', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем штанги на грудь (с подставок)', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем штанги на грудь (с уровня бедер)', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем штанги на грудь (с уровня колен)', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем штанги на грудь и жим', 'Плечи', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем штанги на грудь используя блоки (подставки)', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем штанги на плечи', 'Плечи', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъём штанги плечами сидя в машине Смита', 'Плечи', 'Изолирующее', 'Машина Смита', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем ягодиц', 'Пресс', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем ягодиц («Мост»)', 'Ягодицы', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем ягодиц со штангой', 'Ягодицы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Подъем ягодиц со штангой, опираясь на скамью', 'Ягодицы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Поочередное сгибание рук на бицепс сидя на наклонной скамье', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Поочередный жим гирь лежа на полу', 'Грудь', 'Базовое', 'Гири', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Поочередный подъем гирь назад', 'Средняя часть спины', 'Изолирующее', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Попеременная тяга гирь', 'Плечи', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Попеременные боковые скручивания', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Попеременный жим гирь стоя', 'Плечи', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Попеременный подъем гантелей на бицепс', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Попеременный подъем гантелей на бицепс на наклонной скамье', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Попеременный подъем гантелей на бицепс хватом «молоток»', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Попеременный подъём гантелей перед собой', 'Плечи', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Попеременный подъем на пятки и на носки со штангой', 'Икры', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Пресс с гимнастическим роликом', 'Пресс', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приведения ноги на нижнем блоке', 'Квадрицепсы', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания', 'Квадрицепсы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания Андерсона', 'Квадрицепсы', 'Базовое', 'Силовая рама,Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания в машине Смита', 'Квадрицепсы', 'Базовое', 'Машина Смита', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания в машине Смита на одной ноге', 'Квадрицепсы', 'Базовое', 'Машина Смита', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания в силовой раме', 'Квадрицепсы', 'Базовое', 'Силовая рама,Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания в силовой раме со штангой в висе', 'Квадрицепсы', 'Базовое', 'Силовая рама,Штанга', '2', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания в тренажере в положении лежа', 'Квадрицепсы', 'Базовое', 'Тренажер', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания Джефферсона', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания Зерхера', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания плие с гантелей', 'Квадрицепсы', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания с гантелями', 'Квадрицепсы', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания с гантелями используя скамью', 'Квадрицепсы', 'Базовое', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания с гирей (гоблет)', 'Квадрицепсы', 'Базовое', 'Гири', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания с гирей на одной ноге', 'Квадрицепсы', 'Базовое', 'Гири', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания с гирей над головой', 'Квадрицепсы', 'Базовое', 'Гири', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания с отягощением', 'Квадрицепсы', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания с цепями', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания с эспандером', 'Квадрицепсы', 'Базовое', 'Эспандер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания со штангой', 'Квадрицепсы', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания со штангой за спиной', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания со штангой на груди', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания со штангой на груди используя скамью', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания со штангой на одной ноге', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания со штангой над головой', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания со штангой с узкой постановкой стоп', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания со штангой с широкой постановкой стоп', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания со штангой, используя скамью', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания со штангой, используя ящик', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания со штангой, используя ящик и цепи', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания со штангой, используя ящик и эспандеры', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания стоя на коленях', 'Ягодицы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Приседания Франкенштейна (приседания с вытянутыми руками)', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Прогулка фермера', 'Предплечья', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Прыжки', 'Квадрицепсы', 'Базовое', 'Отсутствует', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Прыжки на подставку', 'Бедра', 'Базовое', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Прыжки ноги вместе, ноги врозь', 'Квадрицепсы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Прыжки с выпадами', 'Бедра', 'Базовое', 'Отсутствует', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Прыжки с приседаниями', 'Квадрицепсы', 'Базовое', 'Отсутствует', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Прыжки через скакалку', 'Квадрицепсы', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Прыжок со штангой из упора сидя', 'Ягодицы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Пуловер и подъем', 'Грудь', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Пуловер на наклонной скамье в тросовом тренажере', 'Широчайшие мышцы спины', 'Изолирующее',
        'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Пуловер прямыми руками с гантелей лежа на скамье', 'Грудь', 'Базовое', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Пуловер с гантелей лежа на скамье', 'Грудь', 'Базовое', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Пуловер со штангой на наклонной скамье', 'Грудь', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Пуловер со штангой на прямой скамье', 'Широчайшие мышцы спины', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разведение гантелей c вращением лежа на наклонной скамье', 'Плечи', 'Изолирующее', 'Гантели', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разведение гантелей в стороны лежа лицом вниз', 'Плечи', 'Изолирующее', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разведение гантелей лежа на наклонной скамье лицом вниз', 'Плечи', 'Изолирующее', 'Гантели', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разведение гантелей сидя в наклоне', 'Плечи', 'Изолирующее', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разведение ног в тренажере', 'Абдукторы', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разведение рук в стороны на нижнем блоке', 'Плечи', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разведение рук в тренажере (обратная бабочка)', 'Плечи', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разведение рук с гантелями в стороны сидя', 'Плечи', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разведение рук с гантелями в стороны стоя', 'Плечи', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разведение рук с гантелями в упоре', 'Плечи', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание гантели из-за головы', 'Трицепсы', 'Изолирующее', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание гантели пронированным хватом', 'Трицепсы', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание гантели супинированным хватом', 'Трицепсы', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание двумя руками на трицепс в наклоне', 'Трицепсы', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание двумя руками на трицепс сидя в наклоне', 'Трицепсы', 'Изолирующее', 'Гантели', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание на трицепс на верхнем блоке', 'Трицепсы', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание на трицепс на верхнем блоке обратным хватом', 'Трицепсы', 'Изолирующее', 'Тросовые тренажеры', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание на трицепс на верхнем блоке одной рукой', 'Трицепсы', 'Изолирующее', 'Тросовые тренажеры', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание на трицепс на верхнем блоке с V-рукоятью', 'Трицепсы', 'Изолирующее', 'Тросовые тренажеры', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание на трицепс на верхнем блоке с канатной рукоятью', 'Трицепсы', 'Изолирующее', 'Тросовые тренажеры',
        '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание одной руки на трицепс сидя в наклоне', 'Трицепсы', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание одной рукой на трицепс в наклоне', 'Трицепсы', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание одной рукой на трицепс на нижнем блоке', 'Трицепсы', 'Изолирующее', 'Тросовые тренажеры', '1',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание рук на блоке из-за головы стоя на коленях', 'Трицепсы', 'Изолирующее', 'Тросовые тренажеры', '1',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибание штанги узким хватом в положении лежа', 'Трицепсы', 'Изолирующее', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибания на трицепс в тренажере', 'Трицепсы', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Разгибания на трицепс на верхнем блоке лежа на наклонной скамье', 'Трицепсы', 'Изолирующее',
        'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растягивание грудных мышц заведением рук за голову', 'Грудь', 'Изолирующее', 'Другое', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растягивание икроножных мышц в положении сидя', 'Икры', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растягивание мышц брюшного пресса', 'Пресс', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растягивание мышц груди и передней части плечевого пояса', 'Грудь', 'Изолирующее', 'Другое', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растягивание мышц груди с помощью  фитбола', 'Грудь', 'Изолирующее', 'Фитбол', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растягивание мышц пресса сидя на полу', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растягивание мышц пресса стоя', 'Пресс', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растягивание мышц шеи в стороны', 'Шея', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растягивание широчайших мышц спины лежа', 'Широчайшие мышцы спины', 'Изолирующее', 'Отсутствует', '0', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растягивание широчайших мышц спины с напарником', 'Широчайшие мышцы спины', 'Изолирующее', 'Отсутствует', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растягивания широчайших мышц спины в упоре стоя', 'Широчайшие мышцы спины', 'Изолирующее', 'Отсутствует', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжение внутренних мышц бедра', 'Бедра', 'Изолирующее', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжение мышц задней поверхности бедра', 'Бедра', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка альпиниста', 'Квадрицепсы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка бицепсов стоя', 'Бицепс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка брахиалиса', 'Бицепс', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка в положении лежа', 'Нижняя часть спины', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка в положении сидя', 'Нижняя часть спины', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка внутренних мышц бедер', 'Аддукторы', 'Базовое', 'Отсутствует', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка грудных мышц лежа на фитболе', 'Грудь', 'Изолирующее', 'Фитбол', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка грудных мышц отведением плеч', 'Грудь', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка дельт', 'Плечи', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка дельт стоя', 'Плечи', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка дельт, сидя на стуле', 'Плечи', 'Изолирующее', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка для отводящих мышц бедра', 'Аддукторы', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка задних дельт с гимнастической палкой', 'Плечи', 'Изолирующее', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка икр и мышц задней поверхности бедра сидя на полу', 'Бедра', 'Базовое', 'Другое', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка икроножных мышц в положении стоя', 'Икры', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка квадрицепсов', 'Квадрицепсы', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка квадрицепсов с использованием платформы', 'Квадрицепсы', 'Базовое', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка квадрицепсов с отгибанием назад', 'Квадрицепсы', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка квадрицепсов с помощью валика', 'Квадрицепсы', 'Изолирующее', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка лежа на полу', 'Квадрицепсы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц бедра лежа на боку', 'Квадрицепсы', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц бедра лежа на скамье', 'Квадрицепсы', 'Изолирующее', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц в положении сидя', 'Бедра', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц голени и задней поверхности бедра в положении стоя', 'Бедра', 'Базовое', 'Другое', '0', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц задней поверхности бедра в положении лежа', 'Бедра', 'Изолирующее', 'Отсутствует', '0', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц задней поверхности бедра в положении лежа (90/90)', 'Бедра', 'Базовое', 'Отсутствует', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц задней поверхности бедра в положении стоя', 'Бедра', 'Базовое', 'Отсутствует', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц задней поверхности бедра с помощью наклона вперед', 'Бедра', 'Базовое', 'Отсутствует', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц задней поверхности бедра сидя на полу', 'Бедра', 'Базовое', 'Отсутствует', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц задней поверхности бедра сидя на стуле', 'Бедра', 'Изолирующее', 'Другое', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц нижней части спины', 'Нижняя часть спины', 'Базовое', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц нижней части спины в положении лежа («мост»)', 'Нижняя часть спины', 'Базовое', 'Отсутствует',
        '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц нижней части спины в положении лежа («пирамида»)', 'Нижняя часть спины', 'Базовое', 'Фитбол',
        '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц обхватывая бедра в положении сидя', 'Бедра', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц спины', 'Средняя часть спины', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц спины в положении стоя', 'Нижняя часть спины', 'Изолирующее', 'Отсутствует', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка мышц спины сидя на стуле', 'Средняя часть спины', 'Изолирующее', 'Отсутствует', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка отводящих мышц бедра', 'Абдукторы', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка переднего пучка дельт сидя', 'Плечи', 'Изолирующее', 'Отсутствует', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка поясничного треугольника', 'Средняя часть спины', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка предплечий стоя на коленях', 'Предплечья', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка приводящих мышц бедра лежа на боку', 'Аддукторы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка с выпадом', 'Квадрицепсы', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка с выпадом и поворотом', 'Нижняя часть спины', 'Базовое', 'Отсутствует', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка с приседанием', 'Квадрицепсы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка с фитболом', 'Нижняя часть спины', 'Базовое', 'Фитбол', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка сгибателей бедра и квадрицепсов', 'Квадрицепсы', 'Базовое', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка сгибателей бедра стоя на колене', 'Квадрицепсы', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка супермена', 'Нижняя часть спины', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка трицепса', 'Трицепсы', 'Базовое', 'Отсутствует', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка трицепсов', 'Трицепсы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка трицепсов с использованием полотенца', 'Трицепсы', 'Изолирующее', 'Отсутствует', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка трицепсов стоя', 'Трицепсы', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка широчайших мышц спины сидя', 'Широчайшие мышцы спины', 'Изолирующее', 'Отсутствует', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка ягодичных мышц', 'Ягодицы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка ягодичных мышц (колено к груди)', 'Ягодицы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Растяжка ягодичных мышц в положении лежа', 'Ягодицы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Румынская становая тяга', 'Бедра', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Румынская становая тяга на подставке', 'Бедра', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Русский твист (повороты туловища)', 'Пресс', 'Базовое', 'Отсутствует', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Рывковая становая тяга', 'Бедра', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Рывковая тяга', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Рывок гири одной рукой', 'Плечи', 'Базовое', 'Гири', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Рывок гирь', 'Плечи', 'Базовое', 'Гири', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Рывок и толчок гири одной рукой', 'Плечи', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Рывок из-за головы', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Рывок с выпадом', 'Бедра', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Рывок штанги', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Рывок штанги (штанга на уровне бедер)', 'Бедра', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Рывок штанги (штанга на уровне колен)', 'Бедра', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Рывок штанги над головой', 'Бедра', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Рывок штанги с блоков', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Рывок штанги с подставок', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сведение гантелей лежа', 'Грудь', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сведение гантелей на скамье с отрицательным наклоном', 'Грудь', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сведение гантелей на скамье с положительным наклоном', 'Грудь', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сведение ног в тренажере', 'Аддукторы', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сведение рук в кроссовере', 'Грудь', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сведение рук в тренажере (Бабочка)', 'Грудь', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сведение-разведение гантели одной рукой лежа', 'Грудь', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сведения рук на нижнем блоке лежа', 'Грудь', 'Изолирующее', 'Тросовые тренажеры', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сведения рук на нижнем блоке лежа на наклонной скамье', 'Грудь', 'Изолирующее', 'Тросовые тренажеры', '1',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястий на нижнем блоке', 'Предплечья', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястий на нижнем блоке сидя на скамье', 'Предплечья', 'Изолирующее', 'Тросовые тренажеры', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястий на скамье с гантелями ладонями вверх', 'Предплечья', 'Изолирующее', 'Гантели', '0', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястий на скамье с гантелями ладонями вниз', 'Предплечья', 'Изолирующее', 'Гантели', '0', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястий на скамье со штангой ладонями вверх', 'Предплечья', 'Изолирующее', 'Штанга', '0', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястий на скамье со штангой ладонями вниз', 'Предплечья', 'Изолирующее', 'Штанга', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястий с пронацией в положении лежа', 'Предплечья', 'Изолирующее', 'Гантели', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястий с супинацией в положении лежа', 'Предплечья', 'Изолирующее', 'Гантели', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястий сидя на скамье с гантелями ладонями вверх', 'Предплечья', 'Изолирующее', 'Гантели', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястий сидя на скамье с гантелями ладонями вниз', 'Предплечья', 'Изолирующее', 'Гантели', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястий со штангой сидя на скамье (ладонями вверх)', 'Предплечья', 'Изолирующее', 'Штанга', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястий со штангой сидя на скамье (ладонями вниз)', 'Предплечья', 'Изолирующее', 'Штанга', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястья сидя на скамье пронированным хватом', 'Предплечья', 'Изолирующее', 'Гантели', '1', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание запястья сидя на скамье супинированным хватом', 'Предплечья', 'Изолирующее', 'Гантели', '0', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание ног в тренажере лежа', 'Бедра', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание ног в тренажере сидя', 'Бедра', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание ног в тренажере стоя', 'Бедра', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание ног на фитболе', 'Бедра', 'Базовое', 'Фитбол', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание одной рукой на бицепс на скамье Скотта', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс на блоке в положении лежа', 'Бицепс', 'Изолирующее', 'Тросовые тренажеры', '1', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс на верхнем блоке', 'Бицепс', 'Базовое', 'Тросовые тренажеры', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс на верхнем блоке узким хватом', 'Бицепс', 'Изолирующее', 'Тросовые тренажеры', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс на нижнем блоке обратным хватом', 'Бицепс', 'Изолирующее', 'Тросовые тренажеры', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс на нижнем блоке с канатной рукоятью', 'Бицепс', 'Изолирующее', 'Тросовые тренажеры',
        '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс на скамье Скотта на нижнем блоке', 'Бицепс', 'Изолирующее', 'Тросовые тренажеры', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс над головой на верхнем блоке', 'Бицепс', 'Изолирующее', 'Тросовые тренажеры', '1',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс перед собой с гантелями хватом «молоток»', 'Бицепс', 'Изолирующее', 'Гантели', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс с гантелями лежа', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс с диском', 'Бицепс', 'Изолирующее', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс с наклоном вперед', 'Бицепс', 'Изолирующее', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс со штангой в положении лежа', 'Бицепс', 'Изолирующее', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс со штангой, с отведением локтей назад', 'Бицепс', 'Базовое', 'Штанга', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс хватом «молоток» на скамье Скотта', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук на бицепс-машине', 'Бицепс', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание рук с гантелями на бицепс на наклонной скамье', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание руки на бицепс на нижнем блоке стоя', 'Бицепс', 'Изолирующее', 'Тросовые тренажеры', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибание руки на бицепс стоя рядом с наклонной скамьей', 'Бицепс', 'Изолирующее', 'Гантели', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибания запястий за спиной со штангой в положении стоя', 'Предплечья', 'Изолирующее', 'Штанга', '0', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибания Зоттмана (развороты предплечий с гантелями)', 'Бицепс', 'Изолирующее', 'Гантели', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибания Зоттмана на скамье Скотта', 'Бицепс', 'Изолирующее', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибания на бицепс в тренажере', 'Бицепс', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сгибания рук на бицепс на нижнем блоке стоя', 'Бицепс', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Сисси-приседы', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Скручивания', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Скручивания в тренажере для пресса', 'Пресс', 'Изолирующее', 'Тренажер', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Скручивания на блоке', 'Пресс', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Скручивания на верхнем блоке', 'Пресс', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Скручивания на наклонной скамье', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Скручивания на фитболе', 'Пресс', 'Изолирующее', 'Фитбол', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Скручивания с ногами на фитболе', 'Пресс', 'Изолирующее', 'Фитбол', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Скручивания с отягощением', 'Пресс', 'Изолирующее', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Скручивания с поднятыми ногами', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Скручивания с руками над головой', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Становая тяга', 'Квадрицепсы', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Становая тяга в машине Смита с прямыми ногами', 'Бедра', 'Базовое', 'Машина Смита', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Становая тяга в силовой раме с эспандерами', 'Нижняя часть спины', 'Базовое', 'Силовая рама,Штанга', '2',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Становая тяга на платформе или подставке', 'Нижняя часть спины', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Становая тяга с гантелями', 'Бедра', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Становая тяга с гирей стоя на одной ноге', 'Бедра', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Становая тяга с цепями', 'Нижняя часть спины', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Становая тяга с эспандером', 'Нижняя часть спины', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Становая тяга со штангой', 'Нижняя часть спины', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Становая тяга со штангой в одной руке', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Становая тяга со штангой с прямыми ногами', 'Бедра', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Становая тяга сумо', 'Бедра', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Статическое упражнение для мышц груди', 'Грудь', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Степ-тренажер', 'Квадрицепсы', 'Базовое', 'Тренажер', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Толчок гири одной рукой', 'Плечи', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Толчок гирь над собой', 'Плечи', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Толчок и жим штанги стоя', 'Плечи', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Толчок и жим штанги стоя из-за спины', 'Плечи', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Толчок с выпадом', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Толчок штанги от груди', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Толчок штанги от груди (частичный)', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Толчок штанги от груди с приседом', 'Квадрицепсы', 'Базовое', 'Штанга', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тренажер, имитирующий ходьбу по лестнице', 'Квадрицепсы', 'Базовое', 'Тренажер', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тройная растяжка', 'Бедра', 'Базовое', 'Отсутствует', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга в силовой раме', 'Нижняя часть спины', 'Базовое', 'Силовая рама,Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга в силовой раме с эспандером', 'Нижняя часть спины', 'Базовое', 'Силовая рама,Штанга', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга верхнего блока за голову', 'Широчайшие мышцы спины', 'Базовое', 'Тросовые тренажеры', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга верхнего блока к груди', 'Широчайшие мышцы спины', 'Базовое', 'Тросовые тренажеры', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга верхнего блока к груди обратным хватом', 'Широчайшие мышцы спины', 'Базовое', 'Тросовые тренажеры', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга верхнего блока к груди с V образным грифом', 'Широчайшие мышцы спины', 'Базовое', 'Тросовые тренажеры',
        '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга верхнего блока одной рукой стоя на коленях', 'Широчайшие мышцы спины', 'Базовое', 'Тросовые тренажеры',
        '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга верхнего блока с прямыми руками', 'Широчайшие мышцы спины', 'Изолирующее', 'Тросовые тренажеры', '0',
        'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга верхнего блока широким хватом', 'Широчайшие мышцы спины', 'Базовое', 'Тросовые тренажеры', '0', 'true',
        '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга гантелей в наклоне', 'Средняя часть спины', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга гантелей в наклоне нейтральным хватом', 'Средняя часть спины', 'Базовое', 'Гантели', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга гантели в наклоне', 'Средняя часть спины', 'Базовое', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга гантели к груди', 'Плечи', 'Базовое', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга гири к груди в стиле Сумо', 'Трапеции', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга гирь в наклоне обеими руками', 'Средняя часть спины', 'Базовое', 'Гири', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга гирь в упоре лежа', 'Средняя часть спины', 'Базовое', 'Гири', '2', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга головы к груди', 'Шея', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга к груди в гребном тренажере', 'Широчайшие мышцы спины', 'Базовое', 'Тренажер', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга к груди с эспандером', 'Трапеции', 'Базовое', 'Эспандер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга к лицу', 'Плечи', 'Базовое', 'Тросовые тренажеры', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга к шее в гребном тренажере', 'Плечи', 'Базовое', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга на наклонной скамье', 'Средняя часть спины', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга на нижнем блоке', 'Средняя часть спины', 'Базовое', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга нижнего блока между ног', 'Ягодицы', 'Базовое', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга нижнего блока одной рукой', 'Средняя часть спины', 'Базовое', 'Тросовые тренажеры', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга Т-штанги в положении лежа', 'Средняя часть спины', 'Базовое', 'Тренажер', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга Т-штанги обеими руками в наклоне', 'Средняя часть спины', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга Т-штанги одной рукой в наклоне', 'Средняя часть спины', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга штанги в наклоне', 'Средняя часть спины', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга штанги в наклоне в машине Смита', 'Средняя часть спины', 'Базовое', 'Машина Смита', '0', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга штанги в наклоне обратным хватом', 'Средняя часть спины', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга штанги к груди в машине Смита', 'Трапеции', 'Базовое', 'Машина Смита', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Тяга штанги к груди в наклоне', 'Плечи', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Удержание веса стоя', 'Предплечья', 'Изолирующее', 'Другое', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Удерживание веса', 'Предплечья', 'Изолирующее', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Упражнение «ослик»', 'Икры', 'Изолирующее', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Упражнение «Доброе утро»', 'Бедра', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Упражнение «Доброе утро» (штанга в висе)', 'Бедра', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Упражнение «доброе утро» в положении сидя', 'Нижняя часть спины', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Упражнение «Доброе утро» с прямыми ногами', 'Нижняя часть спины', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Упражнение «Доброе утро» с упоров', 'Бедра', 'Базовое', 'Силовая рама,Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Упражнение «дровосек»', 'Пресс', 'Базовое', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Упражнение для косых мышц живота «Мост»', 'Пресс', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Упражнение лягушка', 'Пресс', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Французский жим гантелями на наклонной скамье', 'Трицепсы', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Французский жим лежа', 'Трицепсы', 'Изолирующее', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Французский жим лежа на скамье используя цепи', 'Трицепсы', 'Изолирующее', 'Другое', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Французский жим лежа с гантелями', 'Трицепсы', 'Изолирующее', 'Гантели', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Французский жим лежа узким хватом', 'Трицепсы', 'Изолирующее', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Французский жим на нижнем блоке', 'Трицепсы', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Французский жим на нижнем блоке стоя', 'Трицепсы', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Французский жим одной рукой стоя', 'Трицепсы', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Французский жим с EZ штангой на наклонной скамье', 'Трицепсы', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Французский жим с гантелей стоя', 'Трицепсы', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Французский жим сидя', 'Трицепсы', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Французский жим со штангой на наклонной скамье', 'Трицепсы', 'Изолирующее', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Французский жим со штангой стоя', 'Трицепсы', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Фронтальные приседания', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Фронтальный подъём штанги над головой', 'Плечи', 'Изолирующее', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Ходьба на беговой дорожке', 'Квадрицепсы', 'Базовое', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Ходьба с выпадами', 'Квадрицепсы', 'Базовое', 'Отсутствует', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Ходьба с выпадами со штангой', 'Квадрицепсы', 'Базовое', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Частичный рывок', 'Квадрицепсы', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Широкая становая тяга', 'Бедра', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Шраги в машине Смита', 'Трапеции', 'Изолирующее', 'Машина Смита', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Шраги в тренажере для голеней', 'Трапеции', 'Изолирующее', 'Тренажер', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Шраги на нижнем блоке', 'Трапеции', 'Изолирующее', 'Тросовые тренажеры', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Шраги с гантелями', 'Трапеции', 'Изолирующее', 'Гантели', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Шраги с гантелями на наклонной скамье', 'Средняя часть спины', 'Изолирующее', 'Гантели', '1', 'true', '1',
        '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Шраги со штангой', 'Трапеции', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Шраги со штангой из-за спины', 'Трапеции', 'Изолирующее', 'Штанга', '0', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Шраги широким хватом', 'Трапеции', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Штанга в качестве гимнастического ролика', 'Пресс', 'Базовое', 'Штанга', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Эллиптический тренажер', 'Квадрицепсы', 'Базовое', 'Тренажер', '1', 'true', '1', '1');
INSERT INTO exercise (title, muscle, type, equipment, difficulty, is_public, trainer_id, state)
VALUES ('Энергичная растяжка грудных мышц', 'Грудь', 'Изолирующее', 'Отсутствует', '0', 'true', '1', '1');



INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('1', 'image/9ae2a9e303622813140b47b53f6f2f6c.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('1', 'image/cd19e49a8ce70e7ac9e77aeb0e840831.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('1', 'image/9287449b4d791d6e30459979206bde33.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('2', 'image/7cda8a81a40d40b9cee8493fc9882c9d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('2', 'image/f7e5d9d5844cbfca9a9d23b39a783f3f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('2', 'image/0de0296ac2d1fbaac63c6e3384779828.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('2', 'image/1c77329a6e87c37a241f55d4bd7ae6b2.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('3', 'image/a458c942f23dde907ca0dc9324783014.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('3', 'image/8f7cd45c30e9ad5747c4a2c39fccb3c8.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('4', 'image/dd5722096caac0e03a3b20018d8cf13b.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('4', 'image/424a8f902e87db6fff02c299f5a3e642.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('5', 'image/f226b2b7bbff13a66f507780d4f062c3.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('5', 'image/260679a25810c0577bc4697b6da52717.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('6', 'image/633a011b491e0156048f8885eda39106.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('6', 'image/fddf71d536ab631f4009aba616d9d065.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('7', 'image/6cfaca5e529f76a2d7182c8857dc2682.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('7', 'image/1fb8bef931c51c5df25162cc8fd3fdf1.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('8', 'image/ce6046f2f2527b08589754992106e8b5.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('8', 'image/21705af25cec3e45c7519927c97349a5.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('9', 'image/31318546d14c059d39d5a73c004bcc77.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('9', 'image/fdbb24edaeeb173cffb3cccc8076f5ed.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('10', 'image/a12306bba78917a2b3ace22e99785c88.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('10', 'image/847a91f727371f53742bdc227e3427f3.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('11', 'image/25701c08fd3dc8e832afe3eda18a6f93.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('11', 'image/a0827d96232e669c384d91d4be68e0b6.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('11', 'image/c690c5c873dc4426810eeb872d146e81.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('11', 'image/ec27c2958efa82a5e61e39018da49945.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('12', 'image/ea7b9e8c23cc7509e64861f8e02ac38f.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('12', 'image/2c972cb5740d1fcdc18b2b6cf2909e5e.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('13', 'image/902a8178855cedaac3a903eb76c20c51.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('13', 'image/efbbb79fa1134fe1febab577619ff6a5.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('13', 'image/f69dddafa8be39d960c3a42f14b9a4f5.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('13', 'image/a23aeb292d52cd643714ddd264e179a9.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('14', 'image/c54ec8c0ee609c9e8aba6eb8ddab6b5b.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('14', 'image/b263bbe67449e450b501c3b1278ae3ed.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('15', 'image/23bb9bcb159e06858c44a2e30e0dea04.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('15', 'image/e950d308e7dec3693ffda30f5da96744.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('15', 'image/c521993296a1f81a10e5dca36a743c3f.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('16', 'image/12d1eda585dccf6dacb50aaca95fd46c.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('16', 'image/f2f6fff694ba2dc060bfb7c32cc8b9af.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('17', 'image/6f6cf9d7353d457f44e56af962494729.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('17', 'image/945140a7bed91d635985d15a43c85f2a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('17', 'image/71d80e2934f54bf1cad49c2e7f5e9a22.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('17', 'image/3e1807465c96d16f9e294b393de5427e.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('18', 'image/c9807dd3a0eb3dbb2cec929e6b2509c7.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('18', 'image/96388ab5183bf741eeea10613d1f06a2.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('19', 'image/e0ad88b4c4c69c6cb24e75c00f601bc6.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('19', 'image/479cc68869e5f34db3162079a30ecd91.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('19', 'image/076bfaa1327e0c1bfce6baa25de3440b.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('19', 'image/55743695dc71072a97e892061e9be25c.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('20', 'image/4fb48f332ec68712627f941862f41db1.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('20', 'image/8f443a9d58d5e298ea1a0cad411a1047.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('20', 'image/1a705363a36a942d989cfc124ac4f47d.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('21', 'image/a1a07a4a40a2818beca1cf5761eb0ebc.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('21', 'image/dc4e8857307c360c1502196e7969cde5.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('22', 'image/d6190db89cfef962f514ae843b96c65c.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('22', 'image/8b1675be835c39776b7896cc4c31887d.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('23', 'image/c45710ed346c8eebc988c62bc16e85a5.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('23', 'image/32243549a7eb7d307111468d462d21bc.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('24', 'image/1dc9394063e7004590c57c9472ec9289.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('24', 'image/e9952480ff235553ae5a312ea11e8a71.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('25', 'image/ec83bb9e33b0a30fe960f2217cc00dd2.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('25', 'image/b2f82c9d626a307083e281950868c2c5.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('26', 'image/3c9d4dd96af5ca7bf5e10728b89b4161.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('26', 'image/e06643efce5f129f24bf672e67b9ccb5.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('26', 'image/eab1f6e1a3d6c156f564eee2bbbfe07a.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('27', 'image/36ddcbbe6da19c7d59f2c7a5e03b74a0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('27', 'image/b5a362fe787ec9f80e4e2ee99881ccd4.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('27', 'image/1ae98671e03ed1783ab0ea442ae1b69d.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('27', 'image/e60aaca5e740a1d3d2f3c8a4945cfc7d.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('28', 'image/48ff9d9e63f5d8a5b4a0d9888a8a6ab1.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('28', 'image/3cec68bf39576035fdef297fc40b5e6d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('29', 'image/20cb1a9196dc469fac08c0040d25c509.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('29', 'image/ee5d7a9670222ef29beef432c527f218.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('30', 'image/ce2f701f9e16f0b44282761c8e5a06b7.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('30', 'image/92165152e18275bd8ff3fabcbb7c5e01.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('31', 'image/b83ff8bf1630fbc8de5fdb1cc1f69692.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('31', 'image/320bb0d9624e815969b8b63d5f741522.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('32', 'image/d5fa11fb3c812b89be3ee56b9b4d3e3c.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('32', 'image/58244c93b69928cabda5bbcef253b593.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('33', 'image/bdd52570df1cb18dbd49a7c108140fd1.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('33', 'image/aec7c6cf3016a851bebf6a4ed4565e5d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('34', 'image/b54adee91e946a04bd0e9fede19a6c88.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('34', 'image/903fd3a6472bfade98320aab49d4bebf.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('35', 'image/b4988963b808489933cb101fca4bedbc.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('35', 'image/4d2e86a25092179d1d99f3cd89d07a70.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('36', 'image/e3124d7f7ede724f291ec5f878cdfe94.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('36', 'image/0c1353601cc427a5ca43fe093030db6b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('37', 'image/382b6335d05f01a81dc7b909aadc549a.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('37', 'image/83e26275ae7a03a24b74e503e62215e1.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('38', 'image/2ec4c7b9d2c18cc50fe9959cdd196e2e.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('38', 'image/01813266e09ceeda264d3b71be1f8352.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('39', 'image/fcb1f3ceae9fb41e0533f7a949e1f07b.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('39', 'image/daa28282f4693891878c9851f3109e0d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('40', 'image/6885d5751bba4962887f1ac6f3dfda6a.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('40', 'image/0f8b9786c6a015dac608f3dbdf684108.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('41', 'image/701e190a3a7580ba7c91e2ae5b22b671.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('41', 'image/e2df362e23cb04ada00533ce354eb196.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('42', 'image/06546599535cb0f991f230c786bdbb3c.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('42', 'image/19a7b9f377bb91851a35f7d4f7a41271.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('43', 'image/213aca1abfcb2350b422a87db7417924.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('43', 'image/87bf32d5dc07845e11cc1806b829f39b.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('43', 'image/c9b3b26a62b7f33eccb45bb9f2dcbe0b.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('44', 'image/6f3d246a0b9f54f8333998037a722ecc.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('44', 'image/aebf489cc7e73083d46ebbeb894c0f56.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('44', 'image/b70e2c24b0b82520f6a4b6675ade2819.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('45', 'image/efa9de5b7399c3f11f3cbf35f2c722fe.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('45', 'image/1ef2a6cf10a7af72c3df745e2ef17f6d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('46', 'image/ceb958664b112d8a05b2bf5be1f00c65.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('46', 'image/165be11f6cb8ca1987887b57543a0fe4.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('47', 'image/c67f346462d9a4683ee16259369496b4.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('47', 'image/87be238d6de43c4e6b21e513aab0df89.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('48', 'image/898b56efd01e2b9c7738a3befaafc151.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('48', 'image/c31b6a395622b6fdc6e21bcaecc58c86.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('49', 'image/88a3763d8971766245e071b78d10a422.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('49', 'image/9d4857b32ece5ad9b47b0acfe56aa7e5.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('50', 'image/04fd04bcbd68a31576074e3cd717f8cc.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('50', 'image/11d713efd472c9a944792bf5d66145b1.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('51', 'image/a091e0771e39d71ff1aa44fb58a3a0cc.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('51', 'image/1617a3823f1898545402cce33a3b28a3.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('52', 'image/01e6bd7af14a53ac9105ca1403d0aa6c.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('52', 'image/2364f8e79339abc08145a2b93b01b5ab.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('53', 'image/acd47855963bf9fc1692991015e57daa.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('53', 'image/2cf95b1f9162c674c849ab9967157bb4.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('54', 'image/bf5759753f7048208cc9c32b03f4a2be.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('54', 'image/762d16f1d3a985fbff459b62c419b49d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('55', 'image/a3f53c21df6d8294202de9cb87445168.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('55', 'image/804e4e0a4f34a02c6adf43fb2ea3c81c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('56', 'image/ac4121c84fc6d39698be10c12a65cb7d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('56', 'image/848f45a5b303ab28f3490badae0328bb.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('57', 'image/0978f89ca86d1a8018a5844ad4420ac7.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('57', 'image/32a821f6498fb1644de76ddef98f0f5c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('58', 'image/3800318487f7a65a302898c131eacf9b.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('58', 'image/c4a36b93e1530975060ed6a87b243d66.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('59', 'image/686405cba5949536664a915b75698991.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('59', 'image/b5e2c3f6e5a80ccc3c23846870ddab98.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('60', 'image/7457b359edaacb9726b5098845553faf.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('60', 'image/cac9b5c011a85493792875bb26052def.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('61', 'image/ffa6d3008b8d7232324d2880d2037f8d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('61', 'image/02f1f14af97b45fd12786dd2fcd42312.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('61', 'image/c61d64ee985bde7a637a55f6eeb44706.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('62', 'image/43c094378e159034f06c5aaeca9da516.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('62', 'image/e66e73b7ed8d8aca704e619e93c2126d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('62', 'image/522912ecd3b071d4e58e52184aafdf04.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('63', 'image/2aeb68598e0baa01b9773b5964791854.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('63', 'image/f8167a8dc0122e6983dabd6817cd2a86.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('63', 'image/3fa71e3a323b253a735004474523945e.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('64', 'image/062012445d0af50a2688734048d56253.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('64', 'image/9a74df4de2eae73016202228bcae8a28.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('65', 'image/9fa703d6a543937664b3b421723c5c2e.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('65', 'image/976fdf00acf274a77eea345b6c7dc6f2.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('66', 'image/2ec21165f3f41d6b264d4ebd49f88c27.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('66', 'image/39f074b47430b9886ee189db015436c7.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('66', 'image/acae460abd98a5f286dbc540fc5f9f46.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('67', 'image/2d294c4da19235e48372c598134bc7b1.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('67', 'image/f197980708d43aacd2279fbbc0c8ed3d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('68', 'image/d98e128bb2d7f45eebde870762ae250b.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('68', 'image/54d1fe4571172d0e3876f284fe31060b.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('69', 'image/6fb475ced2403bd4b20ef312889296f3.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('69', 'image/ed94372b9de4c91dcd0fac20bfa84e76.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('69', 'image/3e2dbbf3458298cb58228836a6fd4129.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('70', 'image/4de82d38be3c1fa480ee8e4a8a3e3482.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('70', 'image/855fc4ecd87c01f66003466ef41429ae.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('71', 'image/4b12a607d2dd7a8e8c871703a931b1da.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('71', 'image/0fb14e6b046eba06994e1da470ce1c57.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('72', 'image/feb9b03ab06f01001ebb1d8c124d9044.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('72', 'image/3861ac747ed7f862b273faffe5c06948.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('73', 'image/4eb45067b6f76bd1819c5c7d3a2a60ac.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('73', 'image/c5f3f0b037ca87c7f829fe8ed9edf664.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('74', 'image/6e0cc2c56598d3305b13085ab024def2.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('74', 'image/3acf3ab43054fe210cd374b6fc609c2b.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('75', 'image/80c723eab1f0c9d15075f2ffecb1cd09.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('75', 'image/1109dbd01991c46fb7beeaaeff9adf47.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('76', 'image/aaf94ac403c9b77bf14f12b12381a9e9.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('76', 'image/15743e24544067c105dc59b644b83a0a.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('77', 'image/97f4e040f2aa2fc83c88c92cbbe9a1e6.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('77', 'image/ff3178632404d44a0b671e5a6ce7b516.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('78', 'image/58251f0eeb4bc2fa503acb9523e6b059.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('78', 'image/99fefbec4fcb6042119b3a49632ef0ce.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('79', 'image/f34ad7671bc24e47a5ce9eb8bf5a86e5.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('79', 'image/9d9631225d4dac28aeb12dead3bb7f42.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('80', 'image/bce8e643aa70e66bfd85a9d396bd5717.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('80', 'image/6b7eb99a11c3b8ea132a422494512dfe.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('81', 'image/517eeb3f4cfd919cc00861effea9c1f1.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('81', 'image/8feef6ebf673a286632a1cb0e0ebc81f.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('82', 'image/6decad4c7a92ecdf985487cdfd56ec34.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('82', 'image/7b9d79cfcb9b034a0c40e66a710f576e.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('83', 'image/f3fa9830c1dba608cff03a160ce84637.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('83', 'image/2a1b230e0ba714f96336e0b1d414a923.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('84', 'image/2e69d80b7f0be5185eab5510edbaaa50.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('84', 'image/b3f1e9ac1469e77b4ed5a238d7230698.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('85', 'image/ae58e06af254cb9380d18812f091f546.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('85', 'image/c9a4edafeba21b2b488f413e9273b4a8.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('86', 'image/56d6d3e1ea822972f61f84b651fb39b8.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('86', 'image/36c13440c93a9f744f7e4a4719a9a18e.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('87', 'image/2174e752a920eeaaef1845ce69ffeb56.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('87', 'image/79825679b8d385f95352b4b02625f258.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('88', 'image/6103bcb2c60228f1b6a6e805b3958bb5.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('88', 'image/5d207c5c910b7dac832b3fc7ac58798a.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('89', 'image/865c6fbf4c486107f7a6d15ecdc03464.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('89', 'image/0457df1e8caf72d298625cf5ce6686e8.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('90', 'image/ebfeb6d08bdd536f7d466e28666786a0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('90', 'image/14d0b6ff126fcb8a57ec5ce837d0abec.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('91', 'image/6b6020cdee1606ebdd3d156d20cfd233.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('91', 'image/2a0bdb33df7c627fbcd1467c7682db1e.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('92', 'image/e413e2480dad949b42357014c2547376.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('92', 'image/6113eaa6bbfa85b20e450e1cb90e7d52.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('93', 'image/dbb1cbd3be7ef5494bc54a843a9235d0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('93', 'image/5df1efd52583d49230acb88d3579aa21.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('93', 'image/f6199f1ae71387bbb1d3189d0e34b9ff.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('94', 'image/1a94228af3a73cd3300959c2cc0b9756.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('94', 'image/402ff4f73f908c12d1fa3d8954c46f07.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('95', 'image/5b4dd6e61a932672a2ef4b9e9d3f8961.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('95', 'image/76d8bfbdb371df96bcc6fbdcfcb6c59e.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('96', 'image/c50923bf3835d62d8b3cca6f928a3eb6.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('96', 'image/fd561537a4804699ca0eda3bc5027593.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('96', 'image/1dd54fd12b004c59466396e3306a765e.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('96', 'image/f6fe4bf266a1916a05d72f015a5fe013.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('97', 'image/27ab8323e50fb5cdeeb751b600504600.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('97', 'image/edff11dc196f47274f46c575e6444a81.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('98', 'image/e54e2e338cf3bab441298a85739c307d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('98', 'image/ebf4a2a9e57c802143f3b5b047bc0256.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('99', 'image/a893b4b6b0ef683eae7356b765bbd597.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('99', 'image/609d77a4d2710a71a57ec8f7dcb5601a.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('100', 'image/c7572de422ef07db3e7eaba60e2a6da5.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('100', 'image/d30f1cff81bf93d053a2c008c4487e4b.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('101', 'image/e13a2b369303c50fd220de3f1a340c47.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('101', 'image/5b230032796b055b7a7307d5b8b503f7.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('102', 'image/39a492d036b04e263b39c0144a4155d4.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('102', 'image/c82bba86ff24fe3fc60d100c53d9d12f.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('103', 'image/7eb874bf2056cb1ed487eb4b3a7cda0d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('103', 'image/1b65344f51e4270995d1d9d5815d1f2a.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('104', 'image/250914231506a370cbba3785455fef3f.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('104', 'image/ced753758206eaed3031b1ce66cf469c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('105', 'image/46b26f071d5e884e1388cc56a5f7b492.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('105', 'image/355bbf76aa45d7c1e7e048fbc50084e2.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('106', 'image/ea7d9171af7f38b540860acdffa6370e.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('106', 'image/29dc9ab4c791c3f559f74871035cfa25.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('107', 'image/87c0897ce8d5697acfa6e8a8066a7344.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('107', 'image/7728c7122f8834c7d694e5508a844d63.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('108', 'image/30d49dc1e773da76d73300808c82fca3.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('108', 'image/dbfafdd56b1ca3ff8ed923327403d9ec.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('109', 'image/1d5f233aef060b92348d3020fe521322.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('109', 'image/cb1add100f3a060ff3ee361c96b61be8.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('109', 'image/48e4877520de82a60b89def7621750cd.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('110', 'image/8579da4bc24cf600ccd99f415cf17413.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('110', 'image/6c10fc371bf58a71fae7ded1487629a0.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('111', 'image/00e628352cb6bf79778dc7ad8f26579a.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('111', 'image/e9f75eea539a465f18a9d439a81c413b.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('111', 'image/4319cc23c13edccf08e2843c61ece716.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('111', 'image/808a0db0d7fadc6742b9b05370774988.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('112', 'image/1f3b247cee8df5bcab7c12427abfae26.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('112', 'image/464b2075599602075fab1e49ccf17424.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('113', 'image/657f81cf0910d76dd543336670450233.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('113', 'image/e825822407e6a0e8e41861968e22d94c.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('113', 'image/d0f14ddf8356d678424a386546e41cca.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('114', 'image/2e727b60ea7fc5aaf98e9cfd182196ca.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('114', 'image/49a493485af82bff6ad477b96761942d.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('115', 'image/99b57afd998da93bcb5d93391b899bc9.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('115', 'image/6d66b43c0c1381f44e8fb2ea8bf9f564.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('116', 'image/50b65cc9025410b2c5f6a0c54ec808de.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('116', 'image/cc59611c5ca8c0eac720675b395dd06d.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('117', 'image/fa765a504bcdb9e81e8affad54eb874d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('117', 'image/e2af6bd4daf63a2913a0132ba2416b98.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('117', 'image/66dcda415f70febb9ff69949b44ff87f.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('117', 'image/263fef06ab1ecf3a7685f8f0bfeb6949.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('118', 'image/a88520e70de1c480057d9a1e56d3028d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('118', 'image/682cfc1e5c9602ed9514fb596ae2675a.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('119', 'image/32f72415c68c0bff9005819e2ffafdb6.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('119', 'image/6fe26d14eb10a77abcc9e7d01fa2b7e5.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('119', 'image/eac4300a54eaa6a6a24cdd6f676c62a8.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('120', 'image/2d6b98b22b2a47941b759a0dae81dc3c.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('120', 'image/ee806411d4209a1882446a9c3ba39ecf.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('121', 'image/45297d793ca85f7ac22bdfd4c783f5ed.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('121', 'image/620f67949c79f2cc059cb3f24c6d4aaf.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('122', 'image/9bfa61b36cb4e1f5fee3bc9c2ef71be0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('122', 'image/ddc5e1dcc674abe2f104025d6adedf60.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('122', 'image/1a12de914c4e912a52f112d1ec6ae7ed.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('123', 'image/c01b634f1d9faa1fb3464363e524eb5f.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('123', 'image/f6588f7b66199d6a36405e225a2bc6a7.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('123', 'image/ba0dbaaf7d74afc3397d4fbe2d29b2a3.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('123', 'image/8fe4aa19411c17dc31ce0ec4478b70f5.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('124', 'image/937a97474fdf176e0aab0ea346bf4f84.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('124', 'image/caf9ee81b157703e6869643b95174063.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('124', 'image/0e2f2de64260f840c620cd4187af213f.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('125', 'image/fd1eeec97f40eb20064fdc1fe751fa9d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('125', 'image/b7ef940c7c01837ff092b1d18003d8d4.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('126', 'image/a819112ab98cc054be699432ec3ba197.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('126', 'image/55c862d0125319b9a6816051209c7772.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('127', 'image/0fee23c58d59e594290c2ddbaf7927d8.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('127', 'image/2f981ffb2eeaa7bbadb12c3ea661fdfd.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('128', 'image/bf4bc57c806135d36b729de502a9cf08.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('128', 'image/d0c26f6ed55391d5ca3720d7c9c8471c.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('129', 'image/e82a24240ca2d5a05a6d4748378686a1.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('129', 'image/50a04c989c91db8acad6669659044c15.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('130', 'image/5e95797ad820e52151e9bc2d1db2d1b0.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('130', 'image/3fd19a7d05c15217ebafae537673b5cf.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('131', 'image/b5976171080af1ea538d2e1ac135ff64.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('131', 'image/44deaef1f5e9572122223dfa4cc0b94c.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('131', 'image/0dad85de9093995f0486fe5be036b733.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('131', 'image/304ae95d7f2808b2c15997bfbf56b342.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('132', 'image/8b54a5f7a044947024e4891b8a990dd5.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('132', 'image/d6add12741eb34e2c0e49616e76e36f0.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('133', 'image/0f033af614e33d6934c66fd2a073d957.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('133', 'image/9a58b30d441e90b89be6d7337f55f96f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('134', 'image/a07457cf1676cd1cb576800142ed790f.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('134', 'image/443840cc5bea6baec45c93afce0a6fbf.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('134', 'image/0a8f91f4f14a85c30039a685c88183c9.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('135', 'image/ba9b03fbd1537c962727f269a9016926.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('135', 'image/8364d532a7b064882858fd8f1a91999b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('136', 'image/9d2a72ddd398cd4562acf8bed3df8450.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('136', 'image/8d84f04f860c017b0011620a84fb380a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('137', 'image/da5bab4f320611be388993f1c21325f6.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('137', 'image/1c2acec35fe51eff21d2ba4f958b79f1.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('138', 'image/d63ac533d95c98c13f76b3bf28b547bd.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('138', 'image/b2809c307a9a23fa8c5ca8fb059c21c7.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('138', 'image/cf34f31414fa5174cdec6e1785f3aa68.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('139', 'image/4166915a9a54e8524e7660adf909a317.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('139', 'image/f1a383e5914589211a218a1d5c63f0cb.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('140', 'image/d220181c5b03cb55226ac06fcc134a00.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('140', 'image/1b909424d9a52905c369d425d107a164.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('141', 'image/d189823e65976aa7da58ca1e62f03ed8.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('141', 'image/4425eb40a2a4704442331d81232f8561.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('142', 'image/e5d3b78d17d4b97ea3ce0e0b726ca198.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('142', 'image/108b4f917eebb5c413e0b2742e9a5dd3.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('143', 'image/489a76dacde01d4627429b7b36267a99.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('143', 'image/8e04a7fbcd8f671a334611ec31d27303.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('144', 'image/81614c2559a5138f708c1e3936771f14.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('144', 'image/bf5c6bdfd914d83245820001d57e245c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('145', 'image/33758ec92d7be4c7f44f81a07a8fbc6f.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('145', 'image/420a90782a99280ae83bb3279519daa6.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('146', 'image/e9531666e58428a5b66dbdb11e5591d0.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('146', 'image/b5ac40373f21dcbcfda5059ca5e47d7f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('147', 'image/b4e01e5d43cdb1369738a23a3a0d6575.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('147', 'image/67c29a84bf14d63fb7a8038ad7616d6f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('148', 'image/523172aefb2501eecae155d718ec1c26.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('148', 'image/32a399ffa67507f82ce0603652480573.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('149', 'image/73d926fae3f5fd3e61f36b4022906ea0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('149', 'image/03efebd64c3b3e6cd6d7a604ef1884f8.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('150', 'image/6c5b0d60d04de993482ad80afe6ea0fc.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('150', 'image/68fb6daad1db4b7edef5e37351325195.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('151', 'image/17753ed0845edbc013ac157b9888ac37.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('151', 'image/bdee11cde398811bc325f461b7969382.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('152', 'image/d80f758957e9e8d4c76c824cc3c53cd3.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('152', 'image/c28e9446a254454867783c10b9855b47.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('153', 'image/b9a4da7f3158a302e7c298e3d488ec7e.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('153', 'image/7f7678ed8ca0c77fab49a09e8d1ab89d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('154', 'image/0f58c4389422b24adb7efdd32c35ece2.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('154', 'image/730e19954c21071017637b9d17cc2887.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('155', 'image/e07f56bbd896bf35715ceb1b54e8c198.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('155', 'image/b315f7067c9962c1e8abce54a0289c91.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('156', 'image/f9563094104b45f549da521e4202bd8c.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('156', 'image/a79cc795d8a5fb34dd7086859c920cc2.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('157', 'image/37acadc4417eb9c3c14f6c7cd10cf1cf.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('157', 'image/bdf9b5ef0e2a26e90902c62e8df142d0.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('158', 'image/e5df6a0871eccd8c059884357bc1c1de.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('158', 'image/51ee97e95fae98bf15091722a20aaea6.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('159', 'image/a979af5a7021aedb16807a91521c1b00.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('159', 'image/1f381f6d21514cf263ac98f7427c2653.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('160', 'image/b256057aae90eba16e6214bf1ecc420d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('160', 'image/83b70267a0a62779a319e43df99b1587.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('160', 'image/07ceb6fa32d07de6df023135a17da59c.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('160', 'image/fb5fef5ebff7e2ed63c0beac798a8327.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('161', 'image/6851e8e69d7288a129e6b6e0ac0b8aa7.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('161', 'image/dbeb8adb8013a4177ccdeaaabc26c7bf.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('162', 'image/1ac460d8377a0b6ff9fb886fb885d791.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('162', 'image/1fbce734897cee823930d5fe37b9333f.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('162', 'image/5b54eaf223a0034325f1ed34b03ff1fc.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('163', 'image/34179ff2dfb346bce018b4c30c0b42d2.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('163', 'image/5a4aa47c98e650530d3c5040af6a7b59.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('164', 'image/1f9923ee8485e71349412a559e7942a7.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('164', 'image/56f9e1e2a97fef699bee4c2e4b005ea6.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('164', 'image/dda815b5b636f7dbb12c670f1dc440f5.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('164', 'image/6ad1f7011fe08ee881b1875ba93cd4cc.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('165', 'image/98e036459e3eaa299b51cbd491131852.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('165', 'image/6ffacff684d5bda76d922a53c2daa9d4.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('166', 'image/bad67becc497157e3216cd184453c0a6.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('166', 'image/22447d56283fcf9731be44150b777717.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('166', 'image/69362c19d9771dc0bd0dabff33c68b4c.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('167', 'image/bf04dea651cd4824ee6ee87eb095855d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('167', 'image/340b95516b03a3bc9d8d0a583dace44b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('167', 'image/76ac07128e72af376db65a4b608db622.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('168', 'image/c78f96703b9675c08179a534137ce3d6.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('168', 'image/9e6fa192b66f08c4a46c7f2f435eec63.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('169', 'image/a05cf30d0c26754bd798eacfa5aa9378.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('169', 'image/f71dd8b8865a869b50fc34b85a40184c.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('170', 'image/540488a9071fa4a75ac121db25b91fc9.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('170', 'image/abf9f16d6ba8e3549719cc55ea6d68b0.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('171', 'image/2e13769a15c1be6feb1753cf599230c7.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('171', 'image/8466f4164497b2be0b54cf207321563b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('172', 'image/7600000f415fbfab56592f7c8d1ef6eb.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('172', 'image/9ed53db29e9bec5d536225647a7ce990.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('173', 'image/c1e503e48bd2b8c40fddb6e098d8fba4.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('173', 'image/8c561b86925804150a211c3790f2723a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('174', 'image/8b4bdd0fcc1ecf2352423e500b1d76c7.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('174', 'image/98c92f9ac0e1a66a9803e3a88fc51f86.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('175', 'image/d33f34b2c6dd91a0a170964a6bc5e26c.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('175', 'image/b2b965a9510297802a9e621e32d76005.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('176', 'image/bced793296ca71e3acb0e1bd58ac6bdf.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('176', 'image/8e19ff794ac8003b315ad10f35b9e8c0.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('176', 'image/e6067a12c2f381714f46cb0713bdfb45.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('177', 'image/c16fdbe3e98348803b2da968182506d3.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('177', 'image/e5ffdb7ed9320ab4760c05232844e276.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('178', 'image/7bce45b549608b7e4c1ca33e56520443.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('178', 'image/b929b4377db1d86360b6bc2591aa3734.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('179', 'image/9e6adadc6c40ed75644c9d2f362ac8d5.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('179', 'image/6c77b0e77c681fa0f99e409d36c4087d.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('180', 'image/a0058837b3926ec9ce704070301a3f8d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('180', 'image/00ee349710b88fe10c79242c3a9d66ea.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('181', 'image/12e24d9264ff7a4b35e7a461f0e40d57.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('181', 'image/71d83c8c490a07766d8157e8bfe58fb1.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('182', 'image/98712858ef01c74333a7aff1f823bacd.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('182', 'image/5167e9f274c333efd557fbe9561b014b.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('182', 'image/552f844db2e53a939854be24b8264891.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('183', 'image/88de19853f7e5a5885199eff04f4f132.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('183', 'image/96b341cb50fe624388ad0531b9f504fb.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('184', 'image/22df50eab6b910efbc6e101c15cc089d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('184', 'image/484324602c3532cee70ea616824c0b4f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('185', 'image/0ed3899e4b9a8277eb46f30aff1443b3.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('185', 'image/9823003aefeab2de90cadb597f9f3c86.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('186', 'image/90f152947c573904aab14a51be301145.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('186', 'image/8b3261e0bd05c3260fad577af6258852.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('187', 'image/f2b9259f7069b63c6fea57c19d474c2b.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('187', 'image/f60f3abb9c9f7b4bdf1b8095b51bc459.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('188', 'image/dcf98d054ba1c7fffba4167bb7446b30.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('188', 'image/061f2b1978dcb63f43b4696cd751c96f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('189', 'image/8eb0ae243b69e1755b6c4735ac52a329.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('189', 'image/5fa2ef613229d9e0f8b58b4607f6eb23.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('190', 'image/308980ffe33abb7663310e361adfb4d9.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('190', 'image/b47a20c043d7671e105c2ece26c06ebd.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('191', 'image/16956dbd5a1c9155a28f1e33edbb4eeb.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('191', 'image/4c5a6bd99a6e92e5ecc97459c5cbbeb6.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('192', 'image/471fd6aaaae6720e7e7aa36dead2403e.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('192', 'image/1ea419d879e5e1b50d41f5f6633eac8c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('193', 'image/e1fec232bc6d94c64e49ad5a683d20fb.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('193', 'image/2f1693064bb5e804cf70101bbe88782a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('194', 'image/f2e83e992e4a447d3939552af8f1d8d8.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('194', 'image/0f040dab58306173751d20181a11b3f1.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('195', 'image/2cc64e2b58493f48272147da0fa839ec.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('195', 'image/bf378da28bf0123ddb8b9978f39a56ce.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('195', 'image/afbc0035c09dac44e045b163f03d8101.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('196', 'image/cb118e630db7de83497ceb06519b61bb.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('196', 'image/406fb58fca67a3f1071631bfca9d059b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('197', 'image/8db93d0f59ff8a0ca1bf6c29ab09e6b3.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('197', 'image/89f06945353ee9b85e442dc385a9161c.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('198', 'image/dc59054ce237a2340c2ae627e18ae374.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('198', 'image/97cfdc65710d60208bdd86d11721dd15.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('199', 'image/cf7221f9f21b7e14a7444a18d42c5256.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('199', 'image/2342826625cad19c7d3bd71e01e2dabd.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('200', 'image/b42f0fd73638fca7993c76d83f13c37d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('200', 'image/22804a5d867f4c7b3895e41b7f114fa9.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('201', 'image/eddbcbbc5679c867cd0491c103817d7c.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('201', 'image/be6c4c3e87fb1c6e2e63926a66502ec7.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('202', 'image/cc505944c7de02a24d452b97b15daeb3.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('202', 'image/9785dae02c02bad99fa05f440153e0c4.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('203', 'image/e41be579f7b67b664c92a5c2a5a0bc74.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('203', 'image/30ce055a348228888d1a56131dc61864.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('204', 'image/9e9d115793915af2d7b2aae0ba832b2b.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('204', 'image/95b41df0d4207c24e41cac996dffa5d6.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('205', 'image/da5c1674a1c21ea0014788bfa81319c9.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('205', 'image/db1fa9ddad23ff271e50191664c2f4ae.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('206', 'image/0b517c6c6bbec5ad1cd1285f4e844d28.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('206', 'image/9b271302a2cd7203aa150a62580ea30d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('207', 'image/2bf190c95d9add218a96eb453ddf976a.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('207', 'image/8d10f56042dabcb56e2717556eaed5d9.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('208', 'image/f5c8a623b45ad5a678b553315a3b38f0.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('208', 'image/daa5bdc02c89c9a4d057235883de407b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('209', 'image/669442850e241548ddb2b7a6423a46f4.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('209', 'image/2d4bb415a53682c4f18e4fca393de92c.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('209', 'image/b93ca523809267415aa19272927e70f6.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('210', 'image/a8ab29aa6a2b73eca40b8244b29da1c8.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('210', 'image/f0ee49362bb5b4b0f6f79300ca52fb3d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('211', 'image/be834b59d701e2cb70915462afdf0256.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('211', 'image/9136fc0dc294037815f8172c4b514a1d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('212', 'image/16296eaf143e50d1fec1e26611179a0d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('212', 'image/141eb0f5a2e6bf9b60653a8e5d7f845b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('212', 'image/63ccaff03564a07c4b34f85f6ed1ff4e.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('213', 'image/b7b1cd31f4ce696aecba7327da6b1d32.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('213', 'image/ed23ac8b71ae9c87052fdaa487308e1a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('214', 'image/1ce89da1a150e242b33a0d389a90cac5.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('214', 'image/a9db71eebd2db8ae8818fa29c437ad91.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('215', 'image/2bf7f9cd9779c625251c3d55ac123120.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('215', 'image/86e15098bf8f769cc992f2ee9c050f92.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('216', 'image/01722c6c247a276c037cf93e9b28cb19.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('216', 'image/924e7a42e7bdfa66a8f8eb5417936e6a.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('217', 'image/dde05d1b20d037cd8ff8be96dffd1b2b.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('217', 'image/ebab7eca4d3b5ddd05bde8a8e59a7678.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('218', 'image/a74d58cbb109827a1bbe96e352c9bb9e.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('218', 'image/136966179ce73826339444e0a31a8de9.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('219', 'image/2b6543e4602c8567828467a60c8806b9.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('219', 'image/6cbb09e52c9b0e7860422da42c7e3257.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('220', 'image/33d3fa6314851b7d628c0dcdce5e676b.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('220', 'image/b0bb2099d9979748d130f3049f328026.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('221', 'image/e12e64690a61b56a2768351496cb1495.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('221', 'image/5b825bd96af1556c665a95096336a76e.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('222', 'image/6541c6e8b347a49bbd023c4d3ff16f82.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('222', 'image/0732c60886157ca340ecfaa543709abe.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('223', 'image/d7fcf436c8bba9da7f173494ebd94031.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('223', 'image/e67934179f47b2b2facfa82ee45d4a33.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('224', 'image/8f1bec2589853fc6dfb27fa8279b4ead.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('224', 'image/383dbea189895c0674e4e0371b928462.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('225', 'image/db859cfef344f50aa0cdfcd04007ca72.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('225', 'image/11e2925778d8fbc65a1f8a499e808954.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('226', 'image/b3f637985e547af28ec3742799eb624f.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('226', 'image/137b66be9da132c63f0e721f2d981ab3.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('227', 'image/b0e96be31b24f56a8e38570e8d7e19c0.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('227', 'image/c5d087a68e5e0b939524bc8278548dd0.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('228', 'image/e646570cd49addd1edcf252b28d2dd65.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('228', 'image/d7353b32ebec1e5c7d53fc2a66080793.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('229', 'image/caae50dc2c148b3bf54d1b31f4702a54.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('229', 'image/42161b6b53001125ff9771a8c3fa1cf3.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('230', 'image/d0085815805f6633b3197a453615db0a.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('230', 'image/2f91465cc7b211fd17ea13344412810e.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('231', 'image/b8a055355fabc56ad8363afb4b7410c4.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('231', 'image/6c5bc6f6a314c3b733ff31a20d0c10ea.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('232', 'image/4be9d24d63fed00e706ad01329456c3d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('232', 'image/eff03c4da21309d6d2fab6cf325ee8e8.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('233', 'image/872ee60a11705f8228373c943dc2c5d8.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('233', 'image/224f68379684728e19df45e80cd0e112.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('234', 'image/a6742ff8fd9baf78276fad98d71b52b7.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('234', 'image/76c42b97a960c6bec21d27b2bc95066a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('235', 'image/7f935cfd2d2d3096373a94e15c2c40f8.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('235', 'image/5d6fba29c261da7c580e4f24e9f2948c.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('236', 'image/a295bab8de9e7f46f753d110d04c459f.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('236', 'image/1199eda91e3c66a3ce375815fdba0f76.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('237', 'image/d65070cf8e6faf82b1b84602a7bf92b3.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('237', 'image/12240142196cd0f4e06ebfd828f60c37.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('238', 'image/de846975219809827202c0c0a58baa2b.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('238', 'image/ee01fab1f683bc3d83c21098c64ce039.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('239', 'image/13ab4524e149c213c4261958eeb85b96.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('239', 'image/52fcb6b5ec36f1fe6b676b1e995e4aea.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('240', 'image/45a6b07af5363f9d4c60a47570d867af.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('240', 'image/54785f9b6918f222387c8ec851e256fa.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('241', 'image/edd6efef95a6b9f08015f87d4c685f64.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('241', 'image/1c0fb5e2e2f3f648afcacfda7cff46eb.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('242', 'image/e94ee044e46d4e38e8b361541cb806be.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('242', 'image/fc14b206ad26ea844cce4ea875d98ba5.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('243', 'image/cd57d77f0461c37388943fe8ac44322d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('243', 'image/eb4ed670191ec1e5408720cd345792e2.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('244', 'image/ae2bec93fc77d669617d352f6b8d3a7e.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('244', 'image/65c7241c21f51b6384817f6d9bd11409.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('244', 'image/ebf0c2bbce3b4cc7ab70c68d39f729c8.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('244', 'image/d0e13ab1d3998032f2b4103c79ed621c.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('245', 'image/9348a6a09181fbd7117dcc381c4fedaf.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('245', 'image/de5f3e879b447d950ed23c6faf9c09c7.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('245', 'image/4c5a52acab138cacad6684a91c1a6bb3.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('245', 'image/341ae9b203ea2f5b99764f6982744f79.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('246', 'image/f56639840219585297d96059c8b92265.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('246', 'image/15ad5a050bcbddf260fc70b4db8ac424.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('246', 'image/bb882e6036efca92e0e70ba0347d8d60.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('246', 'image/a82a98fbd004ad29d4d99ff0b7526c2e.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('247', 'image/c3e18f08426f02dfac3473d94ca73e4f.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('247', 'image/f839d347b17ff4f38069be23f7aa3346.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('247', 'image/1d9b175518f49acca9ec11380dd114ce.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('247', 'image/bd52795ad9445ceba4f552ff34ea364d.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('248', 'image/5fd4a62b1ed96bc8a938a59123b242bc.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('248', 'image/112c00ad152a8faac5b4fffd2382d423.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('248', 'image/c25311f0c5f9ac0f5048f0f4529656cb.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('248', 'image/c41b8a5b26a65f8b8ad72bd183d075f3.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('249', 'image/670bacc33f343b6fd7eb8b160d2e8ef7.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('249', 'image/9334da12548b6982c38a5f818eecae47.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('249', 'image/0b02a6b82303cfc1a3cb588ec5c5426f.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('249', 'image/6d12e1944a2b280103a373317d423255.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('250', 'image/81ba40b7a45a1371b70d3a0a89d98cce.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('250', 'image/6a9823d5545911fd553e52d844b4eda1.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('250', 'image/5d9c7e5ebff88b3087c21eeedd4cc65b.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('251', 'image/fb36888379aecc8d1e73ccee8ac0ef98.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('251', 'image/c660c7389d947366baec7f2dafcfd086.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('252', 'image/f3a8640e58b56ad80bf31af07952bf17.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('252', 'image/9c70d1efc5cef7aaa8947003d7190881.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('253', 'image/062144c1f0cec539a642891c35d7d066.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('253', 'image/d735b6e48f2bac42578bc5052e505909.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('254', 'image/df442d15fdfc69de15a92ccdae0308f5.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('254', 'image/2dd23af0869a359ff99467bddd17c4df.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('255', 'image/6fe3244b1e0de46214d2f5fe73cbbe48.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('255', 'image/11d496082297f01d57a4a0a271c197bc.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('256', 'image/743755e23805fcd0a54fa61510052fbe.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('256', 'image/0d650b894c7af4fcbbfc80f81d107610.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('257', 'image/b17f73cb5dd08df5b78d56850d0ff8ee.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('257', 'image/3b35db6b5a839b13ec9c3a36ce9687f3.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('257', 'image/3a314630b414e7729dafd323c994a2fb.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('258', 'image/f508ae24324272a543d1334fcd7441b9.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('258', 'image/6bab263715296bf9b403e88da6d9a601.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('258', 'image/7d89a1e2b693b5afaace693588446bd0.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('258', 'image/caf83d298cf387a05ada287a91528cc3.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('259', 'image/d19966463539e7d164c733bfbd338a66.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('259', 'image/e64d48c2f13c2f6a2491cb34d631ee53.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('259', 'image/0e01547f38ce1b355a52c1ba9d34b78c.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('260', 'image/c2866130dc63610d4461128b88b8fcd4.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('260', 'image/3511dbdafb83a3a278f310dc80ef162c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('261', 'image/ca5c73ec61054366165d4e19e87a37a8.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('261', 'image/1a1a4cc342f88d5784e9debbb0f4a8c0.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('261', 'image/8e0d6bc10ffa5d82a4ca985814cb5fbc.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('262', 'image/3d94f1b45d391c6efa0813e7bee1de6b.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('262', 'image/2aff8b92f0997def0311e69dbe0cd790.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('263', 'image/e2716f21c1b82f539b882e7cc47342c0.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('263', 'image/093ba9429a90461090fb4f3a9adb2a0f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('264', 'image/265207bbbe05159aa272d641b23df1b3.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('264', 'image/947ca080e9ad37997a3f748167f68685.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('265', 'image/0457b9b3161aa33fec2c379f6c5a86a2.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('265', 'image/a76693af23c67b4a22d7c242c4ddb09f.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('265', 'image/d653d05e43a75849b416dadc794e694c.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('266', 'image/f7d6d85c664ce6c4d4cd81a32b59644a.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('266', 'image/6241be2a25481b62757ce6595ecd59db.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('266', 'image/e5129a6966c1f32fc94afa5375657252.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('267', 'image/82214fb0a48d3779dcd422d0067ecd59.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('267', 'image/2a364c9d70edc534ec550a08e6d457fd.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('267', 'image/0f4d76b6840f68f1cd522deec0745721.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('267', 'image/6eb505574560226a90a95cb594812ea0.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('268', 'image/982e991a0577c97c9fb9517b74292d1a.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('268', 'image/e3b77e8ab0a8bea1d13d8e13ba6a179f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('269', 'image/86acb855eb4d83f3701a0e6f9b479e56.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('269', 'image/3c6f2efde8bbf90bdd96cfe6a5083c9e.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('270', 'image/fdcec8863b06a450fec15a287333ffd8.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('270', 'image/6feffe8a61d53a39d41fe21398d02b83.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('271', 'image/bb2970ea57cf3385bb8a505441a22b63.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('271', 'image/ef16d6dbde741695e989a5d0dc24b190.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('272', 'image/da8b6df96c37fa33dff85af7c77fa5d6.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('272', 'image/d49b3e92e5e6103620c5b9feddac518d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('273', 'image/f4f94b3cb6b750c50075b5052e1b4724.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('273', 'image/cc7e6662d29f706711669e228eac7568.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('274', 'image/6b1d65cef971175a6297d57cc391d1c5.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('274', 'image/23a26019b95a61317680ef6f628c0dcd.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('275', 'image/e3bc816c7dd67b1224c60380fae17a76.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('275', 'image/2e4cf68856fa308954b888cdad077238.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('276', 'image/62811b8da44759b42debccf674497311.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('276', 'image/70fc83d4fa450685b78e5d8943a374c6.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('277', 'image/68f2d31a8c74845b3862d14ce3131998.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('277', 'image/c6c52c414d6099322f7cd3525ca1d773.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('278', 'image/0d52f2e92de15257c067c566d39e5c06.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('278', 'image/67101fb2a47dd859d0350d08edfc4392.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('279', 'image/aef70a4daf45248e234fd2a212197b50.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('279', 'image/0f6f37fa09a31024fda82fe66c97063d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('280', 'image/4794f22b44ba0781f25050837dd3ac4a.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('280', 'image/dd0cd1606e6624e728b5619679c08f92.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('281', 'image/b964790eac2cba163584efd4a2c1472b.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('281', 'image/7e606c4daee7c113de71a7b93ae5cb7a.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('282', 'image/a5efa843f2290d1f35320d227182b460.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('282', 'image/526808fff7513428869343d59da3b82c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('283', 'image/9bf766612c1d51ace3bc4049fadb1712.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('283', 'image/e7b1e658b6a78689bbd86e0c0c4e22c9.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('284', 'image/65e0800ce4651e21874392960fa120d8.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('284', 'image/1240153ac4d802f5bc6ffa917727ef21.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('285', 'image/55804ff11f5e541e7270c785bda3ab30.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('285', 'image/ed1c5cb90dd3fc1ceb183266612d1821.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('286', 'image/ebb2371452af127e3db11c47ecc76316.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('286', 'image/5bd51e195a05a3330ab68d5d32febdbe.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('287', 'image/dca8964b944477bdee5c38cfbbee21df.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('287', 'image/1a06a58f87493306796b19244013ea47.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('288', 'image/31b61309341ec3618e9808db554da0e8.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('289', 'image/530b84febcf39141433c64769638afb4.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('289', 'image/708d1b1849a7d3f99cb2bfae73e620df.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('290', 'image/2f555aaaa0ccf477ddb78b48f68e1524.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('290', 'image/2eb96ef875c782fef06eb46d6de56bfa.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('291', 'image/1200b248b115692db0100a9ebe37f553.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('291', 'image/e34454711e9e56bf8ec0d217174cb593.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('292', 'image/b642394f71b7bfad1ac2687c5e952620.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('292', 'image/9342da6e0fd6192511e584f93c97c2dd.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('293', 'image/29ef2152f8a794c8c52863fdc7d3f502.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('293', 'image/e2ee6a9eb9a4f63d30600d55f73daa9d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('294', 'image/a6d4a419cebe816c9f7152bd157b8605.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('294', 'image/0476c8f3b1d3a3d7dcc83623a94ff661.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('295', 'image/128d8cffa0941570571546b838e92255.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('295', 'image/75ed3291f91981bc71c5792908de0dc9.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('296', 'image/22a5805484d9529a1310d12530dee1aa.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('296', 'image/2c962f98b55e4a1c68a3e50c53b0dbc0.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('297', 'image/429ce281db55b40940d4fb2b2b8678c1.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('297', 'image/c6adba57db79f452e8251b9f18d1879a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('298', 'image/2eab59a91d35ba16bfb97b59e8476975.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('298', 'image/1f03220652079f31913c446fb4e2161e.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('299', 'image/506dbed20bf006870f132be5110b939e.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('299', 'image/9af994e6d55a9194337497ead9988a76.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('300', 'image/7c2a5e627da1e114c0242cec14e4341d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('300', 'image/3ec0b0ba686e36b0e2ed88b72612b71b.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('301', 'image/03f5967613eacc2e381fb05edd7ccf12.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('301', 'image/0c25d3182d89973ce95931dc594f79cf.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('301', 'image/5b1fa53ae4f7bbe2ee127a03046b93b1.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('302', 'image/c51fb9f5a9b10e369921222b0bbc6f52.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('302', 'image/526f3fb172a2c6ee2ab2b2ae66a49e07.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('303', 'image/793f17735c219e0a2cb03771eb7f3e3e.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('303', 'image/2bc3695bfedae0eff62300c6d5a14f75.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('303', 'image/61bae6c3f587d2b996778415f209911c.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('304', 'image/5e759ff9a0106887f5e515c261b2eb06.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('304', 'image/33199889487231ff5d3d372eb8683943.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('305', 'image/75bd0b8f88d9ed7b8f87245792265504.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('305', 'image/cd40e62fecbdd8b7b50ad84d35c94cff.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('306', 'image/8f39c0f7060d31844f6b8ca8ff297c5d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('306', 'image/9b5011bc96fb39bd23f183c555d51019.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('307', 'image/a00e8f42d919cae0c09b100a56002cb7.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('307', 'image/e54e32323c863141467493092d74f24a.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('308', 'image/545ae638c5a1839f7c071af589aefb8c.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('308', 'image/ef47ea63be6171fc96d3429269a03767.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('308', 'image/175d5f3bef9c361572a33d59f3f5df47.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('308', 'image/768e9aa180dc37f8ef90ee6cf8e72cff.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('309', 'image/e218763b11420afe75cef3be09c168af.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('309', 'image/faf9dcbb3365498baea6b5a6ddf24146.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('310', 'image/6108dd558520f92f49c9b67e272bdffd.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('310', 'image/8b001727c0acdb792954dbebcdacc558.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('311', 'image/6161fb529cd9cee15fe2f1979bfae16c.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('311', 'image/9a9ff3a979e2591fe8836708adbc889c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('312', 'image/eb2a3b43b0963ad763e70e08d66f5783.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('312', 'image/36ebb67de0686de8f35060a1b8016bb8.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('313', 'image/5609f3ccfefbe5c62db119b0b7f0a2a1.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('313', 'image/3c58317e52771d042fef0991f766b416.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('314', 'image/35c136ce1ad34373cea9443f0da3de0e.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('314', 'image/ff5620c4090976c83004d222f4748028.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('315', 'image/bd128e859e431f9a4104407365e8d83c.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('315', 'image/ce8de5df6df9467336da619f52ec0454.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('316', 'image/1e261e06e297e3e1239f53d022ffe3f9.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('316', 'image/1afef36191b157f94c6a397a77c8f5c6.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('317', 'image/596fe8063aa9378a493833d38d05a3a6.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('317', 'image/2a4f10352a461fd005f7738b91bff164.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('318', 'image/8865f6b7370dd1207326f9522896de5e.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('318', 'image/fe341442ddbb1e0e9a4eae3b313ce5a3.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('319', 'image/91c6031aaa6d3ce4d9313447464cb54a.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('319', 'image/d165be7ff617496f5ff7d7b41aa440d6.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('320', 'image/1407ebea9fbfc553e75d91609b65273d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('320', 'image/491e898c4e63b3aaa94afb9e334f5831.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('321', 'image/a190118839c0b132c06dafcfd5a72c61.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('321', 'image/2e9914b0b0643633699ae9489482f437.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('322', 'image/78ce2e295822080239d736f8af3d1a4d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('322', 'image/8c49d8c6539c47fe2475f74ebc4a8e39.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('323', 'image/e44958b4183636ae9e67ae305a6d319a.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('323', 'image/97211295b10380b346b5f747f7a2ba24.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('324', 'image/d958db9769bded8a0ec906a076d2b342.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('324', 'image/a56529e8e375f425991dc10ab74d587a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('325', 'image/5158c8254749b6482c9a8d3aa424e22c.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('325', 'image/8babc09e644fe3c543fbb099dc288904.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('326', 'image/a03ac67a77c39985ddbea5c550624e75.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('326', 'image/a3d480f32e047ece2216c80fefe7d61c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('327', 'image/ec7815253bb41d08c81d5c971191dfa5.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('327', 'image/90b27d3b0ea884ee98ca83572b4b7756.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('328', 'image/7f6667fedf8b89369c8aeca257cb341f.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('328', 'image/3360a4daf39d7e66cfa0dd82c7f0b15b.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('329', 'image/7a1ce24846e3a9f0f5e23f33c67d6767.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('329', 'image/f5caf5376034aac13bfb0b1b99c5391d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('330', 'image/636a7a095c300c4af9b45e32e93fb867.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('330', 'image/abf3f77ffa9062bbc404c2789e235111.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('331', 'image/d0539f7a7081b15f1a7476e2bf4748b0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('331', 'image/5de431117df0c4ca32569b57fa7e9752.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('332', 'image/5776b66f16b07a7acdf3640f4db6c19d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('332', 'image/f43139783ac460eb0c6e052eebaf7123.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('333', 'image/2b9d9128f5f6e0d3b4a63e6e8debb579.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('333', 'image/aaf617ecd0ca0a6756b7b9a164bbb5d2.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('334', 'image/7bde19125a5bffd0aa349dcce36ec136.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('334', 'image/b8eb62ab5b33ce4757ad00d5b429e059.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('335', 'image/de7e4cb5e44e5cd073a098b090778185.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('335', 'image/e355649b60917479b5fdf723b0764d7e.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('336', 'image/edc50153b72932f6e99f9d49045328c5.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('336', 'image/ee735cb77e44489f034effaa56c4e5fa.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('337', 'image/0b0d9386774a71f3a1133e6020d0d6c8.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('337', 'image/36ae2a671339d639c08f0df2d066ceac.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('338', 'image/15e4050c7f78af47dad794343cb1e500.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('338', 'image/4b3ed74805160ce05c18d6a4cc58cc3c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('339', 'image/dc138d00f051e0e7c3e4f133784afe01.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('339', 'image/ceac36c71af8bebd4143e3a887b596ff.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('340', 'image/d9dfd118d03dd5e74bf60bd95bd7be08.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('340', 'image/26f0b93ddce9de06ae9996762c0c0329.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('341', 'image/28fb30c2dac022eedf8a419cc78c35b8.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('341', 'image/2c56ad5b6c18ffa28192e176ad9903b8.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('342', 'image/3fa954200baf17166fde24f353425bf2.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('342', 'image/becdbaced9acad9fd3b629490e61df96.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('343', 'image/26e96e715f78efe668c34e861bc1e7d5.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('343', 'image/8c688f11387c99ddd1e13335103e9e93.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('344', 'image/305cb8ff184018050115bf973195dc87.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('344', 'image/843ac0c7c22c268a8ef10849ce6678f9.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('345', 'image/f206a698ccda7d69c964c321a4fc3b58.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('345', 'image/f787677e44ab8fb000dfd07199189c89.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('346', 'image/603f87bc0e15b56e95fabf8f2f8f0153.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('346', 'image/ec3ec5b0d4353de4925e338da7903537.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('347', 'image/af883ec2bee00fee119f57e6d711c90d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('347', 'image/01d92f6a3acad9a9d0c2082cbc21a4e3.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('348', 'image/7fd54f83a0ff2e37d0aa247073af6fe8.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('348', 'image/c214ce77c125068cf546d389ff0287c9.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('349', 'image/16897eb09017d4015200d248e3fae2e5.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('349', 'image/d25b7507cd118dc548d9128b7e9acfcd.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('350', 'image/8d2a69da11a49eaced753df6e58b24de.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('350', 'image/453454566dbe15af99107b7f25f963d5.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('351', 'image/6a0ae7e97c9d15c41c6506a36423ef61.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('351', 'image/d43de7493b5c82dd3d3f4cf40eb26dff.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('352', 'image/01a6f277ba9df7dfcd14a1d8f5c6d17b.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('352', 'image/750c024db109a3882de18ce5fa7549a2.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('353', 'image/0b023a8b024f4bcbd038ac67ae68408d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('353', 'image/1025cd676f633e38ecee7ed97a9327cb.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('354', 'image/eb86791d1dd1c988e5b744d1b07de095.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('354', 'image/528fa95c2505b96a369e3d2778b3856d.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('355', 'image/18b483851ea13b67d4d045d0d43332c5.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('355', 'image/77c52efe6234aad26579376505ed3dd0.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('356', 'image/0b002534da1ceea8c73e9e723034fa52.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('356', 'image/94c8aaada4fe4a68312e332ed3b07369.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('357', 'image/acc0da5142030a6fd5cb71d35a4972da.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('357', 'image/f520086ed3cc35b8113831d8f5ddb3ae.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('358', 'image/5bc097a6c96455041ea004ad93935545.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('358', 'image/11325e65a13d3ecbf2c77bfb0391c48d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('359', 'image/08ebb14a1a044504c86e222e20047d29.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('359', 'image/9b9f25e8760a9d9955a3e1582f6e3def.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('360', 'image/3e669cb69a3cb8ad1659691b2159229f.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('360', 'image/5359ab430537b26a9abc36510107935a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('361', 'image/d26fb35b1db66de08bea980bb53c7218.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('361', 'image/f6e92f25d7d718f56f31ad832d451989.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('362', 'image/75c6989f63ddb65b06a6b5f283f33da3.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('362', 'image/bdc69449d591f635364fba37fee7f4fb.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('363', 'image/7abebb43488258fc49df8664b696e041.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('363', 'image/3390d101fbb0e14497603d072a678c0e.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('364', 'image/a8ae42a4cd9386bb8ad934e368640f32.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('364', 'image/220d8b99ba6cf4c22098807b9341550d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('365', 'image/a651a03f44da1d1daa1f74387b3fafe0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('365', 'image/65e1be17d677cb109cdaf26069c406a9.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('366', 'image/a09ca745bb7bbb87d97766b0e2de035e.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('366', 'image/034fa7c9c510ef6d408da062cf04c184.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('367', 'image/7df5fc4bd0cf9bdb5cd259d4ea5fbbf0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('367', 'image/0a1cd54e0eb5432d5155ce162a6d7aca.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('368', 'image/fc624ae8f587055cbfe363aebfb7012f.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('368', 'image/bb7c782b9e63df61cf867c2d8ed92d0b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('369', 'image/23114b34af505867dee57138648addc6.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('369', 'image/ed348ee687b1149ec7c94cddb65ea4c4.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('370', 'image/7d6c6eaeb01d9137c222f87fc212dee0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('370', 'image/be286d0106a076f3a4a6bb8eacd41f6f.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('371', 'image/fb2cbc4d8eacfe37dba04e7b1211fd54.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('371', 'image/83fc02555c6140794de9c30459077a23.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('372', 'image/4226aff1242674e517947d1792de825a.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('372', 'image/44c37cc60c1507dfd45cd502861babc6.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('373', 'image/5908688d5711c30f2a0070d86741ec78.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('373', 'image/391aae5ae31200e6a714c1ec8980fbe0.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('374', 'image/eb2f8f5d8ce30c6f0e906ba9ace233b9.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('374', 'image/26d591c3c17a112591226d27a6bfd707.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('375', 'image/0fdd318da3d34a2967e005307fcd6aef.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('375', 'image/161e49d4bea8703ac4069f6850e773a6.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('376', 'image/4aa38dc94b1999acb11ccd93175aa353.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('376', 'image/6d06abac0b82fc4057992c216e36724f.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('377', 'image/87041cc214b2598576cf89a4b46a293c.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('377', 'image/022020f0658cfd387a89ab5bfd1c0fa9.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('378', 'image/2f23ade3177f577d6d6d69982486369a.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('378', 'image/8b94f76ddd339bfa371d126bd3690b14.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('379', 'image/7238927e8490b7f2cdfc562d352b2b0f.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('379', 'image/13134ad078fde632718f4bfdb1071182.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('380', 'image/171d79efa48f709db6f04473d8d5e9a1.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('380', 'image/7c9a59a065775145fd01ccaffb32a8a5.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('381', 'image/bbe6b0b14928c966d8f0e0c62d8441ec.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('381', 'image/2912009e4741d8a4270c29697f27ebc1.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('382', 'image/a1878173c80c04d813dad3044e87255e.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('382', 'image/19c076c6115ebcebb7507066a9eefc05.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('383', 'image/594520f2bd786b95fa9626597c69e239.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('383', 'image/07f4549c9c87ba4facf32cbc4fca5057.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('384', 'image/8878717741e93eaaaf9ee68072f7f80b.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('384', 'image/7f6e63285f2f34d3f5701c1a07f4a756.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('384', 'image/7e24d3cedbcd60aa6918ad1212ec0c0b.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('385', 'image/1006f7cb7995c6e0617f6edf3170ee51.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('385', 'image/0f46c86e668b1c3e1f9fa29e01f22bb6.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('386', 'image/bb0290c00043244394b70fe920449f17.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('386', 'image/d715fa265b43241baf76a07b7bbc7d4f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('387', 'image/ab3fa842267fc936437c22610def7229.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('387', 'image/3c908116e5ca50cc7170d869cd3f9cb6.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('388', 'image/6afdab21e67628436d30bd346574dad2.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('388', 'image/2ec7a19fa0b9a4ab3b027f3901242ed1.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('389', 'image/c21093502323d514d6960f2bba640104.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('389', 'image/02215d80bb5f80273b69ef295accc34a.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('390', 'image/abbca5ca132fe1ed57868967b31540da.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('390', 'image/44265b05cb1c0831b70a4f31df120051.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('391', 'image/ff73274b78dd764e1c9d280d6a21fb00.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('391', 'image/e190e8de1744677ad176d11cc1feedea.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('392', 'image/f32422ba3eff9a83bfe19e73e9d11ce5.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('392', 'image/67308ad05358a60a2f850f5db77f8f67.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('393', 'image/5f1f080f8aec278f817df7d1f99fea93.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('393', 'image/1bd970be3ba414fdf8f393b3c41b404c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('394', 'image/cf2657954222c47720d7909dc204baa2.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('394', 'image/9cb8d4c8cf3ed1a9909decee6e8e99fe.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('395', 'image/400ab63524c4c77906fc57dd6a1d359a.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('395', 'image/097457cc9ebd2ec7b326e253dc45d880.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('396', 'image/f71c35a0bbc0edf62f33d3850565909e.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('396', 'image/0d646971f944da23d33571e2718a20ba.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('397', 'image/95ecb9ed057aef9b3b6c8f1b1d2f7b53.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('397', 'image/01ae9f87adabbc10e51e593d3653c829.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('398', 'image/84676d5e9b05e064f88f6e962e84e8ce.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('398', 'image/94b4dcb5797ff7767d65c1622619278f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('399', 'image/417ed09903295704e3b7575d7da89ef4.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('399', 'image/491d3a06a26da680c02eb643b229a480.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('400', 'image/f80558fe5f4e1a60440d8b6774d0edac.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('400', 'image/07e1ea1b05ee73d678ae58a9b5f08368.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('401', 'image/5b0f86c90d68eaa8e934c6a59ec33be1.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('401', 'image/c7f1c010434e06181336a00156c4822d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('402', 'image/0bb68e90cc09b695ce5b40be5af377a4.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('402', 'image/5ec028206c6b78e73cc1e4879b428003.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('403', 'image/6dae5ef924aaa5b99572f00c97d423dd.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('403', 'image/b479c50bca8609b82d11e05b4bc4979d.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('404', 'image/0b3b93b9c1a8fb8b34fc19fcd3576071.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('404', 'image/fd9675ada99c0b40b4daf4a0cb1e2c7c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('405', 'image/229c07534bb54f13810aed4f682f055f.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('405', 'image/e5cf08da27f752a1d3b95f74d798f400.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('406', 'image/6d95dd203f5d3801f044fd32fecd07fb.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('406', 'image/a47c658b2c6572369c7114f85d2c4059.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('407', 'image/7d604ced65d6f418d37fab7772f207d6.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('407', 'image/bb16030a7d46fe342c884d1c9aea12c4.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('408', 'image/bdf74a64ec33614a7c66d3585e6a4f7e.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('408', 'image/0956a0af9b79713e16e1f516c8715349.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('409', 'image/79b8c0d06ed4bedb895b688e76a89d04.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('409', 'image/beb1a7c82bea8d6fccea16d579ea775c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('410', 'image/416c0f2a62ca18e55700693f64b7a98b.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('410', 'image/ba0958d47afdbc9bbfb324f99d3f1702.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('411', 'image/574b5a7de66bdd79a0abc9549652efbf.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('411', 'image/0748b333e2942bb32d77e7e903b70f4a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('412', 'image/47cc218e0ab861539b793d86a497a10d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('412', 'image/49f4bbb95d5eeaffdf21b0c631fcdc55.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('413', 'image/bfe573599827457d8b0b9f8e4d64a9e2.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('413', 'image/f36650e7375727b9d8f576f390144945.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('414', 'image/984f39eaa3f3b096c393aea0b3a39562.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('414', 'image/a29b8197a4d2f33ddbc69cbfb01c5a19.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('415', 'image/36d35b562122ed57de795b8dfab8976b.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('415', 'image/a56a4c544e0e6b7f09e561eb17fa4015.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('416', 'image/f881526f1f59b257adac4540c7a80596.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('416', 'image/af2d4fb6b08f715657c8c8a60298d598.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('416', 'image/0c484c5bf96dda71fd7ece6835bea7af.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('416', 'image/6e7b2dc2588f0da22666adc7cba758b6.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('417', 'image/7c7515ebea2e24d725b4a773dee7913a.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('417', 'image/c0191487b991b35579ccd2dcb7f4c9d3.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('417', 'image/1265a5e76999e577d844b2ce6310076f.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('418', 'image/3b402451c54fcd17f7b32b7abdb43851.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('418', 'image/40a70b78102f2d94e61e29686efc6beb.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('418', 'image/f709ba1bd491af769b1f73e3750f90db.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('419', 'image/4fbb930e8d25d3770a46b5fad6516f44.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('419', 'image/48930d6e7fcb165de7d4bcc3a60f767c.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('419', 'image/7ad05fdad5d56aa1260ce104ba51fe68.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('419', 'image/7bf5614f9583901b8ee099f8cde3a1a4.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('420', 'image/1308333ed3c827478eb722656da88357.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('420', 'image/c2b755b632f7646b4f670ec45114a4e0.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('420', 'image/39c38b71aed3ca4c66b8b735b0613196.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('421', 'image/1e2423077246dde5adaaa2d4845e2af6.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('421', 'image/1963dbfc5db7d6c746aae624b5b80716.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('421', 'image/84ebd3796a6d3288ce8dc56ce78a3cdd.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('421', 'image/457eaef2c1c34f6d39c35256879cebaf.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('422', 'image/d68e6a563ed5ef0b9c42d5b920cb75ac.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('422', 'image/9195a2fd0a49605a825fd119dc79b441.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('422', 'image/91d181c1c2bb3b54b73ad01a80516857.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('422', 'image/7ca3ef50c7d4185402647e1540e2b08d.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('423', 'image/cc1b24b9d693a5c604ff4f4e548d6ed9.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('423', 'image/9d53628b6423c0201d00102a4a9ae076.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('423', 'image/54eca4f62a40b3cde03cc664272603f6.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('423', 'image/4dab8956c6aecffed763ee585adb5a9c.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('424', 'image/13b9cfb641621a893f8edff82bdcc050.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('424', 'image/ea5e6567cd481138401acb274aa88066.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('424', 'image/90748c2f6ab8e464d7fbb1c736151593.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('424', 'image/d524bc722ec52ff81c9735303b043881.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('425', 'image/f33151a16465873d5027f297e53d3e4d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('425', 'image/04cb45eaae5503b5665db8a9e6c8d2cf.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('425', 'image/d5bdb9158ae076320ca7c9ded49831d6.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('426', 'image/94cf5d979fef7cb85f4d29dea3815b2a.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('426', 'image/6e3ef5340ef380167fafd9f510598514.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('426', 'image/081fd37fce20e26ca96b5b04b8789fdd.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('426', 'image/caec9fe80f3b94f265307e85e72444e1.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('427', 'image/530b6c621f52e175fa6cf7968176e5d5.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('427', 'image/3b6b4326222fa8e105fca011a1071254.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('427', 'image/b0df72a342a4d33316fcb055f2f42f79.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('427', 'image/de2525db23324924b4aef2037298318b.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('428', 'image/49299906fe6c8142903134b1ef1bad0e.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('428', 'image/acc64f4da035ce9ca37c20898f4246a7.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('429', 'image/974a2083a6f8a41a13d6150a5861452d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('429', 'image/62ae506012794eeec1460874ffe644cf.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('430', 'image/79f806f4640d282914a83ea527dede13.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('430', 'image/0f0acb1138618b944819bef4c15422ca.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('431', 'image/a3783972a1ae9caf791324e25e17814a.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('431', 'image/c513abb2523fed1daa7479fe60444021.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('432', 'image/c3492d76bc113ef45b6d9e53aad7cad0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('432', 'image/7212afd9e7e3ac7b237e3c6b014fd46a.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('433', 'image/4d9b2ce086f5b40e5ff37a2903d9e58a.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('433', 'image/88871d99a8ec8f8f5ffb91825ea48d78.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('434', 'image/1d374d22e3a9eedcf62c831130aac03d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('434', 'image/5aa23de06b471408d5340f272e934cac.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('435', 'image/d4952c9f6389c48de884c6468b66f22d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('435', 'image/97dcbad38893b6b1ebb936eaa6d2d0e9.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('436', 'image/5b528d055c93df5915e5af1a0f0f5df9.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('436', 'image/901c8a86eeeea6766c93b6ec650fcbc6.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('437', 'image/4e1a5ef0015cd1cbe9b915c182faccc6.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('437', 'image/7af4dada69a5c0d2a459eb04a484624d.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('438', 'image/901a4ea9da827f7d6ea88eed10a0e7b0.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('438', 'image/f90e5cbd8ab61171e705a839d2ef5a71.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('439', 'image/e839a6b069f4abb91cb6917ff2efbab0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('439', 'image/99491d3e5c61d81bc2d03b5465bcb25f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('440', 'image/5dc7fd082bc1c8f81f5b98ab4671eadb.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('440', 'image/7bab56f0ad8def299756889fca023197.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('441', 'image/418383f6a6cc2a5290d1f87fe1440513.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('441', 'image/2d55fc5e6cd72bba470a794bf72d7843.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('442', 'image/c1d83d6889c0c60ac6762103c7660473.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('442', 'image/39b01536e9dbd7ee30fb1d17c3f9c9f9.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('443', 'image/53688a4827c62c22df40e7362b7e25cc.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('443', 'image/685cb49ea18b70b3a22fbd4f1718d11b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('444', 'image/3b6221f0405b5a6a753bfdce2968e5c0.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('444', 'image/d4c1d708e35f6ee88d9e49b4bfb574af.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('445', 'image/25fde20f23fd1a09a505d914d79fde94.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('445', 'image/28c17a57c50e57384fd1488f5c736c04.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('446', 'image/40846869903b7a9c2aca0faede26a950.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('446', 'image/bb924b1c98d4677415a5885ee653569b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('447', 'image/e2b15de29bb9cce97be287fd707b44c9.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('447', 'image/dbc961287df48a9093089d8586736893.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('448', 'image/2ca0381c3ac37a04fb231947dbcb3174.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('448', 'image/04e64ae9c2c62447b81290349ccfe5c8.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('449', 'image/45aa59a3946998778c1bcc86e0f89a1d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('449', 'image/971bd8b165d09c4686842c9d8e5f0b7d.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('450', 'image/874bc9a2475a6877380dc86896681cdd.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('450', 'image/fb9ba2308f4d5b29506f24483ffa9534.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('451', 'image/e104973b3d9cc9c154fa69bb768a92ce.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('451', 'image/b28416581f9d304be44dc2fb075ec92b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('452', 'image/5f1f90f7b1f23dea538dbf12ae87156f.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('452', 'image/29588704b3daa624b22d123a3a006ad9.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('453', 'image/6671bac8bd6c2c040bbc61c0b6ba5ec5.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('453', 'image/79a69fea4a3f36c2dfb2c0719befe3f6.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('454', 'image/0669791c0a1b98d86705b3bac2e9ff51.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('454', 'image/348736dc9f35d86dafb28e8e978c0a6e.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('455', 'image/65a88fcf20e88384435afcafdc82b444.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('455', 'image/7d2e84f95a392b0bbe9597abe30699d2.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('456', 'image/d104dc7af621d782743ac2ef98489ae8.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('456', 'image/f9d5b12b089d324a306adeed19ce46c6.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('457', 'image/4983f909993aaad50c84640df7e82a3d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('457', 'image/de4b04906f19603e3e767e792b98c999.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('458', 'image/d273c33630ee8209d2ba3e2854cb9b7d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('458', 'image/57e1266f16d495fed69677b388f2b32e.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('459', 'image/8dc68f3762d89b2eb0e21a566b4b790a.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('459', 'image/fbbe5fa1156d2120080dd57261258c29.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('460', 'image/e6790d1998f067ad4a803bdf7c3e37b6.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('460', 'image/46bd0cd51f562ef8a88b0196510965b5.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('461', 'image/e254816aebc882c09a627f75eecbb2e9.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('461', 'image/af5a9ab18b16cf64df4448be4b6201c5.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('462', 'image/692d5fbf084df6dddec20559d65affa9.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('462', 'image/841164df1c9febc63a7f1ac70c425288.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('463', 'image/846a9e9eaf0bf294f937cbdd25b16272.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('463', 'image/4910111a89664c09194d7fe79650170e.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('464', 'image/34032987cacbc431fa27d4288dd2f589.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('464', 'image/b78963a4bac882dccf1740acbad3957f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('464', 'image/e39b1f521ef314348cd54c13247cef53.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('465', 'image/56f7fbc027461bfb3122d5f17e1ab5d3.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('465', 'image/91b4173dc90ed2ebbbc72764c47cc5cf.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('466', 'image/16a5b5e89a530c28377b1d6bf497440e.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('466', 'image/d3bac0502d94b9003b3380a83589049f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('467', 'image/d19a102b7d3c41d5275b71b2702f279f.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('467', 'image/571efdb4f791fbcedb46cecc89a3e28d.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('468', 'image/e67775490fc3108d77ba5f546aa81c42.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('468', 'image/b23d179c207c4a921bd85c983ce91d24.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('469', 'image/6dcdab4a63a479d9673f1518093550fc.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('469', 'image/a98b4673bd2f26c4a3002f3114bb3797.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('470', 'image/61be43acaed9814554b748d5c08cf213.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('470', 'image/543595b118cb749212878b2450b57052.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('471', 'image/a792bed1889615bb4d615627bf761e4f.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('471', 'image/194ad53ab1175bb28332c42b3ae53097.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('472', 'image/b87284fb738ff72061b348615bd2aa79.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('472', 'image/187595cfb45840e5d447b808360c62aa.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('473', 'image/ae168942f07b7d83707be5c14727febb.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('473', 'image/052314b1de44f1f934956d3b34689281.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('474', 'image/903fdafc7d192b886359e3f8d8843e7c.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('474', 'image/95cd8f7937261a1362d9449b5eebb76a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('475', 'image/f24ecb00afe7e8833cac95da5063c2bc.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('475', 'image/cd47643aaff7e8a4cd973fe4ab9aa07a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('475', 'image/46ef50f83136b2baba349cc8068b099c.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('475', 'image/7832e6d837c0cc786886df3b5807e883.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('476', 'image/c50ba540a49bb496ee086c773443783e.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('476', 'image/4de4b4478314311136263bf14f0b9399.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('476', 'image/2a33cab6084655b98bbaa11b790f3423.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('476', 'image/b2e3a37db904690e62b3f2afa8bc0da3.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('477', 'image/36f56a422c29e98330c263ae1518bbc2.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('477', 'image/71bbdd26f6b814df6580816f05a372f4.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('478', 'image/0d41057d0c2512ef7f0487ed56d49668.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('478', 'image/2c28d0ed5f14c99df7cab20fed01853a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('479', 'image/42938e8536457fa23630a79878cecbee.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('479', 'image/73314a811f01ab9109b0fab3c147dc73.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('480', 'image/528b274c37fb3186b57d4c781be0ece4.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('480', 'image/fd50cc68f8bba798ab4ca7aed0ca78ad.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('481', 'image/ee3f7fcbd035ceefc520e0ecf15b9a0d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('481', 'image/a4d029cdf6500f3df2edf4c5cac4760b.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('482', 'image/912edd1da26f2e437612e14955c4feea.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('482', 'image/d444ef0988fd4f06dcb44e4f6b5813db.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('483', 'image/bdd0ffdadab5172e7547250bb5cf3aab.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('483', 'image/5b397bc2f9420687be99a25ceb69d509.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('484', 'image/0a3ac2c0143eca75a319929c72f2f95f.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('484', 'image/786ae616d102957c0fb10da5ca8995e1.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('485', 'image/079f1bff94ea7cb2652e622c5ec2abc9.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('485', 'image/0a9b96efb0df55825afc097879b40581.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('486', 'image/fde2fc4c686019987d83055347a70154.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('486', 'image/2d4a8c3e3d70d138017e39d5b61cc2c4.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('487', 'image/3ff4f7096bd0a835561aa455ffb8d528.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('487', 'image/590ecc856d6a2477531b9097991fc96c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('488', 'image/dfa8221c1ca15639d21245181ce6d641.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('488', 'image/b1324ec0c437c3b4bbfb268fe5bbeb50.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('489', 'image/f65b051b0ff06f4191253cb3b7c56353.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('489', 'image/87a2fde658c932440f1e546a3583c052.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('490', 'image/d15a020b6c5ff55c84d6194a05777609.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('490', 'image/548e6aace570a6585b5679a5c6a83649.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('490', 'image/023e1c87f56fc48d74226a1bb4dc16ef.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('491', 'image/6d36f1065ecb0dc53b4535e84faa7ddd.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('491', 'image/c999bb39b77713c01a9719e0f41a344b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('492', 'image/79a41a1dca44aaaea722ea65f424b3ed.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('492', 'image/f4d06da12c43130623a74ccdec3b1e37.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('493', 'image/253ab098d53d19e4f770a75763014b3b.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('493', 'image/54f1d5056f8dbaa64d8144b7be73e158.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('494', 'image/1d4e1565b4912b829dac7beee1ad7335.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('494', 'image/fedc3f778ff36c25764e9194c1924763.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('495', 'image/8ab456d53f73b98d2bfd8a8b9c9832a1.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('495', 'image/ee2d148891814c58392dd4bb3ba63b3a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('496', 'image/906bc5b014d1ce58c7ac3243a962bc61.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('496', 'image/81b324e2d0650d6e87fbd65414150e5e.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('497', 'image/e4bb0cb17c6f7fb9ba3d48dc613eac2e.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('497', 'image/0931e79dfe90a48e8ab8634f9a383c3a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('497', 'image/bba55ca25a0ee2a873968e2380a94ba9.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('498', 'image/466ed30f42b95fa6366b296d4cfc75d5.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('498', 'image/a7319bd538aa319ff0d2902bb7538a7b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('499', 'image/77013ac9122d4150d4f64437c86cd920.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('499', 'image/9f0bf170e1fc2478a5fbdffc9db01b20.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('500', 'image/f31ffe3004e7f3dfadc157a7e7597cef.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('500', 'image/e298ca3064d94781966995bb93ea95fe.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('501', 'image/aef68b98145a5fb385647457a6e6dcba.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('501', 'image/d4cca2596928258edb19cc890221412b.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('502', 'image/75b78734bf1b39e080172efa8c7ba60b.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('502', 'image/28dc0f0e35b3351b665c9dee7571fe49.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('503', 'image/a91292d89cfa87ae944a55326de30ec2.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('503', 'image/91791e9bdd5cc9c5922a3dbb96332cae.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('504', 'image/0e99c55efa8428b346914e81bdf4fea8.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('504', 'image/b275e1d974639a0add47e73583d379f1.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('504', 'image/c131400fef97ff5a29929392123f613b.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('504', 'image/537c678414628cb9b56b7b459c886770.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('505', 'image/d77e2d8469cdf91d8bb4e69b8e8d6c13.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('505', 'image/c845b73c8ef7acfd20de05856f65dce4.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('506', 'image/d85e936862a57d5d2be2fc09794c9989.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('506', 'image/47acf077a56501eb1c9af0a672fea97c.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('506', 'image/eeb6b9a0a5c96aed19e8319540f850b3.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('507', 'image/4965ca15028ff192b5cd9a32e2c44d84.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('507', 'image/93e0ece6b80539ba2aea67db63169cdc.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('507', 'image/23781bc87bb64e275e29ccc6d6ca2c50.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('508', 'image/2668c2dad6eede9a3f60ce87817c9ddc.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('508', 'image/e672b6a139f59e8368e7d93cf9941ff8.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('508', 'image/2961bcf5eb9d5ac364ba4356917aa50d.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('508', 'image/8e0974c8d77d1a258ca3cb7e9b514e1c.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('509', 'image/fd1200e1a3201ec2a73d90fca891f9b2.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('509', 'image/4b56ce9bec0116f8398df4851fd65154.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('509', 'image/71fe83a7c91a66c0c9c14fa2869e0ef7.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('509', 'image/d9ffd2d763cc0dc3efd26d8c440b72d6.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('510', 'image/f16f7a9500de4cc04c889c2a76e3c105.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('510', 'image/07d67c05bd4c87e19812b7ecb8e7abef.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('510', 'image/07a0fe2c55e9562065be9e8ffc2914bf.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('511', 'image/5305a0ec4c35c157344c8d87438803a0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('511', 'image/e2023db172a0842ff1d2c6ccf91b58cd.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('511', 'image/522a6d43e00edcb44e6b57eee65f793c.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('511', 'image/aef4c5f4b0d6b3f380c465e8182c0910.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('512', 'image/729acadc11c6dac554c19c513cfc9593.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('512', 'image/a6566a1095f53a931901b3515bef6707.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('513', 'image/11debec803e928ae17411eea9b74e222.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('513', 'image/581d3e4ab2617967aa496b1b949e4009.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('513', 'image/1cf66b60f714175004ecb890c9a4055a.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('514', 'image/22ec23141f50980a61b93b4414d93f41.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('514', 'image/14ef4d1c3addb28a6277cdfb101aa9cd.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('515', 'image/41da557a4b3cb58850b4caf4a5bce68c.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('515', 'image/f20880ac478fc12887f9e332942d5cb4.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('516', 'image/739242be8ae8132fcde520c96c92bb8d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('516', 'image/ea5e19556855f456234dfd40eaf666bb.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('517', 'image/db86d985205f30711801afa362c85452.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('517', 'image/cb2a33a52b6c8a9006d757fb77dead81.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('518', 'image/b2dd86d7b882ebefaf12fc23bf8cdb2f.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('518', 'image/936a5643582109e676267d8774c37872.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('519', 'image/269f7f8eba5db2d61f05803100b88c93.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('519', 'image/cf061ad1d01714b39a708c4745df2887.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('520', 'image/714c27502eb2858dc6c99e95e984a820.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('520', 'image/ff1e0bf8f710bb4b65162efb05945f32.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('521', 'image/9ed11563069d434bfd2ededd317d5da4.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('521', 'image/ca5797ff4eaabbb2d8ae0742760ae5d8.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('522', 'image/45fe9bee96b628d0e764902020fdadbf.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('522', 'image/702adcec0cb6b7eabb701facfa15fb9d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('523', 'image/192e4034a9521b463aed022fe578b475.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('523', 'image/58e3c8bb25da1b182215094ca185e73c.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('524', 'image/2e1a77357edf2b45fbe4f73dcd941466.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('524', 'image/42fe4a0ba0de233241a173b6b1c49491.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('525', 'image/9325bcf2ca80797f538c31200d8eacc4.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('525', 'image/e15ed8a02fb8a1e4472fe7acd7fb360e.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('526', 'image/5ca4a8d3e3f2b5683d8c6c8bb8428623.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('526', 'image/cb1a6a48ae6a7a582ebe59034ff545d4.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('527', 'image/4cc0a6ce7a4d861405a4be6a74a597ec.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('527', 'image/d8f9be09d8ea9e75ca30fba0c99fa48c.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('528', 'image/4142f7c6dc1dc4572e9b35cb7c5cc7d5.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('528', 'image/69de82bc8b1edee564248ed85fb0d0bb.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('529', 'image/45521809c180ce6e7c5a63af43b0bf00.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('529', 'image/5cc6d1999582c71476db00c2e096b693.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('529', 'image/cb777eac005f676865f04ef7c1cf36d6.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('529', 'image/d9f1ca1a07efd5598756bad859d59e9d.jpg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('530', 'image/4d8b41e21928972035d41a34f8bc39a9.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('530', 'image/c005f24ec104ce3cf9fdddfa16d47f47.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('531', 'image/2984d7c2e8f1bb908512fe045f0f7fd3.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('531', 'image/bc8cc90fc4a96b51c385e8d7bc596dab.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('532', 'image/7fb3e6a28b2a28fdf133c90f75550a0e.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('532', 'image/1af859c99e6925df1fa8cf183390f702.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('533', 'image/449424e0756994fdd63ecb120f30b04f.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('533', 'image/c80b8105a3a20f5c3be61a4aaa2a558e.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('534', 'image/5f47bf1460dfacc27b4c71325934da22.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('534', 'image/60bdf8484c2b15ad76192bf9eba578dc.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('535', 'image/85cf700c6d5d1aa7e0ffbb12561b6a3f.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('535', 'image/5243d7231dc5278a4de8dffc50df6ec6.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('536', 'image/885fbe77c4eafb17f2d8174c41d4e06c.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('536', 'image/e2dc58cb4833f0dc28b3f31a11052c15.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('537', 'image/d8998d6ee210054484d15ac782ec8029.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('537', 'image/e9cf79db7f0b18ce631caa90db0dd3d7.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('538', 'image/62769e81f0ed6d469e4f05bf0626c262.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('538', 'image/4443996349a2bb17da0bba4051156d0d.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('539', 'image/71e30110e61c9b1d0a0254557c655437.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('539', 'image/bc30510a4a38b7a3a88290d3dca94af8.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('540', 'image/1e8684b5255345e03c838a66cc0a0c41.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('540', 'image/a4d0ac9f6bd1853266dad70acd0d716f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('541', 'image/2b8ef65a50fb51e06e8757f84a2c43e0.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('541', 'image/3b98b6a9f653e4a9b14fab6aafca38d9.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('542', 'image/8daa18195779d52d73d8974e85561a59.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('542', 'image/bb996cca4b90c803a54a5d78ce47dea3.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('543', 'image/9159d9389e6e4c04ef3af406203fd51f.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('543', 'image/494d78f868721ba45dd3c75e1d6deb3d.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('544', 'image/483a610e489100abc97dafb307c7500d.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('544', 'image/95748aacf7fd93765f2f2c3c20be576c.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('545', 'image/f7e44af1eb7bc2dab15761c40a818083.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('545', 'image/94ccc626202f2ca5a3b2fdcf5ca85fac.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('546', 'image/ff0ff58fa5f019db68b41d0ad3371944.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('546', 'image/21bd9bc7a8d84327958a663357be2b9f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('547', 'image/ba1cbd7d31d279749d351ae10df3b18a.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('547', 'image/d1446013a07c8f2a1b276cc27577b44b.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('548', 'image/776cd462b56b8797f21dbe506ad8fce1.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('548', 'image/30166e67acad2901bb26edb40b19ec5a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('548', 'image/48fa6911d062202a264083d3b7e62e13.jpg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('549', 'image/23a3acd7173642af9475be4e53545fd8.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('549', 'image/0719f2387688e2a0ce0778c201055a9b.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('550', 'image/b7525e314fb3a647ef6ea55ede9e083c.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('550', 'image/98e8b0c9890993e928904386754d5a0a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('551', 'image/2ddba3ffb05ccab2ce3f6964dc0ec670.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('551', 'image/17f0031f29a7ee4d4f56279954b60535.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('552', 'image/2b0017b8e4899e1f3d8615009202c8bb.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('552', 'image/caf2e9cff9d6c424c576cbed92390e22.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('553', 'image/6c9ea2c4951ae801bb89e94add26d2dd.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('553', 'image/d0e1198c487a6c8d4467e23732397e15.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('554', 'image/04668214b791406bba08aed425129985.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('554', 'image/f73ed27853e748bb43235955959d2a62.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('555', 'image/028b372eec87c8c026bcbcd1a45611b1.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('555', 'image/ee8c2c4e05545f3cd10347f7c27bb5bd.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('556', 'image/c2a3306b1e2e6f34a1c94f66713f3456.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('556', 'image/794ec5671bf070907ae369a4f454a41f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('557', 'image/929a63f1782a47164d9f742cee75ab77.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('558', 'image/c60b87c5609326a8b79c201a31b0ec51.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('558', 'image/75e6f073bbcfb4ff7f327d8e4a3acad3.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('559', 'image/aef876c7e32c1ca2f6595522302f46fd.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('559', 'image/2a826c36c512f8c9247152d532be2fd6.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('560', 'image/cbb1b0455a5b0e5453d890fa75b70e5d.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('560', 'image/6e6fd4547df1cc28825d26789f63e5e4.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('561', 'image/81d62f24b6719beb3cc27d5a34911bd9.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('561', 'image/a74e8c3562c99c64e7c1e32ed61e2ac1.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('562', 'image/4c12ce0abf927b5eb7805b4dabcb0d52.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('562', 'image/552cd5e5f34ded931b826d2b55e8b200.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('563', 'image/25b875e3de1582833882dfcde42a77d0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('563', 'image/62afa6a77551b1a2c0bffb067afd885f.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('564', 'image/5f3856f7e126e3b4da08e10b40e73c1b.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('564', 'image/a9dd8e5238e609d50d2f377bfc235583.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('565', 'image/839a8d7d2f8591c979af4f677ba445e0.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('565', 'image/81111acac55a74f6499701095704bc41.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('566', 'image/d6937ef0ba290abe6b259e3ba5e801e9.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('566', 'image/6b5970e266e32c24e9abd96f636de656.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('567', 'image/d73c8c767657cfa248e25d4ea05e9de4.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('567', 'image/87f6f43dd24ad70ee81ccd03b2433f22.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('568', 'image/d036d04b7787177aaddd3ef059d8bc2c.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('568', 'image/1a99c6b6ce04ea5ec95fd12786e04ffd.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('569', 'image/2649449f6363df0ccf0d17fe4dee691c.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('569', 'image/76732e011ee12f9c38aa7ae2f481da82.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('570', 'image/0bfaaa3a907c47020793fe506332ff5f.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('570', 'image/9e7adc1e34b0e422eaaacca1557bfcaa.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('571', 'image/9d2f025b831b33f172d6fba322abca66.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('571', 'image/4689002cf2c1db81e40d8a4def0ed87a.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('572', 'image/2a3f86ee5e1a6a5429b28879cf9ac888.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('572', 'image/5d67aacdb431ac4e66331e148d733c7f.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('573', 'image/605cfce90ffa084b97be78ddba28df60.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('573', 'image/09f7c6cdbc1edf1e07fdc6d6f8c0687a.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('574', 'image/2e16fbd1f7ee3a400e3d4623017b35b2.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('574', 'image/0517f1ac22f140f78c95017821f91098.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('575', 'image/e0f41096f76f1e2e579e2eaf2ae0b467.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('575', 'image/b4c204634c74553feb2c17c156c4ab8e.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('576', 'image/a6dd8273f99a816339236396a9cca245.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('576', 'image/873d8e4a81b431ebf0cbd5cd7214ca10.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('576', 'image/cf7fb2642bab1982cf91ccc37c1419d3.jpeg', '3');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('576', 'image/a6196946a8388cbc642d4ab5b36513a7.jpeg', '4');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('577', 'image/033688c3bce59e86dfdb001265cf8c91.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('577', 'image/c66dee6159c0fe8300b548e2db0ecd4f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('578', 'image/c8b35ef51a614e28ecfc8f1346826494.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('578', 'image/cd727544cf572bfaed9f4da0d7928ba3.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('579', 'image/aa2b353e3ec3f0b9bedb546c9b0f21db.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('579', 'image/2da4132271ac9049ddfe4ac995e872a2.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('580', 'image/0f0b6971fce974d0aa2f5cbc250a246b.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('580', 'image/fb7ae70eb72c03b90a1b37de4eb58b5f.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('581', 'image/748ba12fa1a5359b4dc3a1027b8ca6ff.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('581', 'image/d86a4263aad6f1f4f3a9018e7a0b9ec7.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('582', 'image/b9ce84f0e1bb1b244c4227c0c43ecf3b.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('582', 'image/4d0ff73a6c2008d9f8b41f434d6afe11.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('583', 'image/4cf4ae5368e899025025d21516730034.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('583', 'image/d0d8e3a8a532b15092b32337dfe87227.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('584', 'image/192f64654b662ae4b0bfd74483017dbd.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('584', 'image/b741a243307f816715e516bd2171e482.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('585', 'image/9ce0eb11eb29175e0b0b32e729691329.jpg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('585', 'image/04e066b8ce279b5284ac2efa63a82951.jpg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('586', 'image/755bfa3811e888dc4a03b529f2c02481.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('586', 'image/db1f1cfb1bd39ed057303a277871a13d.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('587', 'image/ff9ab129bdb3ba969fedc2b4f8d6dc60.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('587', 'image/56e53ee8b2d40c052f6b3da6e2c7883f.jpeg', '2');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('588', 'image/7c75f15f690c9cbfb75e912b1af9d0d7.jpeg', '1');
INSERT INTO photo_exercise (exercise_id, url, number)
VALUES ('588', 'image/05a74c11ccbff7cf4488c0a7f308cbfa.jpeg', '2');