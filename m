Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F42D1907;
	Sun, 29 Mar 2026 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774816029; cv=none; b=sjJNaFOedqj2SxvjhUUeo1F/cj36NzEITR2+02Bdv8IdYNsANI0w9TmswLvd88DeLQe3q1Oa3EaeS6mJHCEPMQiBlYWcmJKM0+zU1KY6p8YmvxEzHBO3KZRSYHrrW8wzfkpHDi1oFI14B9ic83ayZ8msvQnk/pA+c1HNPunP1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774816029; c=relaxed/simple;
	bh=yv+TW/LLvs884A/kClTYzr11+E3NbbFblc1QuMp8xe0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M2SKMgRV658AbZiXmkRY/mIwsEeHQY3lDWYTvIVhYzvsxFAPM8yowPXPNRAM8s8EoNCgN5bEuwqVq+B60d+wmnfyHpRE87PhqJjZJ4hiJCygGszWgBrosh1MmwdnTbFolZ5xn5Q5PV/XcYtyKPRRmObVguSQn5oVzrI/iGmnoOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np/S9OUk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np/S9OUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277F9C116C6;
	Sun, 29 Mar 2026 20:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774816029;
	bh=yv+TW/LLvs884A/kClTYzr11+E3NbbFblc1QuMp8xe0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Np/S9OUkq1TKXLyFRInSODapLbMgDaCZMYVkKH6AylZp/sCMn4mx/3cmwkeVKHK1v
	 1emhxgrYjZnNgCvd6iyM2QNSKI0JaMtso5ItORErH5+hgWUx6z/OfVb1yelktjlOdk
	 9eaqXoI4Se/fbOXDpobo08UIxluYhJ+kl1Y+b4o7g3SGgXA6OcZBi470PG45ZZ5VSU
	 KZI6i60nHaA3TN0owSttiMFZCGKWocVB0HoaMkA1S88s0BDTaGpea+ioHq6UfGg4Ut
	 fN4TCA9zFfeAKmUwsB/HXUVnUrk37fHbfct6OAGMRbDDzXkfA1KmrT0LKRXjDDLFj1
	 fAkwuis+6Jc8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 031BA3930012;
	Sun, 29 Mar 2026 20:26:55 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <acjB9v4DteoQcNRs@shikoro>
References: <acjB9v4DteoQcNRs@shikoro>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <acjB9v4DteoQcNRs@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-rc6
X-PR-Tracked-Commit-Id: b0faf733fc1cf7f198c299dcc1638571d7cfd0f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32ee88daf78b69a95d21ba9ead55da8469ede1c9
Message-Id: <177481601363.456574.17846062621063291902.pr-tracker-bot@kernel.org>
Date: Sun, 29 Mar 2026 20:26:53 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 29 Mar 2026 08:08:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32ee88daf78b69a95d21ba9ead55da8469ede1c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
