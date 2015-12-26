From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c-core: One function call less in
 acpi_i2c_space_handler() after error detection
Date: Sat, 26 Dec 2015 08:48:59 +0100
Message-ID: <20151226074859.GA905@tetsubishi>
References: <201512261449.pmBxYtq3%fengguang.wu@intel.com>
 <567E3CF3.10606@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <567E3CF3.10606@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-i2c@vger.kernel.org, kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-i2c@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> The kfree() function was called in one case by the
> acpi_i2c_space_handler() function during error handling
> even if the passed variable "client" contained a null pointer.

This is OK. kfree() is known to be NULL-tolerant and we rely on it in
various places to keep the code simpler.


--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWfkZrAAoJEBQN5MwUoCm2NXkP/3T9Btt307u289g31NAzHAZJ
R58vKBGLhZBdAhOZRtfCFMQ5kB0TfrKDdalObUvU3QnjGJgJO92iueIUIRCkYxLi
tf/ORn6ZBOmrb412c8lQNZv96lG8/mBvaqUoQQVwojAJaW8R9xDhyqcutz26Uthb
VkjM6tEfVD9G/qzeoQ9per5CR3WrZbde4iX0mJNMfUWkqH5sK/4jpdKoDXtBQ3Lq
bfsGCZZI67EBbCJxNfhCv5iAUkZt1INQ1TGE93mIf4XPYmGeXm1oh7GXyTZf1k3H
xFCTD5bFezbLIHlrcS3SfgnTsOmMAIu2uXiuE38WV3eyjIVcwrCzhQM15kW8Rw1T
WaLkCzkkrO8q3v74ugfEHBbTpTwJVQHw/Tzb50tQG6Y5s225ebcn6j7NVMpa/lAs
VTEZlhQwaswcsFKPp7fwmmwiX6kz/6ZpfpQ0MVaqyFDcg3M7pZz0ioyNWaxdwpWV
sW6E3XLvnBEsYHIplAcdw+sXMEocVCnUySgmpDoHOK7SCyzV7GwfuGPpcJBrh99A
jOhmHAGpwTMleUG2pEsYNiuJ4Mk0fueOlBxwvDOPA6f0Pwc5PyhRcJR/gqMsvr4D
/HuGviOmH2rPKpU7dk/7DmbPZqbLioiT7QDRVHm1aTF1HRWMwqbCNao8pJOIfvXC
VfElt6PDuzAaxZgUHKL3
=olSG
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
