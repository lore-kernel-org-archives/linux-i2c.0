From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH] i2c: use parent adapter quirks in mux
Date: Wed, 17 Jun 2015 14:36:59 +0200
Message-ID: <20150617123659.GD13393@katana>
References: <557AD36C.6080805@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <557AD36C.6080805-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Lawnick, Michael (Nokia - DE/Ulm)" <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, =?utf-8?Q?=C5=81ukasz?= Gemborowski <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2015 at 02:41:16PM +0200, Alexander Sverdlin wrote:
> Inherit parent adapter quirks in MUX in case the devices on the multiplex=
ed
> buses are interested in the adapter limitations.
>=20
> Signed-off-by: =C5=81ukasz Gemborowski <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Applied to for-next with stable added, thanks!


--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgWnrAAoJEBQN5MwUoCm2AkMP/RA9i2TCM/JGaatDrT8jsg5h
dGOeFwopqeFS9n0amZ1KgwGSaw9+ibiU5tmFVKpwg7YFMv4Lu98o+w1W1kd8isDe
MtfkP67qZbUUNbsL6kHTp5bGBFwCePX0M1Shyb2mvnCsOe61TEL+4KW4FhOpFW9T
yHegicSR33fzz2zRNz1efrGmcXUFjqTgonbObVYfAKH06QVMJY0SU1DnyMLkPXCu
Vof4G3NP6gpuOLnzIfIP4c2b7et+AbC5CBbfGdvo1jR1JukLfRUwenFH/f++xJHE
IG7vvl7abXSafwnzTVtN/d6W2Ql6tlmFT2m++ikbuxWXlII9PIrkRwFqoACtE2Sy
iAAPKVkez9dR3Pm+N3UMKJM6fhJQLfR1dc/6jTOXLDrsMoQwIz+2q4NUnpMD9BY/
aWSLY6ED9ZKGtTX5CZeOh1K5daFv34WoYE04mxeSYIGL45G9rS8zdT37MtZHFM0e
oAG1640+FuynKmiEjIzxnl7+RTDQ0NTINq7yXfvMowOYAKK5YjY2syyTpZBIcOGk
wuFb0yy6Ie+u4nKe4UAhYizgeXRyR0EJ8NS3NDcwzZqlMbMXJmhGkZ4yUWqGmgLO
lqT/nKq9meH5+qFqi1cmco9v6esKGAn4TYMEVkQ6Uq8/sKk8YIjyZ+I7IMIDNwXa
fnG1b5RlyAF1/77gKzQ7
=8P5s
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
