Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EC2472B6;
	Thu, 23 Apr 2026 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776977428; cv=none; b=W7CJ+IIFFf4jHv8/zcZ47h2qulFuxit2PcHzP+c9dBs9NwdFb05kp9MUxEn6/xo5Ou/SgT+AlxnKDGh/PkIZ7YdRboVDpPUeg5Hgvl3EnifteGZFcV3A0li2h3AX84cyuQ7RGn+s55TS9MZQl9lHNJJ6Nc2RmZnCATO0DfZ3wtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776977428; c=relaxed/simple;
	bh=KVCjW1rnn20O99r4TV4uIEDL25OrkXYiU8MmSCY3Ucc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HAJRWGPjTEKNG2a249Q0OIfK2qur4ihtdCuN1bhCsoVUsO9v1v0cTRA6AXJhmMVGthXbAS3jw0NqqJkfD8TAuS9Utlx/cYIhNT7KT+UpiOZB6UNk8cEhIgs4eBuDz1LfiHdJltW2P07ksyfDk0o/gUmmrlh47KZ5BFa7qA3evU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVKrZIpm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVKrZIpm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914A8C2BCAF;
	Thu, 23 Apr 2026 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776977428;
	bh=KVCjW1rnn20O99r4TV4uIEDL25OrkXYiU8MmSCY3Ucc=;
	h=Date:From:To:Cc:Subject:From;
	b=lVKrZIpmkYlzR7gtJ1PFMupeX3Zl4Wy3TGrsPI3iNcyXKuNYI1Olj6FeCljE9sn+h
	 Eionw7XBzjTFNLhq2k8TfkOlok50HU7U3bqyCXQ3A/9FkuJijPDG42n4/8Rzdntn6m
	 OE1+l6Z1mGdv+FWsTYLN2vxxEjznF+r1DT1fPMqwbZpc0/jOF38RilFOK3dY3CoqoD
	 RLmKwTbqdPhZF256TCj92Ux4RP0n7oNaZVoCcyNuX0MvedEbLRP5f/xDTqIY+V1sqQ
	 YxrMseix/03KOZPQiVHrLtsHfk8E3s7d69yc+Vv6KGddn590HgIMa8C+GUvzwcuyPq
	 SAVO/rR76kTvw==
Date: Thu, 23 Apr 2026 22:50:24 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Igor Korotin <igor.korotin@linux.dev>
Subject: [PULL REQUEST] i2c-for-7.1-rc1-part2
Message-ID: <aeqGEIItM7yUkTgQ@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QjpCanfv3ROjwHUC"
Content-Disposition: inline


--QjpCanfv3ROjwHUC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c1f49dea2b8f335813d3b348fd39117fb8efb428:

  Merge tag 'mm-hotfixes-stable-2026-04-19-00-14' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2026-04-19 14:45:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc1-part2

for you to fetch changes up to 79fc229e8a471356ddfea225f42e02f4fb73c469:

  MAINTAINERS: add Rust I2C tree and update Igor Korotin's email (2026-04-20 00:05:35 +0200)

----------------------------------------------------------------
i2c-for-7.1-rc1-part2

- cx92755: convert I2C bindings to DT schema
- mediatek: add optional bus power management during transfers
- pxa: handle early bus busy condition
- MAINTAINERS: update I2C RUST entry

----------------------------------------------------------------
Adlavinitha Reddy (1):
      i2c: mediatek: add bus regulator control for power saving

Gabor Juhos (1):
      i2c: pxa: handle 'Early Bus Busy' condition on Armada 3700

Igor Korotin (1):
      MAINTAINERS: add Rust I2C tree and update Igor Korotin's email

Shi Hao (1):
      dt-bindings: i2c: cnxt,cx92755-i2c: Convert to DT schema

Wolfram Sang (1):
      Merge tag 'i2c-host-7.1-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/for-mergewindow


with much appreciated quality assurance from
----------------------------------------------------------------
Chen-Yu Tsai (1):
      (Rev.) i2c: mediatek: add bus regulator control for power saving

Imre Kaloz (1):
      (Rev.) i2c: pxa: handle 'Early Bus Busy' condition on Armada 3700

Linus Walleij (1):
      (Rev.) i2c: pxa: handle 'Early Bus Busy' condition on Armada 3700

Rob Herring (Arm) (1):
      (Rev.) dt-bindings: i2c: cnxt,cx92755-i2c: Convert to DT schema

Robert Marko (1):
      (Test) i2c: pxa: handle 'Early Bus Busy' condition on Armada 3700

 .mailmap                                           |  1 +
 .../devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml  | 49 ++++++++++++++++++++++
 .../devicetree/bindings/i2c/i2c-digicolor.txt      | 25 -----------
 MAINTAINERS                                        |  3 +-
 drivers/i2c/busses/i2c-mt65xx.c                    | 13 +++++-
 drivers/i2c/busses/i2c-pxa.c                       | 18 +++++---
 6 files changed, 76 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-digicolor.txt

--QjpCanfv3ROjwHUC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmnqhhAACgkQFA3kzBSg
KbaLZw/9FgWmm6EJ/DOI7IoemqrAlkPx7SqrAvLF3YnVtMTuoK1XNIMeey175Gg7
ZD11MrFn05wfZsNWm6UiYIwTXx3VyD5xpnoW/74HXu3O0JRX0DutqwkilM6BwqjB
qVpQuGh7s+xsjmX+vuBE4O/DvXHAC0CHuLRV/ESCwrj61roWsp8gHZtkMxMvMosA
NBNHqr1wCS9RX0F4pcUKA8YUkhSFmsCTqEJ3yyALogCP3xxFI5S0EuP+fo4wkXOI
dGhQh6vhmOZSkVHIaW62c2u2WxH6I9pzpHMOSSbt5tV6VEBudEeQlHEu5cM/rvYY
PvUzISJP9+gBImfHBgFxjuXsSi1MHj5qTFnp39f77MZhnVB5V+/zV1YCLOy2qjmE
L0OlZp5cFFLiQexNc9rRHIJT4d9FKFI3k8+wHhlil8Vot93rIVL7JK8KdVCOt1Rh
oWEyhp3w5fAwl1jgGvLoTb/WUvvzjkylkNVDzXtsgswjmzi5kZv6qFetIYJhMtPy
in50nxFmuinHiUGDexEcngYKv2zijx9Xp/ot+9wDQTqUvxXOJohLMGEss+3AoY7s
LzV74PV1RG/++0GFImAcaEbJSedzbcDgzKQ+mEYaJXo0puREDsvpr1ZU09EvqyrF
MIrNbWZqUliweBZykvHh2gjj+lYFd3AJ9B2pKrmi8OgQg6YJTWI=
=staL
-----END PGP SIGNATURE-----

--QjpCanfv3ROjwHUC--
