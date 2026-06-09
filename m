Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2ED43E9D2;
	Tue,  9 Jun 2026 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022703; cv=none; b=Lzr1qprljRzlyK83eXLXE8Oh1Q/rJhaDFDEeGLqkSt/2Xol4dk1496/3sD2wlXb1Tt8A+okhHWo/YR5FrNj2wlfpZkH0NQ15M1QyQsmrad/kNNUdlVgnRs+mCO/TY8LsnX2loaf7VKTICj37IsTKy7CHelwzLtPawVbZwYk5nX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022703; c=relaxed/simple;
	bh=hFdze7AA0Xt7M/PfvmTLs9j9eDBz5iJU9xRbDpiM41Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jux80+CpvPfdMV8ya0FDfGSRY84ZpU5b+ZJpRpL5NGRnTkLRjARIRcKnfQUy0SBMDEggM2O4buN+mrgXNfKlfQLG9W+ntiS3FcvgvZt/UNK7xs+fKOAry3K+bpVvLziP4/JldnsEKq6l7h8N2KL2H6qXhBavB8OoMFrDUuDEOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5faD/Sw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5faD/Sw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6BA1F00893;
	Tue,  9 Jun 2026 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781022702;
	bh=hFdze7AA0Xt7M/PfvmTLs9j9eDBz5iJU9xRbDpiM41Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D5faD/SwtcjdzwEBZDgKoepGBPi4mwjq2YFxpbZRQteeVscncbTBxU3s/gQMyag0s
	 qaCiEzzpaMy7KCu4/LEgh8JB2k6MPL39FCFTG8ScwtrsaRIPJRa9WdNk05HX9CdSgo
	 PObbZJLBCJWbIebMz2ID2eGYVVCDSi8hx6IkfmcvPn1fDSc9mliPPezVlcns1LOrhK
	 aGgFwKywZ5oPNFQM7PfbkzvfgXfUHhKnncq17VmKozGc9X8jMGI9rfVrKXyPq21gz/
	 1D1ck3KELIN2ZMY/QFXQjjL/pM8+BRkr0DzHT6StT41u60NEk+XgAve7vxgMCL0OrQ
	 VV0vmUtY01i+w==
Date: Tue, 9 Jun 2026 17:31:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Peter Rosin <peda@lysator.liu.se>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: i2c: convert i2c-mux-reg to DT schema
Message-ID: <20260609-bacteria-quotable-369dfbe2eea1@spud>
References: <20260608-i2c-mux-reg-base-bus-num-v2-1-776e313f213a@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rJFX/9uTU97jRAT0"
Content-Disposition: inline
In-Reply-To: <20260608-i2c-mux-reg-base-bus-num-v2-1-776e313f213a@nexthop.ai>


--rJFX/9uTU97jRAT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--rJFX/9uTU97jRAT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaig/6gAKCRB4tDGHoIJi
0kz/AQCCG57i11nex6vsIcCaLgZO41bsF+uUdqFod4JiZboV9gEA0Y8FDvjisgJh
oxp7zX197+ZjQcTo1/Ojeo99L32Ymwc=
=nzCy
-----END PGP SIGNATURE-----

--rJFX/9uTU97jRAT0--
