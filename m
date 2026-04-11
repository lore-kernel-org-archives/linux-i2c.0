Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6E175A9C;
	Sat, 11 Apr 2026 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775942410; cv=none; b=uo4oXsiayOEBoBMzpq4qRiDIUNc82vuiC0jBCLCYT2zrDH2cQoQwlAhS+oaLRbEjukEcvrslZRSROnPFciUIV1M+YOZ+Kxq2VA40VNVPkBO28u2noZ87/94sePSPR0q1BFaQ/IXvbsVLszC+60cBcaw4O33+YNnQC05HBdvQtYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775942410; c=relaxed/simple;
	bh=khg5OlrBGMzuzNw5mb+76XVjw/gMBrwl1x9IkhYgc5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ocRaKbgK7/IynQlccNlmkUyWzNXY1JE9fxDzjJ+zThPhxupSgJG3+dl2USusmb/Ir7ufsZY+ohPGyyC2HI7I8LjLjRc0c7IR0HKzn4pz+vOcdWzwR04JFJYQf2NEiGb09USq7preqE1Mq20BWFoC/DtCRd1H2GP++8+kUXTPE+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihHpvY/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihHpvY/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C32BC116C6;
	Sat, 11 Apr 2026 21:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775942409;
	bh=khg5OlrBGMzuzNw5mb+76XVjw/gMBrwl1x9IkhYgc5I=;
	h=Date:From:To:Cc:Subject:From;
	b=ihHpvY/uZWhC7SUvQbx3VjMY1X29Pe15Jh03PsSj7xjWkA08XPyZ0ospYiGHoa5lw
	 ickLPc3AYYaVm3OFTrbGqhAo+j3CkinX/fEPjVY0UQp27VfAy3TDLqWA202QjJv0Tq
	 k2K3ihEkRFHx/HS2Xt0ehIeQDTncum0rQaxeqQKHS8z/bloX5kjQKxIVRsDnYYXM0i
	 a2e0m6I4tf69o5wqdtKgJKXxNFALNbQfS8JhY7ZX6rzyHUPZxx9kMweDfhpLXUFde5
	 y7F1KHag9rYenqsF+PwvSjuzJbiXyKpUoCp+6aCNw0abebtwYJ1uBpIHQxzGJX3uFa
	 cVMdGYmLQGcJA==
Date: Sat, 11 Apr 2026 23:20:05 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-7.0-final
Message-ID: <adq7BYaP1_uGqYBp@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5qaW1XMb2F0zU85e"
Content-Disposition: inline


--5qaW1XMb2F0zU85e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-final

for you to fetch changes up to 0637a3086b4fc4165460b21c12b845be6be71be7:

  Merge tag 'i2c-host-fixes-7.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/for-current (2026-04-04 12:02:20 +0200)

----------------------------------------------------------------
i2c-for-7.0-final

imx: set dma_slave_config to 0 and avoid uninitialized fields

----------------------------------------------------------------
Anthony Pighin (1):
      i2c: imx: zero-initialize dma_slave_config for eDMA

Wolfram Sang (1):
      Merge tag 'i2c-host-fixes-7.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/for-current

 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--5qaW1XMb2F0zU85e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmnauwUACgkQFA3kzBSg
KbbsnA//UHo9otW/Z2j00cA3omc8MZoMCEdz1HSkLUPTpELLhcDDswUkRUbndXwZ
cog0YL1epsg71XEMvlM661kb/ivHVYgFtg3dEg8v0068k+rJbRRSJ3OEMaDz8Dnj
GPI/hvhgP1/l36f7CnLbDP5z5mzekVwbciMRLusNW0IUBXDYziu68ECP7o/8MidO
irDJJHH/dIP9W2EoC7TBQK0K3/Kz487JP/ukRZsh82r+ExUgzlslOb2jS6HA8ehg
VlN+uaV6UJRPJdg+LKrAlWBCCnmbTVxXSYwW2ECz+YFjwzd8fETVYoIHa2oJRepW
uoprdlgLufonGh56eZ5pKYVvWBQIu0V4UYCBoBX/u2WTUuJ+ANFNEscvOs8QyH8z
fxtHiPh9NCwn76tjb73ihpt3v7gtwM5eKZwn0ZTOUgRdGaX5ppHEGD00GyEP7+xv
L8CQDI59U6U7ITFHGwd5cbtPj9bo3R8j0WrFz3iAFa/71TI9DsB2DOeBUUnRRFsl
xJeox8XWQuAEDsp66plk6i5xA6uYjzSeygahQV2TfTSAo2XOhPhrUae/kSB5YCQT
CToz/SOMw0+XHB4bUa1dUvCTikUW77thb/eAUdjfm7DWQi4Mf+OR0u4td6f7Epn+
Xw2C+2ql9dpQSUqy3u7DbONF/Yb02LBC9rcLeeLSXrSB50XL9+s=
=rMwf
-----END PGP SIGNATURE-----

--5qaW1XMb2F0zU85e--
