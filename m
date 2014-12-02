From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 3/4] devicetree: bindings: Add defeature-repeated-start
 property for Cadence I2C
Date: Tue, 2 Dec 2014 14:16:11 +0100
Message-ID: <20141202131611.GC4072@katana>
References: <1417514749-24319-1-git-send-email-harinik@xilinx.com>
 <1417514749-24319-4-git-send-email-harinik@xilinx.com>
 <20141202111907.GC23671@leverpostej>
 <CAFcVECLtPx6shBXJbg9Uf_8fnhkMoO1zpoxGcdda7PSA7z_2rA@mail.gmail.com>
 <20141202125203.GA4072@katana>
 <CAFcVECJwFoFd6GrmF282CG+fELnYb=FNCTDq=RYKky_dHha=Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFcVECJwFoFd6GrmF282CG+fELnYb=FNCTDq=RYKky_dHha=Jg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> But given the bugs, it will be useful to just disable it if the system doesn't
> require repeated start.

What do you do when disable repeated start? Sending STOP and START? If
so, this is really something different than repeated start. By using
I2C_FUNC_I2C a user expects repeated start, so if the HW does not
support it, we should say so and don't try to emulate it with something
different.

> If you think DT entry is not the way to go, do you think a CONFIG option or
> something better will work?

No, check at runtime if the transfer is possible on this HW. Bail out if
not.

> We chose a DT property because there is a good chance the user has multiple
> cadence I2C controllers - one connected to a slave that needs repeated start
> (like a power controller) and another that doesn't care.

The user should not need to know with this level of detail if we can
avoid it IMO.


--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfbubAAoJEBQN5MwUoCm29vUP/joDQCiY2g+Bc/f63BDzYevg
vlqzOgmZghenJ0flPZL06Tx2MQkIHXWVoMn4OisvNmXS0Z+15g7m6sZZCdfS14nj
e/IjuUHR2vuwTIUbXZlxaBKqIqKsXfl0LYVHDr99aABD7iBfIIHzzKmYJ+uuR11g
+Jo5CmW2HzfLz+tTBVS3ZuoM/e+vniuUWNIJsnCN5d4YY/TcBWUNgosPpf1/vp1J
S0KDgJWbD6vIKUADrgz8t8LMUQb2YJbvG4F+BvT6rWb3LouBU0x5XiVdOmX56Cvy
N5mGlqhzSMqOjIJ4NP7qK3o1bxCdU2F8sOlf6MRfIqX6Rs0SumNliDIc9s42CMPA
cizhJ0EkxU2eff/pfsXxQSCJwxtX+Ul+ypA80Y9KE47c4//9OPJeE33i1tZdLJra
6ZrPXVpUyQO78DiaBa3FPaTmyBj3uuZ0X+qCeelFmLjt4JCNMtlTkmL64rMHr/Qw
FEfqMga7HmJWnHGXmiAaasFzdXY4/CQPQG84qMAD+ffxFSZmuzfg3j8Ge7A0rjw7
koDWyh4tiwkOTJgFXbjl6K4goHalnwquYC6ArRnc1l0r7XVIBlcjfK43aKPNnK/j
xwgWPb9f9pASB4GlMqUECHTrOX9psJezna5G3Q0ZzbUlqtDHHKjhATq864a3ewQ8
b87LjQUxtKyPHc+7G2jY
=av0D
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
