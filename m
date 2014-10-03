From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: fix 0 length write transfers
Date: Fri, 3 Oct 2014 02:27:21 +0200
Message-ID: <20141003002721.GC1323@katana>
References: <1412185241-24950-1-git-send-email-amstan@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412185241-24950-1-git-send-email-amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandru M Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, ZhengShunQian <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2014 at 10:40:41AM -0700, Alexandru M Stan wrote:
> i2cdetect -q was broken (everything was a false positive, and no transfer=
s were
> actually being sent over i2c). The way it works is by sending a 0 length =
write
> request and checking for NACK. This patch fixes the 0 length writes and a=
ctually
> sends them.
>=20
> Reported-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Alexandru M Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Applied to for-current, thanks!


--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULe1pAAoJEBQN5MwUoCm2hWIQAIpcr1HzjtqvzPVcuhJfV3Vn
qo5ZzuxFtclnU9U8mwAJA2Y5HS2BejHK0x9pH++UqfefPp0lQ3aotK1bEmHBX41B
qYLONBgCL/k5IYvallCmaEIsUPMbKz7RlH+1AKp4lkYnn1zxf6MQxCgxXaZ/LlGO
15AhRYyMJEdMUzkhIg7fRreeLSmIobC7OzxeR9CHL8j84f5ukr5NyOAkncUdF7sg
0+h0e0XDUdFma79sAKy4xGJuEGjqhEtPQstCagvmkjVd5I/qBIVoNe2oApeQ9pmp
l8vDUKuqC+z9aEOyRd7hshSrrpBmJDQQXavnFbeMJK2rNLAfvNCybXFBHRo1qIVt
Bt6uRS+nyClF0riRPDX8zim+vNUsyNAqAPVADOMLKfAX+Z70EFBKFgWV2gRT+Y/W
X3cFWOWpzPXUXZuWLnAyTbY3XBFDqbf0BAJ5Hvdk4wkn7TGWatq+y5a1uDlFgtDX
PB3cOzH8g/xkK4GTGmfvf/elk4qWJvZfEFzzUg7p09NYdiW4H8irsNGPxXRzLDlB
drV9HsIfmpKiW9fnFMt3esKTX/2pxfpqWq1x0y3HldwBwNy9Mp8l1B26xYtk0mUn
P1P49AZFvbnuSik37LW2OvOuDR22oyLhrOonRuBHdDnC0Ni4H4wEpjuUuZR4R6Av
cbTarbpkcuzu/S9IXgXu
=M0zr
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
