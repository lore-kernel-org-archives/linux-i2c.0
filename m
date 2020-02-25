From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: xiic: Support disabling multi-master in DT
Date: Tue, 25 Feb 2020 15:32:45 +0100
Message-ID: <20200225143245.GF3677@ninjato>
References: <20200218135627.24739-1-ext-jaakko.laine@vaisala.com>
 <481fe028-0ec6-eca3-7436-ebbb8527f3d8@xilinx.com>
 <AM0PR06MB518514EE9C057CB129079825D4ED0@AM0PR06MB5185.eurprd06.prod.outlook.com>
 <20200225141357.GE3677@ninjato>
 <AM0PR06MB5185341478B6919A9CC22271D4ED0@AM0PR06MB5185.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39480 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729065AbgBYOcr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Feb 2020 09:32:47 -0500
Content-Disposition: inline
In-Reply-To: <AM0PR06MB5185341478B6919A9CC22271D4ED0@AM0PR06MB5185.eurprd06.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Laine Jaakko EXT <ext-jaakko.laine@vaisala.com>
Cc: Michal Simek <michal.simek@xilinx.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shubhrajyoti Datta <shubhraj@xilinx.com>


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > My favourite is to change alignment to be just one space. Then, we have
> > a bit of overhead now, but never again in the future.
>=20
> Ok, I will add that change as separate patch to V2 patch series.

Perfect, thanks!

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5VMAkACgkQFA3kzBSg
KbZ1eRAAj2o2lLo5F8N3ORBhy3oJ7RSWBJf5ri4niPjoNKlN2ui2uKIUVAbcM3sC
DQ6gqmtB+dg+9JyqhN0V943tC5wCz/Cu7A4iLc2z1PEH5v/ksRmLylSwOUbapaSB
tmD2nzOM9EbMrvrwdt6tbjoS/EaqhE8G3T9Svy077tQ5xJjL5mNNxbes9W88cHRR
sQu+SPaz+TYW7OP32PXQ2YW/vj1SLRuDjEyGSZP7iZhDFQONeBBqRWA2bLuAXPcB
Hm6YwolYqOtZvEq8tIphQz/R1W8ZekYGddLMns8KYQxnVUUR63agleMO6Gy1E+sr
Gxlyku0pRenu8sNB+dvHPx9Vs8VPLsYmocTGwW3Z7NJNPl0tucs0KLM030iLGxWg
r5xjGnoPQ0sdr/4ZUI8YN4cNCUTnacHZLhNw1QB6YSYmHbqjvcCyqjkXcK/j75TT
5yOOd6b0hekUqlqWQ69jnEZoXB45RoJiAvYXn6EKlkcu123ZCYtdu7Wk8qqE5Yqf
CjNwqupYVg0gdwUR7mihYnD0glOBRS+BdFZtUisXZC77JdgfIygZ5NaTwRL4r3zH
zrKkIg6R3sb77KP1w/r+ZbuMGZGl1XbErKBGGZSsT9C/N7VRaUImMI2KhYK1Z8j5
yQfYIPW71AR2FIXYUV9MCt5i5VhBVvAP2vLvqL+3LVHHSjChSy8=
=fkfy
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
