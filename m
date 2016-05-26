From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 5/5] i2c: demux: Use changeset helpers for clarity
Date: Thu, 26 May 2016 20:58:24 +0200
Message-ID: <20160526185823.GF1614@katana>
References: <1463416888-22044-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1463416888-22044-6-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463416888-22044-6-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 16, 2016 at 07:41:28PM +0300, Pantelis Antoniou wrote:
> The changeset helpers are easier to use, use them instead of
> using the static property.
>=20
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>

If you think this is worthwhile, then it's fine with me :)

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

> +				adap_np, "status", "okay");

"ok" would be shorter?


--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXR0dPAAoJEBQN5MwUoCm2WyoP/3AVJYo8d6qmHzGhGsVq6hYC
wqumWvZLdL+7EPQLtPpLOYeWLvz23UYqO7tiFs9o+5FRmcFj8cD7E55Cy3lW4zDS
WDHYkEBzfkXRfxTdKglJFynjIzHo/WKtu+Ai1ZGEfe/7M2ct4Rx1ApdZmjpaTiGK
6cYZ8KKOT5P9/uOz1DrgsedIvLrgRw0kgUH/PNSxxPGFTEFuIODXRQEUGqQf8V28
OmVAfutktIDhK/mSdNGfa5pTij5K9ggxYIY6lWoB6wv5XeIDk5gZvOMc3NrAmBQD
b88lrcR4mIC94Ilr6PlfgzOu7ZxCUPQYJC62mBCmPcOZg4UGzAG8qyh7EhcjTpPW
S4CpAzY9Jo0p20QsaAwZFncZuJy/pcoUOmaffq447xFzxxeuWWeSyld5eZFsgEGI
3IRoB0cIfEGhGsoAysp6e8tGYe0EMdFA8iOyZprW2T718VOJGCfri2E6HAaD3M0l
j5xH4YUESyaPXXBK/95aLMjjRHBY3uSx09dgS1+jL6knn6NAbOSfTD8juDEMEAyC
X+KRX77h4Aur/cF2o/rc2a7KU9doiEqPg+TooWk4RZPEUTOiJWzfffsgJvP+lfPW
ed2+MonR08up+EHdrlI0RpOWOzCs7SzkhGLj0SjG9iILpdoba4XBIEbOB9QNz++l
LbZv1+RJ+d2embhwmIEp
=l1hH
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
