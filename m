Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AF3C4174;
	Sun, 18 Oct 2026 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337363; cv=none; b=XrujcHbsE69IgBvOoPb/RpwsKDpwzQMgZTZzrJtsnlAgji8I6tS7zJ/DiEg7F5o+4BCRrYr14bJ2o7Bru5JcNDmZ++a27ZOU9q3PVIH6lrgs9y6B6+NKNuwmeLpbi4LUjPS5UjltBapsRlYEoDqpLl8EXMzv9MI+H5iXBffHCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337363; c=relaxed/simple;
	bh=ndPj/MRuWOmfmpFeNkmAZMv3ZLtkD2rHgxnqzjwYKsc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y6ENdjMlbE8WTMGX9sy0fVJsihnNoodKJLwScDNbGh6hNGlIKsIigRVPQYns9lsELV0S2YTH4oEOSWkVYdYE4jnMxq+xsqobFSMhv/0hX3+SAdiFd6q/SUrlacgR3guctouWHoOp3YXGQ92RJmb2V3nXWR0+Z94ujZD05NyTgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIdk7P8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIdk7P8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E3F1F000C5;
	Sun, 18 Oct 2026 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792337360;
	bh=/fL02t5rlNN+WBTYfMt4VFz1weGYNri94i3vLswweUI=;
	h=Date:From:To:Cc:Subject;
	b=QIdk7P8Zdw9LZw2cS59mxM4YVtBcwUeHK+cSdZATFH0WCaiu90/lZmHjBRf1iUo2I
	 LPYZ1/XZ+1olDg135yIzMRAWziEMLu+VEmaUp+VoN2ScrfuMwU7ADEr+NOFUX3Leug
	 1+T8x6a93qJ3ReuY7pgBJunw+Id7L7Z5ifW+3qdmWgc8fMrYKZMZmHX2T1HG7zLpzN
	 YPCRtgT2bmdjJ3BQhI30ydXCYopN5pgM0dgTicvZuEYRtsFY7LufcfhWKyZ/CdOGhB
	 70IpaQvgCsiBrwxwMGUyMBy//cSJwsMa0i6voz0lSxptqnW08ToKbidBniaOTz1rp3
	 J+taigq0pxiYw==
Date: Sun, 18 Oct 2026 17:29:16 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c fixes for v7.3-rc8
Message-ID: <atTk4XFuPp9T88YL@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

here is the I2C fixes pull request, formally for v7.3-rc8.

This round we have three independent fixes dealing with clock
management, plus one small fix for a reset-mask blunder in the
qcom-cci interrupt handler.

Tomorrow I'll send the pull request for the merge window.

Thanks,
Andi

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c-fixes-7.3-rc8

for you to fetch changes up to d33373c565af9c8a28776af02bd20ba6e5724211:

  i2c: xiic: restore non-managed runtime PM to fix clk WARN flood (2026-10-15 22:34:34 +0200)

----------------------------------------------------------------
i2c-fixes for v7.3-rc8

Three independent clock management fixes, plus one for a simple
reset mask blunder in the qcom-cci interrupt handler.

- qcom-cci: prevent lost reset requests during interrupt handling

- qcom-geni: preserve the selected source clock

- viai2c-wmt: fix clock reference leak

- xiic: fix clock disable warnings during removal

----------------------------------------------------------------
Abdurrahman Hussain (1):
      i2c: xiic: restore non-managed runtime PM to fix clk WARN flood

Abel Vesa (1):
      i2c: qcom-geni: Restore the source-clock selection policy

Loic Poulain (1):
      i2c: qcom-cci: Fix HALT_ACK reset request being dropped

Wentao Liang (1):
      i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()

 drivers/i2c/busses/i2c-qcom-cci.c   |  4 ++--
 drivers/i2c/busses/i2c-qcom-geni.c  | 37 ++++++++++++++++++++-----------------
 drivers/i2c/busses/i2c-viai2c-wmt.c |  2 +-
 drivers/i2c/busses/i2c-xiic.c       | 49 ++++++++++++++++++++++++++++++++++++++++---------
 4 files changed, 63 insertions(+), 29 deletions(-)
