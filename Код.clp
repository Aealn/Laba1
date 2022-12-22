(deffunction ask-value (?question)
    (print ?question)
    (bind ?answer (read))
    ?answer
    )
(deffunction ask-question (?question $?allowed-values)
    (print ?question)
    (bind ?answer (read))
    (if (lexemep ?answer) 
        then (bind ?answer (lowcase ?answer))
	    )
    (while (not (member$ ?answer ?allowed-values)) do
        (print ?question)
        (bind ?answer (read))
        (if (lexemep ?answer) 
            then (bind ?answer (lowcase ?answer))
		    )
	    )
    ?answer
    )
(deffunction yes-or-no (?question)
    (bind ?response (ask-question ?question yes no y n))
    (if (or (eq ?response yes) (eq ?response y))
        then yes 
        else no
	    )
    )
(defrule determenite-age "Определение возраста"
    (not (solution ?))
    (not (age ?))
    =>
    (assert (age (ask-value "Напишите Ваш возраст: ")))
    )
(defrule determenite-economy "Экономичный отдых"
    (not (solution ?))
    (not (economy ?))
    =>
    (assert (economy (yes-or-no "Вам нужен экономичный отдых?: ")))
    )
(defrule determenite-children "Отдых с детьми"
    (not (solution ?))
    (not (children ?))
    =>
    (assert (children (yes-or-no "Вы будете отдыхать с детьми?: ")))
    )
(defrule determenite-excursion-for-children "Экскурсии для детей"
    (not (solution ?))
    (not (excur ?))
    =>
    (assert (excur (yes-or-no "Вам нужна экскурсия для детей?: ")))
    )
(defrule determenite-beach-convenient-access "Пляж с удобным заходом в море"
    (not (solution ?))
    (not (beach ?))
    =>
    (assert (beach (yes-or-no "Вам нужен пляж с удобным заходом в море?: ")))
    )
(defrule determenite-all-inclusive "Все включено"
    (not (solution ?))
    (not (all ?))
    =>
    (assert (all (yes-or-no "Вам нужно, чтобы было все включено?: ")))
    )
(defrule determenite-nightlife "Яркая ночная жизнь"
    (not (solution ?))
    (not (nightlife ?))
    =>
    (assert (nightlife (yes-or-no "Вам нужна яркая ночная жизнь?: ")))
    )
(defrule determenite-sports-grounds "Наличие спортивных площадок"
    (not (solution ?))
    (not (sport ?))
    =>
    (assert (sport (yes-or-no "Вам нужна спортивная площадка?: ")))
    )
(defrule determenite-animation "Анимация в отеле"
    (not (solution ?))
    (not (animation ?))
    =>
    (assert (animation (yes-or-no "Вам нужна анимация в отеле?: ")))
    )
(defrule determenite-proximity-beach "Близость пляжа"
    (not (solution ?))
    (not (proximity ?))
    =>
    (assert (proximity (yes-or-no "Вам нужен пляж по близости?: ")))
    )
(defrule determenite-air "Целебный воздух"
    (not (solution ?))
    (not (air ?))
    =>
    (assert (air (yes-or-no "Вы хотите дышать целебным воздухом?: ")))
    )
(defrule determenite-sandy "Песчаный пляж"
    (not (solution ?))
    (not (sandy ?))
    =>
    (assert (sandy (yes-or-no "Вам нужен песчаный пляж на отдыхе?: ")))
    )
(defrule determenite-availability "Доступность среды"
    (not (solution ?))
    (not (availability ?))
    =>
    (assert (availability (yes-or-no "Вам нужны различные развлечения на отдыхе?: ")))
    )
(defrule determenite-nutrition "Питание: завтрак и ужин"
    (not (solution ?))
    (economy yes)
    =>
    (assert (nutrition yes))
	(print "Тогда Ваше питание включает завтрак и ужин" crlf)
	)
(defrule lots-of-entertainment "Много развлечений в отеле"
    (and 
	    (children no) 
		(age > 18)
	    )
    (not (solution ?))
    =>
    (assert (entertainment yes))
	(print "В отеле Вас ждет много развлечений" crlf)
	)
(defrule active-leisure "Активный отдых"
    (and 
	    (children yes) 
		(excur yes)
	    )
    (not (solution ?))
    =>
    (assert (active yes))
	(print "Вас ждет активный отдых" crlf)
	)
(defrule aqua-park "Аквапарк"
    (and 
	    (economy no) 
		(beach yes)
	    )
    (not (solution ?))
    =>
    (assert (aquapark yes))
	(print "Вас ждет аквапарк" crlf)
	)
(defrule friends "Отдых в компании друзей"
    (and 
	    (all yes) 
		(nightlife yes)
	    )
    (not (solution ?))
    =>
    (assert (friend yes))
	(print "Вы собираетесь поехать с друзьями" crlf)
	)
(defrule recreation-for-young "Отдельный отдых для молодежи - да"
    (and 
	    (and 
		    (nightlife no) 
			(sport yes)
			) 
	    (animation yes)
	    )
    (not (solution ?))
    =>
    (assert (young yes))
	(print "У Вас отдельный отдых для молодежи" crlf)
	)
(defrule recreation-for-young-no "Отдельный отдых для молодежи - нет"
    (and 
	    (proximity yes) 
		(air yes)
	    )
    (not (solution ?))
    =>
    (assert (young no))
	(print "У Вас общий отдых с молодежью" crlf)
	)
(defrule wellness-holidays "Оздоровительный отдых"
    (and 
	    (and 
		    (sandy no) 
			(availability yes)
			) 
	    (animation no)
	    )
    (not (solution ?))
    =>
    (assert (wellness yes))
	(print "Вам нужен озоровительный отдых" crlf)
	)
(defrule centre-yes "Недалеко от центра"
    (or 
	    (nutrition yes) 
		(entertainment yes)
	    )
    (not (solution ?))
    =>
    (assert (centre yes))
	(print "Вам нужен отель недалеко от центра" crlf)
	)
(defrule good-denouement "Хорошая транспортная развязка"
    (or 
	    (active yes) 
		(aquapark yes)
	    )
    (not (solution ?))
    =>
    (assert (denouement yes))
	(print "Вам не нужен отель рядом с хорошей транспортной развязкой" crlf)
	)
(defrule lots-of-bars "Много баров"
    (not (solution ?))
    (friend yes)
    =>
    (assert (bars yes))
	(print "Ваш ждет отдых в различных барах" crlf)
	)
(defrule availability-of-elevators "Наличие лифтов"
    (or 
	    (young no) 
		(wellness yes)
	    )
    (not (solution ?))
    =>
    (assert (elevators yes))
	(print "Вам нужен отель с лифтами" crlf)
	)
(defrule alanya-resort "Курорт Алания"
    (or 
	    (denouement yes) 
		(centre yes)
	    )
    (not (solution ?))
    =>
    (assert (alanya yes))
	(print "Рекомендация - посетите курорт Алания" crlf)
	)
(defrule kemer-resort "Курорт Кемер"
    (or 
	    (bars yes) 
		(young yes)
	    )
    (not (solution ?))
    =>
    (assert (kemer yes))
	(print "Рекомендация - посетите курорт Кемер" crlf)
	)
(defrule side-resort "Курорт Сиде"
    (not (solution ?))
    (elevators yes)
    =>
    (assert (side yes))
	(print "Рекомендация - посетите курорт Сиде" crlf)
	)
