Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078270;
	b=ZVfM9g9PjPjkfNtM5Cu+/hrxg1p87d0o+R+MZvkZ6DU7lBqSm+7XcfZOEurSPbOt0K+l
	 mZzdu3lZMTn32hmYpcPH51XktrdUJKucLoDaPVfgs+TLpJS7BNpqMgyHe4gQFAZBG4wT+
	 irwJFk5y1WtvmIUokpMcY4kNYrjGiCvI1ohu7jy2wRyejMky764nJWpiyKwD3SXyz6l/g
	 6ffTILD5hwKH9IC06UNehH/s2itO7N6pBDLDq1DkU/qkGwoh8BGdb0nOqM3wglcWs5QSW
	 ltkxzcJ9r2xblxOxQORc9TktTWHx5qejywmB3nyIAC5vEMc1qh2UYBZkq7g+DQDiwvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078270;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=tRyuJvVxJm2lkAbYHgvM8xzKHgJsFTpk10S7loVsEpw=;
	b=eXiestga3W0ETTYnfP2Lutueu40yxGFZmA0DPqgfWnsVpGsW96M+t3B8hmITQyeQaRfo
	 u9OKSW/atDbuiS+24ZlqLw3dzj59GjMX4rTE2vAqbFh6eo2dD2owtDu+rUsdx948U9gYT
	 OOPg2dwVsAa+/QWBhPdYEaspTC8ld8ucUlmGbNgGHbrV34bjkEYgGlpao3mSGdCRli9Yj
	 moV7mbltjmRhkniAygkGX0MwmaiIHDYFDV8qDEshMR2TeV9bqhOFp5O8QYBuG4srskCq3
	 dtnV+nTLQrJ12wIaByzH+ci1448Qow3l7XhTwS3Kfwv4jsNf0DVkLTugqFDupzuSaiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=MeIS4cTm;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF66606A326
	for <linux-i2c@vger.kernel.org>; Sat,  7 Nov 2026 19:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF66606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=MeIS4cTm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=tRyu
	JvVxJm2lkAbYHgvM8xzKHgJsFTpk10S7loVsEpw=; b=MeIS4cTmx1OuwNxyfWiN
	0UVkh8/s7DSgTBOied8iHmRroK0A7av1Oxd8919VfwmTmsOCofGWZ2oo7cIJz8uk
	YkVtvX45zV3G2Hlbhn9InefEKt5cdSP7em9Cuekad2wmpyvwo9XRDf/8/dgiyMkq
	XP44hmGyInJ+xke6glUnqSx9fPpkbthdeMmXSkcxVzDzKhFNJ0aP8HHyLl/UEjJX
	dfhHpSFnipMd9hl92BtA4vM50x/fiokN1wrc2YVr68G2oiCf1r7hoEmmEox6FvXg
	8kLUQeefiQisKtpnSR5M7HOEhgCRMlEL4jL48gMyJkZM0KgX2tPmgSLWfkFNrtzc
	Yw==
Received: (qmail 2590113 invoked from network); 7 Nov 2026 20:04:20 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Nov 2026 20:04:20 +0100
X-UD-Smtp-Session: l3s3148p1@UHlhZbRfEcAFFu4j
Date: Sat, 7 Nov 2026 21:04:19 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 1/3] i2c: designware: Use msgs[0] to validate the slave
 address
Message-ID: <au92L9k5i25kgbkY@shikoro>
References: <20250918160341.39b66013@endymion>
 <20250918160914.47514d3b@endymion>
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
	protocol="application/pgp-signature"; boundary="zEv6qelk6xvyhGD1"
Content-Disposition: inline
In-Reply-To: <20250918160914.47514d3b@endymion>

--zEv6qelk6xvyhGD1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 04:09:14PM +0200, Jean Delvare wrote:
> Function i2c_dw_xfer_init() makes use of dev->msg_write_idx to index
> into the array of messages. The purpose is to program the controller
> with the slave address.
>=20
> However, this driver only supports transfers where all messages have
> the same address. Therefore checking the first message leads to the
> same result, without depending on dev->msg_write_idx having been
> initialized elsewhere before.
>=20
> This function was always called with dev->msg_write_idx =3D=3D 0 anyway,
> so this does not change anything, only makes the intentions clearer
> and the code more simple.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Rebased and applied to for-andi.


--zEv6qelk6xvyhGD1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrvdi8ACgkQFA3kzBSg
KbbWMw//RZg2cCO/c/UDqo4sKWRHipGTHZ2iRVVQPgPctuPBWyf/mSm1J2Rkwd/y
6R4nF4FCQALMfGfknX7sho69DarypWHI6gzuz69ZpTPmGWeQsOVlBpqJxCzcB+3C
VENsUXZZKZ4djdaMNmOD0Uc/ge5jQuVGyF6jYPGqldyGbraJ766HioGYs9GDvQAF
/2vVoBGagHntpRPLJdMxlebxUUUoZZj7ORd/2Cx1pJqE5xCoQjoheIv2ygO/aQlO
+kVbzxzl0D5BLUY3DYaoOLW1odyfAMZjELIgkQ8Pkk/yTZa8k6/ZWci2cRuSFb0I
HhATEzyRHEcmfEoXwFvb+Eeh+KAJcg8dumNG7KzLuP16uAtnsCk2gk5BdMCBpRnx
g4ZtrNnplsaEvJINS0W3pdQTRxErtU1hUpicb7t1i2u8HgAOL+4wy392blNSyhCz
Pz7w3Y5jnM/qO6gJivyw9ojx8srsNyIqcCW3UyMF0hPaxrvBuQV4G8+7mT5OCt8u
+yRP50EzeD+GBHlUHvJgV+/9+LFQFcQns7pl9/W1sYeej25EiOvDauLOsRdo8XcI
wgu56TnBvJVIg6P5MlyU/UCWErz+0p1twUodb8llE4L33EgyV6E2WWHmKAXpGz/m
STd8AsMnXLFmtF+y8tJzNIWZEksNdVcYHe29zJQfSJL/LI866BQ=
=y4P0
-----END PGP SIGNATURE-----

--zEv6qelk6xvyhGD1--
