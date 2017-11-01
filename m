From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1 01/15] i2c: Make i2c_unregister_device() NULL-aware
Date: Thu, 2 Nov 2017 00:04:39 +0100
Message-ID: <20171101230439.7kiv6qln5amzbid2@ninjato>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yn7nqhkh7p3mxzmy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59336 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933336AbdKAXEl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 1 Nov 2017 19:04:41 -0400
Content-Disposition: inline
In-Reply-To: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org


--yn7nqhkh7p3mxzmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2017 at 04:21:35PM +0200, Andy Shevchenko wrote:
> It's a common pattern to be NULL-aware when freeing resources.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to for-next, thanks!


--yn7nqhkh7p3mxzmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln6UwcACgkQFA3kzBSg
KbZ2TA//S1ujCjxn2/fdVjtkK701/zvi2XMCcxCiKgjcgugWrbLW1zBC7A0uxEtP
hI17O5S9g5/k52n7NQjeplBw+Dbb0gNYmpKhOLhFGqTaa+AkSvjCcI0sqbIQr9+t
cL+h9qT01x+xpPAlh6c5/0V4NPdxiXgv8yvH1xNHZtR2JRC+FKfKoQnxuRVA6Dkr
niT9RXNurcbnpPXosexdsfCMlm9D/fXd7I1dGZAZSyecTlAxV0N7mkzCmb7MMZCU
+q44i1pDOtzxrqMXKN1IvBi+lvln2z+7j1Ve5oq11PkTjwbFtCTLHa65S1tYZYsj
HhYHSlMO8ff6nbcxd3l05NRsb1mD/p2wRUoovWMOg26qvMyv/2DX88smjsSgyd8y
QmJWC7WLdimOLhqjXezQwBRE1BtQnhDt7Aaf9oytFCO5ZFmLSjBMBLjnLolzAk1c
Ct674yzWIrstu2ynhFWFG7+cjmHZjIqQFq0eHDKSK370FXGRZ9hXRfIdIy3rIIoT
+uFFfRhk64HeyPU1NrRx0N4OlmtMuejCYpt3Gdmq23tGktabXfkcIuXbFTbO+JMN
cRHmJmjBpFf0mG3CgpbMPDaMbnZOYa1WEh6M64YFDxkKyJT7iGQKv3sZ+JAlEtBR
AcoGCXl+21YQ0PeV1cbDScee+RQsl6MD1hUHOXf1oteR5UG8iVM=
=H9ng
-----END PGP SIGNATURE-----

--yn7nqhkh7p3mxzmy--
