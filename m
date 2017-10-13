From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: pxa: move header file out of deprecated i2c folder
Date: Fri, 13 Oct 2017 23:45:04 +0200
Message-ID: <20171013214504.ugu5nquhv7dbg2kr@ninjato>
References: <20170814164303.2383-1-wsa@the-dreams.de>
 <87d15qlq6z.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hxhj2wvafewtlrgc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87d15qlq6z.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-i2c@vger.kernel.org, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Russell King <linux@armlinux.org.uk>, Daniel Mack <daniel@zonque.org>, Marek Vasut <marek.vasut@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Jonathan Cameron <jic23@cam.ac.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--hxhj2wvafewtlrgc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Robert,

> I'm sorry I completely missed this one.

No worries, that happens.

> Either it's too late and trash this mail, or it's not, and then I'd sugge=
st
> another approach :
>  - patch 1 : move include/linux/i2c/pxa-i2c.h to include/platform_data/i2=
c-pxa.h
>    (i2c-pxa.h and not pxa-i2c.h to be consistent)
>  - patch 2 : move this chunk to arch/arm/mach-pxa/devices.h
> > extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
> >=20
> > #ifdef CONFIG_PXA27x
> > extern void pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *inf=
o);
> > #endif
> >=20
> > #ifdef CONFIG_PXA3xx
> > extern void pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *inf=
o);
> > #endif
>=20
> This is the cleanest approach I could think of.

OK, will resend with your suggestions somewhen soon.

Thanks,

   Wolfram


--hxhj2wvafewtlrgc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnhM9wACgkQFA3kzBSg
Kbb+WA//QsU+oSnbLh+CYjWLcJQjMirM7C8mO+rYzbWAu05BAICo8CnThTCIILKc
VmZydbaK97aoLWk8plNkIctbdfTJ2YILoFOr8yCXcTH+AF6RA/a2jt4yFkki70Rq
T5Xet/K+4Q1s4yh8pcObWDEPoqYh7vvEd1/JuLpBIbMHrq1E8bV2CCpT5vtbi5jQ
yGGZg5D4Rx1TwQeET7DeoX5OAJXK3/eGHXNjS3/hWy/XxRBkowaIjJJkVhvOEF2V
2pZnoL12XurVD2lmXmhi5Vt8jZ+pStUHtKFf2te7YsmANEE1X1Z2UESoWC+wOicW
u0qNVg5fjXPUw0YTc/u0vnR1VQDfZZqxmL/MDn43okEM2XsT6nqfcCAVAzBw87qg
qOcVGXcS2KCqzOcxMH3zgG0sxItvjpggpSUjH8y6RvbDYN2zUgpbvQnfKQEflsbl
N1laluHVwCIln4xtaBlWn0u1JkkeErUKZkmVf7nAyqBKnDrvU6gRmQycJTFIgnjX
VIahOR2/HRsXdeA1/K2iLZwFroirwgdogBf9pi/xiRld7T/hxaOMh6d5b6QhmPnI
7KxO2ZPwO8Y3FLq4M5dNror2ynIVwFWl6odH2FdnXIVK0oBta1sDZC1VDpcFsK1A
Aq3TuchVCBrDXwjPFaH2f6bBK2/OxKUQc/+g81YerDe8fzH7JhU=
=mzws
-----END PGP SIGNATURE-----

--hxhj2wvafewtlrgc--
