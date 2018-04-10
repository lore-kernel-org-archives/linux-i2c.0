From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: i801: blacklist Host Notify on HP EliteBook G3
 850
Date: Tue, 10 Apr 2018 11:10:05 +0200
Message-ID: <20180410091005.2cijsmavmay37d7l@ninjato>
References: <20180404225643.6b40782f@endymion>
 <20180405183824.13333-1-jandryuk@gmail.com>
 <20180410093836.1e39d9d8@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m4t4jerzb3qp4osn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180410093836.1e39d9d8@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Jason Andryuk <jandryuk@gmail.com>, benjamin.tissoires@redhat.com, andyrtr@archlinux.org, aduggan@synaptics.com, stable@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--m4t4jerzb3qp4osn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >  drivers/i2c/busses/i2c-i801.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > (...)
>=20
> Wolfram and stable, please hold on with this patch, Jason and I may have
> found a proper fix so blacklisting would no longer be needed.

Awesome, thanks Jean!


--m4t4jerzb3qp4osn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrMf2kACgkQFA3kzBSg
KbYWvw//Q9wCGT6qItgdGnVZHdmaYSrpjjaIXDWiFA17oLAb8ec1fAgKp728yxxz
FnHFtwiRcggjbHm+aagL7eLgzT1qslalUEcVDx7VvXBd+TjaGO037mh0pxrRBKOF
CVmY6rw1S7UbDtLiydr8W7mg/INBF8iFfp59UHOEPlcsv8Q/GBLM8hhVFUh7NvEg
P20GScKfNvXxhT6HewD/uD9hy1fIJj0CUsr5MFYIMJWmV00VLKkLaa0ZPeix+1s0
VdRmWNKYQZdbWjD+KyhRhCFlLiPu0+AQocNPoNGPR1w9SGsZBCAXjtD/kgahd57V
v+qfljgjkc92MI5hW13+dqg+ttemj6vJPOo6YW/JQE+ju2GtUyu6+XmvBuQFe5eL
d7YMKDsn7GX7uP8evm4VqpH/tzPBed+W4E2cVE8xUB1yimIG4bHIdgr8HokTSmMR
mCXhuAou8Fi9oTylwMqeB+/7JDAmbF3NKsXmDvFucDVl7ozsUAvAfpOpsIqBtemv
T0fhoPJxtpuwITGVICVyRZDEv/soiuEJbgKJrpRj9tdBcnGjsGfDRYBdlN0aT8jL
qXbAkoPJWDy+L/k7UC5+PV4uxDkLIX/UwJGgFq7Ush1RGyoPYd8VeF8R8Tx55Dlb
nHPQ/mrNeG5Pri/e43JSlMsD62rLTUm8iGQZituzKC+luYuaR9A=
=CGVX
-----END PGP SIGNATURE-----

--m4t4jerzb3qp4osn--
