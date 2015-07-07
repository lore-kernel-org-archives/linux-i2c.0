From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 5/5] i2c: davinci: use ICPFUNC to toggle I2C as gpio
 for bus recovery
Date: Tue, 7 Jul 2015 15:48:52 +0200
Message-ID: <20150707134852.GE9671@pengutronix.de>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
 <1417010393-30598-6-git-send-email-grygorii.strashko@ti.com>
 <20141126160407.GN4431@pengutronix.de>
 <5476085B.40009@ti.com>
 <1436276269.3344.94.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436276269.3344.94.camel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan =?iso-8859-1?Q?L=FCbbe?= <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Looijmans <milo-software-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Tue, Jul 07, 2015 at 03:37:49PM +0200, Jan L=FCbbe wrote:
> On Mi, 2014-11-26 at 19:05 +0200, Grygorii Strashko wrote:
> > On 11/26/2014 06:04 PM, Uwe Kleine-K=F6nig wrote:
> > > On Wed, Nov 26, 2014 at 03:59:53PM +0200, Grygorii Strashko wrote=
:
> > >> Having a board where the I2C bus locks up occasionally made it c=
lear
> > >> that the bus recovery in the i2c-davinci driver will only work o=
n
> > >> some boards, because on regular boards, this will only toggle GP=
IO
> > >> lines that aren't muxed to the actual pins.
> > >>
> > >> The I2C controller on SoCs like da850 (and da830), Keystone 2 ha=
s the
> > >> built-in capability to bit-bang its lines by using the ICPFUNC r=
egisters
> > >> of the i2c controller.
> > >> Implement the suggested procedure by toggling SCL and checking S=
DA using
> > >> the ICPFUNC registers of the I2C controller when present. Allow =
platforms
> > >> to indicate the presence of the ICPFUNC registers with a has_pfu=
nc platform
> > >> data flag and add optional DT property "ti,has-pfunc" to indicat=
e
> > >> the same in DT.
> > > On what does it depend if this pfunc stuff works or not? Only the=
 SoC,
> > > or also on some board specific properties?
> >=20
> > SoC / set of SoCs. Also, similar feature is supported by OMAP and A=
M335x/AM437x SoCs
> > using I2C_SYSTEST register.
> >=20
> > > Given the former using the
> > > compatible string to detect its availability would be better. (In=
 this
> > > case also sorry, didn't consider this case when requesting the pr=
operty
> > > in the last round.)
>=20
> I only stumbled across this after it was merged, with the additional
I also wonder how it came to the Reviewed-by tag for me. The last thing
that I said about the patch was "On what does it depend if this pfunc
stuff works or not? Only the SoC, or also on some board specific
properties?" (see above) and "the patch looks ok". IMHO this hardly
justifies to add the Reviewed-by tag for the next round. :-(

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
