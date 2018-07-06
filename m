From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] gpiolib: Defer on non-DT find_chip_by_name() failure
Date: Fri, 06 Jul 2018 20:58:34 +0200
Message-ID: <1956873.bHDVU2PRcn@z50>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com> <1579112.qQSMXVQn9s@z50> <4ecc2072-3ec3-6e9b-576f-fd05559e7634@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ecc2072-3ec3-6e9b-576f-fd05559e7634@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>, Boris Brezillon <boris.brezillon@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Phil Reid <preid@electromag.com.au>, Lucas Stach <l.stach@pengutronix.de>, Clemens Gruber <clemens.gruber@pqgruber.com>, Peter Rosin <peda@axentia.se>, patches@opensource.cirrus.com, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> >> On Wed, 04 Jul 2018, Janusz Krzysztofik wrote:
> >>> On Tuesday, July 3, 2018 7:31:41 PM CEST Boris Brezillon wrote:
> >>>> On Tue,  3 Jul 2018 19:26:35 +0200 Janusz Krzysztofik wrote:
> >>>>>   		chip =3D find_chip_by_name(p->chip_label);
> >>>>>   		if (!chip) {
> >>>>> -			dev_err(dev, "cannot find GPIO chip %s\n",
> >>>>> -				p->chip_label);
> >>>>> -			return ERR_PTR(-ENODEV);
> >>>>> +			/*
> >>>>> +			 * As the lookup table indicates a chip with
> >>>>> +			 * p->chip_label should exist, assume it may
> >>>>> +			 * still appear latar and let the interested
> >>>>> +			 * consumer be probed again or let the Deferred
> >>>>> +			 * Probe infrastructure handle the error.
> >>>>> +			 */
> >>>>> +			dev_warn(dev, "cannot find GPIO chip %s, deferring\n",
> >>>>> +				 p->chip_label);
> >>>>> +			return ERR_PTR(-EPROBE_DEFER);
> >>>>>   		}
> >>>>=20
> >>>> Looks good otherwise. Let's hope we're not breaking implementations
> >>>> testing for -ENODEV...
> >>>=20
> >>> I've reviewed them all and found two which I think may be affected:
> >>> - drivers/mfd/arizona-core.c,
> >>> - drivers/i2c/busses/i2c-imx.c.

On Thursday, July 5, 2018 7:23:46 AM CEST Uwe Kleine-K=F6nig wrote:
> TL;DR: Either I don't understand the implication for
> drivers/i2c/busses/i2c-imx.c or everything is fine.
> ...
> So if a patch changes devm_gpiod_get() to return -EPROBE_DEFER in more
> cases that doesn't seem to hurt. Moreover TTBOMK this driver should only
> be used by dt-machines today such that changing gpio* for non-DT users
> shouldn't affect it.

On Friday, July 6, 2018 11:03:53 AM CEST Richard Fitzgerald wrote:
> The intention is that if the DT node is missing, the Arizona driver can r=
un
> using only soft reset, though there are limitations in that mode.
> This should return -ENOENT so that the Arizona driver will continue witho=
ut
> a GPIO.
>=20
> If the DT defines a GPIO it is effectively saying that this GPIO is requi=
red
> so it is valid for the Arizona driver never to come up if the GPIO it is
> defined to depend on doesn't come up.

Uwe, Richard, thanks for clarifications.

I think we can assume the change is safe for all current implementations.

Thanks,
Janusz
