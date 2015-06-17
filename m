From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c-tools: add Android.mk
Date: Wed, 17 Jun 2015 12:29:17 +0200
Message-ID: <20150617102917.GB1517@katana>
References: <CA+TH9VkQzJaSa0okxK+s1ukpaqgiWegh3uumEb63LzZwBjV4nA@mail.gmail.com>
 <20150316101626.2c7a02be@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150316101626.2c7a02be-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Angelo Compagnucci <angelo.compagnucci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Now if anyone has a more educated view on this than I do, please speak
> up. Android is really not my thing (as a developer, I mean.)

While working again on adding i2ctransfer to i2c-tools, it became clear
that this android makefile would need an update for it, too. And since
nobody of us is using i2c-tools on android, nobody can provide a tested
update. So, it would indeed be easier if the android universe would
figure a way in their sphere. So, I agree with Jean.


--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgUv9AAoJEBQN5MwUoCm2+KIP/1kVOSmaryktTxnv7uXxHHwn
VdVUbGRh3Y9OaygwsYIEzfHChnFXrs4XgMSug7yLqokamKGtzmBaL5u3xzJryj9x
c2j5nCzOO0WSojAnWsg1WURwpHv3MLeRqv2m0rrh/AcbSDCnQ1eFlMBB/G6G7wSv
qvlIKJeR1cZDsZz7niA8U+Hcxa/0/3GQEUZKlMW5nKLBEQJOqgGNjGyGPE46TQro
MQ4jH1Pkt4DON7O1952wbzk9xgsPvvpUIEgmAoj8YFeFHpJ7sJo3DhFcCZIH47St
X8g64UwoMC20SlbIEDNC8cU9lU4HnDFVAsw2k+YJM3SdqUPRebNtM0WLAyubTVHt
Ta6e/HkFSSUUlPshu5K53SKgaX30pTCOAyKO3Cqe12f77WjqkK3BAb5pMoiU1PgA
A8QUHU1BKkUUa35Q9MPrlAX9ZMQoHuIlb4dRsziazZoZliih5d+53UaFtmhm3Fl/
HhgiR52/+TzmYCy13Vg+/q2wjX9gatIyPWk4ZgXdVqfYrw9wDr7FWk4C+l/UUwtt
6nA+EdGl4jEXXgDwwwahlq8MzIooEkq8KajAWyYnZkypM6uhayoqg0JHaLMnPt2z
UwKnOY3UPytn2czwkGJyP9qWhNTm6ThWjz8FAGeMPknLH+7USAgMjTfOfePWTWnn
yHrcXn4e8ZVuIKit+ZhC
=pjpr
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
