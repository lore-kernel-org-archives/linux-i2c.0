Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827787;
	b=pJ8gyNAlHYAEsMKkWml11/gJpFZryQShxccWXO75xQV/Mm/Ea86s9x3vzT8rX0obALLa
	 YJWDmOM3zj24dhS3ZcO9a2XcH+G7Nha0ZQYVNdS0vqoX3YYYKTB23/83At9YDtH1LNzCJ
	 0mIX/ZDr4aGlbywag6sWlY1rYIB/OgQlgg2VWDylsrR+edmTJaBrBlmQcYms35KIlTn+W
	 pmHzRsJBb1ZILjYNlV67tElOerHxk2h/pXS7lNpbl7DcAb0i8k7aRC7IAN0CO1I7uCmzk
	 +OIOvA6R4BtUfAQv3apB864PnPM55iDijBeS/3ZlNd3CtlhoEihDs9m4gQjAyPwaIqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827787;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9Pd/Dn5OtHP+GOEsVwxT/iEs+gI1X5UK1UjN68+/xK4=;
	b=UxjSuVKpf8CMF16crHkX2kWPxYYJK95xsRV4W5LGyXBpOdyvBXageVDUUXYN8J88OlaU
	 TVhwVqEOKjSwihiC6Qy7FOBShwzQkBnQamuhKvXcSJozbz5X9I3SoSCwxb5lQAp/EslxZ
	 aPgcni4kPrwHMaoVUmpSkVF2BJTxWEe1HhfYJjHvJzg/iiyLe2NJxgigs7RleA6rpCkC2
	 PEMhsnnTLRFJQAZM5G3etWuBRn7PCuROI0BMVPOQ0ZVRez/kQfqFdYA9UiYCu51xFnOiI
	 A7dhebMNz4CyUWFCXeN6a+SWqSr7P00+4TC4kKf83biL6yJp8KLJzLiNKP9Ntm6q7zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4C607802D
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 21:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEA4C607802D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=9Pd/
	Dn5OtHP+GOEsVwxT/iEs+gI1X5UK1UjN68+/xK4=; b=azpyLX8DUW5XR38Y57c2
	ihJr7cz3rqtHOvHduUeA8LuTVHeEg11jdKrWm+s5oZqMKRY7UzD93aozgEWJRZsV
	EaVii5nxdweRgwtxFs+BvoOZ5nsy6Ru8ZEluuux+8sl1TlDxnp75keL4aNfsdhjY
	ljve0mLD9yT2HCbEPanBSnYfpZQXjZBcq84IEtJkLbIRgsrgkyQ/klBYSsKxGwyZ
	to8/owuTTZ7a16OFUqgdDPt2CKe/FjIjOMEKPtDpJGC9iPj89BQax57ZURVIXUxr
	05TNKw03889CggFSDSP8FDe5RMks/o34f1DB7hJACyCJYGcekliFXwqXHAslIrBp
	Gw==
Received: (qmail 866969 invoked from network); 4 Nov 2026 22:29:35 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Nov 2026 22:29:35 +0100
X-UD-Smtp-Session: l3s3148p1@xuJXE3pfmpnAwtcC
Date: Wed, 4 Nov 2026 23:29:35 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Stanley Chong <ale.sarick@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org
Subject: Re: [RFC PATCH] i2c: algo-bit: return -EBUSY if the bus is not idle
 after STOP
Message-ID: <auujutmzEYNySrGV@shikoro>
References: <20261027130315.390-1-ale.sarick@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kmP87/lEgBvVPxFJ"
Content-Disposition: inline
In-Reply-To: <20261027130315.390-1-ale.sarick@gmail.com>

--kmP87/lEgBvVPxFJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stanley,

thanks for the patch, the thorough explanations, and your care to
prevent regressions!

> When a device on the bus holds SDA low, bit_xfer() can still report
> success. i2c_stop() releases SDA, but it never checks that SDA and SCL
> really went high. The caller gets a positive message count and a
> buffer full of zeros.
>=20
> I found this on a Raspberry Pi 3B with i2c-gpio. An Arduino Uno pulls
> SDA low on command. With SDA held low, all 12 test transfers returned
> success. One of them is a write to address 0x70, where no device
> exists.
>=20
> This patch reads SDA and SCL after the STOP condition. If either line
> is still low, the bus is not free, and bit_xfer() returns -EBUSY.
> If the adapter has no getsda() or getscl(), that line is not checked.

Basically correct, but the check should not be applied after a STOP but
before a START. Remember that I2C is (theoretically) a multi-master bus.
If not both lines are high, it could be that another controller is
transmitting. This is why it should be checked before starting a
message. We retry in the hope that the other controller is done by then,
so the bus can be used by ourself again.

> I chose -EBUSY because the I2C core already uses it for a line that is
> stuck low. i2c_generic_bus_free() returns -EBUSY when SDA is low, and
> i2c_generic_scl_recovery() returns -EBUSY when SCL is stuck low.
> i2c-aspeed also returns -EBUSY for its SDA and SCL low timeouts.

We have defined error value for most cases. Not all driver adhere it to
it 100%, but we are striving for that because it is so much easier for
the upper layers. Check:

	Documentation/i2c/fault-codes.rst

So, in your case, if the check is moved to the beginning, -EAGAIN would
be the proper error code. (And -EBUSY probably needs an update saying
that it is also the response of a failed recovery)

> The check runs in the bailout path, before post_xfer(). At this point
> the lines are still in the mode that pre_xfer() set up. So the check
> reads the lines the same way the ACK reads do during the transfer.
>=20
> With the patch, all 12 transfers return -EBUSY in 0.2 to 0.4 ms.
> Normal transfers do not change. When SCL is held low, the error code
> changes from -ENXIO to -EBUSY. See the questions below.
>=20
> Signed-off-by: Stanley Chong <ale.sarick@gmail.com>
> ---
> This is an RFC because the patch changes the error code in some cases.
> I would like to know if this direction is acceptable before I go
> further.
>=20
> Questions
> 1. SCL stuck low: -ENXIO becomes -EBUSY.
>    drm_do_probe_ddc_edid() stops retrying when it gets -ENXIO. With
>    this patch, a DDC bus with SCL stuck low is tried 5 times instead
>    of once. radeon and amdgpu use a timeout of usecs_to_jiffies(2200).
>    That is at least one jiffy: 4 ms at HZ=3D250, 10 ms at HZ=3D100. I have
>    not measured this on a real DDC bus.

-ENXIO means no device is responding (so no retries). This is plain
wrong. -EAGAIN will be much better because the bus might be
(theoretically) free somewhen. This is actually an improvement.

> 2. Some DDC buses read low when they are idle.
>    In bugzilla 200045 (the 2018 revert of "i2c: algo-bit: init the
>    bus to a known state"), radeon buses 0x92, 0x93 and 0x14 read SCL=3D0
>    even after pre_xfer() was called (comment 14). Today such a bus
>    fails at the address phase with -ENXIO. With this patch it returns
>    -EBUSY, so DRM retries it as in question 1. Is that acceptable, or
>    should the check be opt-in per adapter?

This is actually improved to the expected behaviour. If SCL is stuck
low, it will fail as well, just a tad later.

> 3. Rise time.
>    The check reads the lines adap->udelay after releasing SDA (5 us for
>    i2c-gpio at 100 kHz). The I2C spec allows at most 1 us rise time in
>    Standard-mode, so a compliant bus is high by then. A bus with weak
>    pull-ups is out of spec, but it may work today. With this patch it
>    could start getting -EBUSY. Is that acceptable, or should the check
>    wait longer?

I think the problem is gone when you move the check before START because
we did not modify a signal yet.

> 4. Recovery.
>    Neither algo-bit nor i2c-gpio sets up bus recovery, and the core
>    only retries on -EAGAIN. So -EBUSY goes straight back to the
>    caller. Should bit_xfer() try i2c_recover_bus() first when
>    bus_recovery_info is set?

When to do recovery is a question of its own. I would leave it out for
now and tackle your issue seperately first.

Does this all make sense to you?

Thanks again and happy hacking,

   Wolfram


--kmP87/lEgBvVPxFJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrro7sACgkQFA3kzBSg
KbZdkg/+I1LJ1ifuQ6AcaPmIjXnzQfnu9z2HGEIn5gSw5Da3MTtIaRz2oBj/BCW5
8phlzKyp+k63SaW+JcrW4nrOZMTFqzoyAk7Qn1jGCIdR7e+QR9woisN3FNq1D9eQ
0jSe9/ve2N9k03qWUiVtUt3kLbQelQcCzuh3pRn/6k866mXh6z78QOL3NPDV+cXF
qtOLBruvNBkYO4caKNLddxYXsRBdxgXI+74cpm10qXlBIwEVVearjw6ifsLJskLX
i15a0oH4ybtqXggAbnaxxHt5+Ik60EmeSG0F63YCuJyTPJWJCER0hltePEbnBLyv
FSZ4jdY+hY3UOXgbgRaMZN/OuFVzX02f9uGViA5wizFOg+OZ5CiM2fmlyUqvT9ZT
zGtZcnrcVOWtqR8x6rSqfit5W5yglbuOLD+du4Yu9Ck1D25ExBZllcsZVusZwJ5s
gkQUYHe0AYfKl/Qv9g4m5Zizfk02aeU8HqBrPZD/MweH3ksWs3Lz3XhGbG38LRZU
svtPSsHgOf6NikEqUQwBUO/qdvBUiNaEgvBD9yuxcKI7X0m4sfgxvniRpOs6YCnA
8EXs2n4UENFi8VT8r5iLdvtGw+Gb23N3P7Fks/ILw/3NNNzxpBHuwu4oOgnFgkIc
UvR2GnDBBd2Q8bzUNn6ZrwRAsfL/jOmoKyVWceEtHFVF9ynxpiY=
=utpq
-----END PGP SIGNATURE-----

--kmP87/lEgBvVPxFJ--
