From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V2] i2c: xgene: Set ACPI_COMPANION_I2C
Date: Wed, 17 May 2017 09:20:17 +0200
Message-ID: <20170517072017.vo5m3duzbqoe33on@ninjato>
References: <1494995134-4124-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ocq6e6urfbq4gup"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1494995134-4124-1-git-send-email-tnhuynh@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Phong Vo <pvo@apm.com>, Thang Nguyen <tqnguyen@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org


--6ocq6e6urfbq4gup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 11:25:34AM +0700, Tin Huynh wrote:
> With ACPI, i2c-core requires ACPI companion to be set in order for it
> to create slave device.
> This patch sets the ACPI companion accordingly.
>=20
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
>=20

Perfect! Applied to for-current, thanks!


--6ocq6e6urfbq4gup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkb+a0ACgkQFA3kzBSg
Kba+Fg/+MUbjU/gNoELdzUt1rtuCM1FLNggrU0jElS3IccrqK7hicgYaWsqgVWsj
UJQ7Wi0AiarCsZDypXQ5/Um3i40n/K3OYueaBhFDntKtTZW5xZFJ+uYoK0MgRFYx
tvfrb7qN96T9aIvTDIXDW0Ozc/k1R5IslCr8ah2QdVuNmXPaijTyu58O5j7htDmG
y9FRP5M40Qac4BoKlrrxZob5UenGcN2wpZdEmnCpgcruZRYcRV8ROefE2Zr7l+qk
0GZy7jDPYry3LBykDYXQQlq3/51h1mdOjE3hxlfzJEfY35mInK//NwipXHobt5Pa
a1COFgOHuly4Or5F6jagM6B4/xJpenz5cqZMY9Czcu/tnreJPV5os5fyFSij8JT1
zOvG9ZKYPI9KlMukdr+RiG9PXzDobsFFx63/pDrW/ksRFwrL9auhvyt9ubMHBTXA
bDBt4hbvuDg0GYRSH3++rw7ENp1O8spYH8g7XSaNYi0mgU0DDbXR2O02K67cXcbl
i/95QclVKnGQWrtzV10IFHVeUfzjWG61ZM3w6xDWBz4Eq24LVCoNsmBflUgldHiC
RbpPiUdc49J0vGzWLPdhX/xnCbRdaWYHGwiru98rLiQjSk/PLZUGT2tcF+isdmtr
iBCE8DRtyiPwwAyfjIkkTajvrjwf8Fc+T42MBiR5pj7qIUPQ7n0=
=SjHm
-----END PGP SIGNATURE-----

--6ocq6e6urfbq4gup--
