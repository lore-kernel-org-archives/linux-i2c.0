Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187F43630A2;
	Sun, 22 Mar 2026 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774205167; cv=none; b=RnbIF6UF/0l1RYsiABOO0hDucKnchkhO+vDjb8IM5pu23TQfX7Haa9xWkCBfyipoCnbIBvEE/J3zxjF11a4FP+btwAq02kjRbDOdJGIWJ9u/0tTQ3eADg9d0Jo4tk6LrzXDNz0YSv/WxwTEU6gCZBT1HZahvg2efw4RpXTk4uJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774205167; c=relaxed/simple;
	bh=R4xxjE6uuJIUJRaqn4M/BFpjmRqCzKh+MFBdVo5MqeE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ejRqUxGwYicaTvi6hg3Td1mbnmwbfUXbn9PV/8iBhgCXx1CnLLh/fg+pGBKjEY0T96QmTTg+RPbUXm89QFWpWLPW/fdPbe5eZOXZh7BKUsf5/Zm9/QeUF7/ZGyW6CiCXCxd3VyJUYBYjG/dud6IEAndnMQeDLNbaIJyVWsMDx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCqWJRXa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCqWJRXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49F1C19424;
	Sun, 22 Mar 2026 18:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774205166;
	bh=R4xxjE6uuJIUJRaqn4M/BFpjmRqCzKh+MFBdVo5MqeE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eCqWJRXatBFV/j3qoqUXs1iRsINFRSLWBEMqLb4ylSvjlxWu+2ovGqHH6QfZCgUR1
	 ctDFvCjqpdTrjd9sOtNgruxZlxHDQN/J4wXXV+kuqgCbwMDqgpZpICkgLqUhArgX/b
	 u7Nu2JC79EtH9ddhb8nmrPT5KZFXpyTltY3ROzMqmRbRJ1hqQBHngAFSVhSGLicsYW
	 uMJWEHEIi2tB6PiPgG5APXX5+EIR87ivmBjoiDmd/2B4++RSOX72h0cEMoZNH0hxeM
	 wMm17sZ5jX2I5ymODwE4ZWPRQZU0XqLw0iPONMrgsCMl7mA/sJvopCZJ15FiLAORrk
	 h8LUth/U1BQkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E8C3808200;
	Sun, 22 Mar 2026 18:45:57 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-7.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ab-28wml-Lh06k9r@ninjato>
References: <ab-28wml-Lh06k9r@ninjato>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <ab-28wml-Lh06k9r@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-rc5
X-PR-Tracked-Commit-Id: 2f42e85622567a19459679f71e55d41904866aa7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11ac4ce3f708a073eb9e35fa11f741bb51f45302
Message-Id: <177420515570.3169233.13264758049336524683.pr-tracker-bot@kernel.org>
Date: Sun, 22 Mar 2026 18:45:55 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 22 Mar 2026 10:31:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11ac4ce3f708a073eb9e35fa11f741bb51f45302

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
