From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: imx: Add arbitration lost check
Date: Sat, 20 Sep 2014 14:28:15 +0200
Message-ID: <20140920122814.GD3850@katana>
References: <1409723527-30603-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409723527-30603-1-git-send-email-haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 03, 2014 at 01:52:07PM +0800, Haibo Chen wrote:
> According to the i.mx spec, for multimaster mode, if I2C is
> enabled when the bus is busy and asserts start, hardware inhibits
> the transmission, clears MSTA without signaling a stop, generate
> an interrupt, and set I2C_I2SR[IAL] to indicate a failed attempt
> to engage the bus, which means arbitration lost. In this case,
> we should first test I2C_I2SR[IAL], and clear this bit if it is
> set, and then I2C controller default to slave receive mode.
>=20
> This patch check the IAL bit every time before an I2c transmission.
> if IAL is set, clear it and make I2C controller to default mode.
>=20
> Signed-off-by: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Acked-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> Changes for V2:
> -Use 'EAGAIN' instead of 'EIO' for arbitration lost
> -Modify the comment style
>=20
>  drivers/i2c/busses/i2c-imx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 613069b..ceff87c 100644

Applied to for-next, thanks!


--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHXLeAAoJEBQN5MwUoCm2K7IP+wYFzzpp0gf4iSR3y9HM+DfP
NQLt5kO0sXCDDo0oJFqIWbdvyNA7nnsZWClpSqxqXQuVhHSoxGzqHv9/rVRs5xIJ
XYU4RckMnWQOkDv5OmbVi0W7XDOnM6Dqxp/42aWUKKeeigFdWqasOy9zTo6sgrD+
SRB3KXgkPbVENB2yNyMT707EjFnKaIHKsvalUpsS74hSVFSn55uNlaO5ojquHQgv
Jmj8nfK0cuW2qHe3XiE9t8t0D7CGzEvYJDw7HBSV+BHzUZKcohvW9gNWBpR0bjCl
9CEzo1xbBlRjkuWpKA0gtb7K2zskufEFLf9OqkS0rNk5QZGnVOA0ZLNwiYure59M
Ch5dNzH90uON1eYt2ZQ7pe2z1UoEXlBkTMZLxjh3wUzhRjV5KoPtly1XUC4nj/Lk
gxz+U901kQhVjHiRtcw+wj5CgE1iRKx6WJIsd3fNbj9GpQ3l3EJSJVDBlXvKNgor
Tsv24h2TAcqEe3hFADEiPCa976JByG5xC7dWyGavV8i17gEWBQqKTw1Q+8/X2TYl
O2D65LicvCHJmk5AGZHTA2nyJg6m1HRqGWNBXOsFybTHH9yL/jrI0RLS3yOhycfl
gACPbVFTtQUpLWw3Xr0GTyCehPTCyxiJp/gg8iTXcOGVjKnLYNwTATDelVroegrS
iE7kr7HfEzZvLIP+Mrg4
=ROfn
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
