Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C4F3C81AD;
	Sun, 20 Sep 2026 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789917093; cv=none; b=noFhe1qRsTk8XxOr5LGqblCbGwsv8TxdkHGN9cz/aAPvlpMCRt3t7nK2OX3rulH5/wg6Wc8nUVW/1fGaV0TP2oWLmhq/lMfKE8uY1UeF2DPB0gNcFm4VIkcc8CZ2+SNi83N14dhNcLN3oyeFkmkDG04kcR32pQObpGEhHaXzQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789917093; c=relaxed/simple;
	bh=Jn/A/TWmCZdInBnsZMv/BEJVam5Hv8J3D17Gc2+HTl8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=odcoyNfKHKMeE0B4unsxgMFanmgpTivKmnOY4uHAezOUC4Pt3GLtenGNi3PVrG9wS0BHQlU+J4pL18MKVVrHn1l6TIMzwZZ5k6c9YmTcudb0m9MC/Chs5QGq2zrjXecwUua+FM1BmWkq8lClvU3PmBPHgFczdHm/oIZpj5Wx2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC9LC/6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC9LC/6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DB51F000FF;
	Sun, 20 Sep 2026 15:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789917092;
	bh=GFJfUXYy8SEqytex1T1Dxb7ed+5gdD6XK1a7TiVb6M0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=EC9LC/6r0GSkl7m+/jm3iV2Bd0ZM5B1flT/FTELgrDkO3hf/r83xf/SoisFCWpmwl
	 AOUy5OH84asLkixkPUIhiHKSw1XquC0tbbv8K965M2yrgGgvJSmGc7nnnx3HUcfk1c
	 jpAJZn36EjIUrb/X763onIuKo9O+GRm9iFGBWBF+eIyIwsNXVCC3RtzwCunW8HKrJf
	 UxEjUe6ALDgB58v5XqJH2gravJJpeB5bjrghxzYseXrfK2fzxw+Yis51XdKuLc3Es2
	 MHY5pMWfGI7EUjhh+i3kn2OABUMDe5OxGH/E7QeaymBUTZw9P7EFUEhr/38r86n/gE
	 hxJY5RNgyttgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B7D39253CF;
	Sun, 20 Sep 2026 15:10:26 +0000 (UTC)
Subject: Re: [GIT PULL] i2c fixes for v7.3-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <aq-Vj-gxzyeNGRzN@zenone.zhora.eu>
References: <aq-Vj-gxzyeNGRzN@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <aq-Vj-gxzyeNGRzN@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc4
X-PR-Tracked-Commit-Id: 7362a1553eb09a8cdf8be7e509bd5309a8342486
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa211c7a5837f20f0995691c036a4b22d0360737
Message-Id: <178991702464.1703482.18260818622967814915.pr-tracker-bot@kernel.org>
Date: Sun, 20 Sep 2026 15:10:24 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Sep 2026 10:19:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa211c7a5837f20f0995691c036a4b22d0360737

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
