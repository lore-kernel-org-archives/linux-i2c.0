From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH resend] i2c: rcar: fixup rcar type naming
Date: Wed, 30 Oct 2013 17:11:26 +0100
Message-ID: <20131030161126.GG3663@katana>
References: <87ob75zgn2.wl%kuninori.morimoto.gx@renesas.com>
 <87ppqzaw37.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ppqzaw37.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2013 at 01:04:32AM -0700, Kuninori Morimoto wrote:
> b720423a2627f045133bec39a31fe2bc0dab86f3
> (i2c: rcar: add rcar-H2 support)
> added R-Car H2 support on i2c-rcar.
>=20
> The R-Car I2C type is based on SoC generation
> (Gen1 =3D E1/M1/H1, Gen2 =3D E2/M2/H2),
> but added naming was H1/H2 instead of Gen1/Gen2.
> Gen1/Gen2 is better naming on this driver.

I'd prefer to not change the code, but rather add comments after the
enum types saying this enum applies to the whole generation... Drivers
often start with specific naming. And while things turn out to be more
generic later, IMO it is not worth to keep the naming in sync with
ip-core namings.

>  static struct platform_device_id rcar_i2c_id_table[] =3D {
> -	{ "i2c-rcar",		I2C_RCAR_H1 },
> -	{ "i2c-rcar_h1",	I2C_RCAR_H1 },
> -	{ "i2c-rcar_h2",	I2C_RCAR_H2 },
> +	{ "i2c-rcar",		I2C_RCAR_GEN1 },
> +	{ "i2c-rcar_gen1",	I2C_RCAR_GEN1 },
> +	{ "i2c-rcar_gen2",	I2C_RCAR_GEN2 },
>  	{},

Renaming the platform_device_ids will cause regressions, too!


--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJScS+uAAoJEBQN5MwUoCm2pJwQAIr6cEbLmq8fMOzZryYGqJIz
HFQFC0Peb8bkIy7iNMS9aJrAjlOz3y/+2q3ui1WJiTX10LKyoCg0INOxN45yQw0P
eerjjgthorCvU+6icdBBpqPMlRr3D39vQcW5kkkYV+5WP7RlEwab7PB8h0/wxXtc
LLXYAZvbvy0KmL/zRKTgMZbOa8kHx1w2GmK6G4KuDgk1gZ+VmlH1PKm9NLkuUXqS
zPT1MLJ8tNBOorSDU+4xCmue/AyWuSv8gpsavGbJwsNxPB1nklme/9xJyeT3NfY0
7sMhu1eSleqhOgStaIIjCo2JXCMtF5l1lXifG5CVouCDrCt55lq/IXbEfWw6ENFG
STg3iM/Fhpsrs/kaFThHrhFOhS0RhYltEBE5FkmMrwxT0PvsCWtLQZY+eWHeuERH
3noXmgytRRLctt1A9x0Z+Pg2PfThyT478P7ZOHuzBrvaMB5eTWkoov8R3reazzip
+cC5HRNHatf7HM2vn+p9Dk5TRGxCTCrW3nioPdtjyOURpzSNTr9U20FFF/VCQBFd
fioqULdvfpMT7swBpdcxB3j528T3qYydd7PWQ/dCk/z5t27oe5/OvkZezb2y4EMK
KDP7NkWRY5EIEN/VRFQANmAVLWy1n61fCcfSXInwguPlMe8yjTVF3CUDC/3+EPG8
nb80VU8ciIuJr3Gbe2U9
=ku1J
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
