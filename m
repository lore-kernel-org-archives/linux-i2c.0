From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PULL REQUEST] i2c-mux for 4.10
Date: Fri, 11 Nov 2016 11:21:19 +0100
Message-ID: <20161111102119.GA1687@katana>
References: <7599c37b-c5b1-edb7-e8c2-5afa025a1233@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37797 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbcKKKV0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 11 Nov 2016 05:21:26 -0500
Content-Disposition: inline
In-Reply-To: <7599c37b-c5b1-edb7-e8c2-5afa025a1233@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> here is a driver from Vadim Pasternak that I thought you were going
> to pick up after I acked it, but that didn't happen for some reason?

Yes, because there is not only the mux driver but also the Mellanox I2C
master driver for which I didn't have time to review it. I thought they
belong together. Meanwhile, Vladimir did that (thanks!), so I am likely
to pull that driver and the mux driver in this weekend.

> I'm sending the pull request this early so that the driver can get
> some more bot exposure.

Thanks!


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYJZueAAoJEBQN5MwUoCm2npYQAJ5X94vriq+bmWFtLgg/7nto
KLTUcLV45XfJgFWvuKFN4Rfa2XHTfoCq2XbsHyKsOj7xthuKDavPEckrIDdE2pYG
XgNRJElZg2sWrh7rj3JURVXrU50gJtpoy7hHWHi/MG9AlLVybEVWfCvQvCIUHzg3
6VDj2idVOcIgGkQBVM41Qva7FE6sY15qgJWodsP8vE46FTvBLMLCKefUZO6GYxyJ
wzorWpe+IF4iTYW7lM6qRlhnE6Hxozyz5eT6L1/bwGJwjWYN8OY/s/QSzYddueGk
Deb8+E61dwQ9ejAK4VWUb6CnSWQns+ME9AfJA/Nv9aAvEeA3zS5Bl5CkcZ2k5nz+
L7STcLuSi8lKh5SA/goN42eQnaJJQrbpFyNk4TH6SuCBPWFhhxBkalYQ5TRnvob6
9LW51RAGNHJeyIxfZyY8TRAlHl3HR4UE0oBCgwn6AimUFd6QaZobEVOhyYCvsRzH
RGtV3MVlZN/DLUUZ17WFr0bl85uiTHeirpiHngP9u0bBb0Iac4z3IEpb/cm0kQL1
bD5OKEFyLogge8cUk02dA2CZOp2Jh9lMJciyJeJe4KXnVqD++tR2Zpapsm3LuKUv
gSGU7H9YthOJTJ5quCCHLDL2IxzlAMZbevqNWzE26HXeRADnYrQy1r/riNVbwEW5
bU9R+vjr4eZku+NVgnFH
=OnA3
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
