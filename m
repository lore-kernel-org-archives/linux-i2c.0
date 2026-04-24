Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984E4CB5B;
	Fri, 24 Apr 2026 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776989652; cv=none; b=SjoElmHBsRdr9x1CEhg8ThdxcSfvNY+hDheoUTlvGyNRuBTl/DH+wWGAszWCF6BvAlXVo4opD/qvctXhXYU8zAT+L7RrYZxaiIQIv0kkJl5szFcJHQWDPoH2UnHQu/hetliu9ZpwqyffzZ5PeW9fDo9FCUdwvxdCVw21r3OuvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776989652; c=relaxed/simple;
	bh=CUSSHTe2PoZ42dkabUbk00o0Dfz21qpYxE/8IYUkyg8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NKVb/1XzC5tdvq1p/YdIh4hcUBsfQtVMNB5JfnoUnbGykbT9BADBVKSQDqm3qXteTdZNULRuJdesYzfUelIlnGjOSpbCagA7Vyf9iiHt4HH4rECfPTCIWd/p1762LCWSurRq9hayGXoJkVQ0AbFubOWmHjRGJSfeM5WH64vGd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHl6wxXX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHl6wxXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9741BC2BCAF;
	Fri, 24 Apr 2026 00:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776989652;
	bh=CUSSHTe2PoZ42dkabUbk00o0Dfz21qpYxE/8IYUkyg8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vHl6wxXXklpBFntk46yZuvNrvx9jzT0we2E4O0AweMxllwbh4O8ump5vafW3Mm/Yw
	 oNXXbVwNhR+FLq/3ZN8lMuZC6XrZM4Op9V3WnZjiDZwmg/nGp83Oj/V1VYIXLdZaUf
	 rU5jNmw1em5HQFYch1GoWXdhOLbiVIxA7Eeia+1XfEWwO1bl6rUOvZ3YbB1Gtm5G/r
	 U1oKr1naoVgAFCd4OAn2+CNs52QxVNvDFa6bGSDdpOJsHvzLE6EJHMEiK69WDO00gX
	 +a1ED2+m9yfPT7TnxA7R/kf6r+s9GnFt2wtKJ9diGRO/NYeC5Yh9K4QCC59PTZmnAp
	 /oSg7dJ9RWUxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D62380A951;
	Fri, 24 Apr 2026 00:13:35 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-7.1-rc1-part2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aeqGEIItM7yUkTgQ@shikoro>
References: <aeqGEIItM7yUkTgQ@shikoro>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <aeqGEIItM7yUkTgQ@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc1-part2
X-PR-Tracked-Commit-Id: 79fc229e8a471356ddfea225f42e02f4fb73c469
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8df5a0c0d041588e7f02781822d637d226cdbe8
Message-Id: <177698961364.818077.6498621281200361950.pr-tracker-bot@kernel.org>
Date: Fri, 24 Apr 2026 00:13:33 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, Igor Korotin <igor.korotin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Apr 2026 22:50:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc1-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8df5a0c0d041588e7f02781822d637d226cdbe8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
