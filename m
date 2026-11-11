Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355520;
	b=P+aGVG8g4Au6Yylfpbg9nBsqsKInnNfhKpHnL6Y9TMwk25sTG5z2wQHUQmLmt1Em0UwC
	 y5wcXRc1X/ouodWOZxNIS1H66CCp6VVZzWcuSNRsqDpydUa7nnXb+Sn1Vckqc+lQ16epX
	 EEwcP0rHjS2bm5e7eSEkZKooIPHX6SCaY6+oBcqgxtYjPmhqC2SQdZgtidNZ+HimYFFsq
	 L77fPqM2bRNb/2Nn1G+JSkmU20N/SVp6L/ef6HeHu81KyvxOvml9sxco+jlFVmVjcbI3C
	 RxjceyfGXtJy32FQ5ASsJMWwCx+2g9Sltw9h7Fqzpithpr1xlo/S4zqam5RB1G5RDrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355520;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=PXbYI6MlYY1muC/lFaSpTeRJoJh9HX4zq5mEJ+4vdSs=;
	b=YynS3vxsVRzw3wpf5TmcQcvN3MSlcpVfbCqCBNUb0QoGPTcy6ykMIwtXXQdJanaoVZlD
	 e3acl8XG9QelxEKS1nUZ2VQcmw+QApRmBWWhgJ1Pd60C5iPDXsDkeIghHoMUGC3AsmCut
	 ouOTx6Tva5wY9g85Iqv/557tkX1c6aPIiXMucIDshhHjQZVVEewu8xcrpILrzBm/zYa7G
	 Lpg6/tBl7r8ejVC6N/QuQfxWfbZq4hWKJVBaMy/o/evmcBw0nQL91payMylYu1o8Op3bX
	 q4H69iGfuZz6O5Bzq5KNDZEgG5oUf/mTlYCWLr1dS85XxyTR+Gu/pBAhcfg68NSsLOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bs2LSUIY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B6606A320;
	Wed, 11 Nov 2026 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bs2LSUIY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BA91F0089F;
	Wed, 11 Nov 2026 00:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355520;
	bh=PXbYI6MlYY1muC/lFaSpTeRJoJh9HX4zq5mEJ+4vdSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bs2LSUIYrnXDBy9KP6A4Ah9OjiB02FXR/mBGUrgswdaCiBPzxDgk16VX6a8VvQrw8
	 uVA3Dg2d4qFRredHPlwU+JkX8+ETCvSmDkcad0HYvTOjvvlYvQlpUpwjWnwydWQYv9
	 /sNuJCBv3IsA2OLb1LJM1YZxZxpA9eaFFD3aPpOAAh5PPzF+RdYlmSYAs7fjuauFro
	 Lr0WzGAD6CtLn/P8hXSw8grj9gnYYwy4XI4dYnjMPtdjQvXrDU5ApdKpUfZNWqD1wc
	 DAgaPnWb5rnt2PyYIqrotNHBNglpURgMWlYSmMx+JktSNtrJwxJg8sBPlTJQIGmBts
	 SXChEA79+C/nQ==
Date: Wed, 11 Nov 2026 00:05:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lianfeng.ouyang@starfivetech.com, s-jain1@ti.com,
	andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add Synopsys DWC_i2c controller
Message-ID: <fc1fe51e-952c-4c8f-8dc1-fb832b03943b@sirena.org.uk>
References: <20261111-tda54-upstream-i2c-v5-0-280a4a779b24@ti.com>
 <20261111-tda54-upstream-i2c-v5-1-280a4a779b24@ti.com>
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
	protocol="application/pgp-signature"; boundary="ZnJIa65ka55OZZWa"
Content-Disposition: inline
In-Reply-To: <20261111-tda54-upstream-i2c-v5-1-280a4a779b24@ti.com>
X-Cookie: You can't take damsel here now.


--ZnJIa65ka55OZZWa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2026 at 02:05:48AM +0530, Aniket Limaye wrote:
> Add documentation for the Synopsys Advanced I2C (DWC_i2c) controller, as
> found on the TI TDA54 SoC.

> The block cannot work on its own and needs SoC integration, e.g. the
> FIFO depths are not discoverable from the IP. Do not add a generic
> compatible and only list SoC specific compatibles. The file is named
> after the IP so that other SoCs integrating it can be added here.

I still think we should have a fallback compatible here, while we can't
discover the FIFO depths all the uses have a programmed trigger and we
know the minimum depth configurable in the IP so we can fall back to
using that.  This would be useful for distro kernels, it's one less
thing that forces using a kernel with specific SoC support.

--ZnJIa65ka55OZZWa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrzsToACgkQJNaLcl1U
h9COIAf+PDpfdHMLK/48qHqQU+3Uph29XftpKx+e+RAJX6N7kFljP/OaWHcG5TgS
OzbkC29wWBFpbWCJYh4UvmlMMApF+gfshoSQFgM6HSOfJ5amTqy/71zo/a/uEKnT
7nrzss1UBT/44UPuyfC1whhMqU1RQ/SQB+bhiDFFtzdzE80LIC1IENT5c3jPu3DM
3Y+Rpdkn/uxGV/TxdoAZe9mnkCzzodUd+dYIoU5Q4ayXMqISgPCg0pTX+0DHpFCY
jHpxG+6RAJDCdlH4+IHiozfWXr2KklhBYK4PEPAKoqPcYF8sFH+GiSiANblNqDs1
3dmQO+rtr6kXHEfRIb6ChoTa9+Q5Hg==
=ghwo
-----END PGP SIGNATURE-----

--ZnJIa65ka55OZZWa--
