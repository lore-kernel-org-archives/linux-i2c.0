Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389B29E0E5;
	Sat, 23 May 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779524338; cv=none; b=cuj93sVX2SmI2t4HGUhVAorNA40zIBaLSG/AC5IW9pm8wGh8ortHxDA39z5GwjXORIca98ukSZFlxILX3cl0UXLd1GhyQLN5GwKySPK0d5immt7DuM9CvTUbAf1IjLWNlESOSfPuB1ERHXk1GefTkKLnGVkecJLRrx/0i9JqAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779524338; c=relaxed/simple;
	bh=9kCkSI6t+LoHH1XeHUdNwHRt/xd/jFg5PmczFTcHcHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=krePyGtcK6Kgk8zn8MC2gqoj39q/dpblG1QvadP4huFyEXrQ4zKeCIDrRROTcU5JZfxLcByKu/ga2iAmpKGCQvuaeJW/NaOkR4eg42EwmdVnDP5ZmZLLTPLRBerNQ6AhNgVrR7lXgzN9XdZP1RVJgdjea1rQ1n6r3rbK2lOsuPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzAHx3Dz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzAHx3Dz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285A41F000E9;
	Sat, 23 May 2026 08:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779524336;
	bh=oljnujBcbTxWuFPkx1VlLdw6/gDHCF8niqSkqQmVkco=;
	h=Date:From:To:Cc:Subject;
	b=nzAHx3DzCgAmtgsPDP3cbT04ZM5GwQvapLrCUrlvmH7cdNDEr+8X+hFwRVR7wD0Qn
	 GAQcjiVzJsFzMa9tmR5tX5gD7yGkoEe0wrdEh0jyqDp5xBKlZhbjPnidN4CZokeYDn
	 ZJqbyQLKc0FmXgEK70c1WKaTzqlsm0UBJR4NwxWFEQqk/aUovOoz6TArcKjYy93wTA
	 0bSWHaun1jfj0IBPcl2utw75EKNfPQ1r1kySRc3K/25Oog6emxpkEpiluYvTnV+Fvg
	 KW6u4ajPHLcn2DVZo56uDdI9Km+I/ci7MdOeqfavjw2LozkimX8gRvm/jXd/t0V6+Q
	 qhwYW+0L/EQ/g==
Date: Sat, 23 May 2026 10:18:53 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-7.1-rc5
Message-ID: <ahFi7Rb3E-NJ1a95@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xylo3zIh1kAx207t"
Content-Disposition: inline


--Xylo3zIh1kAx207t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc5

for you to fetch changes up to 023453cb7eb0f53c5dc36babed8e706c1b0b0187:

  i2c: smbus: fix a potential uninitialization bug (2026-05-19 12:43:08 +0200)

----------------------------------------------------------------
i2c-for-7.1-rc5

- core:
  - smbus: fix a potential uninitialization bug
- tegra:
  - drop runtime PM reference when exiting on mutex_lock failure
  - preserve transfer errors when releasing the mutex

----------------------------------------------------------------
Saurav Sachidanand (2):
      i2c: tegra: fix pm_runtime leak on mutex_lock failure
      i2c: tegra: make tegra_i2c_mutex_unlock() return void

Wenwen Wang (1):
      i2c: smbus: fix a potential uninitialization bug

Wolfram Sang (1):
      Merge tag 'i2c-host-fixes-7.1-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/for-current


with much appreciated quality assurance from
----------------------------------------------------------------
Jon Hunter (2):
      (Rev.) i2c: tegra: make tegra_i2c_mutex_unlock() return void
      (Rev.) i2c: tegra: fix pm_runtime leak on mutex_lock failure

 drivers/i2c/busses/i2c-tegra.c | 19 +++++++++----------
 drivers/i2c/i2c-core-smbus.c   |  1 +
 2 files changed, 10 insertions(+), 10 deletions(-)

--Xylo3zIh1kAx207t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoRYu0ACgkQFA3kzBSg
KbZjtw//aEDHd7geulMFHV3T1gnYn2iwtY++XHk5RUE+RkDaXVUtC4aqSioWUKVc
xZRgtoq2THiafoESlQYyERLpgxf01ckHONXlm89WHmNulTE3loj0FG55z0HZEj+9
vt7VpHXQvhTlkaxfQlXFz7gGQk79Yx6hRCHXLXlsKu6Sk/yS0VQ1Hjwq4CHTp6k5
zo9CaW8UywwgAAYcIDQDIeiUeBpvucMqDay2UveGqWNZOhlT72Y0hYWzfUZoFiyp
EQ54NCp9l1lf8nui7VttdviHO1kawYIOIfFHkygqBtpM+Lv6rSPsPiUv9J9OiYqD
BcLDWTcqZiiQuLsTQCoFPoH3LIE0y4lukI3PHHOnnpA/TunpMrsAL7pMTYZAXSVk
AgjFvQ5xMdDhv4EUQQeg4caiXN+KmJzj1Cspsi3ga+oBNqhRyd474rK1JeNDhpbO
51OfiIp0hol81IgeCdvH90/pWKwO72bdkNfPXkJr6pE9OjzNU0K54RTxsATLdCp3
36hIvXzpu6xEiav5R2KmZiQaxEvi24VPX8DV8YUEnVxCo71HE31U1Er8TMuulsLu
I7ozJ9zl9B2STuuhMQUyvHqDTDzkxDeTKul4TZTmGspNk3dyoc/ZIY97Jsykp3kR
sMIXefa8cfOlX/svg+LK5rVQTxymgSxoNkMiLHDjjdQlOetyHn4=
=PIr7
-----END PGP SIGNATURE-----

--Xylo3zIh1kAx207t--
