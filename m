From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core: Prevent race condition when removing i2c
 devices
Date: Mon, 31 Jul 2017 16:11:17 +0200
Message-ID: <20170731141117.3fhlmene2zow6bbh@ninjato>
References: <20170608024344.9311-1-david.thomson@alliedtelesis.co.nz>
 <20170619143656.zigxk77vegedscjx@ninjato>
 <24ee1e30-1737-e3ef-a23e-01d41a29d45f@axentia.se>
 <2e4c5807-3d3c-1ce2-da35-3e37b2e3b08b@axentia.se>
 <20170731133814.b5lyujdl5iwhcalx@ninjato>
 <111b974f-8db7-8dd2-18fb-582af47a341b@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5lz2f76i3w6kp5sv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49430 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbdGaOLT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 31 Jul 2017 10:11:19 -0400
Content-Disposition: inline
In-Reply-To: <111b974f-8db7-8dd2-18fb-582af47a341b@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: David Thomson <david.thomson@alliedtelesis.co.nz>, linux-i2c@vger.kernel.org


--5lz2f76i3w6kp5sv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> to do so and worry about rcu grace periods etc. Has any driver model
> expert looked at this struct device reuse and blessed it as ok?

I am quite sure this did not happen. That's what I mean with "despite
the docs": One shouldn't reuse struct device, some people did it and got
this "fix" in place, and now people might rely on the "fix". As a
result, we can't simply remove it by saying "Ah, that's cruft. It can
just go." We'd need some deeper look into random drivers, like you
sketched.


--5lz2f76i3w6kp5sv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll/OoEACgkQFA3kzBSg
KbZrFQ//e+SJbEhokkHX9ysh5Qs6dh3Dr5efYsU9bvceUFDQXOmStUVkms4qHEaK
l8cuynvSgM7hCXPloKwOgnzjD00xwES+MtLenhx+c8/nRnpKRNIem+fMkXanpeNK
SnWgHL/+MCe30+EEiKkErX6bl4ophlq19Ypt30vC2l3BJxECbEBBi8npSqG5WpyO
KTLEKbfHKkEx55myC26OQWPWITWw+NMN+KEximO6etCadXDKfFxdXHQhSUqTIqYX
Wjx2eBIf+dsecEW5RvOJUT+ZEDeTWLrLaONwUs9vgXVYjrkZCUN1FljjEGqKSMNc
T26TnV8gR2f1NTNzWaAJmaMwleFbLW2ZD5SUnG7IFZ59zHJNkP8xwLLIvHUQHaNE
jzK+/F2RiAvC+FrAGZyF804UNqpQNEPAOoF1DyUkL/WI4HPRpyZGbzgSaJR8F26B
xicRyQyNZxzNSSCJpJKFUC9drcVnsqQ3N/rSrD8CQXh7bzuXy8hRoWM2uUTJ8lJx
hzyCqB7AucrOJYX8HQy894NRo1l9fuFCtKwetpdRpZi9CK1x0ZUoBkr/hkJNla0a
c8InLBxt9G6bnK+59/v5DQQEpLXm0dz8UF4MyooDE+Bjk4+T3FKIDUrWxVYiiidK
Lab23rBAtZ2MBnKYXXIQWP6PCdChsUhgAV5TNW77PJnoOHE+Mnc=
=eDp+
-----END PGP SIGNATURE-----

--5lz2f76i3w6kp5sv--
