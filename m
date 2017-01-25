From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: core: helper function to detect slave mode
Date: Wed, 25 Jan 2017 21:45:37 +0100
Message-ID: <20170125204537.i66nykln4fkxqryy@ninjato>
References: <58edd25a0fbe50b6d5abef14b7e46c63a1e06830.1484663257.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ljn6hsreszyycawd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <58edd25a0fbe50b6d5abef14b7e46c63a1e06830.1484663257.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vz@mleia.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org


--ljn6hsreszyycawd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> + * i2c_slave_mode_detect - detect operation mode

I'd rather name it 'i2c_detect_slave_mode'

> + * @dev:  The device owning the bus
> + *
> + * This checks the device nodes for an I2C slave by checking the address
> + * used.
> + *
> + * Returns true if an I2C slave is detected, otherwise returns false.

Both paragraphs could be a little more explicit. It is not about
"slaves" or "clients" in general, but about those entries which make the
current master act as a slave, too.

The code looks good to me, so we are close to go!

Thanks,

   Wolfram


--ljn6hsreszyycawd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliJDnEACgkQFA3kzBSg
KbbB4w//at6Xu2thB4Tg2Nmn5+Hlc1v7sQu3m0yuB1znGafMvqRc5OirW1HSDTsI
/X7aH0gmFkp2MPV8MIztCThaD7Ej8TVSQlNT3qm3wkUlGoR9LH6U6A/68HjAeEuY
6AYQ9o9Bt0up13NJiTJmzyjzGtjo1F3yXsOeRpQhT/M5LUdvXz2q+/HhFZg61WaZ
qcneahmce3wLjqKGqk1lAweQHxubwSFt5Hc3LWZJFo0dnbEi/V5+Jy8q9LXNF4RE
A7IX+OF+mSmoqj3YNCW6PZSfm1gO9CRudF1mZ3nTUg284a3PCbDwazFKoK5Xg3jo
v4I/OLgHCeYteXs9acSRVTc4gacH6LMDhFNwsdF/kDqA2DFoDet4Vy5TqLNmqhuD
0H7WFCugP7x+5vu1q/ODqUjxzt5xjYDa3zyTAgGSEDCsJYj2wdYGV0cPwKxEfdc3
TXxPBUAEZc0J42Gimu6w1skTQ/EpeOASnj3czZ9w+ecPc1rcW4Snn6n9EQnenO7C
IFlUEaIEAoR6GuQiPWcuGstw+JARBhu9x4XsCPgnVxfRu8tyfjVX3qP2m58hcPFl
ZngpkdWwrbK3FnhwISLZLn0ATiSGXWtYASUcZ9cIvjhJJUWLSK6xjQOhiuNmEppP
JSdPyuOt/mOe2vJ4l2YxNgGsvPB3WaRGInJQMKgogP04F0hHigQ=
=qpJp
-----END PGP SIGNATURE-----

--ljn6hsreszyycawd--
