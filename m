From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 0/2] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Sun, 25 Oct 2015 15:53:07 +0100
Message-ID: <20151025145307.GA9701@katana>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445628427-29244-1-git-send-email-dustin@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445628427-29244-1-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, rjw@rjwysocki.net, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Puustinen, Ismo" <ismo.puustinen@intel.com>
List-Id: linux-i2c@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 23, 2015 at 12:27:05PM -0700, Dustin Byford wrote:
> v5:
> - rebased on i2c/for-next (Jarkko, Wolfram)
> - include acpi.h in designware drivers (Mika)
> - remove return from void stub function (Mika)
> - add acks and tested-by from Mika

Applied to for-next, thanks!

In the future, when you send new versions, please don't set In-Reply-To
to the old version, just leave it empty. I (and most maintainers I know)
find it easier to work when patches arrive chronologically.


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLOzTAAoJEBQN5MwUoCm2bMsP/27pnVIRqQfPe0e2hCD9yIMW
eYI3OeznsoDVaUpB9Nqqf4ZoyDRWLznEcth7lXrDCsnevmYNgIpvRXIWPL1Ck2Yq
94M/AT1qxmRzi6N91imjGVUBnLa2SZ+B8LK4VwBoQ18bYTOFq2EuSZsTETudEwZU
b8HJHopznSg1j3Jy+WW0poPb9KL265VP5IyIQsbC/Fyjad2cgLGT0Re5AB6UYMHT
hXD5LOrte0599j0sSGCqFtoWuiqVn+HwtvIoTE4DYn3auySzsZE/LQRZIKbhiR3/
H7/8sn/LZAuJTrXCyrv7HhYqbgPv0KKOSJ3GjPZ78SzZ/5Kxky4vxWkYw823J2iw
sP49lciFpToB+sL6Eay/9mOQh04aa3jEcoyOHYdA8z/dFa+Z5PidqVdDE4X4q91e
7G21FqAcLwRKTP65d6kQS9OT5GHFA770JCuC+zPuoTXHQCGZo1WqUURlwEEglbZi
ZjsInH1AKsDgO2xa/JrUUP+BvOXJh37hyJVyGnf0wGh5dH9QVb+Twa6NRs8c3sMp
/mZ6dy8L+cL3umBhmNk4R9m8dMbPxd4Dgxam2zbXl1T6k7N3Phao9d3ilfNmUO/x
sv58tKDFunj6HD9BFJ0GuyGjp+y/3AX8I2/FsUot1rdOQdxS7353YxdPspAClkfD
HX8VGEayn3hKw0uI1XEW
=VI4G
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
