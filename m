From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 3/4] i2c-i801: Check if interrupts are disabled
Date: Tue, 11 Nov 2014 21:13:48 +0100
Message-ID: <20141111201348.GA6443@katana>
References: <20141110222655.13660613@endymion.delvare>
 <20141110223139.02aafde4@endymion.delvare>
 <20141111105853.GB3794@katana>
 <20141111153214.39dfaeb8@endymion.delvare>
 <20141111144107.GA1330@katana>
 <20141111210646.02b77c68@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141111210646.02b77c68-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > If this is not the case, then it might be better to be less intrusive,
> > spit the warning, and wait for somebody to show up with this message in
> > the logs.
>=20
> That was my intent, yes. We can always add an action later when we
> understand the situation better. If we ever get such a report, which
> might in fact never happen.

Let's do it then!


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUYm38AAoJEBQN5MwUoCm2zmQQAIIrcOGkC6vYOped3e/S41Ad
oqRlyg40+5Y1IVFxFMAO/a+WOQQGgnMPr4eia8sovDh8gcMa+uymKN4GK9CCfoZ8
Mrfs5jzI1rXWj35hLYfy4L8Ty2qYxwa5S7wgzEcjObGdIHNu7AiU8ub9yPHg670u
PhSWS+u2UZ8G20VdRvTinAAwzjfFKwa/GrhEU7aOgGuRQmxsx0Luconr3cyGVbFn
vNFODkpYpYZWY998hW/tKUVcDhiPWAxVgPCMYg6LLr/VbjGCFP0za53MPLQbp+Eb
zjisuCWMP3BgD6XFNBWcucKhsgx1frXSg6DxKRcxGMxuvhypj7mbEkmtdFVGCgRu
efteg84ww3H1HNsZjgs8gt4YHeRyWqSuoe+KyOTCkCPwChA1NHZyFtTqN8BPPFL3
hV03kAAK2ZI72Wk/+5o/be3792OW62I1U33Bv83OzwGasD4i7weAsUdUtwcJERu7
vuZ+w9oQ6WTPOPv+2I4oUT6BAdAhrkYJpDioZcIfQCLR80nz9v1vZnBG+ixlBrgq
pk41EqG6VTFj/tH3W76Go5QnJKlToYAMCxVwJ1K4au2Kws3YJIUe/51Nmxc20eRu
fJvg6P3KaE2givdLuGKGv6ZtUh8dPlVt5Eo2qwBjGNrC2tWUmhjFotm0UyS89AB+
mj3FZupTx4T25b6phcCD
=Hh6m
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
