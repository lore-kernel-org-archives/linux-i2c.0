Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5F44C0400;
	Thu, 11 Jun 2026 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198340; cv=none; b=GE9803LFwHcc4Ma5goCxQlBWhUL3ja5NPiuNlx+CeSrEFnYgnOPkJ/iuVpQFiyAaIz4zPA92VTsVvkqXJ5SzUjzkRbMdC/N7JC1CpiiORqYB4eIUwjIg57hGK261qsHeMT9x9ZYu/3ZRgLkDqcbTlZ6zXloHeyY9zk8N/bpKBYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198340; c=relaxed/simple;
	bh=F9Psw+rSAwYj1B/d62ffjleXhKYCjaBGyJ13qx6Lj9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+ccfPlYifonBfLfDSQpvy7R3q4xXrfrUpXrEmfhjC///12Q30oqjxyJkvRsY6YmHU0bW7OTATKJhpJDHyI1B7JlPrcKWM8lecIofTWhsmc9+iMEM7oDSwZ++o1uXpjuAKZ+ayAP0ofAOYZ9R2LQDicdoa8h7ZMy5g0S40MuBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyYHEpdR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyYHEpdR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324B31F00898;
	Thu, 11 Jun 2026 17:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781198332;
	bh=F9Psw+rSAwYj1B/d62ffjleXhKYCjaBGyJ13qx6Lj9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cyYHEpdRtk8wB7+DDphXk4wVwy1QPm/3Ab+V+M4qADTJzAfzurtmCZe54Q6Or2nUS
	 6PhnkFR+tqiw/N3u5/Njrph4pKDDomAh9fxPBlWhSJ0iqXuj+mj8qyG8WD6Ul4FkAj
	 ubPbmJufsvgc0yy2rAD+IbJC3ou/bmIVlvc8JUKZr9i1KT+Hp+PnA66pPcB8xPly+D
	 wJasQOlHEuMEXDKqMy2DNx1Y/DVgDhguG8pHR4SGvBBZ8l+D5WulPe/fUuUVjcxGgV
	 houCp1cIWZ6vVao/Kg99UiZwKRX0xK8xDjfmnEjS+BU3Hl/T6CwgYmY5Ya6nLXzGrB
	 Z0L2yRC11gQSg==
Date: Thu, 11 Jun 2026 18:18:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
	Peter Rosin <peda@lysator.liu.se>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: i2c-mux-pinctrl: change maintainer
Message-ID: <20260611-unsnap-recreate-3dce0a7e4fdc@spud>
References: <20260611122704.7559-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gr4d1xmw+6kQmNOs"
Content-Disposition: inline
In-Reply-To: <20260611122704.7559-2-wsa+renesas@sang-engineering.com>


--gr4d1xmw+6kQmNOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--gr4d1xmw+6kQmNOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCairt+AAKCRB4tDGHoIJi
0i3+AQC5P5wuJZG+9luhIPZKb7U40kPlzdm0bU8rDF6Vo3Y0jQEA/YlqBoo9JVSy
UXlFuPYWxuEN37l/OEL0oiqgO9mPsw8=
=SJma
-----END PGP SIGNATURE-----

--gr4d1xmw+6kQmNOs--
