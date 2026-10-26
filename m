Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035470;
	b=JCplIuwIFuX945hHeccK+reG+qIKWS8MngioUhotmc/LwS9PwgidoSqWC4rg+jiMRUt0
	 rHAo3rst4LspH5m148Z9MENDde/pA8f6000/yB9Z2HpSeYvDgHrvPnuyaAcewKdHXYwKv
	 CaqR16PFixywtKnkNzZkojO9tCjypv7l0oJR25/pdtOdPVDRKisoetGmJzNvC6DfwFXSj
	 htxBIe/wNLiyaDtht/ywGppQYZ7yLRYSTAJN45JhpaMkV52vkuhQrr2vU98ddPRxJYS1D
	 1wOSjp86qjWg/lpaWIx1h3S+0JlRPVnfMp3GMUGaiMHqcUAhGUS46HcnfnhqqQQlolg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035470;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=iQYpXTiEbDliXK9QEJNukRJWq6+pUuPF28NLWUvhzdg=;
	b=RNrsf4ZLxR5DgYI/t4gXbOe8/u96tyZyZLLsnjwenFimnXypMzGei2btlBk9DG4VbKzJ
	 3TwCgsRQVd5zdXnnhz7ZiL1fptuFQqj+qweXbl09i1VQzQmer5vW0HUcy44VHMb4FEoAb
	 WgsZayoLWH/pO/+QFzrNBORr6hjtJDJXqk4cuNTDIUBD1Q1f6vQQB7spwwYPgGaO+m6Zt
	 MNMR8Ccpo0bDJ/k0MLjWB8B/FrIH+WlB6inyt2EqQ1gEe7oenCoNFMXWIZsqitnAeBpRz
	 RrTubPeIFgHHjndnA40dnuIpSvXNEteC6bPWm8aiQeEK7V9FgvZSgwcVDIl2NdfSoRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cG+5rLDJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D086606A31D;
	Mon, 26 Oct 2026 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cG+5rLDJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182061F01825;
	Mon, 26 Oct 2026 17:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793035470;
	bh=iQYpXTiEbDliXK9QEJNukRJWq6+pUuPF28NLWUvhzdg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=cG+5rLDJDlaG40SXO4YF/dRRDyQe53JK5TeXAZzeWy2PucQEc6h+s8FyvaBITVGpe
	 sdNgtYV6Mwv4VkDsJuLVzd8mfo/BoT+6th+G9Ui9zW24uprkIl9wP3UIketa4arQTF
	 /UsQhxJmxmBokrSET/RJ81yixzEJk90gVqABSohljWkK+KThIU3fRxhmHRhyq8snt9
	 oMQIpDZCSvwMqyXGKCkmq9CD9y9j5rDTWrqyRGdwLdvLm8Gd3VBt6KF49seDcHNGkF
	 0KGKR8HriO7GsDRRmRvg1HZygSLIQ26Mfqp+a5Pzz57Gm6Ccu+X0Y5NUlc4ZtOSujX
	 d15nOPdldG1fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0758E3AA58BF;
	Mon, 26 Oct 2026 17:24:30 +0000 (UTC)
Subject: Re: [GIT PULL] i2c for v7.4, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <at5i65e5wjMz2TCA@zenone.zhora.eu>
References: <at5i65e5wjMz2TCA@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <at5i65e5wjMz2TCA@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.4-part2
X-PR-Tracked-Commit-Id: f7b70efba26963bf725f10574cc071f86cd5ee1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25e7ab89f4774b0f842cee0e8a20c11f755924d5
Message-Id: <179303546853.3291751.9922977220783551561.pr-tracker-bot@kernel.org>
Date: Mon, 26 Oct 2026 17:24:28 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sun, 25 Oct 2026 21:20:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.4-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25e7ab89f4774b0f842cee0e8a20c11f755924d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
