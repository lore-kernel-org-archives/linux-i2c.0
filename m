Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BBF1F1537;
	Sun, 30 Aug 2026 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788116739; cv=none; b=GE0ZiMQu54meGvSRz8t+eQ327lUmkyffo4/IFKNOy+V8nH1L++z9uLvnZulYonx994n5BWRNGqyPUKMw/LLwSzcRvLo5XK1zwxXcfFPu34185l9Y4nG/le5WdOGRlQCTzlD/2mQjASgbfMJdddjgkkKiqyUUUmHnM2ejJKtYoc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788116739; c=relaxed/simple;
	bh=GB19Aqd9E49IyPgJ5lHN0a8hjt9Y2nPnN5OEAgTSM9s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E9mVFvlZqaoJ5YDz2TGlz9yxt5ICcet2G7OSkzu2Lt+4LFuzIFsT4UIv1xtdTqytrHTFTUACWGpVppVvFR3HppW0Fd4QHWNvGToUkssX+UTigXbKEegDNkwYxkZzV1swH6Rpyt0sAy5s4mtL2v07pgCTUW0W41KMwSt6u30j2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa4uZih1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa4uZih1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10621F000E9;
	Sun, 30 Aug 2026 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788116738;
	bh=/j0czuJfUJfKKcc7WUKPYUNDuaDxN3y/FjWRHQ4SBaY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Aa4uZih1VF2HXK5fBwpPytYQ6bLygW2QrAodMESK4MsmpBp2DZmFQBZuCW1Gktthj
	 rswSTCfNPum0P9aPJyzwm5RyZu47+u16/xOSneLKguI3ZAzdPRym4aUHbmZkCA2Ub6
	 FPfFDPWcCTZ86BTgTBTXbmYFwcgjtMf3LkNrKSiTJuAyxMEBnfCEkl0V8UxCZEzfxl
	 X6RWxRqwGEiEujrx1exjEBdYSgkYIzfvIeQd5YQmeaHYcnP1dIlOv9gGpdSTQA/uKU
	 X9jkApR0CikBtOf1QSiT4PeYmIDMCXFoPICHaaz8t9pXQY6VEtKRl3pnaujNSDEN/g
	 YHhfZM2zhwaEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B9B380CEE4;
	Sun, 30 Aug 2026 19:04:42 +0000 (UTC)
Subject: Re: [GIT PULL] i2c fixes for v7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <apRF7F65GhuKEF1j@zenone.zhora.eu>
References: <apRF7F65GhuKEF1j@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <apRF7F65GhuKEF1j@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc1
X-PR-Tracked-Commit-Id: b15b548d52b43ba8ac4652bc2c7244a8dd1e9622
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78bb208b99e7d3314f670710fa9ee0a793682bca
Message-Id: <178811668137.3429557.6420813472078174940.pr-tracker-bot@kernel.org>
Date: Sun, 30 Aug 2026 19:04:41 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 30 Aug 2026 17:07:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78bb208b99e7d3314f670710fa9ee0a793682bca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
