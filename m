From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V3 11/17] i2c: nomadik: Convert to devm functions
Date: Tue, 18 Feb 2014 19:43:27 +0100
Message-ID: <20140218184327.GF18768@katana>
References: <1392650418-14820-1-git-send-email-ulf.hansson@linaro.org>
 <20140218110109.GA18768@katana>
 <CAPDyKFpRaAAer00dqcXR-qOT9S8-SDTnaMUHRwWCZ93w-wnTDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zs/RYxT/hKAHzkfQ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpRaAAer00dqcXR-qOT9S8-SDTnaMUHRwWCZ93w-wnTDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Zs/RYxT/hKAHzkfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I added the IS_ERR, check as you suggested. That caused a rebase of
> the other patches as well.
>=20
> Sorry if it was unclear.

No problem. I am about to apply all patches except 17 as you suggested.
It fails here, however, although I applied Linus' patch first. What
exactly is your base? Any chance to publish your branch?


--Zs/RYxT/hKAHzkfQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTA6nPAAoJEBQN5MwUoCm2CnIP/1ecVdlRfY2EI5IUp5DMRDu5
H6cWSp2QnZgNwUM4aIeFAjPnwMdwWkY5J4PkVla5p8vre3T9AJ6OPJpzTTVu2YtI
GgNABcsUkL+u0U57GO/3Yz4kiAm0vYB0wlf87opYG78DeSa36wZxSLBbt4Gr4u7O
5UOa9hMBKFFYVgW1jcAOkCcmQt0qetRg7W+1rj2DpC/Qqp1UIZRxZFwqQdRKj1r4
UiOivWnStwKgeYe8YvjGqG44TExPHfujQHIN2CIuz2ITAxnGRIlXf39QbBq374PS
1RfN40/8tw/HuuqjJ1vJNuocXHnjwmyrG9bXLsSlcUiVqnyO29gMyOVEhqP41QI5
o1GkuWIecRB4fsP73Pr9c7C2k5MtfR4YyIFhPz/UwqcNv2M5j1dEOwG/7MS2rbaC
TBKgE135mlH1m//waMwVNgaghBf4g6JEsHkeaZmNnV/NDaUlKCbOt/duWhJoQ3tr
3YeEmFGPTlckqBmv9I2nPryhOCK7EUabguwnUlLhdWJAts9w1AEV8KuemnPFMbKM
YLKv5dWQKgXmmU2DyT5blEOtawOTGdwn/zVlABG6pR3Wj3yHOVAD3MlaxFx6rq/l
i3iaTQxWqR+UcXbhh9O/X3ML9b/TNEQll87YK9289y7BKAxTuVcd2EYWB+C4zzFM
XtVgCePC/lL83bl5sJXs
=Xtxd
-----END PGP SIGNATURE-----

--Zs/RYxT/hKAHzkfQ--
