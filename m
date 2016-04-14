From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: efm32: Prevent potential division by zero
Date: Thu, 14 Apr 2016 11:06:29 +0200
Message-ID: <20160414090629.GO10108@pengutronix.de>
References: <1460619774.4294.1.camel@ingics.com>
 <20160414082456.GK10108@pengutronix.de>
 <CAFRkauC4YeuewDGRWbhhBWCG=XbMuNyNL+Lj2jv-nb5EWzaO-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57871 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752614AbcDNJGb (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Apr 2016 05:06:31 -0400
Content-Disposition: inline
In-Reply-To: <CAFRkauC4YeuewDGRWbhhBWCG=XbMuNyNL+Lj2jv-nb5EWzaO-Q@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: linux-i2c@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>, Wolfram Sang <wsa@the-dreams.de>

Hello Axel,

On Thu, Apr 14, 2016 at 04:29:42PM +0800, Axel Lin wrote:
> 2016-04-14 16:24 GMT+08:00 Uwe Kleine-K=F6nig <u.kleine-koenig@pengut=
ronix.de>:
> > On Thu, Apr 14, 2016 at 03:42:54PM +0800, Axel Lin wrote:
> >> Make sure we don't OOPS in case clock-frequency is set to 0 in a D=
T. The
> >> variable set here is later used as a divisor.
> >
> > This is correct in principle. I thought it's ok to misbehave if the=
 DT
> > is broken? In this case the current code is just fine.
>=20
> Current code hit division by zero if clock-frequency is 0.
> clkdiv =3D DIV_ROUND_UP(rate, 8 * ddata->frequency) - 1;
> Is it ok?

IMHO yes. If you give the kernel a broken dt it's ok that the kernel is
broken then.

So if you want, take my:

	Registered-but-considered-unimportant-by: Uwe Kleine-K=F6nig <u.kleine=
-koenig@pengutronix.de>

:-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
