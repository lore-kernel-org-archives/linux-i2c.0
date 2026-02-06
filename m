Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C223C8AE;
	Fri,  6 Feb 2026 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770422232; cv=none; b=rZajC3QpWh+o8fo66eNjOLCQ/cnUtTzhCKpGnIdKIEirX4EvqkQ3S0W8PruqegEh/wV2cMUzXyBDNBZ49kQ8BcibFBEraX5MQHgvCPIIGbSqBBhYWhUqbiUYidTEQ3DSo2l9OqqBV71C2aSGjyqhNd2wQeClbBiHKwhuHiAQWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770422232; c=relaxed/simple;
	bh=nwNLSl+MG7d54qsImCdYQTeVEJkNXlOSZz/fyKu3Rt4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pLAdK1K4d1o0svCqFlokG7Z0U3YcnBvD+NYkg2ZyvDKK8Sc2LRm8UpCZiWLkxIY3kQkO2noBudhZskHG97XL1yx/pPwmFDCnQ85j6bzJ3ngXVnXE0v5k9AqSw+nNOz7gVOygppRFNPN5UzfaPI+AMBp9ZVjHqHnWVH9iaUtPyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwhnuyJ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwhnuyJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A2EC116C6;
	Fri,  6 Feb 2026 23:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770422231;
	bh=nwNLSl+MG7d54qsImCdYQTeVEJkNXlOSZz/fyKu3Rt4=;
	h=Date:From:To:Cc:Subject:From;
	b=VwhnuyJ0WNr+9ivmbPuvwvghxW0WlgrCuP1OUjV0i+P4ykD1Oaqhg5sjpD3sVjHi9
	 4yEZ1DsLAWSZdu+dJ+dmQ+pOry0I8WrGOyPeyb2sMCw/6/Xp1P5fjERfsZ8+fHQaLP
	 9Voel2jPUbGlO1mvqSfWfOXRJd8Q+4bPlpCemRmYhRuO9h5B5Q97A3FEwJtXQ6Rlz1
	 ifFx5+nZ/jySze6B3kMmIlDBgu4Yoc/g9SjuFbc62qLW7zG4DGZk1pNQgp69XVfTjV
	 lMajNF1dz3xetLYHhzcFEEB93UYfj9djDOXMtUVPxxRFqEJamCeQjA41QwPZLw2/dK
	 mBY7BmTZ+CJWw==
Date: Sat, 7 Feb 2026 00:57:06 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: i2c-host-fixes for v6.19-rc9
Message-ID: <aYZ-AZcfwfG1poEH@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wolfram,

here is the fixes pull request. After you cherry-picked from my
previous pull request, I reset my -fixes branch on top of your
for-current branch, so this should be an easy merge.

This pull request contains just one fix from Carlos for
mx-lpi2c.

I have already sent the merge window pull request and that is
still valid. I am collecting additional patches in i2c-host-2 for
next week. All patches in that branch are tested as usual in my
-next branch.

I wish you a great weekend!
Andi

The following changes since commit b126097b0327437048bd045a0e4d273dea2910dd:

  i2c: imx: preserve error state in block data length handler (2026-02-03 21:47:48 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-host-fixes-6.19-rc9

for you to fetch changes up to b4b4d88ebfbfd3aadb4c9a0f2bfe1abdbaf5822c:

  i2c: imx-lpi2c: fix SMBus block read NACK after byte count (2026-02-04 02:52:16 +0100)

----------------------------------------------------------------
i2c-host-fixes for v6.19-rc9

imx-lpi2c: fix premature NACK in SMBus block read handling

----------------------------------------------------------------
Carlos Song (1):
      i2c: imx-lpi2c: fix SMBus block read NACK after byte count

 drivers/i2c/busses/i2c-imx-lpi2c.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 83 insertions(+), 24 deletions(-)
