From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: report number of messages transmitted
Date: Wed, 22 Apr 2015 09:42:54 +0200
Message-ID: <20150422074254.GB1511@katana>
References: <20150420221447.GA2005@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150420221447.GA2005@dtor-ws>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Alexandru M Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2015 at 03:14:47PM -0700, Dmitry Torokhov wrote:
> master_xfer() method should return number of i2c messages transferred,
> but on Rockchip we were usually returning just 1, which caused trouble
> with users that actually check number of transferred messages vs.
> checking for negative error codes.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied to for-current, thanks!


--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVN1D+AAoJEBQN5MwUoCm2KuMQAKW7fP5I53IaXNjvnEjvR8HL
V2wv89jsrDB8WzuLvsoSlOe5CvIyC5+jx4TkwB8E5ajYlYDTuNz1OmDyLrG6C7xB
ZQc5I0D0kdPqojnTG8cgTf4hmlmT35Opk+WCk0dzGGdb7scMifYeqHnLz4snfk/6
m9JmHIX4Rp/i2EB/HPUyIwVTcpmnY4Jeep6SWbwjkyktTksdwIuAFJjr6D5kqmqL
OxgZzbHcBui12+HrhI/2dmgCe16E/90aJyy+a5QNd2qmDPBiQvY1XcUKxTbXp6oC
hPnnuZSOs3eiqxNdQwD4EqVBroIonPhhTaKfK55KOp2y287yWYTrDabrn+1V7D81
T3gOZWC9eHFt44yPtZrSTMIBVfOkTwhE+1f2f1vQLVKXVHyRfSdq/LhSMo0sQ9n9
rX3k1cHsLhhoLpKCd4ZLDQbVruM0Jg3yYXM/w1CN/EWrOW5BAJr85afrCk8A2MpT
bZQDqln79wUZGSydbSRGTKmlvtQCI0+Wf8RK2hZgr2itfPRAuiWZYQsWxvkxnpzI
LUe9uDhC1qg/ibyoro8GLIFV9lji13DeiWeboXbpIz9lzMm9Lk5Na/79Pqr+43i+
jKJSS1pcPUzN+A0O9pSNqFYoeQ0nUPRTI+016W7aBJxffyhgHCqJy6mzwpamWKCW
UvKf0vF6YHhZs8Y6jfOe
=Smsr
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
