From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: fix Kconfig dependency
Date: Mon, 7 Apr 2014 19:50:38 +0200
Message-ID: <20140407175038.GS29751@pengutronix.de>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <20140407063100.GN29751@pengutronix.de>
 <1396852656.682914397@f273.i.mail.ru>
 <dfab53fa-8b3c-4eb0-90b8-7df779ce68da@TX2EHSMHS036.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <dfab53fa-8b3c-4eb0-90b8-7df779ce68da-8XeO8fnFoNFDUMyIFHz4objjLBE8jN/0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello S=F6ren,

On Mon, Apr 07, 2014 at 08:36:29AM -0700, S=F6ren Brinkmann wrote:
> On Mon, 2014-04-07 at 10:37AM +0400, Alexander Shiyan wrote:
> > ARCH_ZYNC || (ARM && COMPILE_TEST)
>=20
> Why would you add Zynq to the dependencies? This driver should work o=
n
> all ARM platforms (more or less, given that the IP is implemented
> similarly). I think ARM, if it selects COMMON_CLK, is enough. Otherwi=
se
> ARM && COMMON_CLK. I don't see a good reason to restrict the driver t=
o
> Zynq only.
The idea is that if COMPILE_TEST is off you can only enable the driver
for machines where the device in question really exists to simplify
kernel configuration. Sometimes this isn't really possible, e.g. for i2=
c
devices that can be put on more or less every machine. I had the
impression that the cadence i2c bus device only exists on Zync? Ok, you
could implement this device on every SoC that has some programmable
hardware, but that is not the point.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
