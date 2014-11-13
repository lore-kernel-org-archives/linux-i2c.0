From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM: mediatek: Add driver for Mediatek I2C
 controller
Date: Thu, 13 Nov 2014 19:31:22 +0100
Message-ID: <20141113183122.GH1275@katana>
References: <1415078977-18374-1-git-send-email-xudong.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bpVaumkpfGNUagdU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415078977-18374-1-git-send-email-xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Nathan Chung <nathan.chung-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YH Chen <yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--bpVaumkpfGNUagdU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> MTK I2C HW has some limitation.
> 1. If the i2c_msg number is more than one, STOP will be issued instead of
> RS(Repeat Start) between each message.
>=20
> 2. Mediatek I2C controller support WRRD(write then read) mode, in WRRD
> mode the Repeat Start will be issued between 2 messages.
> In this driver if 2 messages is first write then read, the driver will
> combine 2 messages using Write-Read mode so the RS will be issued between
> the 2 messages.
> Ex: W/R/R, driver will combine first W/R and then R.
>=20
> 3. Due to HW limitation, in this version the max transfer data length is =
255
> in one message.

This looks to me more like an SMBUS controller instead of I2C. Maybe you
should populate smbus_xfer rather than master_xfer?

> MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting the i2c
> registers in MT8135 side.

I still didn't get this, even after reading the mail thread of old
series. Can someone maybe draw me a nice ASCII picture showing the setup
which is going on here?


--bpVaumkpfGNUagdU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZPj6AAoJEBQN5MwUoCm298UP/i/SoKTHz4N7HOuev9WcBtwC
XzbQo/VmY+4QNUD1O0rS+qoCDHi5x3hr46Gqn0zCLdRmfRlu0jBi2u+Ccb0m0P9I
HgZdFz2UEJlXz0ZEuMYcVSBqA9U7tm4USF8o27zzPX6nvQsk3/JyNxm0LOPAS/Jg
caLFXcIBkUQcdAevt/Q8O/OY6IstLsTiL2xVcGMCVWaAQoZ4/Lor7YmpYfBh5qJC
7YD2Ww/7knl2BEy2A8p3eMQZMetdmSEnCW35XvqoFhSRi2UI84AHtkEzb+BzOW6X
GrYyUEMbCk2hEXbUR2vp/DWofnnbz52AoghlkrUu20E84FEOpSX2jBxtM/f8k9+i
CqPZl2Bjw4rAzCg3IOlWEad2ItbBTJcRnp3yDdpWZ6T3nlOLOKMuV9zCeLObvZNU
7RLei4ZOtdje32H6ccPgwLv32JrStJdZYhnro0ZT1moxwvOrF2dzEwlPtMYZlIET
37P3LkcIbTN/xUJoBi81VsYerRDYs/NVvQE6NBc1GTNGZqbqPzMYx6rushKiCR3q
tgW/R8bp0go5GTyPUf87ebgk/hTQXcrOWOcOuxyhuuH3pOhXQmItXVm5XS0j9Naa
UACDfqPGPU+C2TEJWjVddkOIGOX1GKzjTFe5O9W4U/gfYhX2AYWxUmEmVABFSsjo
LoF4hHo43V6ZYiirk6nw
=NRsk
-----END PGP SIGNATURE-----

--bpVaumkpfGNUagdU--
