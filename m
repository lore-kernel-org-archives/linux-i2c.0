Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0143BED59;
	Mon, 12 Oct 2026 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831447; cv=none; b=mxuTzBc7cGWzWEg2gxeeElZ19YDQG++CJHYhqPvL/fiJMiJHTXI+bQBHIMUsslFBz5jM2HN/NDp+64tjjU+wtjwG2tlkhghmZtcIYcBTnTaGMwKK5x+xTqg0+scwyjT7CeuAGvu0M/2FA8nxWPhiSavvHMgIRx1vSBUTZRg/sYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831447; c=relaxed/simple;
	bh=aGv7wzz6dSlgfk0zNA/9NELYefYWEvx5y5COyaIu+P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5BQ4b8rq1+Hps/LBpSDnQLwfwqHkM7DqhiCCnTRvyDEMAKzu2E/noW1bocA9FtlNAU1hhemLfgr5IucJG3rZgB4anheKRir/E0YKXj353hfLZtUvAFI18kgusix1F8ZQCLAzopb+2RebWAOJBDH02H51fcXDNQwtIdSYfPt+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPBeZDYr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPBeZDYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702621F0089B;
	Mon, 12 Oct 2026 18:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831445;
	bh=aGv7wzz6dSlgfk0zNA/9NELYefYWEvx5y5COyaIu+P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aPBeZDYrJ/i+B8WrCeaXrBd3+XUWJhZo2r1ihQEkQVznr703fBmMw3UCjeXC6EQ9L
	 etAhg6dkaTZGSkAlaiYGxENtFPCh1fnnuS3hUO9HKKKKzSzfXSsI+MWeTdHg8dC5yf
	 +FYmfmXeK0sOgA96u3jjofHSE2lf0VcwQINa7xuCT0ZeK69C2max3q6yaBcMuMjdYX
	 f/55s+EpA0X5sa4i3v+dsP4DnwLYFY9q6/ZA29WEHh0iamOuy0vKj09ANu3PwhVThZ
	 UyfbNN+0sdiHvATHJq9DV7mUHL+aGneePT0CdMksnHxH2h89m+rpmIPNSN95tuITo3
	 q0m2akVOCy7Rg==
Date: Mon, 12 Oct 2026 19:57:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: i2c: apple,i2c: Add t8140-i2c compatible
Message-ID: <20261012-crudeness-able-6f5f7dc1e7cc@spud>
References: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
 <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-3-6c757966a99e@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="muLY+G8FkQlRJbj0"
Content-Disposition: inline
In-Reply-To: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-3-6c757966a99e@cyberchaos.dev>

--muLY+G8FkQlRJbj0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--muLY+G8FkQlRJbj0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0tkQAKCRB4tDGHoIJi
0vTFAP9A0KLlFBmkMU0KWr4iNtgNej/Za1EjmTmVElTOA1WMhgD/eWeOIHdfVIDr
9YivZwI7/s5C8lmOWzAtJOQouTexAAw=
=AfRS
-----END PGP SIGNATURE-----

--muLY+G8FkQlRJbj0--
