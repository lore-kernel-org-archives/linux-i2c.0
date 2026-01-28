Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0A248861;
	Wed, 28 Jan 2026 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622147; cv=none; b=q7xFbXkiDTZzmzpo9rLD9srQY4spkZV+7HUhl2VIG908A2oqlx4lzt8ge0lLJ2rzDr7iEt1h9gIboQAOl0vJ3dXDVc+RSv8z7t+IMbJ+7LuIq4en9W2cwLYQFqaDq2aFTme9gQCZg+XS9dN618ThrcnNWE5KdtNd48UpUXBS/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622147; c=relaxed/simple;
	bh=3AAO19nNVqLcAGRkxvozsuhUW0i3Z+IQDaRF+aPh0L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUR/63kWAn4wHp2fpqXzsseTuxxYX7M9czKact+gRmIMYb/9XNRXsYMWIIa0tmdh9V25qCUI7j6CW7+lBGavHV509Pgn5YM1+LuczaTPfFqYgtOndxjfR51z9Ltt/2WWV/jWDl14LrhbY2zOaRLpcAVfQkxUMFf2ZGpsrcTNKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl+fSdPs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl+fSdPs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D698C4CEF1;
	Wed, 28 Jan 2026 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769622147;
	bh=3AAO19nNVqLcAGRkxvozsuhUW0i3Z+IQDaRF+aPh0L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kl+fSdPsUFL1MDJ7fF6AsuWf/6pM+UtxxA5AvFPPCf0pnQCnA5BwiF5LATymFfDbp
	 io9U8tZMC/oJ+Pr63Mo/MPR1fpJZ8lyyeKiAPzfDlgsQr8fNuK8YAphdC4xLmpRT6E
	 bBoCL20sLdWWfC7hfo/w42YgBQeuIYbojIlANMT9tiIDrLhD4jnCJoRZok9yDRZ4pT
	 6kdhxWnO139zoB4gIJmfd5xWHjRPMUJjyqRLntSNJSKhTYo3baWcaWg99gh8zwilQu
	 uXDkuehJObU+a39S/gc+qQvPhEtkVJViBvX21NRqpUYe/LoOfetxJUyk+6GUG3CMjL
	 xd3p1aOc+nV7g==
Date: Wed, 28 Jan 2026 17:42:22 +0000
From: Conor Dooley <conor@kernel.org>
To: ben717@andestech.com
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: i2c: add support for AE350 I2C
 controller
Message-ID: <20260128-moonstone-grope-5df7a55b5da1@spud>
References: <20260128-atciic100-v3-0-8c002fcc2bb4@andestech.com>
 <20260128-atciic100-v3-1-8c002fcc2bb4@andestech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="foFtRSyLMH1HfjkT"
Content-Disposition: inline
In-Reply-To: <20260128-atciic100-v3-1-8c002fcc2bb4@andestech.com>


--foFtRSyLMH1HfjkT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--foFtRSyLMH1HfjkT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXpKfgAKCRB4tDGHoIJi
0odYAQCXZQk1e9GHrNVVuWzxBQYPhfgr69mFZon7hexoNefbyQD/SnpkBWgLGvlE
vZ9+FsamjcmoLykBgiSU2lznlobpLwk=
=uHGy
-----END PGP SIGNATURE-----

--foFtRSyLMH1HfjkT--
