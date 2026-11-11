Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403450;
	b=zVFsdjwCKMtxyltE8uVYKUlmx2X0vK/qlRUugV2uEqN11Qh7n38xJM69EsmV6ZMEjW5Q
	 zEyYmoEf5hy/Biaw67NTNBtcaSWvAO73QhrN6YW6PsZFMzX88P/JnmGEcRt78MXZvpKW5
	 aBTOJHR0gwGHBvg6MqXBuBmgKZfR80VFmJU6a4pH7xIIs43RuHOImnzcsL7G2pjlpk56g
	 pZJrHCO9DQ5gyo/MkJogft4G5h0LOyosOevYHJ9xaUYK1pW0qXXSMnUEaW1jBEHZyWaqG
	 T8qT0G30YEBTYWldpmKQAh2xuNGQ2PS6MS6fEzuDmz7d0thOGdEGoZk1hty5fsemXzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403450;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=6YxaanTNTzwLHuzSzrwPQaICHvVNb1Tk/t3EtR62+m0=;
	b=DkWZkaQyLLCqGiD6PXBJb/wJzOzcpgUsS6W1rTJxB/j48Oj91Zd+DzKrOB72v9fkH5MJ
	 8TN5zHnnTvPX7yGE0bvqHDEZr4Bq3YA8f4hiA4QGWnV7nJ94duoo/WceJaS8ikpS0PYrf
	 H2dnXHrrbcOPyPkrdSkY63Qk8JojS+YvgnZLXuyiVAtq7SFiE68h7/gbbMrqRFo7/haya
	 mP6ddfiJ9vhIkFGIZOm82hkw+ldLDj42T9uWtSt3ctyfECXc0r6TXH6nYaI0Uy0/V6XX4
	 TI0rgc6eiQL0MUj2cDLXf4hs+0hKkoMW7IqrGklN66P7Hyh5BhcZ0gk76F9jP4zji6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtxAK+rz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8402F606A321;
	Wed, 11 Nov 2026 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtxAK+rz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976241F00A05;
	Wed, 11 Nov 2026 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403450;
	bh=6YxaanTNTzwLHuzSzrwPQaICHvVNb1Tk/t3EtR62+m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LtxAK+rzIEWeOvMsv0zfu1PlUJDIclNHWFi/MbdnnzJtV11VC5trRRJRU+i4pSJJu
	 RLAluQ63pcrM+ZR7nPpM2y411QL+jfLYhCX3vD1ugEfG1bWZ81m/O4K6LJ/PeuDh3E
	 vtRKyhFvenHASn+IthAYfwd19/FS1ARXZEZh9Hvo3KkUeLip9aa+AAqg4l6keGgXye
	 SghLvOj5Bry1Rn4Ce7GLjaCU4oJBrBQQO5QT8sxfdIiBX0D7cJydwkB0o4aSbR48E1
	 NYmKRnjO5BdrSFvZGNmJY55Dz7Ll4AgFUEJY6/3s8fsvU0vk/xjYt3crnc5sqlEhRi
	 FAvUKXgdIIXLg==
Date: Wed, 11 Nov 2026 13:24:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aniket Limaye <a-limaye@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lianfeng.ouyang@starfivetech.com, s-jain1@ti.com,
	andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add Synopsys DWC_i2c controller
Message-ID: <34533daa-7eb9-4674-a288-e8d87a8bf29f@sirena.org.uk>
References: <20261111-tda54-upstream-i2c-v5-0-280a4a779b24@ti.com>
 <20261111-tda54-upstream-i2c-v5-1-280a4a779b24@ti.com>
 <fc1fe51e-952c-4c8f-8dc1-fb832b03943b@sirena.org.uk>
 <20261111-smooth-meerkat-of-judgment-dbe8bc@quoll>
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
	protocol="application/pgp-signature"; boundary="K37TUb7QGutsDTkg"
Content-Disposition: inline
In-Reply-To: <20261111-smooth-meerkat-of-judgment-dbe8bc@quoll>
X-Cookie: Do not pick the flowers.


--K37TUb7QGutsDTkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2026 at 09:41:40AM +0100, Krzysztof Kozlowski wrote:
> On Wed, Nov 11, 2026 at 12:05:15AM +0000, Mark Brown wrote:

> > I still think we should have a fallback compatible here, while we can't
> > discover the FIFO depths all the uses have a programmed trigger and we
> > know the minimum depth configurable in the IP so we can fall back to
> > using that.  This would be useful for distro kernels, it's one less
> > thing that forces using a kernel with specific SoC support.

> If the driver does not match on such generic compatible - and that's my
> impression from commit msg -  then it is pretty useless.

The driver can match on a generic compatible, it just doesn't right now.
It's getting the FIFO depth from the compatible but as I observe above
the minimum FIFO depth is known so we can just use that as the fallback,
we program the trigger points for the FIFO so it doesn't matter if there
is more space than we're using.

--K37TUb7QGutsDTkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr0bHQACgkQJNaLcl1U
h9A5PAf+N6K4NxWy+Ue34Qka49AWLQ5bLO5NML804x0oHrYOCMPmdFfAVPUUShuN
LBghXbXx+UPiMRVoT2PT64banQyCNOqJHfilN5Fd+OiVrcAM2zYS4CgOBjI3ffVb
vITwfLF735zhDobFjRKfWn9JdM/X5kqX6m7mW/w+43jWppOZzToTMgy5fJDsZKOB
YgCNVX74chs2Ilc6g0dU+opXFYVJg8Tf1c7WRj9qRnJakJTx6CdUTnh1b858sYrD
kcAcPhNHAY5+Zt4ohAkUcWXd9diF+KOcm/GgQBDOynMi4nzSJz6+KkjfasyqbBoO
5yCB0n9J8B5Z5Ld1+Y+P9GBWMj53hQ==
=Txwz
-----END PGP SIGNATURE-----

--K37TUb7QGutsDTkg--
