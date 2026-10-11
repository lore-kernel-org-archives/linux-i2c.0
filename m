Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904B2AD03;
	Sun, 11 Oct 2026 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791677031; cv=none; b=ML1/N9/hSQXfTg+Lo3WYy4ZRg+N4kKAXpaxgzTg2liVqazU14qEseUjb8BnoI0RdULK73X+0iVDKfPgTHdVin0H/xJo6wp1vfZPkSI2XmeS6PBfjMBNFJQ6OFD9SNUX43bM1KTrZCsQX1UBdRdB4xC3wYVcGHPieexNpT4b5dgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791677031; c=relaxed/simple;
	bh=2ETz5eoKIG3oEtqSTfV0VsCbuPvr8GD7OQHpdRX4K+Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sXOPuqftjWW/3Denan/t/zMtszcSxPPc5DLf/citI8Xkve2/gwpHowx57lBXKZp5iuj13kR4xGjcgTL8pIOZm9r8LKM8n4FBJho/qmPFogTYFgjSK5a/819Jq8ojb8w8l6uj3C/eDrRO/qOyK+FQhmeiXZxZUQfQy+nBDaIikOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBH3YgDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBH3YgDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801FA1F000FF;
	Sun, 11 Oct 2026 00:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791677030;
	bh=AHgbsF2+qbke8ECj53AyuPs/cqcXoMQm3cDIl0ASmjU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=kBH3YgDT8PfcwcmlYJnPzG3ePTeF3rQNyZbpsfNuyPllWAbo7bG1odoze3DNxQjbb
	 tGVIwm8q058T+EsnnEuVEhqD1OnhpZDMMUDS7QbsAaCASo1wENPda7c40eEXwINXnD
	 r4g/wL+n/XiP7sKS4c+ovrbPt5SgQbtsOnbG8fUlV+ObG+WYhRfxOjYziU/Th1i3Pp
	 4d4YyNVF3k/tird2I8u5wYTQFUz+cRYRwkXFqFzH6wHCAuuSHZPbSHuxZAPR5WLkdR
	 7TeyP/w0qa0svUYl/LOJ4Pp/haQdgIAvFi0pz2s95LmpGvWMkp1W7FDnWqqlpNiJP1
	 r4tdZ3nJd8JVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773A5381195E;
	Sun, 11 Oct 2026 00:03:50 +0000 (UTC)
Subject: Re: [GIT PULL] i2c fixes for v7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <asoNklC8eK-gbsUD@zenone.zhora.eu>
References: <asoNklC8eK-gbsUD@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <asoNklC8eK-gbsUD@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc7
X-PR-Tracked-Commit-Id: ae8364085574203e7f4ea961921a1c7493bcb6de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b62f58bd7187ddbefa66913ec742137680ca5b22
Message-Id: <179167702914.1871243.14344730772093196775.pr-tracker-bot@kernel.org>
Date: Sun, 11 Oct 2026 00:03:49 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 10 Oct 2026 12:06:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b62f58bd7187ddbefa66913ec742137680ca5b22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
