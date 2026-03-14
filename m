Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B134213DBA0;
	Sat, 14 Mar 2026 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773522707; cv=none; b=tMTcx90FVOh4W+bi7HawK4+rvQtDYB1egdL6kbOJhsDx8p3+F/81ZH/7qsgOHFbojdt3xhIWm3oz9/lVE3aSSqyL3R62MNaJvUhpdbVwXeqnwrce3oYFAY672ZVFW1B8VkoHmuei/2tcsg38tKVNW1Hp+Nmlau4l8TzC+/V9Hso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773522707; c=relaxed/simple;
	bh=9VK2XwSOjbBTcJ7sZbKDIR1ACWvVRlL5IqYVkFUdauQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CDAeQ3XCl9loh7gyvmB1bkQt6TQyUQBUBOmupnYshLuVEMDJVF/szhnLZ/6SNN/eKdvgw7aGSuMtYQzxblHNV1XqC2Jn3r/b4zAw1iG/aDGg2jCCG7VB2c48585CDH/vz+Lpsg8Nupy/Cokmg1Pwh6eBEohuMOMYoBr6x3U9WQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDWLEKlP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDWLEKlP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22753C116C6;
	Sat, 14 Mar 2026 21:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773522707;
	bh=9VK2XwSOjbBTcJ7sZbKDIR1ACWvVRlL5IqYVkFUdauQ=;
	h=Date:From:To:Cc:Subject:From;
	b=gDWLEKlPjYbZgEyvObBpsfRGD1pBpFIH0q4wnP036FTmd1TCgLI9vc2Vs6hfberfD
	 ZSNgUutMH7CFqZPJWA0WNpyil0obKYYI9uTBgxnnZq//SCDasqyzZE7+KolWMG0stx
	 AdXl6He5Nl0GRSYtYSX9P3MtrrKcHVmW1zh2Ac8GWiRIAiMMC7hZqeIW1BnK2CLD4t
	 vS5f9W1usEb7bI/qdF5xGsXj7tavEMuuw1fefVKi09r3YylDA9p5P9a8xdt8NnCdMP
	 fKik+grPtTz3nYYNJV/yoqnRFzVrP7LA/0+ey2jaACrgF96rjImYwUuCAObXhJF4NZ
	 QJKJRujscPwgA==
Date: Sat, 14 Mar 2026 22:11:43 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-7.0-rc4
Message-ID: <abXPD2v0M7BoSaXT@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yrrdte4ZX9muvs9p"
Content-Disposition: inline


--Yrrdte4ZX9muvs9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-rc4

for you to fetch changes up to d800d0bb2009a73630a096d7c7a80a2e64c1e41e:

  dt-bindings: i2c: dw: Update maintainer (2026-03-09 13:02:58 +0100)

----------------------------------------------------------------
i2c-for-7.0-rc4

designware: DT binding maintainer update

----------------------------------------------------------------
Mika Westerberg (1):
      dt-bindings: i2c: dw: Update maintainer


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (1):
      (Rev.) dt-bindings: i2c: dw: Update maintainer

 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--Yrrdte4ZX9muvs9p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmm1zw8ACgkQFA3kzBSg
KbYZ+g/7BWfy1bm4ae/MBPcQazgvIEhFcErffkchg3HXft60wqiYyB99fGFhs8M3
CX3zePbJKmx+yPIvFEEuIBrraKKXE36xH53ucUynjWaIcwC+5mYU/NavekN/lbak
4CVcdkOK4aWhodoBXd2dZP12i57NrdYVLXtk4hfR2QznVFeujbgzGUVz4M23wiuE
n6p0LlkEswZNn5FIchasmv3c27lUtSJc87Oyn/tuhqcDhjeH7dKS2cmaOge7nrj/
kmtQJEa3Dl/Tmm+DeTRMGfBRt99YQl3uc+AQmaMc9Ayw12lQ9o6W2TsRU09QUWEQ
gFYbJBAocwjxfZuAp2RuRXhvZOLs78H2VonG+Z7Vxj0kmAztEiiC7ta9JslKKjv+
hc+dVKkn2qsYHMoQQHVo6XuJrT5XiiW2yOAJK19u+PKlGgTZiPu4qiu0pEY661Eu
a/Pfb8UlIb9eNqmz23NYCOg/zTdlGdA2RP4sLzJDjfZ6a2nKQvC0L8aIpOle9CmY
Sq15hh7F8e5eyfp7GlVwOU8aFezsPPtfzque0LAAvBQUfbLiSeLOMqSL19KihNH0
1VwkSESiFClb9+KA//h1N16q7e7ETnx/soM3AxHxptFPPluggrI4clJn+So56kkk
CEgil8QgpkIVQPsmt5wjTGeLI2DXjsXVPnhr8w7Ptk1VDWkeh3s=
=vmTu
-----END PGP SIGNATURE-----

--Yrrdte4ZX9muvs9p--
