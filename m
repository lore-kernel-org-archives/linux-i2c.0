From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] i2c: efm32: Prevent potential division by zero
Date: Thu, 14 Apr 2016 20:52:50 +0200
Message-ID: <20160414185250.GT10108@pengutronix.de>
References: <1460627375.17638.1.camel@ingics.com>
 <20160414114041.GS10108@pengutronix.de>
 <CAFRkauC+JamMAM4YAunmqzggK7X4dDUAU8O0LTbcOEGHdD48uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35229 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752889AbcDNSwx (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Apr 2016 14:52:53 -0400
Content-Disposition: inline
In-Reply-To: <CAFRkauC+JamMAM4YAunmqzggK7X4dDUAU8O0LTbcOEGHdD48uQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>

Hello Axel,

On Thu, Apr 14, 2016 at 10:17:45PM +0800, Axel Lin wrote:
> 2016-04-14 19:40 GMT+08:00 Uwe Kleine-K=F6nig <u.kleine-koenig@pengut=
ronix.de>:
> > On Thu, Apr 14, 2016 at 05:49:35PM +0800, Axel Lin wrote:
> >> Make sure we don't OOPS in case clock-frequency is set to 0 in a D=
T. The
> >> variable set here is later used as a divisor.
> >>
> >> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> >> ---
> >> If my understand is correct, you prefer to make it return error ra=
ther
> >> than using default frequency setting if DT setting is wrong.
> >
> > No, I'd say it doesn't matter that the driver crashes if something
> > invalid is specified in the device tree. This is not a driver bug, =
but a
> > dt bug. So if it happens, fix the device tree, no need to modify th=
e
> > driver.
>=20
> I know that such case is a DT bug.
> But the intention of this patch is to avoid oops rather than fix dt.
> Make probe return error is enough to inform developer fixing dt.

an oops is also enough, and maybe even better because $developer cannot
miss it.

I don't care much, because the error probably won't happen. If you ask
me, I like your v2 better.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
