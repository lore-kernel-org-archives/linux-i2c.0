From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [1/2] i2c: ismt: 16-byte align the DMA buffer address
Date: Mon, 15 Jan 2018 20:02:26 +0100
Message-ID: <20180115190226.5wuvqfat25e27z4m@ninjato>
References: <20170818160128.21228-2-radu.rendec@gmail.com>
 <20180104134606.GB919@hmswarspite.think-freely.org>
 <1515080529.3062.26.camel@gmail.com>
 <20180104162207.GD919@hmswarspite.think-freely.org>
 <1515085276.3062.37.camel@gmail.com>
 <20180105014727.GA18052@neilslaptop.think-freely.org>
 <1516019600.11739.3.camel@gmail.com>
 <20180115185304.GC24317@hmswarspite.think-freely.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f7gdhw563rnux4hy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41144 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbeAOTC1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 14:02:27 -0500
Content-Disposition: inline
In-Reply-To: <20180115185304.GC24317@hmswarspite.think-freely.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Radu Rendec <radu.rendec@gmail.com>, linux-i2c@vger.kernel.org


--f7gdhw563rnux4hy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I sent the updated patch with PTR_ALIGN on Jan/4. Have you had a chance
> > to look at it? Is there anything that can be further improved?
> >=20
> hmm, I didn't see it, and I can't seem to find it on the i2c list archive=
s here:
> https://marc.info/?l=3Dlinux-i2c&r=3D1&b=3D201801&w=3D2
>=20
> Can you point it out or resend it please?

http://patchwork.ozlabs.org/patch/855763/

You can also download it as mbox from there.


--f7gdhw563rnux4hy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpc+r4ACgkQFA3kzBSg
KbaAwBAAsHd1ELBefPP05x4jDO97E1hkfrWn8C0SYrxvzConLnFa9FpvhCbCKWWv
F/gd5z2BHVZ86k3w51sVf4yTKbPGrQvd0zWMYOTOkJFZvc8ySVxvqlY4jVTBUPyo
ISP/WetrLJBhPIwk05vJ1q9DLm5J218R95ZIyqevCrjtnANmxfu1Milc2znUOd8s
eASj7JKZPGHIUGrQ8L1Nyxh4p96EVVNrM+nJRm7LYXoVu2yrmNZgpjj2v0UOPYeI
UHIrwAEckRmQh+cXsx1h/uNR6mS6lrkssg8pU/rz+95l64WMyubZCb6j/9reay7j
bbOJ0YGuy9cN1ZGkAXtSv+F56j9bxQfxvii8yfVk+Ek7EVACaGs58GKFdDAjD9WG
2qDWdC55z/Drhl3UHqtQt2ghIB0xGHWwBmlnHNstG0GkyNBeMxWftKo42njEpRIX
/PzWNJz3AY+8n9ukobDRGk1Q2ZKc683oBfCyIr2mBRrTGwLvJD6x0fdLZv9pLrgo
j4X/mvL6oAQeoyF9USXLHM5PWE1XypUUGQ9Cj86fYBlVLNCtrjLv8nw0/aW6AIUA
91RBVcEAyP7E7s1FvOfAWT6Jx0X/8xgO5lqYvq8DeOIFQZmjhxsAf7rMApr3Issm
vKpMTRMx0kjZAJNWTI5lDBZvthW+pLfq1/1F9fTUnO6sMW4X3jU=
=dgMh
-----END PGP SIGNATURE-----

--f7gdhw563rnux4hy--
