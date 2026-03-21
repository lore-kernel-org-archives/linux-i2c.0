Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1864369218;
	Sat, 21 Mar 2026 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774075985; cv=none; b=amykZb3XDhxKbsVH7IvqC3lxm0QGMk4VSiuGV6c9cRwn+zhqYrVGryady9LXk0RvGwMSEvqKfnHbg0uoDbfC8B4876HKFgW6abqo+iwORhxzeKz4YDLTGjha5e+SvQ9SyUdHSgqFszK5yaj68znpoQPfBDlk5VkFXSMdg+Sv0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774075985; c=relaxed/simple;
	bh=K78zWrIQ4cQVkZ7dkc5bFXUslj/tUyMYpym63bJdUVE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F3idteezMvoRHR5C1a/FhBjaEnYxBSsZISbvGc4hlEx1mfce+OeYUe27EwKYbuBFCMRkHwQOMX9ld4eV6Gq1dtSgY8PfdLal3/tz5zfpMucwo7/01mVPiyDFNeN6zqU5shVukHnFoh+1YwA4aNTCRrQG67Lqlf+1VyzIIiFkr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzswv7Yh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzswv7Yh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022D5C19421;
	Sat, 21 Mar 2026 06:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774075985;
	bh=K78zWrIQ4cQVkZ7dkc5bFXUslj/tUyMYpym63bJdUVE=;
	h=Date:From:To:Cc:Subject:From;
	b=hzswv7Yhr5WH1VTRnxc7UjYjCKWwL7NokLM/4IGe6MTcxW/t6YwcUZeJiu8fE0dWV
	 oB2WcjG6HO7Gd8rtrGoDtONcluGjuj9tC2j7GmOAp0nLT0/iJty+FG6XVR7yWTb4Az
	 COhUE3y2WXkEaKtcYHC+xaJ+FZVn8VG0pG2BRPo1jlqpXmvTXUGjsakA9qKnykxnsR
	 wo1GheMATHxE8LE0ufx0Omh/mgDe4LxgQNLt1BMvPaVDEB4VsNlvhx40AskpZM2Znu
	 LK3Q8EVofV7BPbR6Gb1WXZGyK+haooSG2m2uYGDi9k16osqCRcISSM1N5+9mXyL54G
	 y2giADOJRuRdQ==
Date: Sat, 21 Mar 2026 07:52:59 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c-host-fixes for v7.0-rc5
Message-ID: <ab4-Fe7_muMFBnNo@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wolfram,

here's the pull request for v7.0-rc5.

It contains three fixes for a regression, a reference leak, and a
potential NULL-dereference.

Thank you,
Andi

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c-host-fixes-7.0-rc5

for you to fetch changes up to 78a6ee14f8b9e1c8f7c77612122444f3be8dc8cc:

  i2c: pxa: defer reset on Armada 3700 when recovery is used (2026-03-19 23:54:03 +0100)

----------------------------------------------------------------
i2c-fixes for v7.0-rc5

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

 drivers/i2c/busses/i2c-cp2615.c |  3 +++
 drivers/i2c/busses/i2c-fsi.c    |  1 +
 drivers/i2c/busses/i2c-pxa.c    | 17 ++++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)
