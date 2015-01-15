From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Thu, 15 Jan 2015 18:35:29 +0100
Message-ID: <20150115173529.GB6342@katana>
References: <1421339635-16039-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421339635-16039-1-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2015 at 06:33:55PM +0200, Pantelis Antoniou wrote:
> Mark (and unmark) device nodes with the POPULATE flag as appropriate.
> This is required to avoid multi probing when using I2C and device
> overlays containing a mux.
> This patch is also more careful with the release of the adapter device
> which caused a deadlock with muxes.
>=20
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>

Applied to for-current, thanks!


--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt/phAAoJEBQN5MwUoCm24w0P/0+Xby0Mz5k7tK9vL/LzgtkU
NV81emFIXFbxDxO8b5Rq8TX3KHCMxdrG80wEQtPN9S3U+61BZnny5RWfFLlq6fGZ
fQgnOrAIK7/02dswlWSmVVjFM8G7EkrIH2OQ+kbLSr6cPa4+9y+Kj9khSvL4nAm7
xcE9fZcYDwufFv3f6v8ubZ9KCjv9rZvXGu5IKI/PhS5gSVwU5do4cl0V7mD7y6u8
Lajr2hgVyCL2v+VQdSDl+YIPr9JAD7+ld7Gj7C1FNdY1roK+10qvHi/U3yRvqEM5
ghwKoHU8JbU9sLabr7ifEFOzUvJ3YWOlOJ/pbPQYuSKaCpa6ipNnUrK8kdPgLk7p
Xh/Qo/rll4n/775UlDUafe22Ojnv4Rjnl1e4QnbM5DWIbF7X+Eug/JBlEbAoG5eI
VDnmHqTdGZhMU/kPGWxzbwPZ8h9nMGDApbOPRntNpa8kBf5ilxNbpWeWldhGGK+8
YGR/f44460zaqdp17FWsUaLfnFK3qZpw9P2Z0ZeESaNEtuxyQmft0ED4FLts7zEO
XUvq2gVRub5R9FQ0PzWlEDh7CDW7IYmDNu4ksFZIEYJpwgOW9SkRxvrgvXjGllgu
J9WDhZn75aHubX2B9dc80EPE3hk6mzsgYQ4zQE6qECRHav5opeNrKjXPHYMI4hG3
ouqbUGF4ltmRuQ94EgR8
=1b1a
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
