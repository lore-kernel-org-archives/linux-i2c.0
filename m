From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: core: helper function to detect slave mode
Date: Wed, 25 Jan 2017 22:01:19 +0100
Message-ID: <20170125210118.z5o6y6aurwic4zxc@ninjato>
References: <58edd25a0fbe50b6d5abef14b7e46c63a1e06830.1484663257.git.lolivei@synopsys.com>
 <20170125204537.i66nykln4fkxqryy@ninjato>
 <1485377409.2133.339.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7lg3yfzqk67hb6bp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485377409.2133.339.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Luis Oliveira <Luis.Oliveira@synopsys.com>, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vz@mleia.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org


--7lg3yfzqk67hb6bp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2017 at 10:50:09PM +0200, Andy Shevchenko wrote:
> On Wed, 2017-01-25 at 21:45 +0100, Wolfram Sang wrote:
> > > + * i2c_slave_mode_detect - detect operation mode
> >=20
> > I'd rather name it 'i2c_detect_slave_mode'
>=20
> When I proposed that I kept in ming `git grep -n i2c_slave`.

"i2c.*slave"? :)

I think having the verb first makes function names more comprehensible.
i2c-core is not super consistent with that, but I'd say more follow this
than not.


--7lg3yfzqk67hb6bp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliJEh4ACgkQFA3kzBSg
Kbbebw/+Mu+G9r2i++6Zp3sOfyKLWZugw2oULMVMVqAKX8TF+GQvrbHz5jMcUvPz
Lhp0zhK81QxaQ/yXsSCDU1CoupVVixWW1yLIfZBe03aFhuZ0lUaJnmEsHgSkutRN
cnk8x6AH585JelsPz7HxaGI/O+4SMcrLj8XaUCtQBjyrq6/7AfFYEtTJUPWtEshP
ef9OBZbZMEzD9oEm8VH0qJ0fwUQk5jc33KT0/aF+sgrxgtXYC7gDyhiQ0S0QX75K
X/fEv6rl9kqKSc1D1kqJMe8Pgn0GOJ60PWpR3sSuVyhwVIHKL2rQegbEvIdHVqsm
QHlHh+/Lbou+GkwUmrZHtU2UXBcGcm9MXFZQF+lwj6Pl9Y10K//I2nl6KORo4+8y
zhYmT+aJqlJ13Ind/CrWmAYtUtXSKczLtnl0zwoTxFQfjfPE/IT0gFVRRIHZVsek
G01kUf46D/eyQkEP23RDv7diGfJBP/PpDSTy69XVFqRKDLkz1KD58hVZN2rf/q6s
6ztxLMkumKkDROYn9ZphQnQtQJQAbsrsr2wncl06Bmw6he60jY506LhD6T8h/iLc
IG+Wn5uiIxH7L1N2ifKVQgWpl/2EEYSZZHaYonXrPVCenBEr3Xv6d14fABzVOFUA
3tWejSgfnzMGKraFRsYWN9n6qz4s3ylhB+Lewi01k+nJmk3JKp0=
=pQl7
-----END PGP SIGNATURE-----

--7lg3yfzqk67hb6bp--
