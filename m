Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589727442;
	Sun, 29 Mar 2026 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774764537; cv=none; b=XIhHNU1lYvNWa/z7EO3L+u6/zM6ALDYkr84yJ1NKMoYgMoYYstSE1cBcl0+M04EopNk1+ee9MWEy5IwDzUyjKmIE1W91/xWRYNVcHu+xD1gJXNmZPH8pTu0CJJwUWJUEyLS2K1Vg5N1xGh2KxltCgLCwu/Pw3tjH8wKR4Qa4bAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774764537; c=relaxed/simple;
	bh=qsMFoTY0MP28ydkio4O3E7lupF9xtiTutfltNqanBCA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S2xr8Px6YESVuYO3STtkOXyUzAE2aKu/F2HLqapgXHTdHSSoLbQkGZ/G5Slk0qH+643bpElkHEH5EEedq60kV69R2r1YFQRoIHLsmPVMBbvgkXM34cYEaKbuXq7I/V4KVR6GdeUohJsbimko1FvpJaItAsxpDBfFGk/DeSdoax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcai+vdJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcai+vdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27A3C116C6;
	Sun, 29 Mar 2026 06:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774764537;
	bh=qsMFoTY0MP28ydkio4O3E7lupF9xtiTutfltNqanBCA=;
	h=Date:From:To:Cc:Subject:From;
	b=qcai+vdJAQi7RY5qY5+qbZ0y5Z+NdbsXt1pOdDcHln9zT0PCf3sblwatYmIZgFXzS
	 V56VGOIDi+aL6jkc2RpmhFgWPiQAsWvRg+/bFMfqQYhro5IvvVLTR6bX9RnevhrwBk
	 lHdCdRLejS2FT3wMhJb8AOt8uLPE8GIne4qrkh/9pfNyAL29RZ83U1CriWsuDkuGQs
	 S+FcU0jHWdyv8NSfVZWtCS2WbOUp1hzfwmf6PlnhOqq7rMirhAZfJblx5xFaFdobDS
	 Xsg0ORaCRX9VNfAkJ+yW19zaj7mfzjIpu4TBK8cbI3Tk6zbnhx4rUUb+0qh+rvdpTb
	 vw1KDIUXHNfvg==
Date: Sun, 29 Mar 2026 08:08:54 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-7.0-rc6
Message-ID: <acjB9v4DteoQcNRs@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ur0yRU8SJXHLSKGa"
Content-Disposition: inline


--ur0yRU8SJXHLSKGa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-rc6

for you to fetch changes up to b0faf733fc1cf7f198c299dcc1638571d7cfd0f7:

  MAINTAINERS: drop outdated I2C website (2026-03-28 20:31:33 +0100)

----------------------------------------------------------------
i2c-for-7.0-rc6

designware: fix resume-probe race causing NULL-deref in amdisp
imx: fix timeout on repeated reads and extra clock at end
MAINTAINERS: drop outdated I2C website

----------------------------------------------------------------
Pratap Nirujogi (1):
      i2c: designware: amdisp: Fix resume-probe race condition issue

Stefan Eichenberger (2):
      i2c: imx: fix i2c issue when reading multiple messages
      i2c: imx: ensure no clock is generated after last read

Wolfram Sang (2):
      Merge tag 'i2c-host-fixes-7.0-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/for-current
      MAINTAINERS: drop outdated I2C website


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (1):
      (Rev.) i2c: designware: amdisp: Fix resume-probe race condition issue

Frank Li (1):
      (Rev.) i2c: imx: fix i2c issue when reading multiple messages

Mario Limonciello (AMD) (1):
      (Rev.) i2c: designware: amdisp: Fix resume-probe race condition issue

 MAINTAINERS                                |  2 --
 drivers/i2c/busses/i2c-designware-amdisp.c | 11 +++----
 drivers/i2c/busses/i2c-imx.c               | 51 +++++++++++++++++++-----------
 3 files changed, 37 insertions(+), 27 deletions(-)

--ur0yRU8SJXHLSKGa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmnIwfYACgkQFA3kzBSg
KbbThg//R+2eiaM7WdFQPMOAzDyh8RIGSoM3RyaITCAP7twfUAIFElBgZrYbwEhJ
oFc7X8lFu7DPTNFtg/a9FP7daJgk6v/ihBxzwDJ3kwPx028krf72vh8jaE3dYcyf
hUJuhR1Sezrbz5uJ2TeNcz9C3YPIokbna7oEE80meE1UQGunbKEQFSm+irUJLSsM
cZvE6ugZK4+pXzD7FpgsMmEoDu64HSOa9NqvvIM6PQeidov0r/liT8Zucti+s3Nz
/QJ1cU2fgId8DJC/mK5woU7ss2JR4yzEVEXrJHNQJ2q8o2+axRI/Vv85Bud1aiSQ
smvr3BxDFmf+rJpIx6AX0eiCELRcYPVBa4cv1htNlQNQjSY/1CYfqCC18aP9HVGe
bbFuIPIyqACN7LLcbINEs3JKpdHm6M20upKCXPX9W+2YQs+ZQU1KMoTvx2JPTRel
vWpb9fAHLy45Cb00uGTwriTBX89LnVCN9Kxk9vNT3V/ji1RaCUbQJgqUHE2LLHyf
SMue0SIXDGmQZWRdvnosIJWYQDVQ4Hutj29Alfk9l+PtAyO5TUD4G0fEI/C15hgt
5EWr9xdT+Cy9zuNjt/CwBkKhzZWP6pyO2CjOXlytlFnnfe4msfbVNYpro6rBJ3fx
hVuzXjEn7CEXHtOcX3NGzjG/3SnffL8rzky2RsYOcs6H7iNTdH0=
=aMqW
-----END PGP SIGNATURE-----

--ur0yRU8SJXHLSKGa--
