Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B11E7C2E;
	Sun,  8 Feb 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770571779; cv=none; b=lgdwflIw1S+rIboeqTBLakqn56sFhdxdHVnFjDaK5RNX3RRjZY9xDbfzm4S6JEW9SDl99Wvkn+8DeuyN/6TXS4s+dIAVrwaXzjeG/x/e7IkooUGzPzOBsJeA3spO01MhgRq3ce9TDPed7HfLLUZ+NKmvGMq0o2WlE+YOxgU5zEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770571779; c=relaxed/simple;
	bh=B26Gwyr840Vv1KfwA1HqlZ4qBySmAMbXwNpoOACe3XM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=go4n/ll0vXhdPuAzsApvWHtESqFdv5I1MmKHF/d7ZTlmAMDjOGM4O8Kueiqs/9xndEuomQxiAbRrVW21r6l/c4wwVSwtpIxVNf+IVT+BtADerkTGV+CTth5SOLVH53zUMZhMUDgRHFTOmObEgrcNS0VdinrW4cscrOCY8Tjsazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTTKHCKC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTTKHCKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D56C4CEF7;
	Sun,  8 Feb 2026 17:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770571779;
	bh=B26Gwyr840Vv1KfwA1HqlZ4qBySmAMbXwNpoOACe3XM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aTTKHCKCWOgkWMOuDG8350xzmTL1Ea1ihBIR28fSKj1N3ekA8QNEmdGWFrDSaM5/n
	 ZdwWxHucKBXqGBemMtvxUebX7y1AKrxDIHwMK6crDjRjg+xwFzLjCJ2manwN23DzjY
	 dqO7OCffvXV0orFVBa5X7XNrewl1loFOlUh54fg5sVJr0moyYURNM1H22dW/jyij0Y
	 +ROd90t8PvyVK0hBGhk6lC4kJ7ewxKq8k1yyZC8Ppf9elCbyJ4RLsUgmTbZVZpzf4i
	 r6bPAfSassCiGMZMJjaMDJAA2XBvfyMVQdvh/Q71kA/n208rJTStSsb3japq8OGggY
	 YA5u7NhK8ugRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8542E3809A80;
	Sun,  8 Feb 2026 17:29:36 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-6.19-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <aYjEEsu44xfIeoAz@ninjato>
References: <aYjEEsu44xfIeoAz@ninjato>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aYjEEsu44xfIeoAz@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.19-final
X-PR-Tracked-Commit-Id: b126097b0327437048bd045a0e4d273dea2910dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e98f34af61167aee238e666bfbc97d1620afd88a
Message-Id: <177057177525.1573884.872365030296859591.pr-tracker-bot@kernel.org>
Date: Sun, 08 Feb 2026 17:29:35 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 8 Feb 2026 18:13:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.19-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e98f34af61167aee238e666bfbc97d1620afd88a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
