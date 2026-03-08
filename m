Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE938E5C9;
	Sun,  8 Mar 2026 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772990405; cv=none; b=ov0AiUt/YTgJ+Uua12vMhJ9X9COgLhqE+MqUsMHoFuPChI1X2hff8Fw63LExD+UlftliQdzevvQ2dzPPtGXM+eEILEDP7eUC6HDSNJUWJDpTKWVh+WPISxZhcBx0uhm535EEYcxTl4iCc7JN7G498fGvZPvqph2hERgqvSVClEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772990405; c=relaxed/simple;
	bh=Nx/unRBYwpIgtJFt6Fh6IJx9vTyDlptVXs18USR1P18=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UzKx+qoHT9NvBdmSbWmokhlVP9dzvSZsv4VE/kngIAvP4kRwPO7ct/ao+AspRCjM7wmvp+cyptaD16njxoa1N5yKvcPI0DPgMmXsMWBCjt6RlWHyQXL0kBV3rUKf/gsgRNzUACyH5Fd1NRs3adWsxEkJA9KfNhJaq2O8sUo613w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDk5c09n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDk5c09n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93480C116C6;
	Sun,  8 Mar 2026 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772990404;
	bh=Nx/unRBYwpIgtJFt6Fh6IJx9vTyDlptVXs18USR1P18=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PDk5c09nfEIjfqmP75/SP22bqPK6rlxsZwEgItWd3MFxuzwrXR8W7o1f3fyjYlvsk
	 IPnG/CPV2iURerISNGBmV1a19ut/P+OkKG48o7onH4OW8zIm08SHmQmqFlQV7mHo4f
	 4EssGsja9ZJLISDfR8qQxaorn58S8e0BE0hLlDRvVjD5vq5nWd2D6Q8rq+CbNVvlI8
	 xDuAsH5rka1cBpWhIt2CRWr9cr7yrP4DePnLZjXi3f1W6CHJHUpzP0ZWSWv48DTFv9
	 U6N2CHS/oXGkC4MccIiLpSFbUgIcvVO+3UioFjoqKicYZLiePjwCeiOZktdz1DqDww
	 CWHBGgywMzLmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3203808200;
	Sun,  8 Mar 2026 17:20:03 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aa0qJvLMHMrBOJvf@shikoro>
References: <aa0qJvLMHMrBOJvf@shikoro>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <aa0qJvLMHMrBOJvf@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-rc3
X-PR-Tracked-Commit-Id: cfc69c2e6c699c96949f7b0455195b0bfb7dc715
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 014441d1e4b2f5be728433b761df3377dee7a487
Message-Id: <177299040248.512151.3735794065242966378.pr-tracker-bot@kernel.org>
Date: Sun, 08 Mar 2026 17:20:02 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 8 Mar 2026 08:49:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/014441d1e4b2f5be728433b761df3377dee7a487

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
