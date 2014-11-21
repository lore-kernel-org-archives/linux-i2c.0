From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: at91: enable probe deferring on dma channel
 request
Date: Fri, 21 Nov 2014 19:08:05 +0100
Message-ID: <20141121180805.GC3754@katana>
References: <1416577472-24542-1-git-send-email-ludovic.desroches@atmel.com>
 <1416577472-24542-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416577472-24542-2-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2014 at 02:44:32PM +0100, Ludovic Desroches wrote:
> If dma controller is not probed, defer i2c probe.
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUb3+FAAoJEBQN5MwUoCm2RW4P/21oC19NbJgR31DV4W1ujM6I
v3fh68NRdZczBmgeycA20ZQ7u8bF67TfhkpPudv3jJdgvtih2564GnXuy+xaVE1M
9TcRHYarh9OT+EfavJHp1yHaYTdFHcu9X5JnuSIfa1WNjvNo2HaBiV6G+zTuetVC
hNPLdLSbY5VWVkeB3X4y9+HXwKQNSF3whuFR2ARyAz4Nzt9ZAebxm6kTyjp1n7oD
LHTWJJ8JLPylWJs01bRyqVUXMqJ1LypuCLd9FjTi+Z81nu+eVkY+Us8+073QxMg9
ybVoNm+OhA7MRtc/VTBAXlXIdL48kvb9dyqyxmD0+kHrfTAtVFyLi3Wo3HMb7ReR
0+tkM7OQnfE2YyTALLnyjSiXIilFyhdNM5JnSJPeTE29IELK4JAeXUXqtg2rBIG1
Z3JTX1T/tx+rHKvgXjjENhOdz/5jlXiRhJ7HvdURlrNsi/tuIvJDH1DMr4yru/re
KG3vyXzM6PM8nbdE9Qnh04YiRdxKONwseOmrno49QK3+TMpFgr4+iKfLChrmVO4Q
GEmyCV++5bEzcPJSTsBnag+9sWSU6Kj40usiPE4wMzvTMRmIRH1+ealX7vaJlN36
hxTb4ndAK9WSH/Jgb5FRHOKfYeT/6ce3I8dMQPm2sMtAXhHBXVYunUCL8wG8FJhD
1q3/JG9Lg9Sjp/NGE86G
=0eUg
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
