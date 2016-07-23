From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: slave support framework improvements
Date: Sat, 23 Jul 2016 21:51:14 +0200
Message-ID: <20160723195114.GA2104@katana>
References: <137031469256709@web4j.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35231 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbcGWTvX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 23 Jul 2016 15:51:23 -0400
Content-Disposition: inline
In-Reply-To: <137031469256709@web4j.yandex.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kachalov Anton <mouse@mayc.ru>
Cc: linux-i2c@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> I'm working on multi-master i2c support in Aspeed SoC (AST2150,
> AST2300 and so on) and succeed with event passing to the slave
> software backend. Besides AST has two operation modes: byte transfer

Which upstream driver does that SoC use?

> and buffer transfer. While i2c slave framework operates over bytes. In
> current scheme I would able to receive an interrupt on buffer fill
> then call N-times event function with one byte. It is a little
> overhead there. What we can do there?

Let me quote from Documentation/i2c/slave-interface:

About buffers
-------------

During development of this API, the question of using buffers instead of just
bytes came up. Such an extension might be possible, usefulness is unclear at
this time of writing. Some points to keep in mind when using buffers:

* Buffers should be opt-in and slave drivers will always have to support
  byte-based transactions as the ultimate fallback because this is how the
  majority of HW works.

* For backends simulating hardware registers, buffers are not helpful because
  on writes an action should be immediately triggered. For reads, the data in
  the buffer might get stale.

* A master can send STOP at any time. For partially transferred buffers, this
  means additional code to handle this exception. Such code tends to be
  error-prone.

> Second one thing that I want to point is a slave support in I2C MUX/switch
> drivers. For instance I use PCA9548 switch and want to have N (N <= 8) slaves
> (one per channel)

How do the other masters know that their channel is currently muxed then? And
what if two of them want to access two of your slaves at the same time?

This setup may work for one specific case but in general sounds pretty fragile
to me. This fragility shows in all the hacks needed to work around the proper
abstractions. I don't think much can be done about that.

Regards,

   Wolfram


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXk8qyAAoJEBQN5MwUoCm2sTsP/Rpf3pbPus4kRaMNu5YkZ3Hm
W423cJ0PO9eIWtwxKObB7O2AwzOungBYRZv7kMtgOJHSAzhbAnkbl2IqSALd0kti
dqIVpZ/mBsnEcLcmPUdVmiglW1h02Z6R3b/6t/O42+3vpsa9WyBOXpzkqKXxliNJ
LDvygCPoSFMLggGXp2TmmlhIuetFCmXtDxHoGIgWDHuAFmSz/dnwzdenGNM+oJZq
itA+MMW35vJDnJPiDdf1lgSJFHsVih0q22RRQCs6v6SraJp7qTrUDUdHUJZcplHB
c7i2G05uyG9SV8aS86jyj3zkmvxpM+AvfpXydwjeQ/2kzaBxyP7ZRcty8vJDQgX5
LNW67cYEX1xUK8SCMK5iMpUO09eoPQOA8SeJj4Gi4CSaf0oSGGaILSxXGqUAvKI8
farAFfP23nIBnTIKQR6y2d1qNzUwRf00LFwGDmv+md4avw7UkoAvUJE2Z5QR5/Nk
6dI1P4m1Tk++ribp0uM2/wjHr5CqMXfTqbN0+rbeCNHu4vT4Xox+HeFvpRy1G4i/
yp+ByZdU1qYnJyc7OXqBFmxXkVl1oHSVHhAbYGmlhBdPMVdYpxGEyMeTVbQgK9++
orYMrntv163NslUD1gJ6mLar8YZ58KFCTs5IW+4tazCI52HgBTvlOmbawAT81RS9
OrIO0BGdDGzwQfD/Vaco
=dlKm
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
