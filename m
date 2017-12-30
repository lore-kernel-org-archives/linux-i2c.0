From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: algo-bit: init the bus to a known state
Date: Sun, 31 Dec 2017 00:17:46 +0100
Message-ID: <20171230231746.tnyck22fc4jc7q5c@ninjato>
References: <20171204081618.5922-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vhsmfmze3vmhxbgs"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171204081618.5922-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--vhsmfmze3vmhxbgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 09:16:18AM +0100, Wolfram Sang wrote:
> Ensure the bus is free when we register the adapter. Before the SCL/SDA
> wires were in an unknown state. It used to work because sending a byte
> has a retry mechanism which was triggered if the bus was initially in a
> not-free state. But the graceful way to do it is to initialize
> correctly, of course.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--vhsmfmze3vmhxbgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpIHpoACgkQFA3kzBSg
KbZCDBAAmoBnoLjH1t2MEwF9JsKDhoVluyVu7WNr/0Czfy8szyoWFdANYuNBwwU7
biLgfbLNeEr+fPc12Yl0P3ylEJ7hzSkPEgWR8BKDxEKEldKIIu9a+cOlsa5GU4Jt
8RvcitFiMnmk7Y27dgYDFuwa2YCOlLhEBE4PPz3O6OgqYcX4By8p76YvE+lWgZqB
wr70kP+JXzW56LYP3FCPqX50kirJDee2SKmXrnVX4YXOhs3703vrKZD/hKm00klc
x23CrKvxOHt6RKuB9EZoqKqYN80xBuWW6Pm1D1FAFWmtFDa21xrGN3PKuJwU8WpU
miNdTXTlKPkA84PHp+wNiu93Oy7tCuAbvFBclvuTKGRhpms/UFxdClMATDRWZ3EL
T8Z4UD43TA0mXar7g4ZN7MwwR3VLmjSvnjh35aD2x7RZJv5AHeYA9nH8HZ9sDlaE
e7ksOVJp7OD+SUuPHZVMk6Vf78X8NW6ILfqGaem4/DlfBeG6Ocx+J1LKQe1Oo2mo
qgjLpmfKx70PotulsajwJaPACNZClKc5mZJrRfd3rk8JG4W4zM1I6KMbhYAByhHa
LiROmdGQ8vNUn6ldQTQoom6iygju/inE9VWduHucAJxDU5Spk8aUWrPfK9GxTawg
TyxXI7s++0G4R8FZMlwlZR9HgVsFIlVGGvDXLB0BhCmq3cfhSNQ=
=Icj4
-----END PGP SIGNATURE-----

--vhsmfmze3vmhxbgs--
