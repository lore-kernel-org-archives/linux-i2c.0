Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64687469821;
	Mon, 12 Oct 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825068; cv=none; b=qCGgY4nX2mfvXmYWeWxiVtFXepQRjcP6UhoKGdMHt57MzarHbWZkdOTb6nesV7j9E3oRg8ONqicwZ2Urd0bc6I4CbSLTb766byyfiBXB7yV77QFSUUNFmgBioZCqgRPZIwQCRf4WRXC4VUn/2+z4ysppYA/E3KefNCcpup6yfyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825068; c=relaxed/simple;
	bh=kMeWUKAHOvbp2Y5OMBRA/Xyoibtw8gkX5ll2fWrH2A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOiLbu7lPswRpkUevaiFfQ0rKHnha2AwPZjYed5T7HOdqV9qwYPeBIRuv1dn7IeiMQmzhfTxJdIXlnIEUUl19+C5lZogs0B5g5dPBaPmtd44qfTcILzw2Sh93KcFw5qdqaU6IS77NwVlrnXjswO5p1RX0c85hPmU6uPbxN8y1o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pzi4+a3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pzi4+a3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B971F0089B;
	Mon, 12 Oct 2026 17:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791825067;
	bh=G2ShRVCJl4ADNMgICYYHDFwKwRhCkwXLZDOE5Y9VotM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pzi4+a3vCIXcG1SI7NRiYdRM3vutIrVXhdQhb3D2AEOFECW4TxmmnG0G9LAwgfd/5
	 9ZJi6xap7j6TTC2NIh95epvsLO3v4UeHkVwPI8rovJ/TqM7/kUVNG2s4pSFqyEoE+6
	 7xUQQ1VY/ee78uSgiO0jizULRnDVczoq30977+vlyMC+f+ZzOZDnjwdh82kgatVhYl
	 y4eACzJjV48FKgbOW2cAN4oO4u+BpgfQucOZFkP/7VUpmVta5IBaboljXH0f/5fLDE
	 1KjiF9DGXa1GJevaZW3hxQT6PZqdCsKK6DwNN1E5mkcUUP2EnMn///E8t9CCTwGbaJ
	 bj5Di5NtSFr6g==
Date: Mon, 12 Oct 2026 18:10:59 +0100
From: Mark Brown <broonie@kernel.org>
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
Message-ID: <0bf04f71-cec7-453f-af5a-d121277eb51e@sirena.org.uk>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bvUae1am23g2EFEG"
Content-Disposition: inline
In-Reply-To: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
X-Cookie: Academicians care, that's who.


--bvUae1am23g2EFEG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2026 at 12:26:27PM +0530, Aniket Limaye wrote:

> Add new compatible and update driver to support Synopsys Advanced I2C
> Controller (DWC_i2c [0]) present on TI TDA54 SoC. This is needed since
> this controller differs from the existing designware i2c (DW_apb_i2c
> [1]) in its register offsets and some register definitions.

> The new compatible updates driver logic due to changes in register
> definitions:

I'm working with a SoC with what looks to be another instance of this
new version of the DesignWare I2C controller - I saw your discussion
with Andy and the conclusion that a separate driver would be good.  I'm
really keen to help out with getting the support for these IPs upstream
however I can, not sure what your plans/thoughts are there?

The I2C needs of the systems I'm using are fairly basic so I should only
need a small subset of the capabilities that'll be visible in your
systems, the only thing I can think might not come up for you is that my
systems are servers so will be using ACPI rather than DT.

--bvUae1am23g2EFEG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrNFKMACgkQJNaLcl1U
h9DYAAf/bjE9rg7RrRaVEqhn3SMg3esM5MwEfWXwbKi+xD8v7jgxIhi2DVw9EzkT
5b0p7aNEqVx+NbnLx3rADjd6lGH7tdQr9uvNsPO8qFY1ZaCj8q0dsaEsTHyqAt4m
9JLZe66Syw8s0mgVB1xrGCGSpdXGSvYQ3qydoIJBjfHp8gpZ70SjCarOEXSPwLcx
Nkig2YO42HRwDlbhLWuGB7HXIklGkJzaTzolbo9wY2qwjHoZG4MUGzMw9mGoe8CX
EtrupLW7XYS6AXna9vABDD2Rhm2WESywWDxDWPOwHQaDPiqY21H5S9StzikgyTJo
Nd3hLF/M+dphTjKwIRllDjwMuk7Xcg==
=W3xf
-----END PGP SIGNATURE-----

--bvUae1am23g2EFEG--
