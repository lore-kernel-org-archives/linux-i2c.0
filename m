From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: designware: Fix runtime PM for I2C slave mode
Date: Thu, 17 Aug 2017 17:57:12 +0200
Message-ID: <20170817155712.oces7tvdrrrstob4@ninjato>
References: <20170815143445.26167-1-jarkko.nikula@linux.intel.com>
 <20170815143445.26167-2-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4fjhfbfguri3wyey"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60295 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbdHQP5O (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Aug 2017 11:57:14 -0400
Content-Disposition: inline
In-Reply-To: <20170815143445.26167-2-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>


--4fjhfbfguri3wyey
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 05:34:45PM +0300, Jarkko Nikula wrote:
> I2C slave controller must be powered and active all the time when I2C
> slave backend is registered in order to let master address and
> communicate with us.
>=20
> Now if the controller is runtime PM capable it will be suspended after
> probe and cannot ever respond to the master or generate interrupts.
>=20
> Fix this by resuming the controller when I2C slave backend is registered
> and let it suspend after unregistering.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-current, thanks!


--4fjhfbfguri3wyey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmVvNgACgkQFA3kzBSg
KbZSVxAAh8seYj8cHGE7LsDAVk/Fh4HAWuRotyZzisLyHUvS5qMGnnuPmIFWmCIP
P53Cp0hKf+EsnU1zkBEnQh2NYQY6htFO6R7kZ1289B4Ihafkv2ghHD/KEwHLptNx
/2CAYc551LjNqGmNnHU9QOve4Bt6fGwZsG3iDWjeJofnS7CDNpmSixVa8eGpTCrC
qO+dHjc/9cv0n4qpP47WfJpOLK6a92e9r6iDlZGreJWos+b9mpXsKObI3LowCCcK
yZ09zASugP1ox7DJ1Pw4MSMLoqwYZvAi6bM8Vl0KTH7G3THc5mlqducK3qUdckWD
MH69H/JZgCI3RWgX+yj0ASD+FeCfbET4/hvzQRzqWnq8HfqDzFEkSFPwxSanKysZ
8Yx6J7mcwog9Ermw6V1/6/nWoInm7sCMMGw3r+CrwG7zwTcD5btE9H5rAT+8Fkdy
4wCILnOjObAQh4RC1ZkcaeRxasBX2aCX3W6p608hh55P7wuW8NKXNI+VaybCsywI
m1dtK7bSWxCTz8dWYBVj1tglbU/ZyD7XC0Bhh2NBNB1h7xAt0VUKPvcc3xuXxJOC
rHmMcnBEWl/hOhu4QwD4ZQdiHCdJ8lVEKvc6FekC2a4ioJYx7hBojL6ulzgZ+g7b
J0RycP/r6g4b/8qa2ADgtpYjy44/56iT/VOV59N1No+II2U/ITw=
=Wss0
-----END PGP SIGNATURE-----

--4fjhfbfguri3wyey--
