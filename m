From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c-tools: add new tool 'i2ctransfer'
Date: Sun, 19 Jun 2016 22:00:30 +0200
Message-ID: <20160619200030.GA3329@tetsubishi>
References: <1434710432-4182-1-git-send-email-wsa@the-dreams.de>
 <1434710432-4182-2-git-send-email-wsa@the-dreams.de>
 <20160427173308.GN7946@pengutronix.de>
 <20160619195641.GD26875@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59536 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbcFSUAk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 19 Jun 2016 16:00:40 -0400
Content-Disposition: inline
In-Reply-To: <20160619195641.GD26875@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> In the meantime I tested i2ctransfer, I really like it and it helped me
> debugging a problem with an i2c rtc device that isn't usable with
> i2cget/i2cset.

I read this as Tested-by :)

> > Note, I didn't check if this patch got applied in the meantime, my
> > excuse is that http://lm-sensors.org where AFAIK the i2c-tools repo is
> > located isn't reachable for me.
>=20
> This still stands. Where is the upstream repository of i2c-tools?

Jean, did we already discuss moving it to kernel.org?


--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZvneAAoJEBQN5MwUoCm2G3cQALQhQJJx3he6mBpO+6qqALQg
PiKbaekwf3qawhYOBeUGhVuGsV68aQBqWoc+K1NRE5Wq2QdXk5SjKjTJX6TruTa+
R7BChsnc9AAMcb0ivZP/3OyJK5ZcHN2SxZYIc5604IjgkWRTduBvLoxqTCKTThwc
VQ8+xgpXMCrnBsVnMpE76FKzCTzZUyI9vCjhFRHfGhPalmKRqZfrbA/qcBgkPdoo
nn/Cw16bT9oVHCCaX8KyzKKM+NOKd8YsjQw6GzZGLCrSbwjuaV1+SKgAqqp7aS6D
vr1bZhx2+j/gNlaRJINJtWd4N0I4GDaA5Za0oDNwJuU6vywVFYcIYvcw5Bu/Zkca
UB4+0Tqb8ySvPRQ9PD7b6Xj2E8eS0Pu+/bt2MPM3Lb/1I3JNsNbRI5jgeNHAOjY5
fED97Kqh+n6Ff1icSPWZ9dCJvjDFs8eEs+3m7dKfZznPXQPqmWwoTgN9d9cnFd6d
LPc6PM0pjC6yJWQ4uEOooPLOevNEZfuXcCyFfKws3bvsBLYZzuTsUsvM6+UxaqPn
udIKpO6QajDu6EJcplaRdSd37jKUT5jeBWkOljQAC4zkujWFijY6TAFlZ6Re0RDP
fTiQhz5sk3S2ScB5EWd+rTwiYbb2oLyDyyZAtt4hxPjbpNW6SKh3/TW1JSgdGOXk
RDSW5qyOSmvLB6zIW4oi
=Zvgc
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
