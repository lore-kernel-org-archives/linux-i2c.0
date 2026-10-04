Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD17423A9A;
	Sun,  4 Oct 2026 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791110129; cv=none; b=aq3MV0y0dVLSmhUsFOVtzfJ7BPOqO/AT/fSG+i3GGC8Bn1KRL3ZSBQh6sji0BfSsDGwhXj7B3pTzb7OnNQJXhZ42fz3D+0v1yL4rzOw0Xrn4SdSss+3xU/cS99BYsMuYsQXvrfL0dhAj2WC6h8cPl0cHiU17eWn9DdVjDyA6W2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791110129; c=relaxed/simple;
	bh=FaNnuiA5CRIE8v94tkAheAVo9Vmnq71nuYLvpy6/cxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PMEVJ0OUSzo+sVAmVj6qoBOYtyurVA9j3Y9KyleVueofz+JrfoP8S4t9EGKEy2Rryo/tQpL6JUJNI0ZwUGBBKREKS2DPKrXdYsyjJm02/rwPD6vuu1gLO3xowUb008HaoIy6yyEX+BG1sadVHuRSboMQ0kKLXPstZlDrrXi/1j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBR5qDOy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBR5qDOy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB281F000FF;
	Sun,  4 Oct 2026 10:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791110128;
	bh=nbNAXhWI550XnZ6vYXKWwGCZsGvqjua6NG/OB10aKL4=;
	h=Date:From:To:Cc:Subject;
	b=mBR5qDOyfMkmu350nd6rK46pXuErFkPpli6hcXbvZwCX5ybU0tFuz0ATRIL5G88XM
	 AJq+JElD7LHTE2ZoTVtajWDZN4vNEC5/M4+R+Qfu8s3jLVLI/q5+txodjkyzo1KHsO
	 BGPpuMG4WSwg4O1UtPBU8TBgC2X/i6JfEM+OBwQe8LWAE+njSSavWGfSa+R/n0K/gi
	 e7TMZjywdEP6AfSVbrTTwqQfX+4WJzfQwsC4t7AkQ1tltXQrmoRruH60Af3o/p3U1W
	 w1a3qIm9hoqI1KV1NkgbwmSaVepE/eqQzwDjuHtI76dG6ExMOdN1kgVM+MloUT+xNU
	 IahOdDlCinJ/g==
Date: Sun, 4 Oct 2026 12:35:20 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c fixes for v7.3-rc6
Message-ID: <asIofz6JIxKb2s-X@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

here is the I2C fixes pull request for v7.3-rc6.

Three xiic patches fix block reads, plus one small at91 error
path cleanup following up on a fix from a previous pull request.

Thanks and perhaps see you in Prague :-)

Andi

The following changes since commit 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e:

  Linux 7.3-rc5 (2026-09-27 13:55:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc6

for you to fetch changes up to c98bf3b86609a18ab16d067280257326e557c636:

  i2c: at91: release DMA channels when probe defers (2026-10-01 13:51:54 +0200)

----------------------------------------------------------------
i2c-fixes for v7.3-rc6

Three patches in xiic for fixing the block reads and a single
cleanup in the error path.

- at91: also release DMA channels when deferring probe

- xiic: fix SMBus block reads with PEC

----------------------------------------------------------------
Abdurrahman Hussain (3):
      i2c: xiic: preserve PEC byte length in SMBus block read setup
      i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
      i2c: xiic: don't clobber msg->len to signal block-read completion

Hongjian Dai (1):
      i2c: at91: release DMA channels when probe defers

 drivers/i2c/busses/i2c-at91-master.c |  8 +++++++-
 drivers/i2c/busses/i2c-xiic.c        | 61 ++++++++++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 53 insertions(+), 16 deletions(-)
