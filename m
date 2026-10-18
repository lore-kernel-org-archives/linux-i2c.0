Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E80381E8C;
	Sun, 18 Oct 2026 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792350405; cv=none; b=sL0USXxPPEneTg8iHMtAbNTYIWVl9veV/zcpjZsztfT6vJBWKZuvCUSOuso/r93xEI3l/mzzFsV1USSL8FqRddM3PS4lWk3olaW6nXGxYqm24hFc5qN8GOGRc9fgcikBN0ntcWbdv+WMlnurej6qGCoKFTPb6IHagd+rbdeaL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792350405; c=relaxed/simple;
	bh=VJSlxiWiLlhRzX4DSRn2mTNdrBpvILYS0Grl3UgbhkI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O5E4YJnvHxN1VA0UpYhyS/ojPrl0aQZBeKHJrgPVi7pOga8kFSPMiF/yc608B4iddXK0Uoacvhmpuscm40UTPn/00WOMtyfEhCGHQtyfQ+vBBiTLECG0RzL33Obc3eqVxOBCQ7+wdOF/EqW+4AJ9mCXj6YRvU1hDRJiu4pNcqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPc9fm2L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPc9fm2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064791F000C4;
	Sun, 18 Oct 2026 19:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792350404;
	bh=deIffueQWgcbAsKBXoJ0l/Y17kkwxBuqYSJJ9KHGm8o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=hPc9fm2L2WoSai65ZKTu/L/Nyn17Bfl48WHKZ07twdJtlV+DbTWHM+e7IjHb9LW/w
	 F4T7dTyn8k0ZkbGm8hii4XDdU3LGAgIL/F8d60qc1Tb5grOaARihHmWyVUr1b6GbOu
	 C1du/lKOqu8igNpe3aKp67QaHFFwtOsjRltEqrRMRxjkSZ+QEtb1rrMK8C5/oTWIau
	 d8SPT9vH9l9PSwE0OyEt6cSkTDc+vmlelwe3msfU3Nb2CbewyHohLTFGxLFD6vSsdI
	 Z6XAezmEvhzq2PB7B7fLk1c4AJpPs0S918swqwr+y7CFZcz3LnBEfwWksSGtMDJXY4
	 kyy+KwqD2RhYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1562381196D;
	Sun, 18 Oct 2026 19:06:43 +0000 (UTC)
Subject: Re: [GIT PULL] i2c fixes for v7.3-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <atTk4XFuPp9T88YL@zenone.zhora.eu>
References: <atTk4XFuPp9T88YL@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <atTk4XFuPp9T88YL@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c-fixes-7.3-rc8
X-PR-Tracked-Commit-Id: d33373c565af9c8a28776af02bd20ba6e5724211
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72732cbee632b1be22b636813c9be3df55c72bd9
Message-Id: <179235040255.1786430.9834473388608451955.pr-tracker-bot@kernel.org>
Date: Sun, 18 Oct 2026 19:06:42 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Oct 2026 17:29:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c-fixes-7.3-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72732cbee632b1be22b636813c9be3df55c72bd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
