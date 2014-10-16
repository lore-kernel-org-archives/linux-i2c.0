From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] drivers/misc/eeprom/men_eeprod: Introduce MEN Board
 Information EEPROM driver
Date: Thu, 16 Oct 2014 10:58:35 +0200
Message-ID: <20141016085835.GA1273@katana>
References: <cover.1413416105.git.andreas.werner@men.de>
 <d169930cfe45d4c05c79f7dd00471d732441529d.1413416105.git.andreas.werner@men.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d169930cfe45d4c05c79f7dd00471d732441529d.1413416105.git.andreas.werner-csrFAY9JiS4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Werner <andreas.werner-csrFAY9JiS4@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, johannes.thumshirn-csrFAY9JiS4@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2014 at 10:15:08AM +0200, Andreas Werner wrote:
> Added driver to support the MEN Board Information EEPROM.
> The driver exports the production information as read only sysfs
> entries, as well as a user section which is read/write accessible.
>=20
> Tested on PPC QorIQ and Intel Atom E680.
>=20
> Tested-by: Johannes Thumshirn <johannes.thumshirn-csrFAY9JiS4@public.gmane.org>
> Signed-off-by: Andreas Werner <andreas.werner-csrFAY9JiS4@public.gmane.org>

I guess this is just a standard EEPROM with a well defined layout?
Why don't you want to use the standard driver then and parse the thing
in userspace?

Consider how bloated the sysfs-ABI might get if every vendor who uses an
eeprom wants to expose the data this way?

> +struct eeprom_data {
> +	uint8_t eeprod_id;
> +
> +	uint8_t revision[3];
> +	uint32_t serialnr;
> +	uint8_t board_model;
> +	char hw_name[6];
> +
> +	uint8_t reserved;
> +
> +	__be16 prod_date;
> +	__be16 rep_date;
> +
> +	uint8_t reserved2[4];
> +};

And what if the compiler reorders?


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUP4i7AAoJEBQN5MwUoCm2ajYP/jA4GWsaAPyluwHcUWY0oOqI
dhmJeltzXUFnleDM/PhpS9FxFnIZ8Y5clYDDcbEOKlxAj9gTaV4p80oZc+EJevPg
f1EIhOQ00t1TOH7GMBhxqu3RruOCPYPuvlpPDkw8qZbniSi4x4C14VZ7Pex6vNh0
kGW+KC7QuCvnDxgbkyLFrWVIOAkC/9W0agt7afhKqw5N76hMVGolYW3W+bhExzw8
oe6SGrKWOjqmxZqRHom9AaTX8Aqin9/YLYrI96U02DNeNIEZXPbutG1HL2Iz6Q55
poPyS1BDgaaYBukDf7Wfl6ooP91rHUkwWGAMTjTKls2SnMaKsP8wvV1n4MHd/xAE
gTa3QyECN4isWG5TIo4XHRkLVNRIl2PKZT5/mTC8z3ORq+OM2d4dSQsrdfMfrTXH
eoUglKHA0EArk0NSeF7403zCJDnVJ4Uklurs2q3gNCfxzehy4W+HzcdrZShvSMlE
BpYsHgEuvBEstXqgrUSTr31UMDMt6DfYQdSq/fRg0JJ6T5B18y2nLSH+ZzlgB9yx
gOeRlKdrWS5m68KRLfCxPGlmDvpnEy03bxC7n7pMy/bWoUi3XxV73qdfYQVisFR2
zAI9/PExQH/3Jja9VEh90vz2vaGNcwu84eBArVNvHaAT3FT93OkZeJLd56j989+k
Z1eqtDi7MCj2qgSGnNOo
=0lvX
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
