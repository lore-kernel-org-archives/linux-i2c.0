From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: exynos5: Use reinit_completion instead of
 INIT_COMPLETION
Date: Tue, 5 Nov 2013 12:24:09 +0100
Message-ID: <20131105112409.GA2926@katana>
References: <1383643630-5036-1-git-send-email-sachin.kamat@linaro.org>
 <20131105101055.GA2660@katana>
 <CAK9yfHwv3T6OXO59b+VeFHLU6mxn1Gw+BotOBLUukHuArZ0qig@mail.gmail.com>
 <20131105105606.GB2660@katana>
 <CAK9yfHyf94oTyJRRYtAiaty=AYiPXf+RQTnqdW4-q=zbvwsdtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK9yfHyf94oTyJRRYtAiaty=AYiPXf+RQTnqdW4-q=zbvwsdtA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > sed will find them all.
>=20
> Yes, that would do. However, since I have already found and fixed
> this, wouldn't it save
> some time and effort for Andrew if he simply applies this?

Nope, running sed with git commit -a is the same effort regardless how
many hits it produces. And it is much cleaner to just have one patch.


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSeNVZAAoJEBQN5MwUoCm2GkcP/2e3TRJ7uRwvVWSn3LjyF1CV
F7P7pcpV97PSMZJ/PURcPqE7gngwPMakHeLeLvX+2IOTg6QA+87niExd1PxYJqsk
Si6J2TwJ3hPwaXdUx4dIAWYCUsGu7V36p2T9RKWIonhp9SzpfTa1T7uYTtWZ3uEY
F1xMa/ADfuCr9PCU788YZRFsZ1IU6IGNa7WBj0ktknWOPHwoP5+rHp8DfIyo42j3
ylCFCXuq2ZQu6GCWfwVFgFi2KhNWtnhlvAqYd3eRnz/YHKzfWNfzIOS63ebsOpd0
YiGfpjwAyEWvpy497T3wfpWK0HswtOEfRGnwxQkhFaoFXOR6YTeIsYij2jlM6oRS
eIcL0kOvsvIzamdM/MDIN84GfEIXG6jnueerhmK/Di+PGLWQiJTngZ+G3wEJoDKs
dIFtYWlLJ0gcRng8YJlpAMvMPccDdtGtIVhENqfUk0dRfUmSs9Vo5rEVP4o5d2BJ
xs5zDNCWjpv8etM8wkyaSw1vA9ddY26GYQrQ/3pkKZBxlkg0Xf0PIP8bnkBDZCj1
au/6+zLRRvk9iNX11wK+hk7hATy4hN3z+Fl/52VfbORdwMkz9kpVLyECM/QFmlVB
nBeoN7wnMKQBDENcRnohUQoQeT/cAeDMW5kiOpuTcohsFQ1efC6d3RY+2oGmn+Yn
dkr4D/THgX+VLqCy4tgR
=HpwB
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
