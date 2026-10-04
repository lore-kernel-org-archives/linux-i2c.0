Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDDF3C7685;
	Sun,  4 Oct 2026 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132644; cv=none; b=rNnvG7u4aVxCyavXUNkpMP8V2kOhsl/bocytki3e/Xb4J82n6RgQ3G2tuwFOdFjIRuzBqk73lN9+4FXSy0s2EwsAsv8Afhcw9SRzSegrNT8nFWVLdUvpcrZ0z7Qr+fKcdktFqSGl7/tiMazFeXfm8ZGN7eGRtjt+U57socVYg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132644; c=relaxed/simple;
	bh=XTpDKl+G+Y66LvVYzydjB21cKT1CJobqzBy+seq1764=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PdR0zpW6gMARAeLcZpXfdS1WlhIxqNC9tGXIKEOsJK1sm0sO5FNuY7Y/AOAR3T523fLMk9X7Sa1ON5tZVh3BYh8S2eWfSm76Swyk+tgwPXAW5qNWREjaHWJwsDWBPtIlTb/gxU+qtnOyD7GehYMsjE5GcyEyDFqGYCS1vLcDpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne0iHyk5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne0iHyk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8141A1F000FF;
	Sun,  4 Oct 2026 16:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791132641;
	bh=EdQZkcJM7uo4ndksMU3I30uIlZ86fw55yA7f/3fBYAE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ne0iHyk51XH42ok9yXWJcIh+3nvtZhjTgGfqpIPzzSyPzUyMxKSCL++9Nxnjk33d9
	 cftGsquiiOxMr/qt0lKnYuzlezvcRmI8Opiaglr6P2IRCNex/B2JW9P2vFwqs/u8an
	 Ml6WSUvLtl2nmdnPQiffOg4Nv3XEdD+4+tIV2NVhwXJZpk/uSaMoR6qAEW7S3ZIujZ
	 6W6uJIX5oa9tS0YnKo8JySp4X+onIrmgZKtx47UoH93OBHnQHXA+OWps9geFbzDzV0
	 PIPJz2ic7bfDfzBGN0TsvhX3ALjDNAZn3F/+NB07BuS7kt7fZWbnk2Pgm3yaWApg3N
	 /Y4XWlFy0gsOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775A23924FEB;
	Sun,  4 Oct 2026 16:50:41 +0000 (UTC)
Subject: Re: [GIT PULL] i2c fixes for v7.3-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <asIofz6JIxKb2s-X@zenone.zhora.eu>
References: <asIofz6JIxKb2s-X@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <asIofz6JIxKb2s-X@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc6
X-PR-Tracked-Commit-Id: c98bf3b86609a18ab16d067280257326e557c636
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7704c4c5bb127673b4f0ead839919db573559e38
Message-Id: <179113264006.470573.7425683394244281128.pr-tracker-bot@kernel.org>
Date: Sun, 04 Oct 2026 16:50:40 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 4 Oct 2026 12:35:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7704c4c5bb127673b4f0ead839919db573559e38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
