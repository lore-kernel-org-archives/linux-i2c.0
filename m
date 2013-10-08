From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND]
 i2c: designware: use module_platform_driver)
Date: Tue, 8 Oct 2013 07:26:24 +0200
Message-ID: <20131008052623.GA2833@katana>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
 <20130828095706.GH4086@katana>
 <CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
 <CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
 <20130830054858.GR7656@atomide.com>
 <CAMj5BkiDExikXi3JcVhO7RN8_82eGYhq3i6oPf5Wbipy=N+iHQ@mail.gmail.com>
 <20130830082712.GT7656@atomide.com>
 <CAMj5BkgqBCh0316NmoP_XMXvJTVQxxvUvs63wZfS_TvNLdqAfg@mail.gmail.com>
 <CAMj5Bki+BS=3sWCRdrDOEKpt6Bj+4vm0zKCJ4YBAudcqbAZySw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMj5Bki+BS=3sWCRdrDOEKpt6Bj+4vm0zKCJ4YBAudcqbAZySw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Any plan about the patch?

I am right now working on a patch series dealing with this.


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSU5d/AAoJEBQN5MwUoCm2JWEP/RLbjLCafjT2kCKD5tFHcfGZ
b4X42GlK1yv0ZaAF+sJroKSwQCGa9wlKis9YfpNcD0xmjAqiZDE/1Z4Whays6nYH
+l+6l5lcBPaP9tgaoKsuANVkE/HQB49uOFZqzg7PTwxcngM3mlz9enkcm4n2H3d3
nx+USZHQ2oTz/A05bBkZVHYY36m70Ew8v1kDgaD66eOBoO6Z2+0qvpXZ9T2C7CMI
I4lVlSiYq/MKnc/NY/kH+7ka7XUCNMgahOY/UhBq/ad6207D3NiNkizaqQ6aQPn2
9kq2HzrFNFpkdYj0KPRxQb/t7Gy+UeX3CsbK5ed16dfq8z7Y6UtAeywDZaH2/hCh
rxbM+oPFYTOfNa8/12oOgHPSNcpZz/TL3pDR44DEB9BOxghVJ8RTTNjnvbhpxHxt
Op0BIlqqIF96723VJ2p/NCVkX9O1oRO2jpF4trJ+lC48Coj2VlchsoJ2PYo9FJs9
R4e5coyUgehaS1NV3I7rUCdR+0PA5rTdZDPu+7E9Ct7tvq8FSlwSgJJOCmWoy/X5
KHYMy0Pn1acdNcHmdIOlK50pg27GyXqEVna+0rYyEHyEIbb2JnakN3Wr7kg+qwXi
dXAu3qoA/wIm4DnYrzmCUx3iz85Nq3KVdgpplmkH4g7bFN9fmncx/yWUAdVUqp8m
+tIGWAVU96RScO+nwy48
=X4rU
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
