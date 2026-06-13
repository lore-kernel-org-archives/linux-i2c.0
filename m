Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECED5368D7D;
	Sat, 13 Jun 2026 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364534; cv=none; b=owAGWfVHv9vqHBpNMNs1iyzBrMFTtO4ilYwOoRbIdVyO/I90HUAqGVHPjFH/rwiIdM8jVFJ+78Hy8pxJSmXeUKnQ0swPU4tw4SXp6/IyuLfIxdFRTLjzQ6fM6ww098JKL2Q+vfb41Na0kH+BrMq8y2uUlZhQDqcY1WUYmH3TeNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364534; c=relaxed/simple;
	bh=6rx8+uGEdwE4mluJ6notOvPQ/1VZ9JWK1eye4tifZtw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nQV9SZe6EnpQedo/y2meQNr07hyP1IGLQTBzNpp3QABuaJ9ZFLryMfkaRdQKuGvWuoWWWIVN2CV1+2Cw7K/UEFpdt/WkECxvpfIBoovZ2hHzk71mlWavJwnyZF5pAFrEvagoQWdQGxUL6NJklScG6KaNBj96jyqW7h/HAxoOa00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJDLhOoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJDLhOoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941351F000E9;
	Sat, 13 Jun 2026 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781364529;
	bh=lKk+4MwAL93GH95KTw71kf+b5X0oB5L6WoKIjRugvfo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=GJDLhOoj+VKoGjIEHd5zk+i8dQGRMQzQMs9y7D9kZQFA9rzxluBJvi4A9gdjSzTmy
	 wVmkaPtTosSjzeDLFGZmAPKXgPzSLhsXMvI48eU7IKN3N+cYvau/uRiodLUh0N7KJc
	 arPI2hIvEDWErymvIgBXzZftWauqGyLUlqIC0LWJSeNyvBO8tGf4g8Rp0CcGcHoR0G
	 6urNW0b2RNkKcNX0RZIS+3qk3AaZB3Qtv6t5wDNOWUAbR1BaPn9ycxQ33RyYi65lSo
	 IOCOUso49Pd+hrkEGZZ8y4zpwK6pOL0St7lI8DVT1WKVk5aqNVgfuztzkNDvc/uPwC
	 iO7xupAQIdQew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199C53811A65;
	Sat, 13 Jun 2026 15:28:47 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-7.1-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ai0phU8FZ9uDcm7M@shikoro>
References: <ai0phU8FZ9uDcm7M@shikoro>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <ai0phU8FZ9uDcm7M@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc8
X-PR-Tracked-Commit-Id: 35ebcfcc9ef29afcf258db854ccf25572c75baef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5e98d1679809cbad0f88f1b6b60e92134d8ee13
Message-Id: <178136452566.1514644.6520552165288282980.pr-tracker-bot@kernel.org>
Date: Sat, 13 Jun 2026 15:28:45 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 13 Jun 2026 11:57:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5e98d1679809cbad0f88f1b6b60e92134d8ee13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
