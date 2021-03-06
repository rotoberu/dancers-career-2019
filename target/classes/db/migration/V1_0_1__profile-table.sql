CREATE TABLE profiles (
  email VARCHAR(150) NOT NULL COLLATE utf8_bin,
  last_name VARCHAR(45) NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  kana_last_name VARCHAR(45) NOT NULL,
  kana_first_name VARCHAR(45) NOT NULL,
  date_of_birth DATE NOT NULL,
  sex ENUM('男性', '女性') NOT NULL,
  phone_number VARCHAR(15) NOT NULL,
  major ENUM('文系', '理系') NOT NULL,
  prefecture VARCHAR(30) NOT NULL,
  university VARCHAR(50) NOT NULL,
  faculty VARCHAR(50) NOT NULL,
  department VARCHAR(50) NOT NULL,
  graduation CHAR(7) NOT NULL,
  academic_degree VARCHAR(15) NOT NULL,
  position VARCHAR(150) NOT NULL,
  likes VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (email),
  KEY ix_name (kana_last_name, kana_first_name),
  KEY ix_univ (prefecture, university, faculty, department),
  FOREIGN KEY (email) REFERENCES accounts (email) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8;

CREATE TABLE positions (
  position ENUM('代表', '副代表', '会計', '広報', '渉外・営業', 'ジャンルリーダー', '振付師', '公演舞台監督', '公演総合演出', '公演ストーリー制作', '音響制作', '照明制作', '映像制作', '衣装制作', 'イベントオーガナイザー', '新歓係', '合宿統括', '役職なし', 'その他') NOT NULL,
  email VARCHAR(150) NOT NULL COLLATE utf8_bin,
  PRIMARY KEY (position, email),
  FOREIGN KEY (email) REFERENCES profiles (email) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8;

INSERT INTO profiles VALUES ('user1@t6sdl.tokyo', '大阪', '太郎', 'オオサカ', 'タロウ', '1995-09-11', '男性', '09032721323', '理系', '大阪府', '大阪大学', '工学部', '応用理工学科', '2020/03', '修士卒', '会計,公演総合演出,イベントオーガナイザー', '');
INSERT INTO profiles VALUES ('user2@t6sdl.tokyo', '東京', '文子', 'トウキョウ', 'フミコ', '1998-02-03', '女性', '09032914272', '文系', '東京都', '上智大学', '総合人間科学部', '社会学科', '2020/03', '学部卒', '会計,音響制作,合宿統括', '');
INSERT INTO profiles VALUES ('user3@t6sdl.tokyo', '東京', '太郎', 'トウキョウ', 'タロウ', '1996-12-28', '男性', '09098127434', '文系', '東京都', '慶應義塾大学', '商学部', '商学科', '2020/03', '学部卒', '代表,公演舞台監督,公演総合演出', '');

INSERT INTO positions VALUES ('会計', 'user1@t6sdl.tokyo'), ('公演総合演出', 'user1@t6sdl.tokyo'), ('イベントオーガナイザー', 'user1@t6sdl.tokyo');
INSERT INTO positions VALUES ('会計', 'user2@t6sdl.tokyo'), ('音響制作', 'user2@t6sdl.tokyo'), ('合宿統括', 'user2@t6sdl.tokyo'), ('その他', 'user2@t6sdl.tokyo');
INSERT INTO positions VALUES ('代表', 'user3@t6sdl.tokyo'), ('公演舞台監督', 'user3@t6sdl.tokyo'), ('公演総合演出', 'user3@t6sdl.tokyo');
