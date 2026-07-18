Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596D626E6F2;
	Sat, 18 Jul 2026 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784406764; cv=none; b=lKWG55H0RxlI2uhMYrfvIxUU3pf7JFdcYncm8W5bDJtbsgEZdkvGV19sld2Yv6STlzCqOt9Hc9ooHGjSH+JL0GA8+v0IOO+JUPCW1P/mTT9kEpnzfR9NojLuRgtOSaZxvJ7Gp16keHjXGY36CorpMlKVYlq7I67Q8jpNm8AjwwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784406764; c=relaxed/simple;
	bh=+MkY3ZlRMCVbfPClD7A2JHO60nqHEAEjLkA6m56xMTo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Xg6SbkeE0BSOl5dKUulFTinr4LQRc3gNxMlglVuS2vkgjyrx80MDA9vkU65AIiW5aZ7+s1YB4MIkZ/s9f9iJKPdY+rqhlYOH23xTCrSfbAt/LGkpd4HsMKss4wOHVI4XKljeztjDX2DLMft+WIYEkiIX3BUrBXL0nTd/4TNXK+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYZMuPcF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYZMuPcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C9D1F00A3A;
	Sat, 18 Jul 2026 20:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784406763;
	bh=Gs7p19xxnCBXeiCiZ+tDp3wAt/hKnR7rYBI7z2YxVPI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=GYZMuPcFq6xUjvGI1cqLPMYNnz0que250SnZAbhfo+F8JOHdNzbyZF+Gpx4Un5q7Z
	 JU2ESdztHSt9sppHCJLWI1nknsTKnpY8A15CcBsC8Wa4aJSsgOvZzhuPh2s8p0g/tj
	 9lrlyvkxepdQ4xaK4sc915wXE3y0OvT12/fXdnDdF+TuF+0DesGj6noXvP7Zg+Copo
	 QB6qrCeMCLaeCajAjJks1LtGyqU7w89IKm/rzM6t/kaJLR6zq/7ti5yZ1DkRhGHj80
	 LGd4AvBW6SNt0hetpuhNtNZvRZdCDLKtcjdJnFkY8AAW4WX37WtPeXszFhFH3BXE9d
	 wwd9R6VF6e/vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C443811979;
	Sat, 18 Jul 2026 20:32:15 +0000 (UTC)
Subject: Re: [GIT PULL] i2c fixes for v7.2-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <altYEuFVUe8KSr5e@zenone.zhora.eu>
References: <altYEuFVUe8KSr5e@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <altYEuFVUe8KSr5e@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.2-rc4
X-PR-Tracked-Commit-Id: deb35336b5bfed5db9231b5348bc1514db930797
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba6bd0df9adb2a7a02db9d1973fc1dc3489b0758
Message-Id: <178440673458.2573970.15931483473511421128.pr-tracker-bot@kernel.org>
Date: Sat, 18 Jul 2026 20:32:14 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jul 2026 12:46:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba6bd0df9adb2a7a02db9d1973fc1dc3489b0758

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
