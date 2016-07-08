From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: imx: add retries for i2c-0 on Ventana boards
Date: Fri, 8 Jul 2016 23:07:14 +0200
Message-ID: <20160708210714.GK16643@pengutronix.de>
References: <1467900229-5262-1-git-send-email-tharvey@gateworks.com>
 <20160708062846.GI16643@pengutronix.de>
 <CAJ+vNU2QLTh7-tbLB_b2S04+pMg3VFjN2kk8T2d6x1okdmbx1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52313 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932159AbcGHVHU (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Jul 2016 17:07:20 -0400
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2QLTh7-tbLB_b2S04+pMg3VFjN2kk8T2d6x1okdmbx1A@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tim Harvey <tharvey@gateworks.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello Tim, hello Wolfram,

On Fri, Jul 08, 2016 at 12:49:04PM -0700, Tim Harvey wrote:
> On Thu, Jul 7, 2016 at 11:28 PM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Hello Tim,
> >
> > On Thu, Jul 07, 2016 at 07:03:49AM -0700, Tim Harvey wrote:
> >> Gateworks Ventana IMX6 based boards have a Gateworks System Contro=
ller [1]
> >> (gsc) device that can NAK i2c transactions when its busy in an ADC=
 loop. As
> >> this is always on i2c-0 we will add retries for that bus for any V=
entana
> >> board.
> >
> > The right thing is to fix the drivers IMHO.
> >
> The issue I have is that the i2c device emulates several other device=
s
> with existing drivers (pca953x, ds1672, at24) and those drivers don't
> have any retry mechanism in place for a retry.
>=20
> Maybe if I converted those drivers to use regmap I could implement a
> regmap with retries in the mfd driver for my device?

Wolfram: what do you think?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
