Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8643806D6;
	Sat, 27 Jun 2026 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782594809; cv=none; b=nOQF/AAqa43T021sRWlWi4Gl/OMEU4sOYpwPzgQQO/ic9dUtanDOVsjwc3idc283+vKAf3jd+7Hn2xvnX2ZOr/op/ePbqWrvNn1ibhGPSmf0tC6Pt8QUgGr+UoKwqNM47a+8mAKXkQgDuoO42dO37F2bXrKmf8Zmjp2ONVWx2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782594809; c=relaxed/simple;
	bh=yQntHLJ1c6Mo+lQwLRXAXP+SfAgwhlo80zwlRph4cAA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hg5kBV4u+euD/odpBeaI2FQizCxJ7JLYyK7+JxvuJXniM8BmjjkGHU5YHA1xRwtRAR3/C/VEeF+RaX2YtwAxei1dP8SLeCDnpLvScFGHiK97MQMPvdwGfPP+axzcAs9gXo+gRK54n0H+yM7EuQAMj4rzQwXtdkV6nLyWvb+328Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtNCKP46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtNCKP46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8541B1F00A3A;
	Sat, 27 Jun 2026 21:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782594808;
	bh=Z1nUvM22LRe0szE2Nv4IAloo8qj4pY1KUV8IYxe6fmU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=UtNCKP46TEaafeulPlRfMsFnRVr9MXBcsPy66UHw+/M0V+xwPHRkLb58Q5VM7ETM2
	 ACFlQx7XWj2aKzrTUI0/bUpWX4q0lf88CF7i40twIlq+GdNJtrSbLOiRqnikp9NfLD
	 +ObVSzdwzBYTtAmIwaRwR80qZfRFO44s5K4DsXdJTOkgYP3NKph3N4J4bjqcwqEQiE
	 po+W7G/tbNa+PaeoNOBAdH0VjjXLHzWWSbsZn7EAFmCvFPnfnPTJZf1VhMTeNtb7Ra
	 JJ2Td+4nqrO9La8Qki+Ca39OjvKB7EwdHazmVObvbZVF/16o/TaaXOwVVpJ5nduMSj
	 z1WiaF3mZ46/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9517B3938452;
	Sat, 27 Jun 2026 21:13:15 +0000 (UTC)
Subject: Re: [GIT PULL] i2c fixes for v7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aj9wIlxL13xmq2UJ@zenone.zhora.eu>
References: <aj9wIlxL13xmq2UJ@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aj9wIlxL13xmq2UJ@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.2-rc1
X-PR-Tracked-Commit-Id: 10dd1a736d557e310a77117832874729a0175d57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bf54e47525dcacd4c6cdd97fb5902592414dd7a
Message-Id: <178259479411.1431938.9663666644227307097.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jun 2026 21:13:14 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jun 2026 08:45:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bf54e47525dcacd4c6cdd97fb5902592414dd7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
