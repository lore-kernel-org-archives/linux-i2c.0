From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Wed, 10 Jun 2015 14:40:35 +0900
Message-ID: <20150610054034.GB1573@katana>
References: <1422083789-18905-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150422074019.GA1511@katana>
 <CAMAWPa-HMhJK9UzwfaMPe-MO=4mzjvC=nRwPX-pbab_fb3YZ9A@mail.gmail.com>
 <20150506183733.GA1513@katana>
 <A4E060DB-2799-4BF5-9CA6-DE53B7DF9A30@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <A4E060DB-2799-4BF5-9CA6-DE53B7DF9A30-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >>>> Mark (and unmark) device nodes with the POPULATE flag as appropriate.
> >>>> This is required to avoid multi probing when using I2C and device
> >>>> overlays containing a mux.
> >>>> This patch is also more careful with the release of the adapter devi=
ce
> >>>> which caused a deadlock with muxes, and does not break the build
> >>>> on !OF since the node flag accessors are not defined then.
> >>>>=20
> >>>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> >>>=20
> >>> Now, that the dependency is upstream: applied to for-current, thanks!
> >>=20
> >> I'm not seeing this in linux-next, or in your for-current branch.
> >>=20
> >> Was this dropped or superseded by something else?
> >=20
> > I dropped it because it caused a build bug. So, we need another
> > dependency in... I am not sure if this is already in.
> >=20
>=20
> FWIW, I=E2=80=99ve posted the dependency patch already; it=E2=80=99s triv=
ial as you recall.
>=20
> Lets hope it gets picked so that this one can go in.

Is that in now?


--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVd83SAAoJEBQN5MwUoCm2TIwP/iWj4DZ+8kU8Oc1rtewnQ7Hi
wlURUjO6nqxQ4/5uzFGziICC/dX9yfCg9QbI3v8lZTjMhrCmeyFGpI+3aEkiXPLx
DzIPQMH3ED/YD7fO5ZoUYwVXIE2oxPQwDPaIQgAWJPI1+XGODnRoHo3S89m2HXm2
Ih+Q7WNNRN6Bj5a4W0cuIBdlS1v1rZf4ua26VtBb/JPRI6o76VGlyVeRXlW82QiE
JISz+n7CymXiH5NHujp79be9AqjmLsEiQzbYqfV5N/lRLZWcqdpj/JjGN6Jlu01z
HS4UwUXZ1J/uGKXBf6wS5pulYE2Wv1ObfxZQXinNL9VMEJNBoQ+XQCqFGeHFQsdd
3iN/9thl5J3XizKiB40CHXXPZ3eP5F7ek1n7GmoEL1CBOw7rDYXIxI59CN0yR0QV
Ehgp8wyKyWegfuIHGFBrVmpnzJIb2RhUQjhB5g5xyOwDNw4kKR5NMrGP7wxrW9gr
3i7S7yR1SrDUA7QwhCR5LV3VaciXvea91y8mlIERbchIx3yX2JgV+vAnyzuXQ/mZ
19F0rNIILPCezhS5ZZcwnr6w5h7ryAodnPXU0FXQx/F89lwKvNHimcdNpVXYFdb6
PuviCnxlAZQvMUEPX1SNX9KlJszbJABfcNOZxM+QLv6FgY0oA2clm2p/liNjt0JT
5iRKUU3/X+t7Y8RDKlZo
=aqZq
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
