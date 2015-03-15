From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: wmt: use msecs_to_jiffies for time conversions
Date: Sun, 15 Mar 2015 10:19:42 +0100
Message-ID: <20150315091942.GC3393@katana>
References: <1425216032-8163-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425216032-8163-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 01, 2015 at 08:20:32AM -0500, Nicholas Mc Guire wrote:
> This is only an API consolidation and should make things more readable
> it replaces var * HZ / 1000 by msecs_to_jiffies(var).
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>

Applied to for-next, thanks!


--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBU6uAAoJEBQN5MwUoCm20eAP/i4rzcc6b8ooazsviniFqBxJ
/ao8NTF4bnFNVPXdYJT3EM9GDznlvvq/aZA1Z3P0hiMSAoxBdSX9Cksndc8CARXK
lD1OTxhWYjh71WSRElhiQ4D/g/pKNF1ibiZ2uWcoGiH7XR0W/C2914VrsMlT/z5k
X3RGmxNd1a78mwYsFJlmRc8GmutXrgDrtCUrpOFhV/JV97wKspjhYogsVNqAgjke
0cVMF5MQ6ji6JmXZ3s8KTaOBwaPQxaFcb9lcL+w4jTEdvWq6wJwr/L0ZKudk7Jal
lLGd/m3868LO/9xVDBI9gl7Hm/QY3oA6Tz9bLHa64LRRdvgSkurGSuCp/e76lAs4
hGkHIS3K1G9STj0V4USm850qw7tDBJX1vZj8IBlPvgx/JxoBTyRjvx6tkXI44FPV
I2xzvEDoKqhjU0KnO8JMuoVeiNFhgdR9s2cNJFD3br3FttRIsk4rpgrjXEcaguh4
SY+eSsoTa5TVrpICHiEyi4+MGnoOIchPGWOIJyFEz1q2xrTiTxwd00T8pS3jlirQ
vTFNgRshIdJTPf+w4LRzDgqSW87kkZ5+pnks4b6kcderMnvxi9rp/z+hDHzd1afD
ZI/PJ1YJcgrTLYm3hFeTaLJYZtSE8ZRPQXhhLbX3kHjRBb89o2ZG8NNk+5HIKCpA
O8HbvE7x5kt8fBnlqbgQ
=4CaM
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
