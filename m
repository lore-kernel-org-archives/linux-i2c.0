Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE813C4166;
	Tue, 16 Jun 2026 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577024; cv=none; b=FQLwwULR8HRu5JvP9+uVbRd1C9aV61QU63jtIkkBRpDFzlvT3k51kYUlvQjhhU6sFSMaMP/xaZGtUmHyQ4e6+N4BX5TlyceHmdAU4qGyUtWy9SOiBKpfDygXh02BUEBHhnswVlCYc4w4f8F4XbXaK29KQCP2fjtlsN5v+cYSktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577024; c=relaxed/simple;
	bh=jDXPcZ3vbAPjCR2MAXOhYoo3wou+zMp1Y5OmetHf4BM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n/vSU2NXqObCpTxbcnCz2dFYCSthkBiItvuJs/sfhWIiI5r5bLNd4pRJSoRRveP1JpFtjmpe846H1AO83/L1J8CTVoAKW44dt8VwGAihfWaiwqUBAL5dDbs3gC1hxbwHf7x6xY+c9k029PFoFt4fCCMjVWgrq0aUAulzu4KmfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xg+W+uT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg+W+uT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE08F1F01560;
	Tue, 16 Jun 2026 02:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781577020;
	bh=Tx1jT5q8vjoRuPyIvyyS2At/icRuzLd5CHWlh+4o6hI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Xg+W+uT9lN8RBSYzAZr3nWRRdzi1wfokiXoymWj+/VDGfLtddkXKaoyHNk+6T3d9H
	 nJqCg9yBhBMTDHy4wX+aoT1ArIUQWgPkDCCpqnXbbaV5sv2Cn04gP5pZ/2kYlRoJKj
	 XZBIpnKudyxAKhALR4kvdi/LtHnyFB7n9g9HTbL1jZifhWm1NbPwCuIhIMLnqbyIgO
	 dH90K6aKTzwrDqbqUURD8mRtXH6R2uIzgFc66NkxYu9tzCPoF3n0NGDO2ZWTvpF8oe
	 rA/MVkZi3UtGyRcJ975wvHvOhA90GE7d2nD2y/FPIo380oS1kk+Cb+DkcYUtKlrCNY
	 Gsj1UxwNljxUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A423839A26;
	Tue, 16 Jun 2026 02:30:16 +0000 (UTC)
Subject: Re: [GIT PULL] i2c for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ai_WLu9JC7GXTU_t@zenone.zhora.eu>
References: <ai_WLu9JC7GXTU_t@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ai_WLu9JC7GXTU_t@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.2-part1
X-PR-Tracked-Commit-Id: 90220ddfa8e2c93e26af2cd51d6158ca2243c622
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2779759c090ea0e78109a0cad0a81d869adfb459
Message-Id: <178157701561.396694.18297537022281127815.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 02:30:15 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 12:54:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.2-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2779759c090ea0e78109a0cad0a81d869adfb459

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
