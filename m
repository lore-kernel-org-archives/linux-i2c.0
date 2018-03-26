From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/6] i2c: i2c-stm32f7: Add 10-bit address support
Date: Mon, 26 Mar 2018 10:00:50 +0200
Message-ID: <20180326080049.lgg4fxcmdav7h766@katana>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-2-git-send-email-pierre-yves.mordret@st.com>
 <20180324224332.apsixpklrgtelak7@ninjato>
 <fd463a3d-354c-d4e9-16a8-2829ccc04adc@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wwvexusscwwnqwkl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fd463a3d-354c-d4e9-16a8-2829ccc04adc@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--wwvexusscwwnqwkl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Out of curiosity: how did you test this patch? I never managed to find a
> > 10-bit client (except for an SoC with 10-bit slave mode).
>=20
> I don't have a 10-bit device either. For testing 10-bit I'm using 2 I2C
> instances from the SoC, one in master mode and the other in slave mode.

Nice!


--wwvexusscwwnqwkl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq4qLEACgkQFA3kzBSg
KbYDQRAAsaHji5ArcOr1ZW9hsRMkICCRJ2F9o7j747YAEnUH6WquoE10ng9bvCBn
fOYrw/5cEoAOrcd80Y5QLHrU5ATkfIi+8gu6dfcXfQ1JdjDVjo0BH2NS7Ws4twlv
tAHrbteFGQjfam7V+qM2XEfxN3kI9RxExWALUoxSNCaKkZhap08FWi0gdNrJadyr
7MdL0MMK3vVxEaDsl98ElWqzz/xkyNHO8+Rvpgw7MRhNOkPBhns5hbXmPIpZhn2z
e1VbxwYG5+ZKD4ODX1HtWdgqAbzsJ3D7r35+E6QRPNIgZup23t/bj3eAKdlpTWbx
SmqEEu7h9o0w6kLk6h0nwZa490EhWiQbMc/WYjG/Moh10JFTOZAGtn/FFpNbu7RI
yzZR+e9cUwpddhGIm/4uFw9BUKC3JLUFwywl2lizPUHvxmlNRodZiK8H1FcyfT3s
XN7IXIDQwrEQ+dgnp0sMyMUoUGFhNXeE6YLiHRAFyA2PMuMAfS8QIM7hn1ogMJwS
MEmsEK+hWgpA+NdNoKjbD7jLVu4Qga8SCPHUH0R0yLXa44lX4t4nxzlW9qBTqFJy
cF4wtCLb26bAumjf046fcnBZsz8VqaD+6QEc1YWIOkvfDuOyAh0PQReYKsdgJKLg
avcp0FqcAXm3Wq6k8JFcB18Oa+8ZFkWkON1x5i+ndNbbbyXXi7k=
=kad8
-----END PGP SIGNATURE-----

--wwvexusscwwnqwkl--
