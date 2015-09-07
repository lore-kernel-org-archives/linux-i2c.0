From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch V7] i2c: imx: add runtime pm support to improve the
 performance
Date: Mon, 7 Sep 2015 23:18:14 +0200
Message-ID: <20150907211814.GI14598@pengutronix.de>
References: <1441006353-874-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441006353-874-1-git-send-email-b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Mon, Aug 31, 2015 at 03:32:33PM +0800, Gao Pan wrote:
> In our former i2c driver, i2c clk is enabled and disabled in
> xfer function, which contributes to power saving. However,
> the clk enable process brings a busy wait delay until the core
> is stable. As a result, the performance is sacrificed.
>=20
> To weigh the power consumption and i2c bus performance, runtime
> pm is the good solution for it. The clk is enabled when a i2c
> transfer starts, and disabled after a specifically defined delay.
>=20
> Without the patch the test case (many eeprom reads) executes with app=
rox:
> real 1m7.735s
> user 0m0.488s
> sys 0m20.040s
>=20
> With the patch the same test case (many eeprom reads) executes with a=
pprox:
> real 0m54.241s
> user 0m0.440s
> sys 0m5.920s
>=20
> Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> [wsa: fixed some indentation]
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Hmm, why does this already have a S-o-b from Wolfram?

Other than that I don't have any caveats to enter any more, but given
that I don't have much clue about runtime pm this doesn't mean much.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
