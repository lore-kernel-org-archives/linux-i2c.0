From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: sh_mobile: Use of_device_get_match_data() helper
Date: Tue, 17 Oct 2017 23:59:05 +0200
Message-ID: <20171017215905.yyi4sc3wkbfd3xdq@ninjato>
References: <1507119425-12566-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2jarpujw6atzujwg"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507119425-12566-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--2jarpujw6atzujwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2017 at 02:17:05PM +0200, Geert Uytterhoeven wrote:
> Use the of_device_get_match_data() helper instead of open coding.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Huh, how did I miss this so far? Applied to for-next, thanks!


--2jarpujw6atzujwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnmfSgACgkQFA3kzBSg
KbYznQ/8DyzYPaUaPieL8FnZEoXaBzrqssqt8k9P7AK98NGvw8tVpip5MB+q+0PK
aZ3lDx3K+i98z1XIrvI3kowsUw8hVdp5dSVw6SQQh4OoRswnBZ4NrBaa+z6VlgVG
UR9ubOi1aSDGT+dRHbrRwcP5OpQfwZ+x3YoNFSEI8ZfpgYqY2QqrfXOFvwwVWbWs
iEl1wPUn+5Ppltkf8EHb4GTGvJkWA3Q6kSKEtrAaFI4i54DQhNMuAW8SXtlyvPDC
Zlz+5GafcWFHLSrw7Tcxp7BjQODNujMq0dMn7STXKy5+kqSYinRmzgwLO7bx4+sA
tnl85LzELPpT0iUs9rs15HCN5w/MfWVC2KfvoXjtC6XRBjGVkt5ePEGCDGEf/Xe9
PGXVgGSY+siUBdjjroT9V/8GKakWFyJomBUBtEAXcAPR/RhZyzzZYhxK66+6cLo7
7q5Tj7DmWO4iMabZ3vUnQf1UmI2bOMkKga0U9VcgycPxnJvG+DMkDniU7Uq7dYL6
zZ45j82PBVZUU30FJp5YI+PKAHkLK0Y7Sf1xaAsrr0Yf68nYMsj6unUfaGqPnTPt
qz/O06Yo0CTruxQx+qhRFcfd1waMgkb60EWojVrSKfaqLeviabJ6ZZWaUu+Qq1EP
/7s4gCNczWb6WpL6mza96T3hq1xpELvBhoz+xYBqD4AZG0+vnrg=
=5CFV
-----END PGP SIGNATURE-----

--2jarpujw6atzujwg--
