Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111191;
	b=wzAL89A9LgCogw7M6LKo+SQw4cP23jzAoudnBWOI/HOvwqVpPQdR9KBqellpIz1xMiQv
	 dlapUkWvCeWjbVHNE49obWlKM1CjnJRnrlJjpYktSMmoLiJUH3akmVAiMD0RIcLJC0yVD
	 tsTBr/GD8XH750ncDYAHWJ8tvpvzD+yTMzNpwCoQ0d2DB+ByHr0lqdC67fPjJxXm1kFBA
	 1BSkcdtsI3B/7yE42IicvwRSrzr5efTr8Cd0tFfc38s7yEJA06wU1THXga+VR7tyvvWkZ
	 Sg6TadWaY5hFVHCWzELSkFwx4W17w2MurOXVZvr43O1QNcwdz8iAtq7/hgDRw5j1fkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111191;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Cookie;
	bh=g0aOtKUPLRZHMhOqPkbeQ2GsTlYesN+QsGZQTYzsAhE=;
	b=q1LtNvZfFvTASJSB1WJ6L0m3zvICHrWxzwYOR7kowGvZC8nCWAgaSV+2u0u7mVt5Jo9u
	 ZhP8v/fcKnoRxeyOh6eoiZ60i7eJ5Q7h41Af9+mABxlohqVekdw7JJggSCLeVkBPwdgHg
	 ycOB7I85q4Gac3ITj5ApZSLKPmC4kXORm5lWJ+rUjbR1UwNc4O3pTx/ww5SvXNucCvIio
	 9Yth2r/Pq6sxEoNhsVKeCBGgqOeIGlFyClPVQ2dwoV+XfC6xJbGpOJ9Lr5P45NlqmrX98
	 ZxC+gj0x+8EK6mHBsx2OCsvH8wXfoABjSwTspaXj4W/m9z5ddoXPShB1mg2EAW7wpxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A2606A31B;
	Tue, 27 Oct 2026 14:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784161F01825;
	Tue, 27 Oct 2026 14:26:26 +0000 (UTC)
Date: Tue, 27 Oct 2026 14:26:23 +0000
From: Mark Brown <broonie@debian.org>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vigneshr@ti.com, nm@ti.com,
	u-kumar1@ti.com, lianfeng.ouyang@starfivetech.com,
	Ritwick.Sharma@arm.com, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v3 0/3] i2c: designware: Add TI TDA54 I2C support
Message-ID: <c6cd214a-e7ad-436a-b562-5effaff927f6@sirena.org.uk>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <0bf04f71-cec7-453f-af5a-d121277eb51e@sirena.org.uk>
 <40844e94-c9d8-430b-90b0-66032e66060f@ti.com>
 <atc5KhqlzczEhQ-z@sirena.co.uk>
 <f308e372-255b-41d8-9225-959750950780@ti.com>
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
	protocol="application/pgp-signature"; boundary="JhUl+OvBjkhu9TF/"
Content-Disposition: inline
In-Reply-To: <f308e372-255b-41d8-9225-959750950780@ti.com>
X-Cookie: You will be surrounded by luxury.


--JhUl+OvBjkhu9TF/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2026 at 06:44:54PM +0530, Aniket Limaye wrote:

> I have sent a v4 as a separate driver [0].

> [0]: https://lore.kernel.org/all/20261027-tda54-upstream-i2c-v4-0-ebeeaf87d181@ti.com/

Thanks, I'm taking a look now - please feel free to just CC me on
further postings.

--JhUl+OvBjkhu9TF/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrgtI8ACgkQJNaLcl1U
h9B5qwgAgXP3DXULMG5ni/vnZNu62OReCPp1K5I5Aj7kvDLw6Gx/sg/okzKTsHKd
zf45r+fwAKieOJqHCB+LCH2UocFHs5WM4xbfCjdGX6koM5s4ocAxr8zS8W9Hkas1
49hGwyEUm+j9vdN3/FusrbuotrlE14Vas9W+xdp2NcbNYskWiPskzHR50VWsRyyd
XSp5BIws/iZK+KxVIWwvnynNGUcHnzRxhzWQBwqgNKXAHjo4hEYXh/ljwX3RP0b+
ho7fQy2uC2cCXJ40azpd1MQLif50tAQblm6sorYZdgXv0ogPDnT5TPajHCseGgcj
INF6dzBZkvdke6PntU9E0KmxhASXIQ==
=SXNI
-----END PGP SIGNATURE-----

--JhUl+OvBjkhu9TF/--
