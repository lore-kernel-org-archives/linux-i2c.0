From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: reduce parent checking to a NOOP in non-I2C_MUX case
Date: Wed, 7 Aug 2013 16:54:36 +0200
Message-ID: <20130807145436.GE2978@katana>
References: <1372233395-13663-1-git-send-email-phil.carmody@partner.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372233395-13663-1-git-send-email-phil.carmody-GrGkmOP51GdLN7c7dRTbYkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Carmody <phil.carmody-GrGkmOP51GdLN7c7dRTbYkEOCMrvLtNR@public.gmane.org>
Cc: ml.lawnick-Mmb7MZpHnFY@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 10:56:35AM +0300, Phil Carmody wrote:
> In 0826374 - i2c: Multiplexed I2C bus core support
> core i2c code increased in size and complexity even when I2C_MUX
> wasn't selected.
>=20
> Turning this check into a constant NULL in the n case lets the
> client functions in be simplified too, not needing to include
> never-called calls to the mux-specific helpers.
>=20
> Signed-off-by: Phil Carmody <phil.carmody-GrGkmOP51GdLN7c7dRTbYkEOCMrvLtNR@public.gmane.org>

Not my favourite style to have #endif in the code block, but good
enough. Applied to for-next, thanks!

> ---
>  include/linux/i2c.h |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index e988fa9..b3c4b8d 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -447,11 +447,13 @@ static inline void i2c_set_adapdata(struct i2c_adap=
ter *dev, void *data)
>  static inline struct i2c_adapter *
>  i2c_parent_is_i2c_adapter(const struct i2c_adapter *adapter)
>  {
> +#if IS_ENABLED(I2C_MUX)
>  	struct device *parent =3D adapter->dev.parent;
> =20
>  	if (parent !=3D NULL && parent->type =3D=3D &i2c_adapter_type)
>  		return to_i2c_adapter(parent);
>  	else
> +#endif
>  		return NULL;
>  }
> =20
> --=20
> 1.7.9.5
>=20

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSAl+sAAoJEBQN5MwUoCm2tPkP/jv2q5LIg0HNnEaIeLVpky4X
3vKRq5c3b392/HzgmYqgpXyfDJ0gy+uZM/I3PouVAwRsWdNH1Io2cAquthl8vgIo
wBayGOcoybhbTnTSvDmgWbe8CaZmmrL/6GaIr/EDn5Ge4bLTQ/28gvJEUtbq+MIN
8ZomzceFIQY4fiqTWQwtFpDL7M/QBrANUqamUwgJYIwKDX2val4RULFQlSsC2vL+
9rFnzecOP56hLcs2aUqyLBfpkV7hNd3LQ3Gp/OOFh+pcHzJ8WnHKKbe3CKDInW/t
th9C5zww9ZqY9wjdrcftwyJlw9yKZ7An5SVUN/5i5R6fpcTMW/uLQpLQKY/wIFQK
LnQzRs16JKNjYn6bY4nbn5XAo10rS9wD0qLxHrDB62iH7knKc/o96kFs43eGDkT/
aTQ4ZHI39KCEdNLHRYWpyLRVsBnSmCfrw/hmoCOIiwkORf/9kRrUroZsgMjMO+3u
EBaOoN5IcdDxeotkWd8S8iJqmcXs5nvlwUs/R7vGdLwGMGe0QwDLcOgLT/ZdG+AO
cbwWY0jvfy6OZvV9e8wr57x5/Sq0NuSwzgwPwc++vYIfno/zjlDjdwLBzEl15b3Q
RhtdCg9A6fooUadou7w5hlx2208SJWL54gUJ6+C86nkzQQm7WYCdLdjwQj/NZt5K
mLUKC42biibPvv9+eSqz
=mCaB
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
