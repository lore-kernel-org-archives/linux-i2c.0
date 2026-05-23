Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145B31AF2D;
	Sat, 23 May 2026 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553431; cv=none; b=AWtTUz8iBe5kQKF4GK/6L2ebfoCRGiNDvDwB9L5o4ENojUFqbcS1ABWGw07icC398/W2/b4TbCPqtHam/bOk0dNc3OpJXjVW4ty8nKA9cervjw87ApHnmSsYL9S87OkvqCc5MKJ2FCeNAvs5p+P7OM0+xB/aXiVdA3bels5LIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553431; c=relaxed/simple;
	bh=rhKxrFTyt4OiqZ7gmkUAoKoi5PdvWMuf63EML1LHvc8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j2/a+2i1ptGq0qTXo2aqI0xYWm0L/w7xAxL/k7x4pdPliPErIT6j6jOmnZn0nq3xIdjG6HJii83vZnlDj4q/EA4GY9nvUgmuFjVzz5CR8SlUpm2KxyHm4cwIyUSglIUTLHuqs6gGdja5rOV3s+B8kCIOw+iOa9DiDxAcOp6klgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=medoYBNr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="medoYBNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774571F000E9;
	Sat, 23 May 2026 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779553425;
	bh=2geqW5T50r8vgYtQ+RYz/wreOf2tL/NM+xP4SvLPaG8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=medoYBNrSyMA+uYuVMTe2C3lXHwTE4sIWHysOIfAm5fOnn2yN9rtEv8FGcJoqCQDk
	 uG+z+2eFu40ADUSfDt0g06E7fr3AhjvJ4Q3hJc1CXEIjDQ+pWgJ1sJ6kxVfdQ9vYGi
	 9W8DOkJlC2ZDqJbPdxzznV/ZPLIoXFJw4+c0PPFmM+/jszf4HK6o9pvrSSlh+MpCJL
	 n3hlFrlFLVkxJhrH3vNTzXUN7AEAcVu4alBP/Wutpz47JFNWbt85Zk+myQGi0nqYww
	 h/18YG/gwqjP7Ep7pbXCMZgsYZkr7j0GzsRJ0O+/HS8Ayp55yZvGA0s9QV1dU+oNWC
	 9CqCQOor7B2iQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19D423808205;
	Sat, 23 May 2026 16:23:55 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ahFi7Rb3E-NJ1a95@shikoro>
References: <ahFi7Rb3E-NJ1a95@shikoro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ahFi7Rb3E-NJ1a95@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc5
X-PR-Tracked-Commit-Id: 023453cb7eb0f53c5dc36babed8e706c1b0b0187
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f264650ca7d2a2d6de86234d919f305211632cd
Message-Id: <177955343363.1611769.1209981259559254622.pr-tracker-bot@kernel.org>
Date: Sat, 23 May 2026 16:23:53 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 May 2026 10:18:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f264650ca7d2a2d6de86234d919f305211632cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
