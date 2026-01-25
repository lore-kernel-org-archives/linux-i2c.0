Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511023EAAD;
	Sun, 25 Jan 2026 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769341997; cv=none; b=b4fsdO3vKVGvyqNGXJJmJ9BapgFlU2v/Apg6ot/8bcFYz3iCjdm82+NHA3xakMeiU+VeL4tCV6/5O2fjR0ftBlAuokWYXOqq5S1HjAItg4MH/8UQ3go4wbCYW4r+h8fE889S80i2iehGYUkicKjrolEBNMgyMnh/ODaLgO1ICGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769341997; c=relaxed/simple;
	bh=VyJdk6f/chUrMYh+Ke/VkpOqnL8DbpUgwKHkOrUieI0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xnz0R5V8unONEhXHrYczNwvhL9ttFvkQkGDk8iVopGMtbcfwSPEdr8qbH7S3AyoWIlZsb7cdDcfG2hXZcKoyZkyc/+SIygK3TwO+D7Xl3R+koQkgHmWv3/OA2FZzx6FLsNrMusH1hKiOSiAdeiOEqYq4Vi1NLWoiwOzFjSvl43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC2dRW2I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC2dRW2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A34C4CEF1;
	Sun, 25 Jan 2026 11:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769341997;
	bh=VyJdk6f/chUrMYh+Ke/VkpOqnL8DbpUgwKHkOrUieI0=;
	h=Date:From:To:Cc:Subject:From;
	b=mC2dRW2I2g9TqbhAKp0XsHsPqTmH+hhaLJmU7KbC0/W8YqstzELYn/qsk5p7Pcat+
	 1pCBCn18QMoOAFlRw2IF//aThg8CVNcEsnH3QHYqipyRHIDNb13f/z7lwmRt2lJnkG
	 DElezWqNIZfRMFGvc7atP5SvJROwbeZziMYnW8PLfyIZrHn81JFrp6aMh19tFVbqDh
	 bWRjNClXBp4Yqg7iAtZ7adJTkQ+SX8//mCiz9WBkeihLjHRV6IaW3fK3+pdvHM8T4Q
	 ajkFPixBNfBkQ2To8CKnIg3V4c7UZMWiDHSiN/IAwTR2IleF+cTUphnnY1ouqxCNBO
	 H4bDzKvLpK70Q==
Date: Sun, 25 Jan 2026 12:53:13 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-6.19-rc7
Message-ID: <aXYEKRm-w1AkwaAC@ninjato>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q2DW68PIgWo5qqJR"
Content-Disposition: inline


--q2DW68PIgWo5qqJR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7:

  Linux 6.19-rc6 (2026-01-18 15:42:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.19-rc7

for you to fetch changes up to e6e09d34118477fa3cb4dcea330ba2f6c5bdaf4d:

  Merge tag 'i2c-host-fixes-6.19-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/for-current (2026-01-24 12:56:53 +0100)

----------------------------------------------------------------
i2c-for-6.19-rc7

k1: drop wrong IRQF_ONESHOT from IRQ request to fix genirq warning

----------------------------------------------------------------
Wolfram Sang (1):
      Merge tag 'i2c-host-fixes-6.19-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/for-current

Yixun Lan (1):
      i2c: spacemit: drop IRQF_ONESHOT flag from IRQ request


with much appreciated quality assurance from
----------------------------------------------------------------
Javier Martinez Canillas (1):
      (Rev.) i2c: spacemit: drop IRQF_ONESHOT flag from IRQ request

Troy Mitchell (1):
      (Rev.) i2c: spacemit: drop IRQF_ONESHOT flag from IRQ request

 drivers/i2c/busses/i2c-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--q2DW68PIgWo5qqJR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAml2BCkACgkQFA3kzBSg
KbY1RQ//Z+ZV60C+YM0by03Wz0YhsPgZ10iDbwNIa/kLSmawX+wsa6n4NWgOzC4+
GUy6l3MWO6zdrT/NFYUwB+nqUwdfemssHY+LO/pUD5QncH6LEtfVNrl+NTPGLaYJ
qDEpdr4PvqF470ff3NwUGKcIt4JjWN+nNPlVl4tSyWLEGYSSvBkk/WpjGQnHkbHZ
PAR6mHS02gVrA39DHPsKu51K6VTZRuy6h6KeYHOrxvF27BvyB+4gN/9eS9iye4Po
AcSia2CcbKUyqgsOZnkIMsJHewAHNpUn6gI1KVdgHomgM+Ge2SH0wNc8/rbCY+H3
QrpLIwsiYUcTVVg0GFlO3PwGKd+HTOG+fDxiZQygQYqVlW9BlBSg0c4tNnBuM+LX
E3KXMaUCyz5IV0GpI4GQJYHVmZcKZS0mvPbnxEr40nc1vulZhWpPkv/NuKTQ4GCe
XLjmQSrMCOtYKspLmvYX++lsQRr79FuY9+TLBQtQLw1190h3vqV/hu3aJ06wL1J6
lYJr+xam2Iu15FDd0BnhMloP6kXJSk5nrk+h9+apujZw2VxK4HG+Tr2FjfhzIlhZ
3xpA64tiMr4rFQdQmkZWqThPyli+cTResT9nWD4pjLXwuSTJzcCEs3rL0Bf9Ufcq
lU/F2gCEa37d40kWbP6XLgKML2En9EVogI4r9XqOJ0NsOWi4JbU=
=bsrT
-----END PGP SIGNATURE-----

--q2DW68PIgWo5qqJR--
