Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D14636A375;
	Sun, 31 May 2026 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780262039; cv=none; b=RNI+AR3mmElj3a/EWWE7Vgrj1S1p/yYK6W70G7KQL71Gpi5UwQKJfB5LvGi9KCpwi8ZHkLPrGO/A3aWbwbg0035kgeFAIHCgru9l+vrQZBPIIzuz6nHb0RVP0yUtb00atnLFrz11nevBTrnPEnpGj2+scj6NouE3aJys7JBiMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780262039; c=relaxed/simple;
	bh=oYUVw1w6BvECd4yaNXKoTPi5FDEO45LbLMKKMvmpH8c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NOt6qGhLmYUC905PQ9DQctR7N04G0zvWLwLIrwvrq/1JZ5Rsm1eZGBmqyXVuCM/A2kRsqEYMuMVtY51GV10yerF6fxk2UA4ByL/xy6W4UhCCy6eP+ECVLifnUMAfnCrpRa0WIegDhAU8spTw82l+I4qQviLcM3AhcgmymsxmCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFu2LDlG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFu2LDlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0711F00893;
	Sun, 31 May 2026 21:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780262038;
	bh=qo0F4vfAjEAs+E4AtR5gva3wvcORv1keL8M/gakEiGo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=LFu2LDlGn1N4PsxqUDNNKjVOZCRXiCMvAyOIBA4LBplG0zj8tKprKAELCw9nE+eYr
	 zywh6Mt2ekZ4mq9w19Q6S46QmHKeV1UfaK+oa/7zeohppRWh1KtIC+8VqFEY9Y7hFx
	 NwRJHGEacoRIUWv/qV2XhhkiiV3OboRBZ9SZ2yGYmf/532rT2FLG5W5IlPCVEtcvJF
	 oFN5zZXfyQzY3CQ2YMyKkhlhPXSsf+gwRTR70ZZu1GsGUUsGJv05a7DOCaAyXsfeCv
	 ocOaNW8vcAwl5nby2klvNNn1UKZkg7kQj42MTmiXYkqPmOb296WaRngowyBsy7An39
	 VEgNJssCMweoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5696239302F7;
	Sun, 31 May 2026 21:14:02 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-7.1-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ahwJodqpwBrKuwP-@shikoro>
References: <ahwJodqpwBrKuwP-@shikoro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ahwJodqpwBrKuwP-@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc6
X-PR-Tracked-Commit-Id: 1d774589f924056b8403e271fdecaf9a803a50fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cf1afe6de1dc9dfced6070328626830794bac9d
Message-Id: <178026204092.2979054.16007759390321233652.pr-tracker-bot@kernel.org>
Date: Sun, 31 May 2026 21:14:00 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 31 May 2026 12:12:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cf1afe6de1dc9dfced6070328626830794bac9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
