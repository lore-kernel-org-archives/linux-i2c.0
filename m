Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41D242D88;
	Sun, 15 Mar 2026 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773600439; cv=none; b=IHGdaAIFNZcf6Isbf2tlgP6c1DGeMk5iya/1KL1h+nKizfdDxdePBevvntcT+HGsSl9HMQ2YK9Oai+M7Yn4qy6tWCURuU0YeHaGIqIre7MbXvY1krlNFZXM2JeQjprgSSgPBkMaqJijtGPta9B2GagWPKiXE7NL1sfyYyX12epM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773600439; c=relaxed/simple;
	bh=Fei6oH/9FVEzrywOVJwqHWzZXc51spaJF8Thsv9BWwI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fw9YozwPjuVF+gyjsJbGGkHVHU2Ysjuz/OygQsda/aGWvESsVMdnbJiG9lsY/vyBNAPIqGWjvoE2livO5MV9+1NHpbK3KyKcbxMQltsl4lRoKdG9VuJbPG34se6Mnae/4SlRcACo2fV2iAyRTa5KiwtZos7qzX1NUCi31IYJFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDRic9GL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDRic9GL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0164FC4CEF7;
	Sun, 15 Mar 2026 18:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773600439;
	bh=Fei6oH/9FVEzrywOVJwqHWzZXc51spaJF8Thsv9BWwI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oDRic9GLkbuUIk00MOj1jMncZ08Nk+CHZt8LnssNXGuu3pfODKc978c5UQCnyDa/u
	 0W9O1mN/GURfr3PHJc1oYTBQFoFBwWYJVXAjiWkMLqHBpa1JdXtWVZT0W979lF6cIV
	 hT0coAUvP0XK8jU3x1bVPRLKRGxTpuKBzzF+1WsiS+/vxdC7QnZ+utFfzEhZ7fzX0F
	 Wirn14vMaxoAaKNV515QzUx9VFsbMnynp5w9Om/Sm0PgXUcPM8CD/m4T/pa0sX/pKD
	 V1Cblq/fC6y44gccVRFFede0DQF3etkDVDUS6gx/Nu5fw4gEDfHBZBqq02B86PXjKe
	 91e/VbcTyUqXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3033808200;
	Sun, 15 Mar 2026 18:47:13 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-7.0-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <abXPD2v0M7BoSaXT@shikoro>
References: <abXPD2v0M7BoSaXT@shikoro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <abXPD2v0M7BoSaXT@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-rc4
X-PR-Tracked-Commit-Id: d800d0bb2009a73630a096d7c7a80a2e64c1e41e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f26de90c68a66ec95accc50555692d545e04a135
Message-Id: <177360043233.1970460.3524235426549517892.pr-tracker-bot@kernel.org>
Date: Sun, 15 Mar 2026 18:47:12 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Mar 2026 22:11:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f26de90c68a66ec95accc50555692d545e04a135

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
