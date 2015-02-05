From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: clarify comments about the dev_released completion
Date: Thu, 5 Feb 2015 20:18:26 +0100
Message-ID: <20150205191826.GC15307@katana>
References: <1422567909-13399-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422567909-13399-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2015 at 10:45:09PM +0100, Wolfram Sang wrote:
> There was quite some confusion why this completion is there and if it is
> still necessary. Sadly, it is. However, let's improve the comments and
> share what we rediscovered.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU08ICAAoJEBQN5MwUoCm2pqkP+wbrrqKWPB/mFUhSueJ57BRs
hUzBp85eTv7AHDVj+qRu+Pr25jZIp1a8Po0C0CZ6Fr301NVHXwlpE5bOW6REWd/7
oDe1UtlXEitsJXAsHmzmLWQ55jMfbLevtsAP+sJwQ2WFptGNfRn+WSSl9hSa2gKQ
gD9Y/ZERkcqzg2INPU5RPciuzLCGAKXDkpoh2BQNK8dgH2z9Q96wLiWHnHDFNcNV
8aMJoELzUJMtZ8+93bdmogZtpHDR9FUZFosDFixZ9c+9jtceX9xZijiwBYTTBP39
bK1vNt1fvbtJfOqD1d465U9wYwsbctJeiFu5i5hM5QaaGYMkuagaoT4GzehGeOAF
eetnc1sWOMQ+v1GxOp2dY1fiJ39GDWTn8YBV6T8z2wbhoB99iZxpStiAyUXQ+dqk
lJ8TP3Y4NnoC5yar7M6pRrhLzQaL6OU0sHaKARwTsJBRPSlb3WkLe6wguFuFuxdD
30t7DRGIPRjJTaAPiZUzluwTvMliYLToTjqXqoZJjC/uOsNgILlz9s3kPEMqmjxu
VKYY8vIrgKgO4GS8E/yxtFYMw5LGu6V0Cd299OrJTDTfRmjgQmAJGQxhZ66jVO8w
06ZnaiQQ9HRuFzVX6u0rBVM4Fqfv20CCOIT8+kpGA+8kk0S4rqdHFrZCZLeMWqgr
AArc1PzLCktd0H0xpBfF
=KUic
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
