Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508857;
	b=UZE7R8E1OICYvW2DyEfyWUGg2VhMBJiMlCIaOWotft+ENFviEf8PLeqWb5NEplbixVYr
	 7xL/Ebalxy/rts086OwqCyG/MAlShhmMxWwvYBG6sir24dPP8iC0ga1iFsNGw8D/Ya9xZ
	 Zinu937ikpdnTZs9VmUMGgsPuyk/7uXais49XS/rWn8cpa8CzEhl2Np0xIte37PM1KaMr
	 XuWjwkcI2ho36V0nQ+V+KNcOnfivj/ENxPqNqhtMAQ4a+7igdk8oluuxJKz+7KU/Kg17D
	 nI12+1q4L0J5M3X2nonhOS544sSQOUZrKcD3FB/DRLTy6JI9xWnsS2B7pxATrSzgOoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508857;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=8HwKy2Ni3hhvlhPAIbhLgQPBiXHFM2JdTyPuEE7hnDI=;
	b=xqHiY19XpJ1f5GojgNzt3SfNs7ZPlTV/nChA/Ev1gPfHRZZ8OTDjugiacG4HNaAKBq/P
	 XaBeMdBUFNq04SpxxJhw0B12e7KCxkw72Ujons2o7tBVocNrgrIbnq9fzog9lkTSFBZlo
	 dQiDEyN5dQ0cFa8zZZ/EFHSzSv9PCl9dKBwVzZ0U5YMXMRuN6RYa51Q8QTsLlGyxlGEoj
	 GBOJXOGFYobrSdA8SHzZS99x3VDmAZ9YUMQ9yq1LfTOAJlsRos+f/jfOZCPP7aCepqaWr
	 /PSSWJQNluOhqCgzeKEhIHheu5RvYJ0DQTCV5IZJicIFQDqmBgIF0P/frmix1/3sQ5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2XFml4V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C557606A330;
	Thu, 12 Nov 2026 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2XFml4V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9D01F000C4;
	Thu, 12 Nov 2026 18:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508857;
	bh=8HwKy2Ni3hhvlhPAIbhLgQPBiXHFM2JdTyPuEE7hnDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I2XFml4VnUd9hWL11SqonT3UQ7RpFiGf2jFkNpay7r2Rvn2MCvt70KsIsO/IbOQAE
	 hsHQKymF4/2AXgmKyL2diX1kUmzfaMaOYZXHypct6PAtJqfbiBN4zULMmqqLaqNdvU
	 UG5V10GX8F/oUPWwlAb9eozaPJDTHFrXLVk5HnfHn6wLOwNV0h7Rz7q5dEgWku/WqD
	 vWEzIyrsrby3B36UvvpiKHwRyTr2uVr8Q8AMVTJZg0bnkun3NNeftex1CVFT4W0+aQ
	 2IbUsxxCfgnY/AAYU00WDi4MbAW9ixXH4RJ1SPQuw9dU5kXfohsIbiciSM2Ct1pelz
	 UcJ6Xav1JgT6A==
Date: Thu, 12 Nov 2026 18:40:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lianfeng.ouyang@starfivetech.com, s-jain1@ti.com,
	andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add Synopsys DWC_i2c controller
Message-ID: <77286fa5-5952-4e02-9c4d-040b047cc2b5@sirena.org.uk>
References: <20261111-tda54-upstream-i2c-v5-0-280a4a779b24@ti.com>
 <20261111-tda54-upstream-i2c-v5-1-280a4a779b24@ti.com>
 <fc1fe51e-952c-4c8f-8dc1-fb832b03943b@sirena.org.uk>
 <20261111-smooth-meerkat-of-judgment-dbe8bc@quoll>
 <34533daa-7eb9-4674-a288-e8d87a8bf29f@sirena.org.uk>
 <fdeee43b-9a27-43b2-9193-7b2db468e9c0@ti.com>
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
	protocol="application/pgp-signature"; boundary="JPShpkDOxa7X/GR9"
Content-Disposition: inline
In-Reply-To: <fdeee43b-9a27-43b2-9193-7b2db468e9c0@ti.com>
X-Cookie: Baby On Board.


--JPShpkDOxa7X/GR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 12, 2026 at 11:46:27PM +0530, Aniket Limaye wrote:

> So if I understand it correctly,
> 1. you'd rather the driver have a generic compatible such that we can have
> distro kernels not requiring specific SOC support for this driver.
> 2. AND it is possible to have a *sane* fallback by using the IP's generic
> minimum fifo depth. The DWC_i2c manual specifies IC_TX_BUFFER_DEPTH and
> IC_RX_BUFFER_DEPTH as 2..1024, so using depth of 2 as a fallback would be
> functional on any integration, just slower.

Yes, exactly.

--JPShpkDOxa7X/GR9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr2CDIACgkQJNaLcl1U
h9DFUgf/ZgGPRM6nv1tMqke3XXhd8qi2gi9+yWd7tFmhD377HQAi6oU+E2oF4jmc
Bm1f/14MWdfgUCgYwjHidMCLRjeHac8RCbon5z4Gl7izfHr8PN4Ip6//xLFvvGzf
IG93Ly2yhILFrvD92uYo6f/4D2V32FDNleCGBii7JbcdFqfxQQCZ6VqsAHiHCpll
RS0ovnSur0GnFjd9MDD/cH01f/Y5SN822CkpPgpU/2cAtI+LE46dmcAvnobExdIx
1nWUaOoyoKgu1sad9S+TaVYV+T90zF1uPeD2F9yR+Ma9bqryLbIxFpx8D41gXPJR
ixBMreAecmQuPPAl2lYN2ZdBIy6oAQ==
=NxGe
-----END PGP SIGNATURE-----

--JPShpkDOxa7X/GR9--
