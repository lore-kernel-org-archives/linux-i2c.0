Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489773;
	b=BbJr8Hkz0lB39/MI2i4fD7a9LvuC/iSZ1wiWhAHEtHARQk0g2a5kIL0/r8DZy+wzf+YI
	 5bFkRdJE1otw8ft5cZHcpHakhWXlX1mHASkAM0E1lOlNgDijFnCK2YW/YoRGLvbmjSiDK
	 ExDpKVszOwO03d7J6tHt8B18VbNT2OeaJp1utksoeD4G/1LMRlECgFQsWojQJ2FsilNYc
	 eLm9MqoGw5J5AMP16aSoaCGJcRC9jBHJK9kVkyfDtTSCj/jPf2y0QaZ6oMY/5eCTqTtlX
	 PkIkKVaDK54LH5CJDlecSFxcmnJDRhyB51AopRQIBfNhKLORPq+dMT2YH2ePvpOkpFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489773;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Cookie;
	bh=65LGNoWKRUo+nKW8ixCTDsk0n2dsCvhy2et/A8WBD1A=;
	b=XQ1S10xDTv8mdF/8Doiqm+Jhww6e9cxGd2RDzwQsPy7f7dZYIIm+KdXCsgiie1O6/tjk
	 IzFWC1g97NWX2RRttrOS7B4XKHwglzhHeKy91EGXe9zTSbf7IjjGSBzsqGO4opf1+USh8
	 pdHVKCt4WFC26mFB13Az7BlPOlT8YRy3k74jJVKg/0d8g2fJTOCr0O9+MIWEdB7P8KdwQ
	 RmVd1j35ULFyAYmq4K4M7pVw//3Jdd2kKvh6/CtYGdsXvXbtbZ63+YLubJGutlMQ+lIk5
	 BEsITdVQ+C7DZUqQ7UHoPkxeAfAJ8Y/ivkdaEG9pSTcDZ+yLscVaHQ+gXmnGa10Rzdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C207606A319;
	Tue, 20 Oct 2026 09:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9801F1F000C4;
	Tue, 20 Oct 2026 09:49:32 +0000 (UTC)
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 6962D1AC57D0; Tue, 20 Oct 2026 10:49:30 +0100 (BST)
Date: Tue, 20 Oct 2026 10:49:30 +0100
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
Message-ID: <atc5KhqlzczEhQ-z@sirena.co.uk>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <0bf04f71-cec7-453f-af5a-d121277eb51e@sirena.org.uk>
 <40844e94-c9d8-430b-90b0-66032e66060f@ti.com>
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
	protocol="application/pgp-signature"; boundary="7MXv3ziPad81FTm5"
Content-Disposition: inline
In-Reply-To: <40844e94-c9d8-430b-90b0-66032e66060f@ti.com>
X-Cookie: You buttered your bread, now lie in it.


--7MXv3ziPad81FTm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2026 at 12:21:20PM +0530, Aniket Limaye wrote:

> I am planning to send next version in a few days... aligned with Andy's
> suggestion for a separate driver. Would like to get your reviews once I do?
> Let me know if you had something else in mind.

That sounds great - I'll look out for your patches.

--7MXv3ziPad81FTm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCatc5JQAKCRAv73Ows9A4
iYwBAP0fR57EuTGYO1X/nHi6gn4+pwM+iujcwDxQ6pJcelO6OQD8CcYHayy1MrWw
AWtEDnzEuwqiJFF9/1t/q9bZumUYBws=
=MPCv
-----END PGP SIGNATURE-----

--7MXv3ziPad81FTm5--
