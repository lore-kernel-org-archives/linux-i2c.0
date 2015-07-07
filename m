From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 5/5] i2c: davinci: use ICPFUNC to toggle I2C as gpio
 for bus recovery
Date: Tue, 07 Jul 2015 15:37:49 +0200
Message-ID: <1436276269.3344.94.camel@pengutronix.de>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
	 <1417010393-30598-6-git-send-email-grygorii.strashko@ti.com>
	 <20141126160407.GN4431@pengutronix.de> <5476085B.40009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5476085B.40009-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Looijmans <milo-software-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mi, 2014-11-26 at 19:05 +0200, Grygorii Strashko wrote:
> On 11/26/2014 06:04 PM, Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, Nov 26, 2014 at 03:59:53PM +0200, Grygorii Strashko wrote:
> >> Having a board where the I2C bus locks up occasionally made it cle=
ar
> >> that the bus recovery in the i2c-davinci driver will only work on
> >> some boards, because on regular boards, this will only toggle GPIO
> >> lines that aren't muxed to the actual pins.
> >>
> >> The I2C controller on SoCs like da850 (and da830), Keystone 2 has =
the
> >> built-in capability to bit-bang its lines by using the ICPFUNC reg=
isters
> >> of the i2c controller.
> >> Implement the suggested procedure by toggling SCL and checking SDA=
 using
> >> the ICPFUNC registers of the I2C controller when present. Allow pl=
atforms
> >> to indicate the presence of the ICPFUNC registers with a has_pfunc=
 platform
> >> data flag and add optional DT property "ti,has-pfunc" to indicate
> >> the same in DT.
> > On what does it depend if this pfunc stuff works or not? Only the S=
oC,
> > or also on some board specific properties?
>=20
> SoC / set of SoCs. Also, similar feature is supported by OMAP and AM3=
35x/AM437x SoCs
> using I2C_SYSTEST register.
>=20
> > Given the former using the
> > compatible string to detect its availability would be better. (In t=
his
> > case also sorry, didn't consider this case when requesting the prop=
erty
> > in the last round.)

I only stumbled across this after it was merged, with the additional
ti,has-pfunc property instead of using the compatible string (which
would be better for a soc-dependent feature). Can we still fix this?

Regards,
Jan
--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
