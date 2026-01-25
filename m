Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114A123958A;
	Sun, 25 Jan 2026 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769363643; cv=none; b=akgwGNEf5V8VTg7ORp17G/PZQCfLpI+b9eg65hzlEuGuscFdI/1ubm5Bv5weX+9EeK2vnYdDqYAewp1Z5qa5jdhm6eFG/lg2Adg7zKiBU2+u9HEfb1gvTfk7SjRCSinx5KUJZRhwYMEa4km7vbjaPU0p4mddQ7Ty7rwF8Pr1BjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769363643; c=relaxed/simple;
	bh=jfpJpXcrHzzRa/+VMMNPfKqEUrfbCtqpnPD3qco8q84=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fap2xEpgi2fzml8rzinLo0JrlSdKhNpmjRfMxLJwb0tLqKnthk+hu8K/AIE93/NhK6YF8/qY2U6lNcCQnyUKI+tIOW7PNu6y5W1fMb8shHx2z/B8Hukfm62UOiQErDCDOnUH5PpaPQd3+rznAo5KlocqJH36wMcE/RhVenfhx68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cH+Abdvn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cH+Abdvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50A1C4CEF1;
	Sun, 25 Jan 2026 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769363642;
	bh=jfpJpXcrHzzRa/+VMMNPfKqEUrfbCtqpnPD3qco8q84=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cH+AbdvnEPXC22vpTPCgCJZXw51A4ShxLLVXRsJDMQzmGXnFE3aFp+vNCXiqo0D+s
	 vF8RJCN6drXwCPlEmlB0qdAZeKgVA5canXZ54r8mJpgpC9QO6a+OxwhnQL5vFEILIr
	 iQILiCjheE0BzmObO9i6G0Vu05o071en5kQ2nPyJUGv0qRBOgVfrBLPNdRQoiy7Wdg
	 o1kae3cmqtH6ivbp+KVrLT1wYFHsMNqglWrPK3osQx1rj+NlTK+pWfZYpLghqr00sN
	 m6pZNjDMM+TgYutWHl8cMWmRSY13wIdbJ+n90nd3fKrhnTmZBNTyjC0xrzHnYJkIaz
	 SOuBjK5yMg/Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C901E3809A0D;
	Sun, 25 Jan 2026 17:53:58 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <aXYEKRm-w1AkwaAC@ninjato>
References: <aXYEKRm-w1AkwaAC@ninjato>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <aXYEKRm-w1AkwaAC@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.19-rc7
X-PR-Tracked-Commit-Id: e6e09d34118477fa3cb4dcea330ba2f6c5bdaf4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 913fb068e259079bf9564c9e84ff9e65c37dcac7
Message-Id: <176936363749.3551274.17935483162802120559.pr-tracker-bot@kernel.org>
Date: Sun, 25 Jan 2026 17:53:57 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 Jan 2026 12:53:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/913fb068e259079bf9564c9e84ff9e65c37dcac7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
