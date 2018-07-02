From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v10 7/7] i2c: fsi: Add bus recovery
Date: Mon, 2 Jul 2018 20:16:42 +0200
Message-ID: <20180702181642.aa6yjecsavv47zd6@ninjato>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-8-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023833.iwjz7pqnhf4jd3w5@ninjato>
 <c9d0b0c8-268f-04af-7c43-6fec0e272a9d@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u2q4ccg7tyhlb6wv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c9d0b0c8-268f-04af-7c43-6fec0e272a9d@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org


--u2q4ccg7tyhlb6wv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > This all won't have any effect since you never call i2c_recover_bus
> > which calls back into i2c_bus_recovery_info callbacks.
>=20
> Ah, I thought there would be some use of this in the core or in client
> drivers, or some ioctl interface. Would there be any outside users of the=
se
> callbacks in the future?

No. i2c_recover_bus() is only to recover from stalled SDA and the only
place where this can be detected is inside the I2C master driver. It is
not an event which can be controlled by a user.


--u2q4ccg7tyhlb6wv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAls6bAoACgkQFA3kzBSg
KbbXnA//eo8DSb11K6+Z925m4DH1eqinQ+inYTF94j3RBKFDHHFqB4AEvrSKzPzP
PIE2v6AnNs02djJE54McVadbWHF65ya9Esbi5t9JgniaXbIPZOQyIV25JNfOfZTG
AGLY/NKWV96RmQKTXCmDM+YY1C5GdSgeGIlVsBcfovu0QXMMAXMQsYQpAmP7FbG4
AJwQKyGSJJO4fSIf32MJ/iSo7PwshHe2zD0X8zrsQa2EQeZT9k2Y/jtyNAZJ4ale
Zzjrx5WyRaItUw/MKtaBMGNY0HlTrY3DX3dWuMSQZPnSFiTzjCQnJ8q/4w7N+xTM
1dfQoFkLqm36TNvco8nJ4cLQv/zOdwYyVf2D9+VveMiXkmNp2XBYGnyo5x5rRRON
m6p1FG86wGD9V/sQqREcDwbzr5El5UWGYnULVR45GnC/+VcLtGKGfoliQy+obBJ7
ZjKdMUiPPVuWhaUJ7Ms+dtbZKeLLjEmEc+eUmKVYXXnj2KIxWbsbOnEN5Cly1giv
pMqVoeQAT3HQshcuMlIJ3g8BKfX8GsQ+O85nR1oBQyAkafQtXJKkmoi4nw9BfGjF
TiNVz0KIsRypYoNzu79BNx6t44rmo+e+ZNrKn7+ReSFaZjQwpkhz9ATFAzBmBOUC
siQVAq3S3chZ7ATsGkAgLW0XN9znYZKVuUix8Snm5++xv//u/eY=
=llkO
-----END PGP SIGNATURE-----

--u2q4ccg7tyhlb6wv--
