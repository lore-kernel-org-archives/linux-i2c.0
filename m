Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0A37C11B;
	Fri, 30 Jan 2026 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769776633; cv=none; b=B/e8mSuFcq6IrLIjIb4xjJSkgHrmAfycbexSTzwtX62XPtYE+EeOR+tRddolM5543+eTCal25x9q/wcSmSH/XoYoYd7/23EFk+PN+gTkI8yi+hKU1dJEaVgSDDJwChXxcd2OWXJhP52eOoLeAIgZQ4uHiBe/7wBwsIVQ1kmTw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769776633; c=relaxed/simple;
	bh=drjEDZy/Jwzku6kLG5GuINXQUdrKzFDkYaKdxN51L3w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c//jLLhOuacDksH0GQu/oxuuDT9ropKM8dXyxMmK4A0/rOCQOJR6oFVRn2kGHmt34sCNdVKLzB3/v5x5awnW4CU2Xm4vr9BFdTS6ZIKda6YOKvJLq6gsPESi9LRHVKQm+6gDvJ5l9J3hpwWiX3M3y8oA0sRscnmUCpUYKEUCdqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehOVeHna; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehOVeHna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E11C4CEF7;
	Fri, 30 Jan 2026 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769776633;
	bh=drjEDZy/Jwzku6kLG5GuINXQUdrKzFDkYaKdxN51L3w=;
	h=Date:From:To:Cc:Subject:From;
	b=ehOVeHnaKMdFpIE/M7ef9mZqDwa6Kggld7Uf4SzUE2dM7N6jvxNMpTcnFjuCbGNX9
	 I06ogHhda5zgZa5hWQAEXdlDYEwM6t2Od1daiDShEaD3Ah4+UxdgZsYbLppG55t4lW
	 S7E1L9I/jVDtvEHCpe2Sw4TK6WFf00kANL3H6IsLtOw2VA+NfjNRhNqc/Z4JKNvCoE
	 51y73HOZxKWOz3AmAnFVJ58pveHskrvgZFCNAjmLCWiJNGq//3rqCYSwfZx9GnJ7Em
	 HFVcv/JRtrLavOiURcHB/mMUjJT2KeVhTYiZ50ox8hyPLRln7Cf+GAmPJH2bsoZK4I
	 FFFHBmoDr9ewA==
Date: Fri, 30 Jan 2026 13:37:08 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c-host-fixes for v6.19-rc8
Message-ID: <aXyk_FOGDp7qIReN@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wolfram,

another single-fix pull request for this week. It addresses a
potential endless loop in the imx driver.

See you later for the merge window pull request.

Thank you,
Andi

The following changes since commit 913fb068e259079bf9564c9e84ff9e65c37dcac7:

  Merge tag 'i2c-for-6.19-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux (2026-01-25 09:47:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-host-fixes-6.19-rc8

for you to fetch changes up to 35f98b8eddc05198331d7c73aab1678f7cbd4a6b:

  i2c: imx: preserve error state in block data length handler (2026-01-28 23:07:18 +0100)

----------------------------------------------------------------
i2c-host-fixes for v6.19-rc8

imx: preserve error state during SMBus block read length handling

----------------------------------------------------------------
LI Qingwu (1):
      i2c: imx: preserve error state in block data length handler

 drivers/i2c/busses/i2c-imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
