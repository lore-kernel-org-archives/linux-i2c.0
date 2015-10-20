From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 6/6] i2c: designware: Move common probe code into
 i2c_dw_probe()
Date: Tue, 20 Oct 2015 18:32:17 +0200
Message-ID: <20151020163216.GA1014@katana>
References: <20151010075725.GF1619@katana>
 <1444658135-9281-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43818 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbbJTQcW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 12:32:22 -0400
Content-Disposition: inline
In-Reply-To: <1444658135-9281-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2015 at 04:55:35PM +0300, Jarkko Nikula wrote:
> There is some code duplication in i2c-designware-platdrv and
> i2c-designware-pcidrv probe functions. What is even worse that duplication
> requires i2c_dw_xfer(), i2c_dw_func() and i2c_dw_isr() i2c-designware-core
> functions to be exported.
>=20
> Therefore move common code into new i2c_dw_probe() and make functions abo=
ve
> local to i2c-designware-core.
>=20
> While merging the code patch does following functional changes:
>=20
> - I2C Adapter name will be "Synopsys DesignWare I2C adapter". Previously =
it
>   was used for platform and ACPI devices but PCI device used
>   "i2c-designware-pci".
> - Using device name for interrupt name. Previous it was platform device n=
ame,
>   ACPI device name or "i2c-designware-pci".
> - Error code from devm_request_irq() and i2c_add_numbered_adapter() will =
be
>   printed in case of error.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

There was a merge conflict with a bugfix from i2c/for-current. I think
it is okay, but you may want to double check my i2c/for-next.

What about this irq-clearing-in-probe thingie on top of this series? :)


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJmyQAAoJEBQN5MwUoCm2vd8P/1hyoYrGxsv0NvME6w7z3HaJ
w6i0/KtTojKhNJoupbE6lMlU2EGoq/5e2O1+5P0KYNkrSmSWDYqKa724wHK8PGc0
SRhK80q1+wh+d+01S6IvmxD9wqucbnDleHJKNyI1EZqBMFkrmpLlsWZvmMdWKps+
43qlnTLt+IDcNQqy2azrYpj11LogOCp7SM3kmIg7F0TEFDl2RJu38HgD1czLv5BC
h43EaHKmoTDMZ5YCNuIcEwYB42n/ECKr7w/+NlDR0WvMZu0zITBP3AmrpifeRdt/
fagmrWKA1Z2sp8SLoRYybOFKxEEBpMXK2Wbq0Gy/tSLWGrrGTcHJaWbVLL1gvg7X
UWYoC4cdZHv+ncROOIYcmC/pJi23yUuUtZ+ky1Lmi0r1hzjeUHwlpjXpCBOPCwx/
9H+Vb/1K4KkxC4zz63H2DnsnZ02fa+KkEtB7ZOXFduZtDnD7O1IyT1JGV9JcKB07
d8ey8LgWJeZiUtH0CiAAOaAxWXR6ujl+Ppa4o36PneFj20CelbkLvT3b/XFehtuu
ylACt+c5ZDqBpA0uwTgmy3VmAloLNozQLQ6isNglsQf4TQLEVt71EGeBK6VN7igs
O1ii94eL+TV7lI2xbPmB9VDO6ZPSMtgwnJmzXtYaq5yNdsdxrgB127Mew9M3iRqF
Xb2j6DXrknsbGM1Dtlkv
=mbTr
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
