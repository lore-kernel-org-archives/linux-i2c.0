Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971FA2D1913;
	Mon, 22 Jun 2026 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146183; cv=none; b=ptx5t86fmQ95lCNr48+ZNAyydY9tqdB6CSrpy5cUexmmpu+acK091jVsTLXLLJWVwKlU+5o/9ScHvjS6+XLLc74Uxl2+xMFPHMFJtWw7+S0PCxziA4ZzNMeCUUt61Mhj111XFruEBluCMLRycA7fLmANAIzUZMiukX2MmY0S0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146183; c=relaxed/simple;
	bh=wURubbLDscgfLvqv0aXWbgOHmN/g0iKSGi7NRCw+Fw8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IDbuDZCHRZrqp52z7zEyiZXjGmDyF70wqWDqP5Qe87iUeMUSm5Vyd5W8qJOb884iITVHi2yNfNtngcJWm7O4Uqky+ZXwfnuoWdZSr2pK1XhdnrUKL7IxmKcuBI3zxJLnG1+MnW55IjA0rHZr6ell9DzvALV/4nzlWsZFkamWYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbnUDVmY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbnUDVmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467831F000E9;
	Mon, 22 Jun 2026 16:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146182;
	bh=D+TEUdTnWMB0k5VkxH76r5k/MNGWU6AeMckHJnUCgNU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=gbnUDVmYSeAomEx4fLFBDfdJdGCG78wKR2h096NfVc2aj8Dap40+ZgTDRORbavwfb
	 NS6NTNTSDm960275G/j2zY4H/EddHVTlDm2JRfjy28N0eNIIX5l1ofR2FtikSnCCH/
	 wJkLvBKOFJvsFzuMxZ1QLLQ2qvdVLZaiBj6B0MJCf0dJuePCfojPMbJof4dd1kU4Gc
	 pOqggKAs2Lb1raouru0KYA1MmsE1piqVmwJCLhELS5ew3TcFZC8w3TtF1YWCeXbPy0
	 WtZ0hLMyrD5MHYEf/IyXfnuErXU9V1lAEBMoN5jXuC+dDyT7N3GYYb3q2sMs2wVNPQ
	 fAt5x2H6B4RsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19D0E3930907;
	Mon, 22 Jun 2026 16:36:14 +0000 (UTC)
Subject: Re: [GIT PULL] i2c for v7.2, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajjUPH75tmYjbUvo@zenone.zhora.eu>
References: <ajjUPH75tmYjbUvo@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <ajjUPH75tmYjbUvo@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.2-part2
X-PR-Tracked-Commit-Id: ac930b80c1e0eba283d7843180964e6d2a87369d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dc18801be29bc54709aa355b8acd80e183b03cd
Message-Id: <178214617266.1310507.13817169471426680281.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jun 2026 16:36:12 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jun 2026 11:00:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.2-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dc18801be29bc54709aa355b8acd80e183b03cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
