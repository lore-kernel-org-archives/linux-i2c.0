Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF701E8332;
	Sun, 12 Apr 2026 00:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775953455; cv=none; b=TjlNDOTDZkkl5u+QqajepK4m5Dl8Epvo65YVCGa5NOFNsIAqxpq8cU595iU3ib5XNpOgVNsEIxnmw1j1hJtcQ7++3DamMwYxkTFBT4Wjtl4U9raELDM9oUbEtLE7X6NyGjjrU4WeytcXAFqe2AHuOPC4tT3LGoq405L09UdFjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775953455; c=relaxed/simple;
	bh=0abYpplRh3fZB7u5KOhFZovEmzEJx45VJR/88nTxh6Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fpCF0OLmVau+xwrLyyT5cwEIF139W2rp+D+2uzKNuYUHrTTMJYFuu9UU2yQ69Ntt2TMVJQXKwqt1ISXBRmZ50bDIcUDolxKcPl0nR4YE6dbOLm22bXIR2zfbJDDDZsa5h9OfwYYXNOdh+lNSX+KbvNB02vfk+AgQjD17dMN3dBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7LIYkFT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7LIYkFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE782C116C6;
	Sun, 12 Apr 2026 00:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775953454;
	bh=0abYpplRh3fZB7u5KOhFZovEmzEJx45VJR/88nTxh6Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V7LIYkFTY0T9jBmV89RS/AWuhMhSxNUj+BPpP5A2dXWQZbhhr9wf19507VYd78FGg
	 cEXAICRwX/b4mYE4OKvT1Fl4FILnKZpHS13hv4+TmtNm8SryR9vkLR5ajH7mAc5fX+
	 di/i0Nz+lB3wZGZreo5oM+tpjdD8qplmzDyHD1sSqURkmnFR8z4avm7E+aSCaoXkBj
	 fOxeG2jCujYJI41ZqfIPwNDxRwu3gjvQc1OEJ6EULx2o5Uhzx2FWyCZ/jf+cXWTYna
	 zjvqy3qAjLPGEgPSEztwDcJWjGN+Zvhl0UUJIvZIuwmhPSS9EcV3U4/O13fFDVtWRc
	 aTOALGoWxzvNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4005F3809A8B;
	Sun, 12 Apr 2026 00:23:49 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-7.0-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <adq7BYaP1_uGqYBp@shikoro>
References: <adq7BYaP1_uGqYBp@shikoro>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <adq7BYaP1_uGqYBp@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-final
X-PR-Tracked-Commit-Id: 0637a3086b4fc4165460b21c12b845be6be71be7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5459048c38a00fc583658d6dcd0f894aff6df8f
Message-Id: <177595342784.3120865.13440020499690052336.pr-tracker-bot@kernel.org>
Date: Sun, 12 Apr 2026 00:23:47 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 Apr 2026 23:20:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5459048c38a00fc583658d6dcd0f894aff6df8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
