From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH-v4 06/11] i2c:pxa: Use devm_ variants in probe function
Date: Tue, 14 Jul 2015 13:45:49 +0200
Message-ID: <20150714114549.GF1517@katana>
References: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436859410-28878-7-git-send-email-vaibhav.hiremath@linaro.org>
 <20150714113556.GE1517@katana>
 <55A4F509.6010009@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55A4F509.6010009-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> So this additional error message would print one of, -EINVAL, -EBUSY
> or -ENOMEM.

The driver core can report this; dunno from head if it is verbose output
or not.


--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVpPZtAAoJEBQN5MwUoCm2dagP/ArgBCNIf9GvDHahmq4Rd/Sl
XYRGoNny9N42RydBVRjEErF6Qinr6c4Xq9m6ITOu5v9lXlvsAk9ik1DImQPx6KeA
C6qnEv3xc0Z4l9R5JIA+kJl9HJwXBMabx/atHXWZ73KoYXiUDzyyy8qwaXyJRNPl
/gVvRZuoX5iQy2+o09vesRdDfxofj4FNa8sipG6fnLrkTBf8iPmQyzfBjn+i208+
TaHnCkHlsHgjEEaAXLEPeXtvy3fr0Z+xuVS/3oVA0NJczpeeroICL3k1Ld4UhIOb
g/v2XFLlhTKHN5HBW8uKDDCa4ztKBnkGfJwCmgtrU6zJp3DWRHX1U+zn/t70XEDx
WFdwtits/Mr5J6xprtTylQqyZMTxtZhJcWWdt9JhkcnCbql200uCCpC+IH4eKyDI
Os+2gXZCz+C5Q5kTKQlxHbI3or9sRYbKCyMGkQZN3aTHbzZ7Mztov3uoUMvPivVC
WhnV83Hy8Xy6XMjRNuBvKs8AwWk/abFQO3cVm1rOtis045XB4+uTWQu26zQRw0S1
P5WoD+zyvauQXNbzO0qazNrVjHEWau0EyVSy/AQf2BBbcLzJ6E8YYX6KBFJTuGp5
Jl8Od0VEIwHbaJnbtmx636LIqvv5zJFMi5GXjSCTlZ0BAfXJO4BvEzxpDfWWrgy0
PHSmS58AlNhLJWKQghkt
=voQP
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
