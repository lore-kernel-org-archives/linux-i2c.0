Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112E2DC791;
	Sat,  9 May 2026 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778341269; cv=none; b=G2NpoVp8NU3dvmuAnWuHrhbPjuzbz+NzTUjFzE4Mm83hhFwGNkyX14O+F/zzMCLcjCtFYeNaQLQBXOnwPwsn4cJ7SzmKTjALyiEmbQ0xYChRA93ZkrRXjCi4mVOsR2m+X9w+MMpwbFNVACFG2i+kfDLy5az3kgApFZOz+taw4QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778341269; c=relaxed/simple;
	bh=Eg+Z5TCAT/uQTgnTwKq22IYXwI13dcxmdQgmLsVUfMQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RDqi89/2QfKKvbEC5onCMgHDxGHl5rvlGN+lrnrVtL9O7Vg0JXzKcbO39x3EeZgNCq/9JhxFHIX3mPXT30w/AwK/3WTxuDDWfZHaTT0Dx5VuTiikpC3EXeQa8OPsWLCHNkGd+gBy5niQj0ip5fDBhnyRf7gOLAG8QJk7iLHedEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXgr3J+o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXgr3J+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14267C2BCC9;
	Sat,  9 May 2026 15:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778341269;
	bh=Eg+Z5TCAT/uQTgnTwKq22IYXwI13dcxmdQgmLsVUfMQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nXgr3J+oFMbeWMfqcyY1U7/eDxhJ/YBZf/ObjyQA6FAO5Hx/YGvhhiZQ48yoOPleD
	 R+gT1Lx14tuUsDWN2vXv+HAvitD6YS1e/EKvh9/VYxDcg5FyKrhFy6Q9WZenBw3zEo
	 nxyMSjugpbehFwepqWpSuMLu+6ojWYUnoJ61jyjHw+7Aol1exkGvSVKoQGB3QR/ffd
	 3iz6UaonrSnoc9G9lR8frT5PKniFnFOh01Y6f0kWA/ts1QUhUPm6GoLJYzzfx7nwqw
	 pyf6A+PE/TewTgsOiPPZ07y3uGmWFY7OnxJQkdSWBQDYHyVNbjyRYp/GPQBTJgxI26
	 dggXUq75+xPFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDF53811A53;
	Sat,  9 May 2026 15:40:18 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-7.1-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <af7QNdBvNvwQSuYI@shikoro>
References: <af7QNdBvNvwQSuYI@shikoro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <af7QNdBvNvwQSuYI@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc3
X-PR-Tracked-Commit-Id: 3051cd060fa496df42954291fa2306ed2eab4ecc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 656a95c4a0faf9ebb8e15e7e38ade41164018c99
Message-Id: <177834121693.1109995.5720954683317637168.pr-tracker-bot@kernel.org>
Date: Sat, 09 May 2026 15:40:16 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 9 May 2026 08:12:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/656a95c4a0faf9ebb8e15e7e38ade41164018c99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
