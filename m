From: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
Date: Thu, 24 Nov 2011 16:24:51 +0800
Message-ID: <20111124082450.GB18060@S2100-06.ap.freescale.net>
References: <1322121140-5216-1-git-send-email-shawn.guo@linaro.org>
 <20111124080004.GD8439@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111124080004.GD8439-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 24, 2011 at 09:00:04AM +0100, Wolfram Sang wrote:
> On Thu, Nov 24, 2011 at 03:52:20PM +0800, Shawn Guo wrote:
> >   CC      drivers/i2c/busses/i2c-mxs.o
> > drivers/i2c/busses/i2c-mxs.c: In function =E2=80=98mxs_i2c_xfer=E2=80=
=99:
> > drivers/i2c/busses/i2c-mxs.c:196:6: warning: =E2=80=98data=E2=80=99=
 may be used uninitialized in this function
> >=20
> > Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> Which compiler? What flags? I don't see that here.
>=20
gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu3)

$ make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- -j 2 zImage

--=20
Regards,
Shawn
