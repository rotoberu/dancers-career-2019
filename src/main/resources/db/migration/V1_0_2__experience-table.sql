CREATE TABLE experiences (
  experience_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  page_view INTEGER UNSIGNED NOT NULL DEFAULT 0,
  likes INTEGER UNSIGNED NOT NULL DEFAULT 0,
  last_name VARCHAR(45) NOT NULL DEFAULT '',
  first_name VARCHAR(45) NOT NULL DEFAULT '',
  kana_last_name VARCHAR(45) NOT NULL DEFAULT '',
  kana_first_name VARCHAR(45) NOT NULL DEFAULT '',
  sex ENUM('男性', '女性', '') NOT NULL DEFAULT '',
  major ENUM('文系', '理系', '') NOT NULL DEFAULT '',
  prefecture VARCHAR(30) NOT NULL DEFAULT '',
  university VARCHAR(50) NOT NULL DEFAULT '',
  faculty VARCHAR(50) NOT NULL DEFAULT '',
  department VARCHAR(50) NOT NULL DEFAULT '',
  graduation CHAR(4) NOT NULL DEFAULT '',
  academic_degree VARCHAR(15) NOT NULL DEFAULT '',
  position VARCHAR(150) NOT NULL DEFAULT '',
  club VARCHAR(255) NOT NULL DEFAULT '',
  offer VARCHAR(315) NOT NULL DEFAULT '',
  PRIMARY KEY (experience_id),
  KEY ix_name (kana_last_name, kana_first_name),
  KEY ix_univ (prefecture, university, faculty, department)
) CHARACTER SET utf8;

CREATE TABLE senior_positions (
  position ENUM('代表', '副代表', '会計', '広報', '渉外・営業', 'ジャンルリーダー', '振付師', '公演舞台監督', '公演総合演出', '公演ストーリー制作', '音響制作', '照明制作', '映像制作', '衣装制作', 'イベントオーガナイザー', '新歓係', '合宿統括', '役職なし', 'その他') NOT NULL,
  id INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY (position, id),
  FOREIGN KEY (id) REFERENCES experiences (experience_id) ON DELETE CASCADE
) CHARACTER SET utf8;

CREATE TABLE es (
  id INTEGER UNSIGNED NOT NULL,
  es_id INTEGER UNSIGNED NOT NULL,
  corp VARCHAR(150) NOT NULL DEFAULT '',
  result VARCHAR(75) NOT NULL DEFAULT '',
  question VARCHAR(315) NOT NULL,
  answer TEXT NOT NULL,
  advice TEXT NOT NULL,
  PRIMARY KEY (id, es_id),
  KEY ix_corp (corp),
  FOREIGN KEY (id) REFERENCES experiences (experience_id) ON DELETE CASCADE
) CHARACTER SET utf8;

CREATE TABLE interview (
  id INTEGER UNSIGNED NOT NULL,
  interview_id INTEGER UNSIGNED NOT NULL,
  question VARCHAR(315) NOT NULL,
  answer TEXT NOT NULL,
  PRIMARY KEY (id, interview_id),
  FOREIGN KEY (id) REFERENCES experiences (experience_id) ON DELETE CASCADE
) CHARACTER SET utf8;

INSERT INTO experiences (experience_id, prefecture, university, faculty, graduation, position) VALUES (1, '東京都', '東京大学', '理学部', '2018', '代表,会計,イベントオーガナイザー');
INSERT INTO experiences (experience_id, prefecture, university, faculty, graduation, position) VALUES (2, '東京都', '慶應義塾大学', '法学部', '2018', '公演総合演出,音響制作,イベントオーガナイザー');
INSERT INTO experiences (experience_id, prefecture, university, faculty, graduation, position) VALUES (3, '神奈川県', '横浜国立大学', '', '2018', '副代表');
INSERT INTO senior_positions VALUES ('代表', 1), ('会計', 1), ('イベントオーガナイザー', 1);
INSERT INTO senior_positions VALUES ('公演総合演出', 2), ('音響制作', 2), ('イベントオーガナイザー', 2);
INSERT INTO senior_positions VALUES ('副代表', 3);
INSERT INTO es VALUES
(1, 1, '', '', '学生時代頑張ったことは何ですか？', '私はアルバイト先の飲食店で新メニューを提案し、売上を1.2倍に伸ばしました。\nバイト先は近年売上が減少しており、私はお世話になっているお店に貢献したいと思いました。\n調査したところ原因が客単価の減少にあると突き止めたので、客単価を上げる新メニューを企画することにしました。\n企画にあたっては、来店客100人にヒアリングしてニーズを探るとともに、競合の10店舗を調査することで、今のメニューに足りない要素を分析しました。\n結果、この新メニューは人気メニューとなり、売上向上に貢献することができました。', 'なし'),
(1, 2, '', '内定', '過去最大の失敗とそれを乗り越えた経験について記述してください。', '高校の野球部で肘を怪我したことである。原因は間違ったトレーニング方法や計画性のない過度の練習であった。\nそれまで朝夕練習時間を設けるなど誰よりも努力していたが、方法を間違っていたと気付いた。\nそこから効率的な方法論を探してから計画を立てて実行する習慣が身についた。\nこれによって大学受験時に塾、予備校に通わずに自ら勉強法・暗記法を学び、勉強計画を立て、実行することで第一志望校に合格することができた。', 'これはこうしたほうがいい。'),
(2, 1, '野村証券', '内定', 'あなたが過去に経験した失敗や挫折について記述してください。特に、その原因と考えられる要因分析ともに、そこから学んだことについても記述してください。（500文字以内）', '失敗：英語上達のため留学を決めたが、いざ留学してみると思った環境と違い、留学自体に対するモチベーションが下がってしまい、留学を中断し、帰国しようとも考えた。\n原因：「英語を上達させること」自体が留学の大きな目標になっていて、「なぜ、英語を上達させたいのか」という根本的な理由がなかったから。\nそこから学んだこと：\n1. 学んでいることや努力していることに対して「なぜ学んでいるのか、努力しているのか」という根本的な理由をしっかり持つ大切さ。根本的な理由がなければ、勉強も努力も長続きさせるのは難しく、また、仮に長続きしたとしても、その学んだ先や努力した先にあるものは、自分が望んでいるものではないかもしれない可能性があるということ。\n2. 自分の目標と、その目標を達成したい理由を設定するときは、自分が納得するまでとことん考え抜くことが非常に大切だということ。その理由は、とことん考え抜いて得られた目標と理由ならば、自信を持って、迷うことなく、その目標達成のために努力し続けられるから。', 'とてもいいね！'),
(3, 1, '博報堂', '', 'あなたの挫折経験を教えてください。', '私の挫折はフットサルチームの主将を務めていた時に経験したものだ。それを表すエピソードは以下の通りである。\n私は昨年度、大学のフットサルチームの主将を務めていた。主将の仕事としては練習内容の考案、出場メンバーの選考、大会登録の手続きなどがあるが、業務をただこなすだけでは自分が主将を務める意味がない、と感じたので、これからもこれまでの課題を解決しチームに残る「変化」を起こすことを心がけた。\n一年間の任期の中で具体的に2つの変化を起こした。\n1つ目は、先輩たちの長年の思いを受け継ぎ、体育会部活へ昇格するための交渉を行ったことである。体育会の幹事会に定期的に出席してプレゼンを行ったり、Twitterで選手紹介や試合実況のツイートを開始したりするなど認知度を上げるための広報活動に力を入れた。その活動が認められ、体育会部活の前段階である「体育会調査団体」への昇格に成功した。\n2つ目は、チームの人数の多さから下級生が公式戦にほとんど出られないという問題を解決するために、サテライトチーム（2軍)を創設したことである。そしてトップチームも参加する社会人リーグに参入し、下級生の経験不足を解消した。\nこの結果、トップ・サテライト間にライバル関係が生まれ、普段の練習もより良い雰囲気になった。', '全然ダメ。'),
(3, 2, '電通', '', 'あなたが自身の経験の中で、周囲の人と信頼関係を築いたエピソードを教えてください。（400文字以下）', 'サウジアラビア人、フランス人とグループになり、3人でサービスを作り上げて発表するという課題に取り組みました。一番の苦労は、2人が与えられた課題をきちんとやってこないことでした。初めは理由も聞かず1人で取り組んでいましたが手が回らなくなり、2人の態度の理由を聞き続けました。すると、徐々に2人が各々の考えを話すようになりました。初めは自分の足を彼らに引っ張られているという意識が正直ありました。そしてそれは2人に伝わっていました。しかし、きちんと2人のことを見つめてあげると、それぞれがどんな思いでそこにいたのかということもわかった上、こちらの思いにも耳を傾けてくれるようになりました。経歴や考え方の違いはあれど、わかり合おうとすることで距離が近づき、良い関係を築くことができました。結果、自分たちの満足のいく発表ができ、終わってから3人でいろいろなことを語り合うまでの関係になれました。', 'この言葉は人事には意味が伝わらない。'),
(3, 3, '博報堂', '', 'あなたが主体的に取り組んだことの中で、最も困難だったことについて教えてください。 取組みは未達成のものでも結構です。（400字以内）', '70人規模のキャンプを実施するまでの準備が最も困難でした。まず参加者を集めることに苦労しました。キャンプを企画した当初は学生があまり興味を示してくれず、開催すら危ぶまれる状況でした。そこで私は何としてでも参加者を集めるため、自ら1人1人にキャンプの楽しさや参加する意義について熱く語り、想いが伝わるよう努めました。また様々な学生がいる中で控え目な学生でもキャンプを楽しめるようにするため、キャンプ当日に共通の趣味を持った者同士がコミュニケーションをとられるよう繋ぎ合わせました。そしてキャンプを実施した後、多くの参加者に「楽しかった」と言ってもらえ、翌年にも多くの参加者が集まりました。この経験から学んだことは、人を巻き込んでいくにはしっかり想いや考えを持ちつつ主体的に行動して意欲や姿勢を示すことが必要であるということ、相手のことを理解した上でどうすれば良いか考えていくことが重要だということです。', '結局何が言いたいのかわからない。');
INSERT INTO interview VALUES
(1, 1, 'ESは、何を意識して書いた？', 'ESは、自分の中では二つ意識していました。一つは、書類選考を通過する必要があるので、成果がなるべく第三者から見てわかりやすくなるように記載しました。僕は分かりやすく大会での優勝経験があったのでそれを記載することが多かったです。'),
(1, 2, 'ESとは別に、ダンスについて話すうえで工夫していた点はありますか？', '当時は多分意識できてなかったんですけど、なるべく定量と定性で話せるように意識するとうまくいくと思います。例えば、「一体感を出す」といった内容も、具体的に30人のチームメンバーで踊るときは、5列目の子たちにダンススキルが低い子たちが多かったので、5列目の子たちの振付をそろえることがショーの一体感を出すためには大事だと考えていました。そのため、週に一回補コマをやって。。。。と、数字と具体例を交えて話していました。\n「一体感を出す」止まりだと、何にも伝わらないのでマジで注意してください（笑）。自分にとっての一体感とは？を日ごろから意識するといいです。'),
(1, 3, '何か、就活生ダンサーに対してメッセージしたいことがあれば、どうぞ。', '僕は、ダンサーの一番すごいところは、想いや情熱が強い点だと思います。損得勘定が強くて出世欲が強い人は大学に入って体育会に入ったりゼミ活動して良い会社に入ろうとするはずです。将来何の価値になるかもわからないことに本気になれる力って、ダンサーならではだと思うんですよね。一見、世間から見たらアホだと思われることもありますが、僕は社会を良くしていくイノベーターは、社会の規範に従う（＝いい会社に入る、給与をたくさんもらう）人ではなく、自分が良いと信じるものを貫き通せる力がある人だと思います。ダンサーはそういう素質を持っている人材なので、自分のことをうまくアピールすれば絶対にうまくいきます。言語化してちゃんとアピールできるよう訓練することだけは怠らず頑張れば、必ず結果はついてくると思います。頑張ってください！'),
(2, 1, 'ESを書くうえでのコツはありますか？', '第三者に伝わることが大事だと思うので、とにかく周囲の人に見せていました。社会人、先輩、OB訪問先、など。'),
(2, 2, 'ESで書いたことをもとに、面接ではどのように話した？', '僕は、事前にESをもとに話すことを次のように整理していました。ESではダンスと研究の二つに触れることが多かったです。ダンスと研究それぞれについて、個人で取り組んだエピソードと、チームで取り組んだエピソードを用意しました。特に、ダンスは個人でもチームでも取り組んだエピソードの両方を話せる人が多いと思うので、ここは大きな強みだと思います。個人ではバトル優勝するためにどのように努力し、何が大変で、どういう結果を出したか。チームでも、同様に周囲のメンバーの中でどういう役割を自分は普段担うことが多くて、その中で何が大変でどういう結果を出したのか。以上について話していました。\nあとは、ダンスと研究について両方の話に一貫性を持たせることを意識して、エピソードを整理して面接では話していました。'),
(3, 1, 'ESは、何を意識して書いた？', 'ESは、自分の中では二つ意識していました。一つは、書類選考を通過する必要があるので、成果がなるべく第三者から見てわかりやすくなるように記載しました。僕は分かりやすく大会での優勝経験があったのでそれを記載することが多かったです。'),
(3, 2, '就活ではダンス以外のことを話すこともあるかと思います。ダンス以外に、自分を効果的にアピールするために話した活動はありますか？何かあれば、ぜひ教えてください。', '僕はダンス4割、研究4割、アルバイトと語学留学を2割、という割合で話していました。自分はダンス以外にも学業に打ち込んできたと自負していたので、研究の内容についてもアピールしていました。\n自分の強みは、ダンスのように一体感、芸術性、ロマンなど人間的な部分を大事にすることもできて、かつ研究で求められる論理的思考や社会性も持ち合わせていることにあると認識していたので、その両方をバランスよく伝えるように意識していました。ただ、「ダンスと研究どっちが頑張ったの？」と聞かれたら、必ずダンスと即答していたので、「情熱的な人だけど、しっかりと社会性もありキッチリと働いてくれそうだ」という印象を残そうと意識していました。');
