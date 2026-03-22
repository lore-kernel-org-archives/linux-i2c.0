Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA4757EA;
	Sun, 22 Mar 2026 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774171895; cv=none; b=q2VL4u56ckfQfTGN9HCvvfkmU9R7YNbOae3bSl9+jBflt4yCCEUXVvQnHXahYjzwYi63bQ3yE/MJfcyuBRTixURv2vbw53Z9qEzb7a5c1PpF9W9rURALPxBY1eCa3WsZslf4m7evXQ7NcJAopGyLcfQDqxGLw773NeR72zaOWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774171895; c=relaxed/simple;
	bh=TH+cce3pe22A5RBRCzqc6Aeeh18OQOe0lTaIqc/SBQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hq/rUEXtmznjrefUUpBLRwkB+rCDrVvjCEyGHuJSFzLzA1ob6b0EsBH/OIqVNmbNcSi7GeXpG/9jJRCf0lVOlMVkLU1ZaCFTZXNaZb83FXQOeNzALtwHtfyIqlvSD8j/b+4OLO+ijVLsDXGxBL0hNn6ZY9M9QrX7Nrr9VQLDXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAXmXbn4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAXmXbn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6E9C19424;
	Sun, 22 Mar 2026 09:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774171894;
	bh=TH+cce3pe22A5RBRCzqc6Aeeh18OQOe0lTaIqc/SBQc=;
	h=Date:From:To:Cc:Subject:From;
	b=iAXmXbn48EdIArLXNL/nB6y2ng5Dda0OqZvrXy9FLJJQO68J2VrdsbvSKka5iNCdE
	 P5vZqij7emPI3tcm0aV5IusbwXqUNvgP17XsPNWjxDKgZ6c7JlyxRgwz+9OsuC+FcI
	 lvHBQwVyx9O1NMQuCMK0vwAAhl4t2goTOyGto5SNtzzQf67rvFE4ROfkKLM5/Csjqj
	 Tq21XUy1eDEWFvyD2jz6w4TkNTpplp88uKZpjQw+9KJv49zAUon35/i5sP0FDK2fvu
	 GIMvHFGcsQPLLd23B5rUvh5IFdPdacRjh57dB5QUtDiEYU6+V3Xcsn77WuF/txt+Aw
	 yDS3pI++Utptg==
Date: Sun, 22 Mar 2026 10:31:31 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-7.0-rc5
Message-ID: <ab-28wml-Lh06k9r@ninjato>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3zYtG01i/HWuoHWB"
Content-Disposition: inline


--3zYtG01i/HWuoHWB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-=
7.0-rc5

for you to fetch changes up to 2f42e85622567a19459679f71e55d41904866aa7:

  Merge tag 'i2c-host-fixes-7.0-rc5' of git://git.kernel.org/pub/scm/linux/=
kernel/git/andi.shyti/linux into i2c/for-current (2026-03-21 19:52:12 +0100)

----------------------------------------------------------------
i2c-for-7.0-rc5

pxa: fix broken I2C communication on Armada 3700 with recovery
fsi: fix device_node reference leak in probe
cp2615: fix NULL-deref when serial string is missing

----------------------------------------------------------------
Christophe JAILLET (1):
      i2c: fsi: Fix a potential leak in fsi_i2c_probe()

Gabor Juhos (1):
      i2c: pxa: defer reset on Armada 3700 when recovery is used

Johan Hovold (1):
      i2c: cp2615: fix serial string NULL-deref at probe

Wolfram Sang (1):
      Merge tag 'i2c-host-fixes-7.0-rc5' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/andi.shyti/linux into i2c/for-current


with much appreciated quality assurance from
----------------------------------------------------------------
Bence Cs=C3=B3k=C3=A1s (1):
      (Rev.) i2c: cp2615: fix serial string NULL-deref at probe

Linus Walleij (1):
      (Rev.) i2c: pxa: defer reset on Armada 3700 when recovery is used

Robert Marko (1):
      (Test) i2c: pxa: defer reset on Armada 3700 when recovery is used

 drivers/i2c/busses/i2c-cp2615.c |  3 +++
 drivers/i2c/busses/i2c-fsi.c    |  1 +
 drivers/i2c/busses/i2c-pxa.c    | 17 ++++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

--3zYtG01i/HWuoHWB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmm/tvMACgkQFA3kzBSg
Kbbl+RAAs1J4cIPDOYArl7lvOvbFoREHuroGQcuKw2DU4K7pGSHibq1Gj5b+Rf91
x1nh7jaiirCzl7l6NuTGr1PhhcWoybmQ2Swn0hT5I/Y6VkO6vAcMjGZJxjoWRAk2
o5tS+PpKYbisDk1afe9etnmI5uytxQTMzETF06lpUIsqQz0bhWhfhaIFDXx4gfXG
X+QKaM2OJ3RXefFAjdCQVOacReqcI2SYHv5rEi0XhXhARHipDvxpEjJiSmjxstV2
hzmECvSTruQQcGmfgH+dw4pFBjEbA4rdiKgeOUO0U6jhp19CSwIQwHzhHKHcukYA
CoMoKa/r8rBbQ/WADR5ldti2mCd7AKr2JgdiekDAvI1Tfx6hH1RxHFrkojoABK8g
eeO8Ug6CrptPSUPO2dcJDLdhlTpOaZbdc6kG+BNOBbcXhgOvQL2mxsy8niGqa/KK
SUSsxcHiHyBApm4zK3vb3NY3SGfV5MHDWX+7ZD5uVR39VqgLcc0XsLOa74i3GweF
ELagJ/WOy4sA53V3NzS3+4pLuk5hzqhG+hJXtVlmuBMZ2R3wZZXCZdSfYpwuYl2Q
z8J2KmTvHj3xDVfoedJivBznD23W9KROv6U9NKfTAzcB38ZJZRCO0xxwYTaf3rd8
N2401rj+O/wUMXasmAtT4wIQii3ubS8yc5g6b9NGu0IUuZREwio=
=aJ6M
-----END PGP SIGNATURE-----

--3zYtG01i/HWuoHWB--
