From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c"
 compatible string
Date: Tue, 2 Apr 2019 12:17:57 +0200
Message-ID: <20190402101757.GC2960@kunai>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-7-ray.jui@broadcom.com>
 <20190327222439.GC15396@kunai>
 <0b97cacd-9bf4-135a-b2ee-1d51ab380b1c@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0b97cacd-9bf4-135a-b2ee-1d51ab380b1c@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Note APE is a co-processor that is not visible from the Linux running
> from the host processor.
>=20
> "brcm,iproc-nic-i2c" here is introduced to allow the I2C port from APE
> to be completely owned by the host CPU, to meet the requirement of
> certain use cases. At the same time, the control of the I2C port from
> APE will be disabled.
>=20
> The "brcm,ape-hsls-addr-mask" defines the address translation and be
> programmed into some configuration registers to allow the host to
> directly access the I2C registers of APE. Note those configuration
> registers are owned by the host, and that address is not APE's address
> space nor the host is intending to take over the control of APE.
>=20
> Therefore, I think it makes way more sense to use an address mask type
> of DT property here.

Thanks for the explanation! Well, since Rob is already OK with it, then
so am I.


--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyjNtEACgkQFA3kzBSg
KbZsNhAAqxsHCfBYJ33tztPs31q8C+sO9ENStERBsehhnKVof2x0ArFYXmPzyOU4
J/Fc7OM9vVZhYoogbIxSZvL0ixi/v1WYDCQiyxAEOKOb4kr35gdawRM41KgP9390
9Re6BIB0MdW5pvgoTz2Kypd6StyIHOlinvjC1eSedA4/CXd4n7e5e1k85UqopYpk
7gY1CzTrZ073k/hE6WR9cRmj17TxyWnhQNJw7tmcc+5DUmaOVaNy+n2tUBF40W1a
ALldjj+BwY4oIir4jmfGar4DWUBNW8LYKfZHY63FC9CWPkjNNpSA60yH9V2ZM5wd
LznGq3MBfS6V4yVGaFHkJRp9BQRgkTe1kLxDrNskDxxYfjVcuavf4c7xgdsIXi+m
KDY5voyZxIf5tVq6J/J3fYw2KYn4Ep1DL7RJ0kA/9fmfYD0l+KXTTs+v/ofipWsR
N8+0aJ2xH77H8XoFJtaFqdcVtJmZu+RUXq8O2TvhVxQ7KgHFMW0RyaflJSxcspR/
eMZBLKvCvZrsyZzYf/AH8merQtDWXlO0a7mgc5MbZflZFtWyCOXmBI14o67y6EyA
S60JTbEsLfO7NLvpK2P1DvY2CT9I3UGQPupTBR3vDh5lj3E4Cek9UC+KZ+v4I9CQ
DfDshJFLrmPetrEvx2auDtKuhdI86a7/BwCV3yYqQsqcb/ZsOh0=
=c8Wy
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
