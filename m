Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C0279907;
	Fri, 19 Jun 2026 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886595; cv=none; b=lityPqwdMhCetRFolVybj7BywfnbDv1HBbBjRun4vaIyKtRWMrAj1CvUa6uAH05e14B1U65Ns+JMizkWD7umQz5PL3mUj99L08DXybK9CLPATg38GWe0seqTZFg5PUh3e7tQ0eoMp6dK14q3eah82E5U6FGXyCs7kam0J0UPlU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886595; c=relaxed/simple;
	bh=+XEYgedP2+rsgk2dCqKyYxBbZEMCdR5SozPym8Th4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XafYIwQHnlUsMEh14cR+xP6fBYwu/YUzxjbK4NBshMpeQkTK1tLiNvtEcMBgmJcL/TjWYEoLVE6DQz4ITOmFEdKtzy2tgt2yJGb6mFawuXrLUEoeuBHWV8W607+phNTpcAIKc262t1FvOz2xqXzEzZVs1sXgfbChtbL8jUuNRzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg4xmFxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg4xmFxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2460E1F000E9;
	Fri, 19 Jun 2026 16:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781886594;
	bh=+XEYgedP2+rsgk2dCqKyYxBbZEMCdR5SozPym8Th4JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fg4xmFxkBGkA/7uC2c1bGpPCjNQKO1OH/keV+aY+JAqs//287TxBFxr0cW/UN7l4C
	 wm+dWIgnBldjDgH1yywP8D8ZilYKwJK9L7gR+Q+JOBUCCskiO51kS+c58j8uWZll4k
	 adaqPgbcnkec4L0dGY0hCCn2TtwDN+8wZ1ozMdxJTS9PBt0NfAhCLW0p0pEjTiqzOg
	 b5mqJEmH85P1sAz5kD6o95rcd7SVW2f2VKbuozZcnBI9w1RO6STXCxxqpFlCPQ0j61
	 iSvw4QVY/r5tbxyDlmEHMlslUvJS8PjFfyksNiu3Gqsc+DgNI5XCipV6tXobPtDpl3
	 NimCT1AsgOa4A==
Date: Fri, 19 Jun 2026 17:29:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v1 1/1] i2c: microchip-corei2c: Use generic definitions
 for bus frequencies
Message-ID: <20260619-pension-deepen-7dd3c03fb422@spud>
References: <20260618141346.3241286-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yzhqw6Idhf/dthgS"
Content-Disposition: inline
In-Reply-To: <20260618141346.3241286-1-andriy.shevchenko@linux.intel.com>


--yzhqw6Idhf/dthgS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--yzhqw6Idhf/dthgS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajVufwAKCRB4tDGHoIJi
0mBjAP0XB09qOMrHaGvhmNiY0lYsURtCL8D99P2FpHacQ3VDjAEAtMGT1Q1KgOD7
/60ZWDAO1fJxwJ+BMNkanABQS+qR4gU=
=g0FO
-----END PGP SIGNATURE-----

--yzhqw6Idhf/dthgS--
