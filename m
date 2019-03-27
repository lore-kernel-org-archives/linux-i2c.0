From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 0/8] iProc I2C slave mode and NIC mode
Date: Wed, 27 Mar 2019 23:27:12 +0100
Message-ID: <20190327222712.GD15396@kunai>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 09:57:17AM -0800, Ray Jui wrote:
> This patch series adds the following support to the iProc I2C driver:
> - Increase maximum read transfer size to 255 bytes
> - I2C slave mode
> - Polling mode
> - NIC I2C mode
>=20
> This patch series is based on kernel v5.0-rc3 and available at:
> https://github.com/Broadcom/arm64-linux.git

So, I had a high level look at these patches and made a few comments. For
the details, I trust you (being the maintainer :))


--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyb+L8ACgkQFA3kzBSg
KbZYPw/+PYVz9b2xHF9zo5/uC9rhvfMlpbw80Qc8bL+eeE9+/Q2HTKCxNxTCuUIh
oO1z66oFTDIdSPCQKnUKKSbiMun4a5k88lFQFm2emSU435yccnuCE+sAe+ER3XWJ
zFi2OjtBBERc/doieK68ppcyRTOg5Vj2jIWhyTQs6ZdcDAn4VtzZEzMyKemZdS1l
FUlNzfb+drlxqK1N96cnDHOl0laTEmp/CqbePXw4FJ9rGToXCMKf334knDJBgqU4
xzieZMQPVSXAOVI7uADihzvYq3GL1YQhcM4bf5G8mTkNPHDKhFbXBjHorH3hEFbH
YmGd5YUjaqpLhoKfZ5caapuryUM17BWzlT4QWAVvdMFpE/RYUIchkePU4tWZ1q7q
l6hB6VrTHsZ15kPCNQUD5aJpWJKnMWI/LwHbFrsiVxB2FqGD5RA18U6S3LRAOzQL
I8xj+O8Bvl3wtp1olbE++CXMd0Hk3AwLq+9p+Us18/AVgI9JGiCYinL/h4557TSK
y4oDvJXGW09QZnBgK7KkNiF3glVDbcOQyV2HWLFjCuWJVgXDcrSYKG0szW/Az+Rr
gIg+qa9x11nXjb5hhwWbPUY0HqoeMOCN3kp4BVrk2o5MhlBi4/G26yKPGHrljRyE
Jicrspmf50xyXSOLL9dz0B3FPYWTzssM6UDdsfrvkXvGB75FTIY=
=1BDz
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
