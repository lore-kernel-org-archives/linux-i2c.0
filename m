From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: xiic: Make the start and the byte count write atomic
Date: Thu, 6 Sep 2018 20:52:01 +0200
Message-ID: <20180906185201.GG8607@kunai>
References: <1535967671-7784-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535967671-7784-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shubhrajyoti.datta@gmail.com
Cc: linux-i2c@vger.kernel.org, michal.simek@xilinx.com, linux-kernel@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-i2c@vger.kernel.org


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 03:11:11PM +0530, shubhrajyoti.datta@gmail.com wrot=
e:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>=20
> Disable interrupts while configuring the transfer and enable them back.
>=20
> We have below as the programming sequence
> 1. start and slave address
> 2. byte count and stop
>=20
> In some customer platform there was a lot of interrupts between 1 and 2
> and after slave address (around 7 clock cyles) if 2 is not executed
> then the transaction is nacked.
>=20
> To fix this case make the 2 writes atomic.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Added a newline for better readability, added the stable tag and applied
to for-current, thanks!

BTW we have no maintainer for this driver. Would you or Michal be
interested in doing that? I don't maintain the whole driver directory
anymore.


--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluRd1EACgkQFA3kzBSg
KbaGUA//Y1TH+XzL0PJFUgv/9hLCeDYMrhwdpW1ah6Vx6hwCMkMLEX11xtIMQvQe
Q7+Iyj5s7wuWXX3bDrtzMRT4OnSuvu9MYNsHlsCMM2I9SQD+EOC7WudXw1DJu7WA
EL++/74DmSWhCRTCBkBgOtWgTzM+a/bUPkg2d8qFna6/DC8J9I3dTQf/vhtH4jXB
6GIV4ePOrj7p3GqI46fI5bwOUbEoJHahOBfXBmvaQ5RQomdSmT6LKjsJyrZXNXtK
EE+YbLIg16KcDDTZ9aw0/kDhmMlHNs6LDv6LfLuz+piFDQdE2GhPIJDmf5erj5js
mHhSuzXiXh6NFY3fsbG65nZ1Rk3Mm167NBr1RiZ8bZ60yqMHbC4gFg/J04KJghzg
N/TvRzpCXQHNo5eNQCsaW+IA5n6dtP9OyoXZusP9XPuzpHzrc/0tHrf26vVS7s1q
vtiTNfdqmfyXVFZzuFvvo4EwJnC1qRlE96eoHEC/1i+BQnWGacyrouFRBRO3H0eq
ZJAsG6+lc77pmrspFbDlFB5fAu4/jFdYhpWKE7+pCqoePDZoe6mFxuLe8vEGaREC
fLz/uEdy4nz3QIjuvew9WqUskwzKgP+6D8M8wZKOV/bduy5FOn08Pl5A73uZzG9J
CNXVvcjmCz31mJUgFqUTdk97EkbsUFcK06OnJx91fCMOLlfI1wc=
=XF2e
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--
