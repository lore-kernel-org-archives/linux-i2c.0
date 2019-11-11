From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-cros-ec-tunnel: Make the device acpi compatible
Date: Mon, 11 Nov 2019 21:02:44 +0100
Message-ID: <20191111200244.GH1608@kunai>
References: <20191111161431.26293-1-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191111161431.26293-1-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: cychiang@chromium.org, rrangel@chromium.org, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, Mark Brown <broonie@kernel.org>, Neil Armstrong <narmstrong@baylibre.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2019 at 09:44:28PM +0530, Akshu Agrawal wrote:
> Add ACPI entry and use device_property_read to get fw value
> which is common to both dtsi and acpi.
>=20
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Applied to for-next, thanks!


--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3JvmQACgkQFA3kzBSg
KbZdERAAo0SddYxmjJW7ale0dJNw/yGCy4O5bzkVkSGDSOzmYXblYoXqtnUI9Bnz
1LTDk4al4y8ewW6k1tvw83mld1VaYTryHSlt3/bjmKNNQ7F7SwclNdPNOYbbtwJz
/SaZwuZMFLmCzlXgs6D8xEVH1wxVymqOTxieTtnde2sfKOZjIFFGZGSlbiRME3ah
I4OM8x4o2SOwHOflZn4E9TDDg5CkRgBtjJDH9nRtvEScL+wi4HnngBqmtDObsQVS
/2namTb723w6HeSlR6mZMRnLbLGoyY4uy6NKawC1xC5aFf07ALam9GiVeO+jHUOD
mo7MTfA1W6tRpnR5kj57clf1ypcdxj0jWapfgEHxnNukDtlkx9UjObXBccqQxaRr
hDcVghwDvx/jdZicArOozFn1Ks4N59wpSdqgpqQr/UCoJhYrUGkKvyinwV0ePCcT
A1p9K0trXf3+4PPxQEnKoDiFzyt9DscjtTuAnXrELc1vC3hgjOLSpdJfdwonNbLJ
+GnCPIq1ZaFPmQ6QfDhkmhCvnjDxztoCZz9HSPg7IyE26kF8nyExBUW97dMdMnuV
Rk4ZnZcQWOGQTlDruH/ykM19wekg93U12TvTs+HaImGETXvEccXjV4VyvH5uY7dA
DG9eKYKKf+PYoM0kJOY3SLu6p1MXx3vR7kd65hElDjzzBVxpcCA=
=XnrD
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--
