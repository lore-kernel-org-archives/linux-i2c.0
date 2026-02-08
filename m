Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B76E253B42;
	Sun,  8 Feb 2026 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770570808; cv=none; b=Tor2kIUEsZSPJaCGW/Aorlg9adjC93Jw/wdLVPyhrZqgF9jbg2gtbmaJLmdMgqkGaNAbi+CrGTCmnNXDr7E24upHwdeAKibHWvTY62dFUQawEfNJRskI+okT7HY/zw79tob08f5Cvv3+x0cfGjmKzDJkwpxzGUOycYfaR/QYVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770570808; c=relaxed/simple;
	bh=jpoQ2BnzMeMQ9AGPckNcPnBswJtoR0znLbChYlIDBDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UBpR4L8gYUqyya3whNtPhsyoyfjNcdZ88lL4r6d9B7NilbE67OcA2GD6NvlX31F/C5K8p63czxKTclGIemvgq6qmU+1Gro5LzgWhU3t8aWpvPKRFLabbzTMUGgRSbcvpRpSPmUp+b31N0m03gAcq9T1OYWCYgmKmvZIC0s9sGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myN6ObLP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myN6ObLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F04FC4CEF7;
	Sun,  8 Feb 2026 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770570808;
	bh=jpoQ2BnzMeMQ9AGPckNcPnBswJtoR0znLbChYlIDBDc=;
	h=Date:From:To:Cc:Subject:From;
	b=myN6ObLPMWym2mPkpkz8FCQrUNhECPn1A+FT2R8WTyK4hvh2pJl86GloUhN0zABjW
	 u77K4yIVGP4SJsWH37/SoqcQjGshn20z4v+Ls3yE2DnOSqiMa+xbnS6n085lWDF5H3
	 bs7TNEqSLcWyyXpJjgu0XzOFdTkOVSDXmoNEPJaHLE8NgSJl0aOGNLAzNaj2IOFLuH
	 E2bcKO7VOLl/487XyN0rOsqmLGmOJ3Ez/KI+a4tIHIVq81ymSKzAHZ9H7Bi3tpVVi0
	 aGmSFTGxPxhCIbozg6XHDVPatXSAX2xl7K3edqNCMBPKYesWZUl+SGOs4hazAMNgNQ
	 R3ETnQLuo+FJw==
Date: Sun, 8 Feb 2026 18:13:24 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-6.19-final
Message-ID: <aYjEEsu44xfIeoAz@ninjato>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7nOPOkjRV3RD8DEZ"
Content-Disposition: inline


--7nOPOkjRV3RD8DEZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


The following changes since commit 18f7fcd5e69a04df57b563360b88be72471d6b62:

  Linux 6.19-rc8 (2026-02-01 14:01:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.19-final

for you to fetch changes up to b126097b0327437048bd045a0e4d273dea2910dd:

  i2c: imx: preserve error state in block data length handler (2026-02-03 21:47:48 +0100)

----------------------------------------------------------------
i2c-for-6.19-final

imx: preserve error state during SMBus block read length handling

----------------------------------------------------------------
LI Qingwu (1):
      i2c: imx: preserve error state in block data length handler


with much appreciated quality assurance from
----------------------------------------------------------------
Stefan Eichenberger (1):
      (Rev.) i2c: imx: preserve error state in block data length handler

 drivers/i2c/busses/i2c-imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--7nOPOkjRV3RD8DEZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmmIxDQACgkQFA3kzBSg
KbYvyxAAr//CiJ2IoHi1pwZzeU4Zl1ckb4uj+DDpQDDbvTYv6TTX3xfTvks4pk0g
ZZ5A89yRUTSLsvrQT4xqfQpUqCafx/TaGQz8FWsPcciAhbuw0zh8IIgkrnWMZxGc
MXUyHXkNvWmQSsApAhGYtwgjSgtcXUIXTr2Ak+2Otu5a96M8h3fazy6n6jI1KNdx
Tp0YVV/c5y/g61BGOMsu6dv58VpmZB6f5mGkXL+cbWEzdqqwIqa8kSdVoofpgpon
LHSSNL2QFaoaMY9Inh0lJa/g5I3arx48fzC8sRgMwt/IIy0ZxCx0cSOnOign6LKF
r8WjYxSlICaFjhBhVaJKTM/PSmJIHDCu8vkfNb44EEOv/1tJaGBYI0MsGylWQD0b
OYKCwh4t4plgRUaxMvV4vJhTEQCnioIPEQkwjAjqUP3CPR4USJX0I2CfShWUCPwJ
UDjc4GOH4Vb546hqFzXrfV4AHgxnKrV/yS7w0AB3ikekf21OajFiBijuWNQ/fgZO
DHWfWgmHpTIe5iWULFfwmcg9Z9zAhrirw7NcLWSFj5cP8ZA+v/VdN2HW7Da7IR/Z
UMHFts7kKqwjJ1x3C5JbmFG8h1yIZpT/g+/J9v9n44S07aoBxgslF7XX0O13SpY4
MWZ5o+F3JQmvfvzpJGr6m7y52WL/9jqCMHOaHk1upsaoQKkCJnI=
=BfD7
-----END PGP SIGNATURE-----

--7nOPOkjRV3RD8DEZ--
