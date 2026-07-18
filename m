Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D518FDDE;
	Sat, 18 Jul 2026 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784371606; cv=none; b=FbCcHRZDUiiFjvZHhnnOg3YzOc79zcU58ypC5aEnrEVkbsypKuYXUb6gMkdOXW3oPY2kZhmNmF2Fhs5R0JrV2vs2S+dS+487okA/K9fKCcJkULgjhGRA8w2uMLCgssofy51PxY30W2QW1DowqzG4Ed2970wGN0JI9B2RWZ1ysHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784371606; c=relaxed/simple;
	bh=j24HJqkCtsvjNtSlB1kg21ECS25KZzL1U1nDsIO/H3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A6qejx7LjGl63n1MlBP4tcVodf0LPNvKDxQYEXzRpLdH6mEWx7rBHgh0bs6j2ROPZHueQqO8NX8+bo3YX5WzjAstVhtHX8IOjwmtG9P6NCShVpeROoeJMmln3eOBP8cPiJtx/0l1hAtgqeNcRzpIpTJuhKiWxMYY2+tW6RYzacY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGWf2GVj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGWf2GVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AC51F000E9;
	Sat, 18 Jul 2026 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784371605;
	bh=COkKMy3c6nCwIHb1Yv+jhwurTd7elm3gzusG9atW52k=;
	h=Date:From:To:Cc:Subject;
	b=hGWf2GVjHpUcp+/FxJZlM1+iCWJi5WQKUwFOXWL7ncpr8dhvwktj4SEU/3HNY3AV2
	 TVL1VkJij/LLG0M1OtLYx3sBUD4F8+F8gT1/bBUhxMg0OMYWp2kLAfZxIDMW5Vz7GE
	 /di4lxW+Bimpyk3+dx985t82dRjGEDFN/cTLyZpMjpf64L60N/oWdwxaWlKjZBFgB8
	 94xLYxmzE6GJUYb2QZE80il+X1zaDrEh9OpnRvOXknay4fNI5GsiootrjNgsongEAk
	 /ZTF6ZOlpWHbUo07XspvKiYeuQIMVhaOP/kbHvB4AfKAVmXqC1QOdPiEHc1NJHBt9U
	 XhJCpetVT2wEg==
Date: Sat, 18 Jul 2026 12:46:42 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c fixes for v7.2-rc4
Message-ID: <altYEuFVUe8KSr5e@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

here is the fixes pull request for v7.2-rc4.

It contains a handful of small fixes for host controller drivers.

One patch also adds Wolfram Sang to CREDITS after more than a
decade of work on I2C.

Thanks,
Andi

The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.2-rc4

for you to fetch changes up to deb35336b5bfed5db9231b5348bc1514db930797:

  i2c: mediatek: fix WRRD for SoCs without auto_restart option (2026-07-15 00:21:51 +0200)

----------------------------------------------------------------
i2c-fixes for v7.2-rc4

imx: fix empty SMBus block reads in atomic and IRQ paths
spacemit: return IRQ_NONE for empty interrupt status
mlxbf: fix a use-after-free issue
mediatek: restore WRRD support without automatic restart
CREDITS: add Wolfram Sang

----------------------------------------------------------------
Andi Shyti (1):
      CREDITS: Add Wolfram Sang

Pei Xiao (1):
      i2c: spacemit: fix spurious IRQ handling returning IRQ_HANDLED

Roman Vivchar (1):
      i2c: mediatek: fix WRRD for SoCs without auto_restart option

Vincent Jardin (2):
      i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
      i2c: imx: fix locked bus on SMBus block-read of 0 (IRQ)

Xuanqiang Luo (1):
      i2c: mlxbf: Fix use-after-free in mlxbf_i2c_init_resource()

 CREDITS                         |  7 +++++++
 drivers/i2c/busses/i2c-imx.c    | 36 +++++++++++++++++++++++++++++++++---
 drivers/i2c/busses/i2c-k1.c     |  2 +-
 drivers/i2c/busses/i2c-mlxbf.c  |  4 +++-
 drivers/i2c/busses/i2c-mt65xx.c |  2 +-
 5 files changed, 45 insertions(+), 6 deletions(-)
