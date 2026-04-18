Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6F33A9FE;
	Sat, 18 Apr 2026 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776536988; cv=none; b=limqyvMfiNeA9sYLXOV0U3+7XQb85qivKxiB8HtRsyHnfaFrGeujAoK0jak0nAGisXIj243SZvYw4ov7od6DhXS8Uk9PK/fBSUwPCA2aZVy/xBxuL7ClNHmV9FcPvruEOX4m14UEkhYLhM5i+Efb2suZttGihUHAUc6XDa7Pp3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776536988; c=relaxed/simple;
	bh=EOdnTEBujJTzN1KnHIq1LPCYa6ArawoH2LKEgzGrON4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jt4vTExMwfA8IJJ5QVM0dSb8vHc7LEfciwPfoLpPHfFyE2wTPy7pgH/9GxULmbdzkw+HYO4gN4t8evC3kaWL6QgDgYqpFWTnW6AFxO//7tWLg6vvpRwkxeESVHhFdrWE0pRCEVNoXSNLA23bmY5k+sqjBgvnLn/EUepsZsigf4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eujNFrPv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eujNFrPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A77C19424;
	Sat, 18 Apr 2026 18:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776536988;
	bh=EOdnTEBujJTzN1KnHIq1LPCYa6ArawoH2LKEgzGrON4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eujNFrPv4fAX9S3p7VcoJ5O2P1r5EeMUro8azJYRqCDj4j6jzE2ZbD4kcugQ/GK2D
	 Vk7Jqmo1Rqrb3/HLWTNrw3I+nrS7Q72mVaSQkd6pJyYDgAArxkGatw5UBig5es9QLj
	 ABkJj/BVBd0PS1+hf84j/ksFBKiKl2S9Du0NhA/VdAF9GPV8c5Lv1DPu6De8gGJbh9
	 B1nl9+VxRVIX8VE7TNc9cQ/maVMifjZsnY8P47gTBkSZ7/WiIUQEBK+rgT8RI9N9lQ
	 lv4spxLQr16lTwgT7n7tzu7VUu8AkveRkG449W8HU0SN05q6HA9yMrRV3OV7yboLbO
	 MSBzKyTtwBRvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D03A380CEDD;
	Sat, 18 Apr 2026 18:29:16 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-7.1-rc1-part1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aeMfqTRgtRkxSBMd@shikoro>
References: <aeMfqTRgtRkxSBMd@shikoro>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <aeMfqTRgtRkxSBMd@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc1-part1
X-PR-Tracked-Commit-Id: e336aa3c396ba41fd5a3b818df917a70f39594a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fba676bd2919ceff5a678c0bd05ab3ac89affaeb
Message-Id: <177653695510.493726.6491917494474547585.pr-tracker-bot@kernel.org>
Date: Sat, 18 Apr 2026 18:29:15 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Apr 2026 08:07:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc1-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fba676bd2919ceff5a678c0bd05ab3ac89affaeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
