BrowserDetect.init()

$ ->
	userAgent = window.navigator.userAgent.toLowerCase()
	ios = /iphone|ipod|ipad/.test(userAgent)
	if ios
		$('html').addClass 'is-ios'
	if BrowserDetect.browser == "Explorer" || BrowserDetect.browser == "Other"
		$("html").addClass "is-ie"
	return

loadingNum = null
_loaded = false

Pace.on "start", ->
	loadingNum = setInterval( ->
		str = $('.pace-progress').attr("data-progress-text")
	, 100)
	return

Pace.on "done", ->
	if _loaded == false
		clearInterval loadingNum
		_loaded = true
		init()
	return

# Pace.start()

## app

# $ ->
# 	$('.app__content.viewport').fullpage
# 		scrollBar: true
# 		fitToSection: true
# 		autoScrolling: true
# 		onLeave: onLeaveHandler
# 	return

# afterRenderHander = () ->
# 	console.log "afterRenderHander"
# 	return

# onLeaveHandler = (index, nextIndex, direction) ->
# 	# console.log nextIndex
# 	if nextIndex == 4
# 		$.fn.fullpage.setAutoScrolling(false)
# 		$.fn.fullpage.setFitToSection(false)
# 	else
# 		$.fn.fullpage.setAutoScrolling(true)
# 		$.fn.fullpage.setFitToSection(true)
# 	return


## swiper

coverSwiper = null
prductSwiper = null
productDetailSwiper = null
bannerSwiper = null
examSwiper = null

$ ->
	if $("#coverSwiper").length > 0
		coverSwiper = new Swiper "#coverSwiper",
			speed: 777
			# loop: true
			simulateTouch: false
			navigation:
				nextEl: "#coverSwiper .swiper-next"
				prevEl: "#coverSwiper .swiper-prev"
			autoHeight: true
			pagination:
				el: "#coverSwiper .swiper-pagination"
				clickable: true
			# onInit: ->
			# 	if $("#coverSwiper .swiper-slide-active video").length > 0
			# 		$("#coverSwiper .swiper-slide-active video")[0].play()
			# 	return
		coverSwiper.on "slideChangeStart", (e) ->
			$("video").each ->
				$(this)[0].pause()
				return
			if $("#coverSwiper .swiper-slide-active video").length > 0
				$("#coverSwiper .swiper-slide-active video")[0].play()
			return

	if $("#productDetailSwiper").length > 0
		productDetailSwiper = new Swiper "#productDetailSwiper",
			speed: 777
			navigation:
				nextEl: "#productDetailSwiper .swiper-next"
				prevEl: "#productDetailSwiper .swiper-prev"

		productDetailThumbSwiper = new Swiper "#productDetailThumbSwiper",
			speed: 777
			spaceBetween: 10
			centeredSlides: true
			slidesPerView: 'auto'
			slideToClickedSlide: true
			# nextButton: "#productDetailThumbSwiper .swiper-next"
			# prevButton: "#productDetailThumbSwiper .swiper-prev"
			# pagination: "#productDetailThumbSwiper .swiper-pagination"
		productDetailSwiper.controller.control = productDetailThumbSwiper
		productDetailThumbSwiper.controller.control = productDetailSwiper

	if $(".video--swiper").length > 0
		videoSwiper = new Swiper ".video--swiper",
			effect: "fade"
			speed: 777
			onlyExternal: true

		videoSwiper.on "slideChangeStart", (e) ->
			# console.log e
			return

	if $(".exam--swiper").length > 0
		examSwiper = new Swiper ".exam--swiper",
			# effect: "fade"
			speed: 777
			simulateTouch: false
			# fade:
			# 	crossFade: true
			onlyExternal: true
			nextButton: ".exam-next"
			prevButton: ".exam-prev"

		$(".exam-reset").click (e) ->
			$(".button--quiz").removeClass "active"
			examSwiper.slideTo 0
			return

		$(".exam-check").click (e) ->
			# alert "請作答"
			# event.preventDefault()
			slide = $(this).parent().parent()
			if $(slide).find(".button--quiz.active").length > 0
				examSwiper.slideNext()
			else
				alert "請作答"
			return

		examSwiper.on "slideChangeStart", (e) ->
			# console.log e
			return

		$(".button--quiz").click (e) ->
			# alert "click"
			$(this).siblings().removeClass "active"
			$(this).addClass "active"
			return

	if $("#productCatalogSwiper").length > 0
		productCatalogSwiper = new Swiper "#productCatalogSwiper .swiper-container",
			slidesPerView: 'auto'
			spaceBetween: 0
			# centeredSlides: true
			# longSwipes: false
			# width: 1000
			# speed: 777
			# loop: true
			# virtualTranslate: true
			prevButton: "#productCatalogSwiper .swiper-prev"
			nextButton: "#productCatalogSwiper .swiper-next"

	if $("#starProductSwiper").length > 0
		starProductSwiper = new Swiper "#starProductSwiper",
			slidesPerView: "auto"
			centeredSlides: true
			# longSwipes: false
			# width: 1000
			# speed: 777
			loop: true
			virtualTranslate: true
			prevButton: "#starProductSwiper .swiper-slide-prev"
			nextButton: "#starProductSwiper .swiper-slide-next"

		$("#starProductSwiper .swiper-slide-prev").prev().addClass "swiper-slide-prevprev"

		starProductSwiper.on "slideChangeStart", (e) ->
			$("#starProductSwiper .swiper-slide").removeClass "swiper-slide-prevprev"
			if $("#starProductSwiper .swiper-slide-prev").prev().length > 0
				$("#starProductSwiper .swiper-slide-prev").prev().addClass "swiper-slide-prevprev"
			else
				$("#starProductSwiper .swiper-slide").last().addClass "swiper-slide-prevprev"
			return

		# $("#starProductSwiper .box--starProduct").click (e) ->
		# 	if $(this).parent().hasClass("swiper-slide-active")
		# 		$src = $(this).attr "js-target"
		# 		window.location.href = $src
		# 	return
		
		$("#starProductSwiper .swiper-slide").click (e) ->
			$n = $(this).attr "js-slide"
			starProductSwiper.slideTo parseInt($n)-1
			return

	return


$ ->

	$(document).delegate "*[js-toggle=\"slide-to\"]", "click", (event) ->
		str = $(this).attr("js-target")
		# $("body").removeClass "is-open-drawer"
		appSlideTo str
		return
	$(document).delegate "*[js-toggle=\"slide-to-next\"]", "click", (event) ->
		appSwiper.slideNext()
		return

	$(document).delegate "*[js-toggle=\"slide-to-prev\"]", "click", (event) ->
		appSwiper.slidePrev()
		return
	return


## scroll
tight = false
scrolled = false
delta = 5

$ ->

	waypoints = $('.ani').waypoint
		offset: '50%'
		handler: (direction) ->
			$(@element).removeClass "ani-from"
			$(@element).addClass "ani-to"
			return
	
	# setTimeout( ->
		
	# , 2222)
	
	
	# if $("#ani--brand").length > 0
	# 	scrollPageTo "#ani--brand"

	if $(".sidebar--float").length > 0
		$(".sidebar--float").sticky
			topSpacing: $(".sidebar--float").position().top
			bottomSpacing: $("body").height() - $("#stickyEnd").position().top

	lastScrollTop = 0
	didScroll = false
	navbarHeight = $('header').outerHeight()
	$(window).scroll ->
		didScroll = true
		return
	setInterval (->
		if didScroll
			$(window).trigger "resize"
			hasScrolled()
			scrollEvent()
			didScroll = false
	), 250
	hasScrolled = ->
		st = $(window).scrollTop()
		if Math.abs(lastScrollTop - st) <= delta
			return
		if st > lastScrollTop and st > navbarHeight
			$('body').removeClass 'is-scrolled-up'
		else
			# Scroll Up
			if st <= navbarHeight
				$('body').removeClass 'is-scrolled-up'
			else
				$('body').addClass 'is-scrolled-up'
		lastScrollTop = st
		return
	scrollEvent = ->
		st = $(window).scrollTop()
		sv = $(window).height()
		if st > navbarHeight
			$("body").addClass "is-scrolled"
		else
			$("body").removeClass "is-scrolled"
		return
	return




$ ->
	$(document).delegate "*[js-toggle=\"scroll\"]", "click", (event) ->
		event.preventDefault()
		str = $(this).attr "js-target"
		if str == undefined
			str = $(this).attr "href"
		scrollPageTo str
		return
	return

scrollPageTo = (str) ->
	oy = $(str).offset().top - 30
	st = $(window).scrollTop() - 20
	if md.mobile() == null
		scrollPageHandle oy
	else
		scrollPageHandle oy
	return

scrollPageHandle = (n) ->
	$('html,body').stop(true,false).animate
		scrollTop: n
		easing: "ease"
	,
		duration: 777
	return


getScrollBarWidth = ->
	$outer = $('<div>').css(
		visibility: 'hidden'
		width: 100
		overflow: 'scroll').appendTo('body')
	widthWithScroll = $('<div>').css(width: '100%').appendTo($outer).outerWidth()
	$outer.remove()
	return 100 - widthWithScroll




# drawer

$ ->
	$(document).delegate "*[js-toggle=\"drawer\"]", "click", (e) ->
		$(this).toggleClass "is-active"
		$("body").toggleClass "is-open-drawer"
		menu = $(this)
		$('.drawer--bg').fadeToggle "slow", "linear"
		$('.drawer--bg').click ->
			$("body").removeClass "is-open-drawer"
			menu.removeClass 'is-active'
			$('.drawer--bg').fadeOut "slow", "linear"
			return
		return
	$(document).delegate "*[js-toggle=\"drawerPromotion\"]", "click", (e) ->
		$("body").toggleClass "is-open-drawerPromotion"
		return
	return




# news

# $ ->
# 	$(".box--news .caption").slideUp 0
# 	$(".box--news").mouseover (e) ->
# 		$(this).children(".news__caption").children(".caption").slideDown()
# 		return
# 	$(".box--news").mouseleave (e) ->
# 		$(this).children(".news__caption").children(".caption").slideUp()
# 		return
# 	return

# catalog

$ ->
	$(".nav--catalog .nav-link").next().slideUp 0
	$(".nav--catalog .nav-link.active").next().slideDown 0
	$(".nav--catalog .nav-link").click (e) ->
		$(this).parent().siblings().children(".nav-link").removeClass "active"
		$(this).parent().siblings().children(".nav-link").next().slideUp()
		$(this).toggleClass "active"
		$(this).next().slideToggle()
		return
	return

# submenu

$ ->
	$(".panel--submenu").fadeOut 0
	$(document).delegate ".nav--primacy .nav-link", "mouseover", (e) ->
		if $(this).hasClass("active") == false
			$(".nav--primacy .nav-link").removeClass "active"
			$(".panel--submenu").fadeOut 0
			$(this).next().fadeIn 333
			$(this).addClass "active"
		# toggle = $(this).attr "js-toggle"
		# str = $(this).attr "js-target"
		# if toggle == "submenu" && str != undefined
		# 	if str == "none"
		# 		$(".panel--submenu").fadeOut()
		# 	else
		# 		$(".panel--submenu").fadeOut 0
		# 		$(str).fadeIn()
		# 		$(this).addClass "active"
		return
	$(document).delegate ".panel--submenu", "mouseleave", (e) ->
		console.log "mouseleave"
		$(".panel--submenu").fadeOut 0
		$(".nav--primacy .nav-link").removeClass "active"
		return
	return



# video

$ ->
	# $(".inlineVideo").fadeOut 0
	# $(document).delegate "*[js-toggle=\"openInlineVideo\"]", "click", (e) ->
	# 	$(this).next().fadeIn()
	# 	$(this).next().children("video")[0].play()
	# 	# $(this).css "opacity", "0"
	# 	return
	$("video").click (e) ->
		switch $(this)[0].paused
			when true
				$(this)[0].play()
			when false
				$(this)[0].pause()
		return
	return


$ ->
	t = $('.spec__desc').text()
	console.log(t, t.length)
	if t.length > 300
		$('.spec__desc').text t.substr(0, 300) + '...'

	return



$ ->
	# $("*[js-toggle=\"modal\"]").on "click", (event) ->
	# 	event.preventDefault()
	# 	str = $(this).attr "js-target"
	# 	nowModal = str
	# 	$('.modal').modal "hide"
	# 	setTimeout( ->
	# 		$(str).modal "show"
	# 	, 333)
	# 	$("body").removeClass "is-open-drawer"
	# 	return

	$('.modal').on 'show.bs.modal', (e) ->
		$("video").each ->
			$(this)[0].pause()
			return
		$(".modal .mov-playback video")[0].play()
		return

	$('.modal').on 'hide.bs.modal', (e) ->
		$("video").each ->
			$(this)[0].pause()
			return
		$(".swiper-slide-active video")[0].play()
		return
	
	return



## resize


$ ->
	$(window).resize ->
		browserWidthResize = $(window).width()
		# console.log "resize"
		$(".scroll--area").css "min-height", $(".sidebar--float").height()
		return
	$(window).trigger "resize"
	return


# parallax

$ ->
	# $(".parallax--item").parallax()
	# $(".parallaxBackground").parallaxBackground()
	return

# $.fn.parallax = ->
# 	$(this).each ->
# 		$this = $(this)
# 		active = ->
# 			$(window).scroll ->
# 				# pos = parseInt($(window).scrollTop()) - parseInt($this.offset().top) + parseInt($(window).height())
# 				area = parseInt($this.offset().top) + parseInt($(window).height())
# 				top = parseInt($this.offset().top) - parseInt($(window).height())
# 				sc = parseInt($(window).scrollTop())
# 				pos = sc - top
# 				p = pos/area
# 				if p < 0
# 					p = 0
# 				if p > 1
# 					p = 1
# 				p = (p - .5)
# 				# console.log p
# 				velocity =  $this.attr("js-velocity")
# 				$this.css 'transform', 'translateY(' + (p * velocity + 'px') + ')'
# 				return
# 			return
# 		active()
# 	return


# $.fn.parallaxx = ->
# 	$(this).each ->
# 		$this = $(this)
# 		active = ->
# 			$(window).scroll ->
# 				$t = parseInt($this.position().top)
# 				$b = parseInt($this.position().top) + parseInt($this.height()) + parseInt($(window).height())
# 				$s = parseInt($(window).scrollTop()) + parseInt($(window).height())
# 				pos = $s - $t
# 				if pos > $b - parseInt($(window).height())
# 					pos = $b - parseInt($(window).height())
# 				if pos < 0
# 					pos = 0
# 				console.log pos
# 				$this.find(".parallax--itemm").each ->
# 					velocity =  $(this).attr("js-velocity")/100
# 					$(this).css 'transform', 'translateY(' + (pos * velocity + 'px') + ')'
# 				return
# 			return
# 		active()
# 	return

# $.fn.parallaxBackground = ->
# 	$(this).each ->
# 		$this = $(this)
# 		active = ->
# 			velocity =  $this.attr("js-velocity")
# 			# console.log parseInt($('.viewport').scrollTop()) - parseInt($this.offset().top)
# 			$this.css 'background-position', 'center 0px'
# 			$('.viewport').on 'scroll', ->
# 				pos = parseInt($('.viewport').scrollTop()) - parseInt($this.offset().top)
# 				$this.css 'background-position', 'center ' + pos * velocity + 'px'
# 				console.log pos
# 				return
# 			return
# 		active()
# 	return

# global

####jQuery.fx.interval = 16.666
md = new MobileDetect(window.navigator.userAgent)

nowModal = ""
bannerSwiper = ""

_loaded = false
_scrolled = false
_auth = false
msrc = ""

n = 0

$.fn.extend animateCss: (animationName) ->
	animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend'
	$(this).addClass('animated ' + animationName).one animationEnd, ->
		$(this).removeClass 'animated ' + animationName
		return
	return

$ ->
	root=exports?this
	$(".invisible").fadeOut(0)
	$(".invisible").removeClass "invisible"
	$(window).trigger "scroll"
	$(window).trigger "resize"
	return


init = ->
	$mq = window.matchMedia "(max-width: 62em)"
	return

$ ->
	$(document).delegate "button[href]", "click", (e) ->
		e.preventDefault()
		str = $(this).attr "href"
		window.location = str
		return
	$(document).delegate "*[js-trigger]", "click", (event) ->
		fn = $(this).attr "js-trigger"
		eval(fn)()
		# alert fn
		return
	return

$ ->
	$('.row--news').imagesLoaded ->
		setTimeout( ->
			$('.row--news').masonry
				itemSelector: '.row--news .col'
		, 1111)
		return
	return


