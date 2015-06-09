From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 4/6] i2c: at91: add support for new alternative
 command mode
Date: Wed, 10 Jun 2015 07:19:37 +0900
Message-ID: <20150609221936.GB1717@katana>
References: <cover.1433348016.git.cyrille.pitchen@atmel.com>
 <ad5348072752e523b4c677a1a986c142af716b19.1433348016.git.cyrille.pitchen@atmel.com>
 <55770F43.7050707@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55770F43.7050707-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nicolas,

> > +static struct at91_twi_pdata at91sama5d2_config =3D {
>=20
> No, please name it:
>=20
> "sama5d2_config"

Thanks for your input, but please don't quote the whole mail for those
tiny comments. Only the relevant parts, please. Otherwise it is too easy
to miss things.

Thanks,

   Wolfram


--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVd2Z4AAoJEBQN5MwUoCm2zLwP/3IUFrUV5eVlXXFN0C8IDyhB
153m/8dwwofNJ4eCehpGT/fP59YpdxfYpLgOM6oBkr+Ckqbw73hyxzZLmovp7Vm6
LSg/rIUBZh6U3GzA5m5CyqqxVsY7qAPWBi1rdMHMSVkpTJiVO22DmqZNejEFl5AU
ale9oD653LHnhqtvkHc1lr6sJ4t8d193I18vCJN2P4k63DJRRqtKspkqz/oHwNxF
ZzBNfR41BdQzbeGvUoY7hN3lXwBqSDLabqlAeVCh/FPKcJRGGiYS+RS9WOvtUfw3
wg+BMTKNOADvqnKXEY7nvgW85d/jBjcDRwJCiz6ndXU7O2ibyMJIVkTnfmR0k3t8
D08UDb76CsUJwSYDSzbCvQNZLhEtlsnL72mujEUhNHsVAKOjcvLQcgX6nkslKcLL
ChI57gEfPaviPaWQuVWvSL9+ooCu2RuPc4cSGN2HDh7wOolxZYj+5UMCFhkPUsS6
2UWfNz+yw6fRMUS7ieDJj0U/uI0vc+bK5wxz1n6jea/qQUSPUzQbwb86ChlpHz/c
1AvsF1V67DM3dK7imS4lpSmBvb7o41Rxs9vJS7BbA//xex7dX8Z99yXBLX4xPxk0
t3RTBbUSOhAPxZgu35pKfo7d5Hl3boyJ+eEhrlJlEfYmSiNc57ThtrosAdFpl/5p
7SUreW2FQaER3Fw4qFIv
=22K8
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
