From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 0/9] Unify i2c_mux_add_adapter error reporting
Date: Mon, 3 Apr 2017 12:27:23 +0200
Message-ID: <20170403102722.GB2750@katana>
References: <1491208718-32068-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491208718-32068-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 10:38:29AM +0200, Peter Rosin wrote:
> Hi!
>=20
> Many users of the i2c_mux_add_adapter interface log a message
> on failure, but the function already logs such a message. One
> or two of those users actually add more information than already
> provided by the central failure message.
>=20
> So, first fix the central error reporting to provide as much
> information as any current user, and then remove the surplus
> error reporting at the call sites.

Yes, I like.

Reviewed-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY4iOKAAoJEBQN5MwUoCm2wg0P/3JCuM7Z98JlCLi1IsO64z+z
mR+FRXYt+yHhH+RRNxJyCSD8O4nf/EietPa0WofCtLJ3c2ARZ0CWKqGcn1qngdY6
sbIW4C0L4Q7xiPp0UblgiUDCMCtCRe+FXEMVyLR6577uTGA4LkK4JoIhjgO4KGTF
4hwXyzBmQb/jgU4oQ6PrVFy5WqM1Xe4hFUoO0FyAvdNDcbsa4F9Ro7MreZjGXa8I
fsrATdx+Mlgp4gB9iN5JTKP1dOMmv5a3HeM+KuG6bHuP40Li3RwCZUNlK52S/oDQ
hvMshqK43PJPlvpq/GperEe8m0N1j6WfeGfPzwmEvhXsmAsYGS2kl8fcplcryG4t
A+Q0ivfRD2D/x9ElHI9VUnqXi+RrtXJeJd7o9sVKTbQz5xowwIRwHyF9YmA7BE0U
7PzazArDZBxDLK+jxCBq5NchLSf6E1OETBy+tlE0dk/wwUf84hiF/fXkbAEceNlI
i2KM27EOilE4Mt4nScUycw92vEZN9h0uVrcvIAjyzle1GxDNe8rVTowf7YFPVRkN
rVVhJrfdOhB43FBgvPaY5TZXTrFQhcPlgjMLSI8ZurU9CGcLrcEK8EYnUIFDLVuQ
KX+ybgdJo1/LybV7dWKYB6fd0PqVB7S+7zynXP5l+ukAXRmgCDcwuaziQJgcrmF9
M+9wQ6P9OnJG+Qd/VBW6
=/LhN
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
