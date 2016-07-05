From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: portable device tree connector -- problem statement
Date: Tue, 5 Jul 2016 10:31:52 +0200
Message-ID: <20160705083152.GM6247@sirena.org.uk>
References: <577ACE0D.9050700@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="16g62bNiOXHZyjZa"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <577ACE0D.9050700-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, marex-ynQEQJNshbs@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--16g62bNiOXHZyjZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 04, 2016 at 01:58:53PM -0700, Frank Rowand wrote:

> On the other hand, I have no previous detailed knowledge of the beagle
> family.

This is in no way specific to the BeagleBones, there's plenty of other
boards out there with similar setups like the Raspberry Pi and its
derivatives. =20

>     - for bones with the same pinout:
>       - the pins are routed to different function blocks on the
>         SOC because different bones may have different SOCs?
>         - the different functional blocks are compatible or not?

This is the general case, there will be a substantial level of
compatibility between different base boards by virtue of the pinouts
being the same but obviously there will be some variation in the
specifics (and even where that exists it may not be enough to be visible
at the DT level for the most part).  That said there will doubtless be
some plug in modules that want to rely on the specifics of a given base
board rather than remain compatible with general users of the interface.

--16g62bNiOXHZyjZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXe3B2AAoJECTWi3JdVIfQ+e0H/2kaN1DHfEa1BPMPmuMRjtnt
WHbX7eA28turg1rpwW+yQazaMTyQre8rBo4TC1jCNaABnxeK3tcUJA7XkcrQRhJ1
Y5zUbq9yDn31wlN2G1DaSLSEGN1I/yr3EGRReEh3IQjMBI5Bq5VHlX5myG3UDeNy
syuwh8mINgdSmImdYJ7QZZoZ7RH7/Y1I3+Tx1lUVeAYsJah5Sg9I4bCs2LCYTWME
VCwH5ZMIbekhHasvADV4baHVLP1yxlf2HA/4O9m6/Xu239jQ47l2OwKbQpE+S2Pd
o57A4ynxJXklteDvKEVFwSyD6Fe9eaPuzN6Yxw1aONWmKvqre/dr1R73bcRBdJs=
=VMg8
-----END PGP SIGNATURE-----

--16g62bNiOXHZyjZa--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
