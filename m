Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AF42F8EA5;
	Sun, 31 May 2026 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780222373; cv=none; b=Ag/hrGYLBeF+Fzgzl011eHKfOBdJEBUJqzjfuPD8iHDg5qUDUkpiN17rZ8lkilP2L2Yc72kP+rZaga1+Iyaroea2rSbxF3g0OOG43irBORaKnBZsen0/s/Wh6sP8LoLLOetnAX9woj+M2PwcfhPwT5w/Zg2iR6wUNBWCqEwy1jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780222373; c=relaxed/simple;
	bh=cB1hPj51DVZ3mNO6qJsaWdDKJeZDdFKIeKRL5BH3pfU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hn9v1dpdGbDlOZAANT0BE5ICnzxKXJtkKqjUkS8Ae5ZfEMRPFK2qZAg65d5ynJyTvBTuhwjxKPZKVn3Fz0Eh6ORZvOgVzHf5GQ1pL2lxsdKYaUDf357GP7wnl31FxtgHImpdhnHjzmxw1+2fSmbCSuFEDRfrp9oJUReqYQgTGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAO45QzV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAO45QzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9461F00893;
	Sun, 31 May 2026 10:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780222372;
	bh=LpKD5fHqTd7m8Wl4k2DhiqJNlq1tec63zKs4Y1sSClM=;
	h=Date:From:To:Cc:Subject;
	b=oAO45QzV5ANHxnnp7IUPd4cfA4d3YidJsM5y9lzFsPNudYLR+1f2hVFeUrJh24/Ag
	 kGLO3N2Xuo49TMSZ4yl2bIQB8GBy3HWUQ1uy/CFKG/LhQayuKp6bgJDhjZRaLgi3JY
	 ofiPwi5EEHbVTxFix+tE8FSGSTclsDiK2e8L6hg36xVqFaFI5G0MkuWQ7hdoRQIvhy
	 Y4a5Quyt+S860xWlr3ru7OTSAZVh2rfd9KOU/OS/Jq9WrpVzDdBTAi9RA3FShKZ2fc
	 JCywFSUbWLD4mRdqZ1dxQ2PFXo5Mfz7kexPfSVGZRBF3a+rOd6jxlzjPRIadf4oh/q
	 5yyll3gfJ3c/w==
Date: Sun, 31 May 2026 12:12:49 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-7.1-rc6
Message-ID: <ahwJodqpwBrKuwP-@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u7f9QhWG8afGMvuT"
Content-Disposition: inline


--u7f9QhWG8afGMvuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc6

for you to fetch changes up to 1d774589f924056b8403e271fdecaf9a803a50fc:

  i2c: virtio: mark device ready before registering the adapter (2026-05-30 15:56:07 +0200)

----------------------------------------------------------------
i2c-for-7.1-rc6

davinci: fix fallback bus frequency on missing clock-frequency
virtio: mark device ready initially

----------------------------------------------------------------
Alexis Bouzigues (1):
      i2c: virtio: mark device ready before registering the adapter

Chaitanya Sabnis (1):
      i2c: davinci: fix division by zero on missing clock-frequency

Wolfram Sang (1):
      Merge tag 'i2c-host-fixes-7.1-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/for-current


with much appreciated quality assurance from
----------------------------------------------------------------
Bartosz Golaszewski (1):
      (Rev.) i2c: davinci: fix division by zero on missing clock-frequency

 drivers/i2c/busses/i2c-davinci.c | 2 +-
 drivers/i2c/busses/i2c-virtio.c  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

--u7f9QhWG8afGMvuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmocCaEACgkQFA3kzBSg
Kbbvfg/+LzDBTlDMnNsh56RnVUxBpuwm8u5ylGZyqvBsg7YQE3Je8Hh3IuxOJFjV
EXWBNE2yk/sCJ2mmRDox3XEud+f+MavCU8MKYNp3JR23vKbsU4trJm63yEQqFSpJ
XBEu99KGc+99VAdCv/wzUtbIGYp3cEm+3VmGJKoQ9bQQz9giVWmANS9tIJiF6w0H
jcZwq8iaVD7JtP3KJcXQFCXGokpZMvgHCvfZCck3f56BFdxiaOHQDESIkOH9OhjK
ZEub0z1x4UX1ccSNZZgBvmVPJSt8Jqn+iDfSGhtKuj5YkPlbWiYKtUb3DtiaFW/v
amzu3TTfQmrffTdla7pfjLJJMGYCDXdMuRtTR+fEW4ZxxWHwLpOVtuUuMZRA9lkG
qdMY+SfJ7qWeaxn/ae0bc0VYebKW1XXc8z+wA71JnthkfiTwMPB0CPnL9eG8vd76
Xrvwd8nWjN7EWDEan6M9ETchj+aA/0P7AcSSTrpky7KypF3RPYYtZnWj3X2GXdOH
XZwW5601D0LHaxRsW1BJpl8ByEKM96ecZZfM2jxxr0uVWR0BT0RF1cY3g+GdtQid
hNWON72VjCRQy3vKt2MlTQjyynK6dH3m/DKpZyk56wnHZhU+nfv5zcv8QoGjPsiv
XdPPAg09JC+GryV5/KnODw6R5+gRVrpBL/iJ/2CI//RIHYjX4m4=
=DtLf
-----END PGP SIGNATURE-----

--u7f9QhWG8afGMvuT--
