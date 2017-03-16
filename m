From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Thu, 16 Mar 2017 14:07:14 +0100
Message-ID: <20170316130714.n42zkjdei7pm7vgw@ninjato>
References: <20170314151638.23132-1-javier@osg.samsung.com>
 <20170314151638.23132-5-javier@osg.samsung.com>
 <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
 <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com>
 <20170315075835.GA1438@katana>
 <ed3caa80-2b73-752e-a13f-aa5d348abd18@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dktoaxa35hbag4fs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ed3caa80-2b73-752e-a13f-aa5d348abd18@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--dktoaxa35hbag4fs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I'd think we should fix the DTS files instead to contain a fallback we
> > agree on. Say, we agree on "atmel,at24c01" as a the generic fallback,
> > the DTS should contain:
> >=20
> > 	compatible =3D "<your_vendor>,<your_type>", "atmel,at24c01"
> >=20
> > And we shall only keep compatible values in the source file which differ
> > in behaviour fromt the generic case.
> >
>=20
> Do you know who that's familiar with this device and driver can do this? =
I've

Sorry, I don't understand your question. What do you mean?


--dktoaxa35hbag4fs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljKjfsACgkQFA3kzBSg
KbZLHA/+LClGQzDMrCjIciXNOYFeabQNdCVzPsDPjB9sMVg2ijdmhGyWljhCWdkr
ZCbPMJbiznX+2x95zWk7Gj+vVGRNcpzwQiOS/tVJ93qz8BFikRD0M1MGPgqDSLC+
qd3PvrsbO9LjJGtE3HyK3e2thMBr2GbPYz38WvUcCxvVWPFb8XZM/FV5KtkuoF50
Bk//dYnee+gWS5b4TnEY1/7LzV6fdMUMiVPtjtIbMYZzEp3rMrW/sLj8KB7kDIHY
9Il56XPPkGGcFqeFCg9IC8UBGT43cSXm4Xm4fulaZctPYBcRTa1NBSN364JoBlnm
lQrRc3/v0qJRw9JQ/1ntDr3himqkrYxyWCEfkOcY0KvAICmF3XLH+GHIfT9Aey5h
Zc86QLY67ivABIG10VVSOliE9BBtSGNwokmSe9ilGyj2gdi4+64bcffNA2NU3VBj
e46dVxFjWDSvN7Enzgu3Q+avsUnx7kPAT3V7GZ2LvQVOWaLLuVQoEMQwMbxCgP3i
ZbinlK8O7uTLoKEJoj3QEMN3iZd+NprguzRqPyu9iO3pjZ7CopuW7vFTkrWEvpmD
svSCFRKgoo5exWGRak0f2IegJheZ9HFHqfuv4h8l3DekPJUfmVpfMUvaV5Lsm4rY
1VNOkGHH/uY5Ugf143RVitM8hiPIJ7Nc8Y2Q8TopSfNNG1owmaQ=
=TZ5h
-----END PGP SIGNATURE-----

--dktoaxa35hbag4fs--
