Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1301C38BF81;
	Tue,  5 May 2026 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998322; cv=none; b=hJmknESBinOTpgIudhC1vx8ETcO3JWAQN6cO3wouNB2QLDEXbpvVTnEh/bZ/McmhArOr4w0yjclWrLoESWLEK1j4NKda1g7/Phabu93L1h5MSznUcOQyP2JYC4pbSLi9YOXtDUQHpAywN5IJyYSHsqrsXRrMeKyiDyDqgVOD5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998322; c=relaxed/simple;
	bh=P3PUsEhxiyv0MVCPjH1f+nJYAM60mYlApLVeqBXtLlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXqVhSPwoaGfxD/W7GLKngt/SGJ/OKotq1A53k65vV8GvkL9oV1lgNdAntJUfS/JFESilleA0Fz60BLrgGRO7YGhYhkvYXtkzDviPS5PX2/s6r3cMxlNkms6DV+WjnVUoDE3p8ZAEnnTWAxbRsmoNYbnB6C6YZMG1FdxQI7br6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsdVYyQY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsdVYyQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80061C2BCF5;
	Tue,  5 May 2026 16:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777998321;
	bh=P3PUsEhxiyv0MVCPjH1f+nJYAM60mYlApLVeqBXtLlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsdVYyQYtQM6np3dFH11uwV6G7629W81Acc5Aa/jC1laJ6HtyxornDPLKpkz9n3tn
	 l6cbWBKdb+G3t3/1e+z1tQe14bofctaiuYfofAoDjqGwiM9HypyyqJaz42CHpnTBa+
	 0eHDpDylvC69XTPGQFs4YpI+VXvbZGs1nzqan7bNuWMJ3aivvv67msnJiNqU+rh/Uj
	 a5Tf91KZwbqx1NAcjiGCohb96ITlBifSdW9PXAqjy81Eg7k8bQzRSEFHWCVcfRMY6s
	 WjxVWSZFZkpmhynV2imqu3dGE39tRL4ECs13/wwfSML9WDM16wP62i6k3FHGQzZig3
	 RJI22RucIcCSA==
Date: Tue, 5 May 2026 17:25:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Swark Yang <syang@axiado.com>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH 1/2] dt-bindings: i2c: cadence: Add Axiado AX3000
Message-ID: <20260505-eggplant-little-87b6134a95ba@spud>
References: <20260504-axiado-ax3000-cadence-i2c-support-v1-0-97ed2fdc0b7b@axiado.com>
 <20260504-axiado-ax3000-cadence-i2c-support-v1-1-97ed2fdc0b7b@axiado.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SnZyNtcB4rZeJFCl"
Content-Disposition: inline
In-Reply-To: <20260504-axiado-ax3000-cadence-i2c-support-v1-1-97ed2fdc0b7b@axiado.com>


--SnZyNtcB4rZeJFCl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2026 at 11:26:43PM -0700, Swark Yang wrote:
> The Axiado AX3000 SoC integrates the Cadence I2C controller.
> Add a specific compatible string "axiado,ax3000-i2c" to support
> its hardware features, including SMBus Quick command capability.
>=20
> Signed-off-by: Swark Yang <syang@axiado.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--SnZyNtcB4rZeJFCl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafoZ7QAKCRB4tDGHoIJi
0rlUAQD+nb4X/sN7660Y9aXpeiu8qfjC2cP3Djl/gh68JLcFswD9G966+as4y2ZW
WY7GCArjHENU9Xu82cwWyEnS+8g6WQA=
=eHFt
-----END PGP SIGNATURE-----

--SnZyNtcB4rZeJFCl--
