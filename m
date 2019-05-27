From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: dev: fix potential memory leak in i2cdev_ioctl_rdwr
Date: Mon, 27 May 2019 20:59:58 +0200
Message-ID: <20190527185958.GB8808@kunai>
References: <1557238832-10723-1-git-send-email-yingjoe.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557238832-10723-1-git-send-email-yingjoe.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
List-Id: linux-i2c@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 10:20:32PM +0800, Yingjoe Chen wrote:
> If I2C_M_RECV_LEN check failed, msgs[i].buf allocated by memdup_user
> will not be freed. Pump index up so it will be freed.
>=20
> Fixes: 838bfa6049fb ("i2c-dev: Add support for I2C_M_RECV_LEN")
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Nice catch. Applied to for-current, thanks!


--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlzsM60ACgkQFA3kzBSg
KbbrPg//afgtgokT56fLVAUimGKtp43xzDIQTphV9hSrj6qPYR0k56cR1pHzIusn
2CI1BMettrTAASHv6klyeQcSJzoNDEJLwc3zWgPnMEARpTOaqc7IeptQfS0qNMkJ
a83IE5Wvhl/w8dDINSxGqXOiMOIsYQ1fVHXYxB+9iaWM2ptxsCidWl5G+6hXUTn1
wW3icZKaPALroV+TlvlyFIp1D+WhkrgWf/Dt2t5xe4kvnO4Z7dAvdBKvzMh9ns61
zR/F9g0j8044RWSPzIm/uw7yvoamv+haq2f6P6k8aEvlt/R4HnsWSB440uZinZvy
JGjn+XskfNUny0rQsWn7L8b7Avigx5bJSS5DCNeL8TUSIu4qCaBv3GSJAMd/IId4
u8Hfs2efh3xVY8szRzl3Cw2UT92Alhg5Y0+IQK2iSeEovnKiH9asyQU7FPbDLEeO
L10vkNMEKz1WsAOmDr+MTf7qjER6sYoECehEnn2doOE9Cvsy2K8OmrLXZ5lnQ4zl
w30FOYcZWdohFjMBYFOtZbL785pReQ/5dAPJlNUNPdbWU3FMfNhtylcbhCc4KJVV
Yu0NvSTfN0fKHtfEpdB6VTsecRw7tjZogVXUvoecos8SKRd+J6n18j0QXBeR2BRx
kUdKKAQWKwTi9U/bFlwHsXGW0yJRJL8w8Z6utUXJ/xPmNXnQsRI=
=VNJn
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
