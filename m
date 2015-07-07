From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 5/5] i2c: davinci: use ICPFUNC to toggle I2C as gpio
 for bus recovery
Date: Tue, 7 Jul 2015 16:13:12 +0200
Message-ID: <20150707141312.GC3411@katana>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
 <1417010393-30598-6-git-send-email-grygorii.strashko@ti.com>
 <20141126160407.GN4431@pengutronix.de>
 <5476085B.40009@ti.com>
 <1436276269.3344.94.camel@pengutronix.de>
 <20150707134852.GE9671@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150707134852.GE9671-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jan =?utf-8?B?TMO8YmJl?= <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Looijmans <milo-software-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2015 at 03:48:52PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Jul 07, 2015 at 03:37:49PM +0200, Jan L=C3=BCbbe wrote:
> > On Mi, 2014-11-26 at 19:05 +0200, Grygorii Strashko wrote:
> > > On 11/26/2014 06:04 PM, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Wed, Nov 26, 2014 at 03:59:53PM +0200, Grygorii Strashko wrote:
> > > >> Having a board where the I2C bus locks up occasionally made it cle=
ar
> > > >> that the bus recovery in the i2c-davinci driver will only work on
> > > >> some boards, because on regular boards, this will only toggle GPIO
> > > >> lines that aren't muxed to the actual pins.
> > > >>
> > > >> The I2C controller on SoCs like da850 (and da830), Keystone 2 has =
the
> > > >> built-in capability to bit-bang its lines by using the ICPFUNC reg=
isters
> > > >> of the i2c controller.
> > > >> Implement the suggested procedure by toggling SCL and checking SDA=
 using
> > > >> the ICPFUNC registers of the I2C controller when present. Allow pl=
atforms
> > > >> to indicate the presence of the ICPFUNC registers with a has_pfunc=
 platform
> > > >> data flag and add optional DT property "ti,has-pfunc" to indicate
> > > >> the same in DT.
> > > > On what does it depend if this pfunc stuff works or not? Only the S=
oC,
> > > > or also on some board specific properties?
> > >=20
> > > SoC / set of SoCs. Also, similar feature is supported by OMAP and AM3=
35x/AM437x SoCs
> > > using I2C_SYSTEST register.
> > >=20
> > > > Given the former using the
> > > > compatible string to detect its availability would be better. (In t=
his
> > > > case also sorry, didn't consider this case when requesting the prop=
erty
> > > > in the last round.)
> >=20
> > I only stumbled across this after it was merged, with the additional
> I also wonder how it came to the Reviewed-by tag for me. The last thing
> that I said about the patch was "On what does it depend if this pfunc
> stuff works or not? Only the SoC, or also on some board specific
> properties?" (see above) and "the patch looks ok". IMHO this hardly
> justifies to add the Reviewed-by tag for the next round. :-(

That needs to be discussed with Grygorii. I can't verify the correctness
of tags for every patch, although I do try to keep an eye on it...


--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVm954AAoJEBQN5MwUoCm2ltgQAJO2ysHyJhuGYg+qe7+hK2qB
ZpOA7s0U9uSkVczWOBuNvdGorPsLX/L479LwfyzGYcMfqNLWOr9uj+m9V0rPzV2S
JOISCDQ3rX3HNYZJW716S0c7LgL4QVCli8zbNYDioCJ7kCCM33Fsoa2TwMwD+UcX
FfbBQRRw7Ou0DOJ3y3Nwo8NeUOUJv+L8N/JLs1Vz8lw13bBoRvWUtZCc3lEqsKPE
TDUu2Oot2qqK6cYyAk0gi+gbikYPvj9GXWeVZRfYKz5Lr98s+gnuZSaS0/nJDwhu
6YQxZ6edwuqpuXubB1zW3VhBMc3LNSH0vvG2qWKWSfi0UnuNai/MiyPvd2OE/GPU
Oux1Q0d+e3ZjL+lyz7NtCL7dm4J0SaVZcaMokT/kYjDuaGPhTzD61WMH9xqGIDYL
F/6G5tjclrSU3lScl+hcmAENHRnodWaEbjML+vpoFnxOI5dQSsAAaci4ONfa4mqm
teilrlSzjLczwlhd9Jvi3FqspJKH6RPCJT+E56yB404bym8VvXGWJv+uM/137acA
as4n5fSdp8ydMotegIv7QirNAd6U03BKXD5hqK0Oq+c+1+JVbIfPC6xucfcrmItV
CC5w/YEE2fHBpSzVvxsELUO/EPC/ZIFLCr0N9tiRHtO1DxXY0W2wtNgDLOJ9xdyV
P30F6aQybrLPtXEpAIo/
=cxHH
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
