From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: i2c-cadence: Initialize configuration before
 probing devices
Date: Wed, 25 Jan 2017 22:09:19 +0100
Message-ID: <20170125210919.x2fwb4lbfuqzyw5p@ninjato>
References: <1484578178-3165-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zlzzjlf6tvm52kik"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484578178-3165-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, soren.brinkmann@xilinx.com, michal.simek@xilinx.com
List-Id: linux-i2c@vger.kernel.org


--zlzzjlf6tvm52kik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2017 at 03:49:38PM +0100, Mike Looijmans wrote:
> The cadence I2C driver calls cdns_i2c_writereg(..) to setup a workaround
> in the controller, but did so after calling i2c_add_adapter() which starts
> probing devices on the bus. Change the order so that the configuration is
> completely finished before using the adapter.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Applied to for-current, thanks!


--zlzzjlf6tvm52kik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliJE/4ACgkQFA3kzBSg
KbaZTA//WsBy0OpadyNk9ARdmR+44HZ3VD9Mj62+qtBfMrj+dzvDV0qMktAnzlpk
U/ZvheE/CrgAYL1tcThcWtPWF+cv1vneuNvzs79tB5DnJWTGKE8XO2wMNbkjWycB
Um/q4J3//f1dzKR4WJIMDulpyxBM9Tz+7q0m3n1Ih77Mk2Nrh9EZFAWW9oUr36NI
KwhE5El6K79tLkPb4XMhUxwNgOGN0vuZ84E8OI4rnMli1RECaHx2/bUugoNC2t0k
5sqOqpCjbH1ukP636lQJ0Ddz9uSpSvX2GMbs9ktrk0P3pnxq9u6O240wydGRPDhs
QYnIla0L15x1GgbT0necDAAUV7i8Q2W83VkG9o5uwW3vK3OXqW3B+2ciad3Oxox4
LrFepQP7ccd0NtYSglx2/zA4EclWZyT4mRZxpnL88WwZtMvIXdS8ezR6r4HRY14W
CwCxMfH+xA2ygsih5AHrhiSCg4PuiACCVDEpe5LmxeRQt0Bi4FO5Y+uMBEma9lFO
qtvZi9+3SvHh1i7k76hwFpNVUdEQ8u+P8aW4WAtWTXAKlnmqXTmSg7/cDBi/CHXn
ofYkg/hCTcVp+FkdH/BjWXXn6VwyjGztDCmuTrb69B4XfMrvvyv9H5noBaulDIFt
6Ev8zqxNL3SK9zgAEIELE1/4fOsB3MKJWbI83KPZeJJKkOaI2Nc=
=Cd0w
-----END PGP SIGNATURE-----

--zlzzjlf6tvm52kik--
