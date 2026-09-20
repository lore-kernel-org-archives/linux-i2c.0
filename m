Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3B3E63AA;
	Sun, 20 Sep 2026 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789892383; cv=none; b=BxjQu3S8p8XB01fWIUdxOzrXwRzzAqzIx2Xd5VHs3zgtwOq7LCwMvApNyJXNZQykVkc5Zzc2Lc9hKW/OERr7Wqw8I018VF/ozAGZgE9PK79xEm0xoB8j2JsqpAiZ3XY+C7vPKGs92bMhBsxV61cXSLXmPbV2KINcm2Bmmx0L5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789892383; c=relaxed/simple;
	bh=XOZqgrbTwEhLDXtAAzFL3BsufuQiCiIExA6O5OOO/Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FRlcAGg6LgtQFELCOwsYFszkXhyAcQjhaR7eRA7XcKh4ejqWa4/A4bGE2GW197zsmv78Ocrm4ezC4uQ8/843rm1z9ttnOQjrEDcMm7pVHlltaH1H8u3iVawlH3e2s0q3KOjad0N3Dha3P9OXdrnbXDWa1vO4mmxuVcCLJazSNoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC1eVwvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC1eVwvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DF01F000FF;
	Sun, 20 Sep 2026 08:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789892382;
	bh=ZdZlDKO/d7p0FuNgjS7oKNXPIN2Vb2CrJwuPkXktYgo=;
	h=Date:From:To:Cc:Subject;
	b=iC1eVwvDeyML/c/ZA8bPqsu78ddunDxGBn1Yv/X3yqPLVQRL+SVTXfpeMi/joF+lu
	 wdeMS2KGL45HeS/7UWw9hDev8BDtIT/VY9RFfaD5WJu3KvpE8EamlUuuPHzJ6ZDJx1
	 kIJp2CSxN1rvTFbmK8Y06xKt6W5AMilng2rf78y3E3y7XsO1W9KL3qvmjqbneELJJC
	 y+EtKv2SbVMTWrHxeXcwQP4WFe1bWeu+FM+Ja4CJpa0433gLnky9tiJbVcLkzCBXIZ
	 n4WQOVZfaf9e5jNLjF6q6PeGJU2gRbYgYG8Q5TLugHMAuJU88pSbJkThjyQJ05s5a+
	 DfOHSkdPh0qbQ==
Date: Sun, 20 Sep 2026 10:19:36 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c fixes for v7.3-rc4
Message-ID: <aq-Vj-gxzyeNGRzN@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

here is the I2C fixes pull request for v7.3-rc4.

With the increase in AI assisted patches, quite a few fixes and
cleanups are showing up in exit paths, probably because LLMs are
good at spotting failures path issues. Indeed, this pull request
is mostly about error handling, with a good chunk around DMA
resource management.

Andi

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc4

for you to fetch changes up to 7362a1553eb09a8cdf8be7e509bd5309a8342486:

  i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove() (2026-09-20 09:40:29 +0200)

----------------------------------------------------------------
i2c-fixes for v7.3-rc4

Fixes mainly for cleanup and error handling, a good part of them
around DMA resource management.

- at91: ensure DMA channels are released on all exit paths

- imx: fix autosuspend cleanup on remove

- qcom-cci: fix device node reference leak

- atr, imx, qcom-geni: set adapter slot to NULL on registration
  failure

----------------------------------------------------------------
Guangshuo Li (1):
      i2c: imx: disable autosuspend on remove

Linkai Gong (1):
      i2c: atr: fix dangling adapter pointer on add failure

Liu Zhenlong (1):
      i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()

Shengzhuo Wei (3):
      i2c: at91: release DMA channels on remove and probe error
      i2c: imx: release DMA channels on probe error
      i2c: qcom-geni: release DMA channels on probe error

 drivers/i2c/busses/i2c-at91-core.c   |  3 +++
 drivers/i2c/busses/i2c-at91-master.c | 12 +++++++++++-
 drivers/i2c/busses/i2c-at91.h        |  1 +
 drivers/i2c/busses/i2c-imx.c         |  3 +++
 drivers/i2c/busses/i2c-qcom-cci.c    | 20 +++++++++++---------
 drivers/i2c/busses/i2c-qcom-geni.c   |  4 +++-
 drivers/i2c/i2c-atr.c                |  1 +
 7 files changed, 33 insertions(+), 11 deletions(-)
