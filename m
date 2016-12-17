From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V5] i2c: designware: fix wrong Tx/Rx FIFO for ACPI
Date: Sat, 17 Dec 2016 19:38:38 +0100
Message-ID: <20161217183838.GE27020@katana>
References: <1481707438-32240-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481707438-32240-1-git-send-email-tnhuynh@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2016 at 04:23:58PM +0700, Tin Huynh wrote:
> ACPI always sets Tx/Rx FIFO to 32. This configuration will
> cause problem if the IP core supports a FIFO size of less than 32.
> The driver should read the FIFO size from the IP and select the smaller
> one of the two.
>=20
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
>=20

Applied to for-current, thanks!


--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYVYYtAAoJEBQN5MwUoCm2a5wP/0x+/TRPv5vUpE3fqz7nV1+r
ESh5Oy9VtopkcQnqI2KNcdyVHdFH6r5xeNqsTvZ5pZtIHRPtsiwxCttT5ZmYhoT0
tfx7d3Y6TttLA919z4wGJiV9O316BMjUt9jwa91mdtCruRwkSMO69rEkxqjN081j
oFszVwI8f7I9oLdl3pRd4/QP5ckUzYzr2yKDRV44BXPQmeKGW30lfTbQZ9cLy3KB
cp+++DYjnA7FciVcZGqDhC7tdFrpnJw7FPMUppO6PbSKuPoLlK2A+8XEcPkXrKJq
OPkLUN57yOi/LMmyhw+1vgnba2K9HlAQroL/vAsdUpJ6F6QXWgYUtN+4bq0j7q9P
YJvZPR89zbsEX+B3R2bZZzJUe1sjZpdvVtj/9+5g92+RArKPKjA5yn5RnHhqm0Oh
LYxmh9VWOqEOG7UgLG3tKZnr7ovkW0TfhHr4Ai4cNNL/mZjCYk6/ieeZ7tVSyc/l
6wPMu9nWFyU5U9L1u8+lXdgn1tvfRom2mfL9Rm9JXGSP22DGVxG/LwMSYXMDv/OW
btZhpzivEISXeyCfr908ZrZf2K3y2Kq8Hlc0Fi7RiSnrAzqwOMYwNfiQtBS0A6lk
fHTAMHpS/SSo5hW1BA2Yq3kOd/mcQslmHqR8YNpN1da7y0lNOm/4llArIX4+Dlcn
zR9m7jbyPQKH6JefbW2U
=SWm2
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
