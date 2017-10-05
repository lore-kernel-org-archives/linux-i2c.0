From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v1] i2c:i2c-stm32f7: fix setup structure
Date: Thu, 5 Oct 2017 13:14:44 +0200
Message-ID: <20171005111444.77qib2ddnz4jmbnr@ninjato>
References: <1506000609-27409-1-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x6aochfhdu7k2ja7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1506000609-27409-1-git-send-email-pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pierre-Yves MORDRET <pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--x6aochfhdu7k2ja7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 03:30:09PM +0200, Pierre-Yves MORDRET wrote:
> I2C drive setup structure is not properly allocated.
> Make it static instead of pointer to store driver data.
>=20
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>

Ouch! How did it work before?

Applied to for-current, thanks! Please provide a Fixes: tag next time,
did this for you now.


--x6aochfhdu7k2ja7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnWFCQACgkQFA3kzBSg
KbY13w//QAQXgYmF20eEIk1lC4jjJ9Z4ZMZGj3nMI+v+pRD7oRuZvMB1LQDOoeT1
YJA2P/lff0Fw+NpvvBQDWTlFei0uFWbGngme3byHfm30cb2GiiO1aFgGgtK0VTvY
ZxWJTSR8MHHp42PpG98hFinnTfJq9omVyZ8ciHgiLv/nVce9n1aqov3avRmwv89Z
t9T2dtAVubJi7rLOTFkG7n0t8XwYCVH1dBfKMwTTfwcsnzS1/dGVHSHX9TFMLj0D
neC0SxtNrC9M/WUzuTn6kOo6g/dzPRwLvdtFG+GE/OXVqyPrTtj9W1gQ5gl9YZWD
X+WbhbSXS4unICGsqMO5BoGI5DC1S44nbh4+4BfVwcwG3cADgB+09ALlMFoTXPfA
8oOTp2eYWvpyBOhp3DnuX5R/Zi3Jv8povjZ+5g2ynmGYXZimnAVBGFKc+NcMmOm9
GdK4HBW8RZoMBHN1yZ2Cs3WSm/W86vN0D30lBesmbw43+/SHcyvrJg+l32v5Te9k
R8eFRyTtdSZnH5CLkJMCyp6KVnO8rpyIPWqzmEDQ52lmIGBzCIEajgJcnlPMCzrv
1djLSfEgKANn5aVBeKDK/z47Qio4Yhg1Gp1mSPlMC30FJK9xqJJ06rLwrjpayrXC
16g2aNQPuKPhVEcoUPhgRGwbELIzvrZPRMtUV60IkFuTF0Qx/IQ=
=9/mT
-----END PGP SIGNATURE-----

--x6aochfhdu7k2ja7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
