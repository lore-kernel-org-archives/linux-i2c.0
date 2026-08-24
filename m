Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11954399E2;
	Mon, 24 Aug 2026 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589344; cv=none; b=Hq9D+0MrQzOIxZlSN8a6TWUSfhZ8kjlHepb88hb1YN3ieNi60XJ7kMLa8CX3y1itRpGSncnoYtdyVmDyXMBvPY+BB+tdYBi5ajmEdmgpR55NeAM/zxr1BTC0X5qJ5rfRT9DtwR9nJHqYQOI8lSbe8q6axTnuR3lf8c3D2FuLUFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589344; c=relaxed/simple;
	bh=3+EmtSO88AEPmJr9F5lWGCrFhbUFD0O3+pJpEBC6w08=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SCn/i97ZjpbpLHAPKEkVVJ/iljZ/uE3wl7KL4X92e3ypceHp/4H4UFuchs0qzE/W4XVh33ylavkzgyh2SfZCvQRdqf1N6eaovnvdD99CekiwncXOczX70A5F+UAxVj6qXlvNgjho0YsUmSeu2FhTgX0GZaC0E+5Xeap7MTtEHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut6QrVt9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut6QrVt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEAF1F000E9;
	Mon, 24 Aug 2026 16:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787589343;
	bh=r1trycTaXKiQTwCWTUu/e37wlfMfbj1q+J1JuuCjh2w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Ut6QrVt9jNQCKN6l+0d3L5kuQZUHzit3xB3oSZDOa72fQImhkEvSz9hAjjtEQJQOS
	 Zd5cckEJIp5QO9pT0ehn1KlzOGcX6yLo26ZI+eRbbVDF3wx2PQVDNoHUyNx3eOL1wd
	 eHBjvKa2Ql1GvPUUHz3/INA1mTOUlXkCSMNmXbCfYNb4Q5+HCl0m5RoOaAND3WKIHR
	 84paA+Oa/D5oncdg1Hh5WdTjTJTWQk5WykCy8C2WGNU1hAmbmUP5uttHCfZtZ3ZtAU
	 kwIxQrozrJzn/U3lzt6wIUJoSOBoGJEjvDaDmkoY8KsSK8q9/17Z5KzcUKBrbct9Kk
	 TeG6bNYIftOSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19977392446C;
	Mon, 24 Aug 2026 16:34:52 +0000 (UTC)
Subject: Re: [GIT PULL] i2c for v7.3, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aowtbUKLY8W2kln8@zenone.zhora.eu>
References: <aowtbUKLY8W2kln8@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <aowtbUKLY8W2kln8@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.3-part2
X-PR-Tracked-Commit-Id: d576a9561a1c80ae593539fb0ce0743d66825ac2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47096fc3d064a07c0842f748b99ebf01be120f2b
Message-Id: <178758929053.3007333.15854571884794335722.pr-tracker-bot@kernel.org>
Date: Mon, 24 Aug 2026 16:34:50 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Aug 2026 13:55:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.3-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47096fc3d064a07c0842f748b99ebf01be120f2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
