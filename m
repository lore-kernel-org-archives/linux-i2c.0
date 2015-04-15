From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c-davinci build failure with Linux v4.0-3843-gbb0fd7ab0986
Date: Wed, 15 Apr 2015 21:07:57 +0200
Message-ID: <20150415190757.GD1125@katana>
References: <CA+5PVA7Fzw4m1qqj2nHCzP4JJFZnis-6=kQehAbt0a-RJiF73A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+5PVA7Fzw4m1qqj2nHCzP4JJFZnis-6=kQehAbt0a-RJiF73A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Josh Boyer <jwboyer-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2015 at 12:33:57PM -0400, Josh Boyer wrote:
> Hi All,
>=20
> The i2c-davinci driver failed to build as a module with Linus' latest
> tree as of this morning.  The error was:
>=20
> ERROR: "i2c_generic_gpio_recovery" [drivers/i2c/busses/i2c-davinci.ko]
> undefined!
> ERROR: "i2c_generic_scl_recovery" [drivers/i2c/busses/i2c-davinci.ko] und=
efined!
> ERROR: "i2c_recover_bus" [drivers/i2c/busses/i2c-davinci.ko] undefined!
> scripts/Makefile.modpost:90: recipe for target '__modpost' failed
>=20
> It looks like commit 2e65676f710e (i2c: davinci: use bus recovery
> infrastructure) likely introduced this error.  None of the i2c bus
> recovery functions are exported from i2c-core.c that I can tell.
>=20
> Was this commit tested as a modular build?

How embarassing. I meanwhile rely on the build-bots to do module
testing, but this failed here :( A patch was sent to -next a second ago
and I will send a pull-request to Linus ASAP. Thanks for the report!


--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLrcMAAoJEBQN5MwUoCm2hAgP/0yDQxda5qZ9XC+6HyEeOpFE
PeU70ICYtOxxevur5HPa2KcllArz/K5nAADa4q+v5p2UNPE0JQqKy9zP+goiBtPJ
1gxbsNHuzwwPHx5+gN5EEEbPJlcQCH6wJArwroIdLZJpzsu6XzEtkwIAm3odYypr
bWjm5pnexIGpxI0/bvDDtf4kjF1hVkTckJMbBCVKCX3DhKjTTn/9SMtRWq5LkHj6
yjc4EZ+XBfQTdBCT5yxY1k9C3BkYQ0GjT3sJ27KJniJexabdxZ055GFYrYgfiloV
ReFZ1g/oHZLzuDe/Hbl35hMi1nYAFwRA7xMA4cFEgQXJFja7N1Z7KFEfVJuK3jNj
yNarTCjMovwxohH0rBxDLFJ3RpBYBtcXhDYxPNk3H8I8PEz08gXX1aZiJz+aT96H
SWIa5BQ9QzoHx9e8dEBuRHv0S2cvAKId993ztIPDYB46BZLNye5t22dmvlNY+msf
btX+En4lHfnYsNgmBj3hw0nUNwKtzCVCYaC3m1UAKHFOoMgXCmJykTIfZONpY0fg
nD36oMGgiTe79rygr2njZpZ3zp87Gr4xmJ3FwJjNws9+Wum7MHcDMvjL46GQVugT
/5Ovsg0vr7TNtZC4LkYaC/C+4VnHD0EBsSx17EMq2lHo4Yrv0+7cqY3bqP4qhh1u
00sGRHoVBVySc+P8KZTw
=ExNM
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
