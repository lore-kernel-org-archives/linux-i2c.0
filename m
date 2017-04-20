From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/4] i2c: octeon: thunderx: Add I2C_CLASS_HWMON
Date: Thu, 20 Apr 2017 17:55:29 +0200
Message-ID: <20170420155529.riir2yqhddj4y7lj@ninjato>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-5-jglauber@cavium.com>
 <20161211220434.GH2552@katana>
 <20170125204923.2mxtlszvco6wxjok@ninjato>
 <20170420091632.GA8383@hc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o6zj6kuoaropastm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49777 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S946533AbdDTPzd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 20 Apr 2017 11:55:33 -0400
Content-Disposition: inline
In-Reply-To: <20170420091632.GA8383@hc>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-i2c@vger.kernel.org, Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>


--o6zj6kuoaropastm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jan,

> We do want auto-detection, so either this text is wrong or setting
> I2C_CLASS_HWMON in our i2c adapter is correct. Am I missing
> something?

I was assuming the pci-driver could ACPI for device instantiation, and
the platdrv could use DT. Then, the adapter class usage raised my
eyebrow.

I just saw that the pci-driver does not have ACPI support, yet. So, the
class could be used. Not sure about the platdrv case? But even then, the
adapter will probe EVERY hwmon device as soon as its i2c client driver
loads. Do you really want that? This may cost boot time, has unneeded
traffic on the bus, etc.

Regards,

   Wolfram


--o6zj6kuoaropastm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlj42fEACgkQFA3kzBSg
KbbEWw//S1zB9DwcHiCV9u6+LoUW/FC26oE0hGF+rloHYHRhD0jJJQc8thdYM3+E
AYQoEjvNip/izr93TRI0VsPioOnCBrM9Xlc4Tg5dQ7nUQnsS3Twczn/Hpy26wzQV
YXsBO/yDVq2QSKLiCgRnHzBB+p78/drK1pWZXHNJXR1oKwfJ8ZCVMy8ubSagXUFs
Z2tTSbD4c1gg3Jhd9CQmhCza1oIkpyXpHb4a2mIla/RlIckr8LpzavTLZ261Eci0
Q+Z06E/JI9rpjIcDZl8lrIfmfOHuOY+DNSyT9hLWAcIx840w8kudOYvoeF5WcCS6
J2SGS//WqeJoE/c9rfloNfO0kvP7IjPCn4loigTzfNQsJ/BSdkOC2lhApqVPGG2X
DDILwYJqNeZJn4zpFXWv1jgRPwtVIk+ufOR2O7Gh5kKEpSa6B9epO0owoim/oyyC
O06Hmc/NIsLzuuWM0c5sAWsyEAAHwz1+bb8xXOnGIdsMCd0APIa98YLuA6HF1APV
GRowRgWgQBXyWh1A1I6iIjhhLWgrviWvbFy3FSuIy0cvqPtB5EuSwCPQYXOpwqcj
M2oEffC5yJBOvSj0xsfm1mGi5rmL1qdcijb857J3VmCSC8B7kROa5y9fw7ldoaTU
qqMttIKxw1B2BqRqGSYajbXWCV+VPL03C5ngZ9oHPw8au2YWGJ4=
=n0Z6
-----END PGP SIGNATURE-----

--o6zj6kuoaropastm--
