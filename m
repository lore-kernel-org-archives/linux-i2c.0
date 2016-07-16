From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH 05/14] eeprom: at24: hide the read/write loop
 behind a macro
Date: Sat, 16 Jul 2016 13:56:52 +0900
Message-ID: <20160716045651.GB1677@tetsubishi>
References: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
 <1465202936-16832-6-git-send-email-bgolaszewski@baylibre.com>
 <20160715122429.GA2620@tetsubishi>
 <CAMpxmJU+HDvUb__Q6UvuaVC70+GdSU312uVuXuicqsn6_v2uKQ@mail.gmail.com>
 <20160715150352.GB5136@tetsubishi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:42086 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbcGPE5c (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 16 Jul 2016 00:57:32 -0400
Content-Disposition: inline
In-Reply-To: <20160715150352.GB5136@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > >> +#define loop_until_timeout(tout, op_time)                            \
> > >> +     for (tout = jiffies + msecs_to_jiffies(write_timeout),          \
> > >> +             op_time = jiffies;                                      \
> > >> +          time_before(op_time, tout);                                \
> > >> +          usleep_range(1000, 1500), op_time = jiffies)

What about:

#define loop_until_timeout(tout, op_time)                                \
     for (tout = jiffies + msecs_to_jiffies(write_timeout), op_time = 0; \
          op_time ? time_before(op_time, tout) : true;                   \
          usleep_range(1000, 1500), op_time = jiffies)

? Would probably need an explanation in a comment, though.


--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXib6SAAoJEBQN5MwUoCm2ITUQAKymCpFx1rqBS3caXPapcgZe
mWq8kMeKUphM/pRtxbULkdKvtPxe2/WXcac3cTowhtlhWUqBeps3H2GnE4O1zBd7
tlFJ/XJXjCjb4sZxroU4d/KZmykOgo87nM6DXFv37d0Y6PB27pcHcC5j1BH/kPfD
c2hBdyNQuy7fckBoR/TqpOWcDwQLJPp0aRPJJ8SVhijwqz59ttQo708e0jsz5oqa
JybRTCcjf4/ySXptOoOh0d9OhqQJy8C5qNl0Ljo0Jkf3V9QuDdTSB5aKrRIRob3O
TCQIPoh/jEvGRJWN31WoA0Afj70pmU6I+eb4W9tWsXo5pYmHW7H8bM7/QVVgEVXb
US8MWXKUmnsAIcqB0ISDptEmjJdwmXvKiCpFS6lnzj6JEBZPFjGZNa5QMbsztU8H
4R5oh+bch0MIQcY7HIDKtNhpkr6IYo9hDIZm9DNiEfTN+DSkRUaD4sujK96+0S5y
4K8ufqKA304Sl/lupFWEQDv6tZ1WC9cucls32sZOnMVHyxg71i+54cOQjuCvr4qN
KUvVcUBfQsJwIkR8EDHCPM4o5u50B2fkNk3HnOHs9KEeC36hRvzHVzZFyWGBrDwx
N5SDl379JbsaJ7aqsiR5eKYnYxDP8e97IFOYXNJYCIRn5g4ocsM5o93LjwpVF66s
lJ4XOXWfR29Vuio2XTsW
=7n1e
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
