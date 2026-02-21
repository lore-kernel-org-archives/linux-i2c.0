Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013ED215F7D;
	Sat, 21 Feb 2026 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771636807; cv=none; b=qQM2q6rxZ/9+D7oar+0vKx1oq469gDEm+e08gOpSNnBIsxMwBrlb7LdhyH8W7f6tMFbYb1iz9w9s50cH/yygHQOgkomI9bb3SbyIMDUM7+x1yNhP55DNLsvh0FMTkhOmUHVaEjNr0Wu/mVx5LmSkwbn2AtbQxKy+l8PZd0AtqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771636807; c=relaxed/simple;
	bh=KcXOP4oX7Os6lqK6yNh7wAtdTFbznd1R4xDBn31XavY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G6Mfj2ShJGX3VEZ0CmqtRjklJSck5J1zQ2IZRyXpjyJZgrXY2JL5UMTmlFWN3v0lmEKKYC8aQ0wx9cS2VsP8M4r1UKQrUfDJGrGKHa4ZpI1PgkONHk0TBLs8rMZMCoX6YTNT3B2AE6eiGruj7hULvkEhqsBe0Hi4TsAB+vknTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0L7maWA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0L7maWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57CFC19423;
	Sat, 21 Feb 2026 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771636806;
	bh=KcXOP4oX7Os6lqK6yNh7wAtdTFbznd1R4xDBn31XavY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V0L7maWATbI7zOiiP7XCj98bZloV+fKUZKH3UmMOW08zzkLCH884FmYr0239cunMR
	 6r6l0ry3gsIVRPmhnTJreYglzxyV4br6xJoXeIsq86tHbVuGrZAC3yAoVlaKe11Yg1
	 bUlKt9NVLzSuteYENu7wV7kY/lu1ocsMvNLSNHPCB0lxcnfw3RN5pRbPxA6jNaoID3
	 VZlU9r3dBnm9HCOqlJRifrTAITmYcfuL22nF7E8kWTVM/43RjtcCi89jdDeYq86+iR
	 F0YV9PMFqBF8xDcBLbouemkWtetFE3CAxkfeR3d4QTh+L5qhcjCIfyi3GlU2mJZ7ya
	 d2s1+I5tSaEyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EED3808200;
	Sat, 21 Feb 2026 01:20:16 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-7.0-part2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aZgkWTsMn1zWAlJa@ninjato>
References: <aZgkWTsMn1zWAlJa@ninjato>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <aZgkWTsMn1zWAlJa@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-part2
X-PR-Tracked-Commit-Id: 709cc48d3d01facaeb1eec3d93e1e1fb2fb21717
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99e447220b938dfed6488db95a2930b57ea849ba
Message-Id: <177163681481.969912.3439197785487481456.pr-tracker-bot@kernel.org>
Date: Sat, 21 Feb 2026 01:20:14 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Feb 2026 10:07:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99e447220b938dfed6488db95a2930b57ea849ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
