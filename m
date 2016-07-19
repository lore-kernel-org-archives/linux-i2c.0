From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c: core: Cleanup I2C ACPI namespace
Date: Tue, 19 Jul 2016 06:33:36 +0200
Message-ID: <20160719043334.GE1640@katana>
References: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1465212383-24639-2-git-send-email-jarkko.nikula@linux.intel.com>
 <20160714133524.GF4149@tetsubishi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56393 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbcGSEdp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 19 Jul 2016 00:33:45 -0400
Content-Disposition: inline
In-Reply-To: <20160714133524.GF4149@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2016 at 10:35:25PM +0900, Wolfram Sang wrote:
> On Mon, Jun 06, 2016 at 02:26:21PM +0300, Jarkko Nikula wrote:
> > I2C ACPI enumeration was originally implemented in another module under
> > drivers/acpi/ but was later moved into i2c-core with added support for
> > I2C ACPI operation region.
> >=20
> > Rename these acpi_i2c_ prefixed functions, structures and defines in
> > i2c-core to i2c_acpi_ in order to have more consistent name space.
> >=20
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>=20
> Applied to for-next, thanks!

And reverted due to merge problems and 3/3 not being in shape currently.
Please rebase on v4.8-rc1 and resubmit.


--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXja2eAAoJEBQN5MwUoCm25Y8QAJsixJeYVYZ19OGmKB3ICXsV
IBekCjUkX3ttINvPm1eNbWTpFFN4QHgc2OBLAXm+5ot6pJH41uap3dAki0Aqtt3E
m2AKMGQDl70Hi2tP1hcQLBnqbYLHSBlMwSbyUcFb/TxDib0GGqAJigZVu5gB36IQ
1pG0InYXU96podLA18mdBwAW3ikDJ6/qBaeHUpnTyGJ/aCe2x7pfENqosYg+cnbs
5fRmZBnvWw4Azgkpof3suQZSyqVfckVVK0kbM6bxXEAoFf1Nbj2IalMfoDxot4pO
1h9nNoNkwO0c/zmN1FKnKwsgeNHQYNJ5+UGiBolna9mweW1XLcBsjXXy/qUnteTP
xMMmiKzW3dl9WYK3ZERR4w8jB+DB558+HAYBxsKocEpmnd+EecRvhLGsR7KJiTVE
YmjVEiFp8AwK4IGMfMySj8wXwyd6xveNaqcszQIBtlVV74V+9iM0odiKZ0pwJOnc
9qyL/t8pceKbsPmtxd8pAP4SRgY0jlmYeB5RXV1ZsrT35lKi/SHF3zj1kmKVGglI
RQebAVaOPWzOVwN6H58AqxRzRP4en/ArHXFkg6DgSNNxdQhjHxFERDnzugt8tOzA
8p0uka/ATsjm6KAplnpw9T4xmm8aeAz7rk+hKrxAl7SOHL/j7R6WFIitPc6MusTK
AiB1xAmCzcHCtbzayaze
=i8sC
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
