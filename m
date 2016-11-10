From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 00/14] ARM: dts: r8a779x: use demuxer for I2C
Date: Thu, 10 Nov 2016 08:57:19 +0100
Message-ID: <20161110075719.GA1436@katana>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161109084406.GA22213@verge.net.au>
 <20161109172813.GA1545@katana>
 <CANqRtoRwSh602rjbHA2qo=XHyimpyyi_T=0sh2A4NOfzzVB+oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANqRtoRwSh602rjbHA2qo=XHyimpyyi_T=0sh2A4NOfzzVB+oQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I think postponing merge of patches is one thing but I don't think
> dropping them forever is a long term solution. I think we should have

Just to make sure because you wrote 'them': I talked about one patch of
the series, not the whole series, namely DVFS. Because Lager is the only
board we have where you can multiplex DVFS between IIC and I2C, no GPIO
option here. All other SoCs have dedicated pins for DVFS which you can't
mux to anything else at all.

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYJCheAAoJEBQN5MwUoCm2r8gP/jT/s6XqN65ivUo6olkMDU9L
v9yCWKFQU+Rg9QHARvw+pCOP51+fJlUGrzuN084zcnJ9bBt5+QBG/exGwmTamA1N
rUtIinPhiBNd83ldvVe5JtPHkEbU9JrLZwZRv+FKV4MSEslrkeqPOo0P+CszRRlQ
W8tKnF9PEKkmi1T3r0INj2GAEHcNIRMs2+/sceBUyJCswi32cMhUc++sCTh7CFxc
CNHSyuaXkPykaUePkDVQcVwANkEA1r2NdNhlB3KffJvjHQfB/MtS7upXHRp5P9VV
shK8jsr84w1MXZHljFleJmea4lO7kK9ONwLCQm2RZVuFUcpHzIZz5YuweBgVtssv
1RtxXtIiyKc0j6pKSen0BvwV+nQFL9Eng+6YiFVdVzzKIfE63ra9suaZRa3Wm24z
vldRy/TA4FHTFxAPppc3Syo7/AE5kvwqD+dwZOaJ8M+uS+lb/oEMDx6IjrzPvhb8
vf1IY8uLNu/adrInf20RDLR2BRBbB9cSlY+SM6iZymkb8lcHVcdbVD3ax0tiXngG
+tmCbHDhe6WkSXdmGhJZPw+oLwcp7E+X4ykK23gkeuG44D+uB7Gi3ZKsMcbqh8Dz
uNN1Hc45ank4kuVrt3YvPUoh7tTFy7WWQauQarIpXcMNb4lX17bR1ziCtfJb9Frl
HHmMrNNJNtM5958XlvA8
=HdtU
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
