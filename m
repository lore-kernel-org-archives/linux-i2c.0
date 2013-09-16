From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/4 v2] mfd: add STw481x driver
Date: Mon, 16 Sep 2013 18:00:02 +0200
Message-ID: <20130916160001.GC3909@katana>
References: <1379094851-26385-1-git-send-email-linus.walleij@linaro.org>
 <20130916091956.GF3999@lee--X1>
 <20130916104009.GA29403@sirena.org.uk>
 <CACRpkdatiELF3WK9qE_Mgcq3iCgv5w3X22xp1=232JJq9sWggQ@mail.gmail.com>
 <20130916135118.GD29403@sirena.org.uk>
 <20130916152104.GA3909@katana>
 <20130916153414.GN16984@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130916153414.GN16984@lee--X1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wang Shilong <wangshilong1991-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> So in the mean time are you happy with this "dummy" approach?

No. "dummy" is reserved for a dummy device in case an i2c slave needs
more than one address. The proper solution would be if
i2c_sysfs_new_device() could recognize the of_device_ids.


--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSNysBAAoJEBQN5MwUoCm2UmQP/RcwJC5DY9UBKy4fI0DbsmOr
2pAacHsfEvIXsHAsQJTFVX8UyhH9rxtkCxsYZYsKIbUPcc4URhJOTq4QUtFqogM2
IPpUyXzCK7Dct4vdGMZR/lspbQu9sIkG7GtnSUUobsU+hZBrxY+QC5YQxJ0Y+l59
sFZMdQqb7TqGrvTIzkTTLSKfJE0wQE7q3aZqLA+mshDv27P2sJCGV1+KTMGbIlyj
J3OjM5G3xMvRMdhw9BVT0KpNDuGs8Em0UyDYyn/7AKhDaihP8AEWR7fzPkshzZCX
WBlCF7BcckWAVJKYQUJXw7uuYwiZGNKhEK24D7WKZ12NKqrFqrYULQpZ5JrUG88u
ASu0wNt4gg4ZiCk1ApCaQA1ZITUBeRzS27X8CWBDeM8omZdf79AreEWbzrOopvJc
EJId1VBPrYZ7mEoaSGHd191VtD1lH+fPQW1DiSjXUk0P2iwyMW4g7NBfBDbxyXzT
WHen055TqruglMv5Fdk8k1s1nlmsvZGaaeoUUmq6LOt1y1QSDv9m3kz+GjFilCUt
TlZPVLeRw2LcJJc9Ljh/DdkXhcJ6/51pCvu0P9CkSTGaJzkzEfsbWd44dH1WP4T3
WH9PvMABtO19/CcP6wyMdz9kmDboka25Uc7S32Sq+qnYegrelXMaf5yqIe+J5yI6
Nc889XrGEMDsT0Gcstam
=u3Y7
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
