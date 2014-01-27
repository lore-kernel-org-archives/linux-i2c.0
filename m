From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: rename Blackfin TWI I2C driver to i2c-adi-twi.c
Date: Mon, 27 Jan 2014 12:15:15 +0100
Message-ID: <20140127111515.GA3729@katana>
References: <1390720607-447-1-git-send-email-sonic.adi@gmail.com>
 <20140126102859.GA2579@katana>
 <CAJxxZ0PW+QHZqgo+7HCTt_s-Vbp=R4xX8a967qT84VnfZt3MAg@mail.gmail.com>
 <20140127092838.GA2633@katana>
 <CAJxxZ0PjCYMgsyJ5qPu077EBoEBs_BUqbg0vQ4k0ST_KDfynnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJxxZ0PjCYMgsyJ5qPu077EBoEBs_BUqbg0vQ4k0ST_KDfynnA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This is part of the reason. The other reason is some macro such as
> SSYNC is blackfin specific. So, all must have SSYNC should be moved
> into the architecture code.

Ah, yes, ACK for moving arch specific parts out of the driver! Please
submit this part of the changes.


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS5j/DAAoJEBQN5MwUoCm2utUP/2G7laPkfoGSdYHo3R0lartS
dlzgSm2LPOa7R1B16yA/Js/5VTcfewwEhsnLr1w+tbMLE+TQ5X5VQrLvh18YOeUE
JYMs1DIYHEG3aLls02qHEdATrIHXjAMl6+LAHXN13XaIqVgkAVs+eD/MAFJAG/i5
HlRyTbRV6YNSJX68Mu5b0sloOLZLQrHKtjjpzPKFRVlmjYwNLIl7awmaKEVCpgXa
4ZH4G5DrpDfKnMoJCu10zxvy7zkqBidWteZYjx9VV4dG/fF6qP201bj5tL87XLn8
JNmGxsJozIUZRMGdN3Les6p0ZAr2uu45e6tZ/2bwZ5r8jU8QlB9fAY/kJOmseisQ
dU4YQaaQCUQSslnMICZb74M2pI+FhvHjYZg1qdHfDsI1Om5VEaN8oXB+z9eRM/EA
I4GlkaLv4EXsAWS5ujLmcPLunhUmgxsyoQHGrQIwzM3AiEoP+iPyNMcSMnihUW2O
VdDno8n1BHy1HK0UY/7/QZLoSuooSzValR91HHlWhBozlO/4yZC8cOQkCP2/yb99
ggt2Vw5/xqd/0AfD5kuhAVemQ/tE/4qzdxd+xnmaPol90A+dRGR9tubE0E4qGcWa
29S9LPKCFrWLdHllJ3HfbqUgb/pBFsQicQ67FMAe2LGqTNUu9zESTvbGTsaitfJ2
kRBU/dqt1rXaEXbL/pqE
=ED8Z
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
