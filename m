Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672433A9DA5;
	Tue, 24 Feb 2026 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955762; cv=none; b=tgVO0tuoz2ngqzrWWSJaxqc6HYZXYM6YCNH31sTggAixey5RHEirgz9sySC2/Hrmd5HM+uQDajc55x3kS8vjPHzYQHYl9K7LkEMfe0OgaQbY3LrJNufl8KvEkMy/6fLQPJntveq+U1v5BjJ96Lh4D95tR8sXr2CoHJRu9i9GCCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955762; c=relaxed/simple;
	bh=FYJMufp8dDEIilx5JgSY/m2olD6DzD4PzEhfO392SMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAicr/m9IBFHV22BwEHbUhixoePPL4H6c5RLODWBht9WG1kUp8JDZh7m8pPeRWgQ31GE/blSFSFkscn2frUO/xpTaUnY1dB55hq2tCML9mRsgjttLRH6p443SsNQVoNPwxDwDG3zDLF9BfRln5DJQ516yVBejxJIO5IA33wXy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlhQukWm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlhQukWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A47DC19422;
	Tue, 24 Feb 2026 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771955762;
	bh=FYJMufp8dDEIilx5JgSY/m2olD6DzD4PzEhfO392SMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PlhQukWmeRaR5yJI5mEWXiW9v7pTAZUJA8PyNoImzNrxJYYlYENWMOkN/4cc/jB2v
	 eSvC1R00nFP4fPAlafPZVxkG+yPdbTluLS3MwJwa2bP5beq4mOKufu9/XXrHsyoQhF
	 2RmUqoFf6saxg6sTOtOyVNTWCbjPdIK6Ekfp3HqwqU0mRw6bxXYxsU9FM2WCnCSEV9
	 KTGK3gZNUZ4VkdKocCcKbPYHqYC33okH7buyzVccihMwP2kIY7Jj6uUYjWn+P2wg4N
	 C3dtPPaRurjdUZ+SiF0lfmb6BnokBTRK8ZpBqgKLBNRahwHtJyGQZ4NzFyhzzkx3z6
	 CTfyzSVmucNtQ==
Date: Tue, 24 Feb 2026 17:55:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v1 1/1] dt-bindings: i2c: dw: Remove unused bindings
Message-ID: <20260224-wrinkly-flinch-8c75a8ec7d61@spud>
References: <20260224115210.3499191-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aqINCfUvLFkexCVG"
Content-Disposition: inline
In-Reply-To: <20260224115210.3499191-1-andriy.shevchenko@linux.intel.com>


--aqINCfUvLFkexCVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--aqINCfUvLFkexCVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZ3mLgAKCRB4tDGHoIJi
0vc8AQCvmdMr3IA8S4jVeOckvB7RomrAPaU1dlRAyx5Ptq9I0wEA3M9BSxJUf1jM
NO9cHlBcAyKE5HgnpWKe9LP9craEvwA=
=sK/M
-----END PGP SIGNATURE-----

--aqINCfUvLFkexCVG--
