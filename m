From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [V2 1/2] i2c: brcmstb: Add Broadcom settop SoC i2c controller
 driver
Date: Wed, 15 Apr 2015 09:50:56 +0200
Message-ID: <20150415075056.GA1826@katana>
References: <1428004866-13543-1-git-send-email-kdasu.kdev@gmail.com>
 <20150414134740.GB1375@katana>
 <552D7AF5.7040005@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <552D7AF5.7040005-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>; bcm-kernel-feedback-list" <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ray,

thanks for the review! I agree to all points except one minor thing:

> >> +#include <linux/device.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/sched.h>
> >> +#include <linux/i2c.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/io.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/version.h>
> >> +#include <linux/delay.h>
>=20
> Wolfram would prefer the includes to be sorted in alphabetic order

Sidenote: And one can see why here: clk.h is included twice.

> >> +	adap->owner =3D THIS_MODULE;
>=20
> Not needed...

This is needed. It is not needed to set it with the platform_driver
struct, but for the adapter created, this is needed.

Thanks again,

   Wolfram


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLhhgAAoJEBQN5MwUoCm2Y40QAI9nVY5V5gNqbYZCWwuL8g1I
z2/+h1aORzEnnL9xmrRadSNZE/d/s2vmmX1riBJZLQFOyy/P4Z55oZMHLLWRxmad
9BLudC1OozFF/f03lgArqDpTVki8db/0f7GMnGZ2ZBCJDjSIGOIFL2j3yeNS1xaL
79DgiAnMTyzeq38t2QJCGYwfAnMCRIzjZH3YSNfbdATgP+o43+h1CWHacFHu7VgF
j+fNsx7x8OG1ES282xxYCgOr+IOcHAY8eNkpfgrtl8+6AmZRRTXfJSZ7FkGHzX8Q
2rDLvBqJIn+A+XevVE+RTi2EpPtab5j7RsZ0iHJhkLNur4/6wtGMDHLhpnm1c5/B
+xptQN53SLLbQ25G6hCR46+qe/jrEkqdZHrEyjVHCbePfLSuv3ymqWMSw1UgFegZ
ZNOn48oH31IOVU8b56rvamOtS/D6rvK/iZ1kAxY0H8c/f8jN8KOOABzBLKBy7zyq
2KjAJjNiPOBrlxhD1kzY0GtnEQ2yWBCS08Cnr1ZjhcUa2YOADy6k2EWS2/I0ZB4Y
VcRz2JHLJdlOL5iZ1cmJLnEilc16+LZsUglWJM9jE4y4njuxQE2m6TAF5HH6Ugz+
KdAxeaWPaBbeHupjURQWRHZKEMTPjFjqrXv2NUE9TzCVJ4SORI9uLnWJjCeILWFn
Jz1aOD4B8lCN8JfIY2Tb
=P40W
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
