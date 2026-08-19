Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5711F494809;
	Wed, 19 Aug 2026 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160113; cv=none; b=FWOpBAnKSRkhdayldPaXFtmVLyx0lNNrjsEkO+hjhdfoL0IwVYssrMRQhLI0prcFRMT/NuQOYnye5Er4PY/r+w4YC1k/W/Z/Vke7RPeQb3pJJySr3IUvyBK0o2sJKG6XCD6YTYpOpHVwGa4qATtZKEe8drqjA4jiVK727HucbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160113; c=relaxed/simple;
	bh=fsO4pFTMQ4Bn8FyeUtzJFR2WK7YHOWudL5ThHxeglYI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aNTkNYL6aty6afRTUiNKGuM04RDb0HW7gWyQ8qk32V+i1mxwmVmMAm2Q4d/SBfNvbB2d01UKz/J4G/eLEo4G1BsD0uAbeDeFsZKKkgLhethFya95WdhmocHiFR/5/K2qvEz5R0fsGYXWpAHBE+StJLz7JgvMAMT8aWSa2xIq9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvZR4GUz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvZR4GUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD551F33544;
	Wed, 19 Aug 2026 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787160096;
	bh=itjo3IQO13VzLbF4XHMsdzFv32ARYRgamIz253CIyN0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=FvZR4GUzt9eZ/v9LGOOm75ENYm+KKuEm3+O2J8EUMAnN4zQpesv3B13z8MkYWUT49
	 lpQRb9e7prKdfAs+bqg7Z7JQ2z3fqXMkwbdst9irFt9k+CKPgi4r6eHGawsR/Na8DZ
	 ZTI7N2VzmPdxVSnKziC/PrwkvRgio1yoQE6CFxGcIY59epSOvRyIHKKzXkSVcLUiIr
	 UFHA+t5su3b1mz7Jf5l5ciidwBl53P5LsOzCwPrI+/L4l54C/uDbrc/V2ar+gezSe6
	 d9MsvAoKnrF5f5sPK7hcAcNfxDqv1dDy5ayQXh/iEEFf3XHlp8CYZYBjtrjPO7YT5W
	 clJ3lj+DL/Z+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D26C638119E7;
	Wed, 19 Aug 2026 17:20:48 +0000 (UTC)
Subject: Re: [GIT PULL] i2c for v7.3, part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aoBAaw7d1A6-a5PJ@zenone.zhora.eu>
References: <aoBAaw7d1A6-a5PJ@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aoBAaw7d1A6-a5PJ@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.3-part1
X-PR-Tracked-Commit-Id: 18ca2ce160ffff977f28456039f2475a3b500bc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abea5c349368a683e40fdc2e745099aaaacc89d7
Message-Id: <178716004774.3599392.6661320352306683546.pr-tracker-bot@kernel.org>
Date: Wed, 19 Aug 2026 17:20:47 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Aug 2026 12:38:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.3-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abea5c349368a683e40fdc2e745099aaaacc89d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
