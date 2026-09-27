Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D0643F0AF;
	Sun, 27 Sep 2026 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538568; cv=none; b=dKMSDumew/jkfMQYrtFKnJ8M/8SUcF3jrx3aNKGio77yZgfugdUqXQnb/1NmTWPFm/lGR7ZI+xrOF+e/xHZ+TM7Xqic+fvxbvS9hUG+Vo1Ll+4VQjMKweGp5zR6wMHT40codqXFnSAXq3PJhX2cGVjnUyxFhV7qubxV1XkS3phE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538568; c=relaxed/simple;
	bh=2PNFlLQPv9SAdltDp7N30svBMwNc5ZYZWXdJARh2+l4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SezBMhWq1FzwjTSfLG06o28ax8dRZEsNSFg1zzYcaK/k2P3Hb96KMrZ1mXHZ6GSzjR3iC0KqTop3Vh8+Z5EJLQaCW7gdNV1aTRq9UR9f9qV8L1U91Oowy/hOG17d/zYH+K1eYgtFPaPYq4D0IHKq9LX/unrdt/OXICiW7lOaSDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+FhzsbI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+FhzsbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B012C1F00898;
	Sun, 27 Sep 2026 19:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790538566;
	bh=lxfaSFzFGtCEILXqJHz9qxGSTiZPi1b0ISAgtUpkHB4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Q+FhzsbITUiDKb2Kp4MMIlgmiXX/HDJDymU5anYL6KtvxMNXnCJX4hX8BiMAsJtMt
	 66CqAhdaXHGo3TUOOxg+MRhYibzTk3FF090KlbAFj/zCd7d7dadF9W7uQA1/BIaGzp
	 1mgI9cKYft1bFsLkgJXvEjfAvM7Sb0NbtYVU/e+4gJ/5Xd+45mryu4WjgdQN2vm0np
	 U2/INMrWqOUvnzrKvTyzdNxQuDCa5rGxQVR2R+5SyYVbXFeR75cB+JHI+iwpAvi7yA
	 8B9zzSCmSVddeu3d7pOexS6ZNM9p0DqhcBGCtClFHkBt9ogV1dQm22EyIGxqIYxdUv
	 QnkFKTHkJRgdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93903380AA5F;
	Sun, 27 Sep 2026 19:48:13 +0000 (UTC)
Subject: Re: [GIT PULL] i2c fixes for v7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <arjpVJwkFP8ozdq_@zenone.zhora.eu>
References: <arjpVJwkFP8ozdq_@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <arjpVJwkFP8ozdq_@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc5
X-PR-Tracked-Commit-Id: cb97bf3d4f91453b881acaf8e9f0cc47bb40b604
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64d34cef2a32331fedabf25ea8fa8a30128af9f7
Message-Id: <179053849216.2777566.6201400719470221786.pr-tracker-bot@kernel.org>
Date: Sun, 27 Sep 2026 19:48:12 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 27 Sep 2026 12:03:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64d34cef2a32331fedabf25ea8fa8a30128af9f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
