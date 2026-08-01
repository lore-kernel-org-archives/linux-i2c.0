Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2C280037;
	Sat,  1 Aug 2026 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785603869; cv=none; b=aVxy10DdFX/gAjayF1fUJt1etv9FPbbfpsqpZ9RXm7cM0cATZOWPdeLiYSBaHbDEQa2ywbERp/juzyezivK3/XCWlISnDRQ09b/kI7sLqxwKs2vd/N9xGUZ/aQUTrH1WYXvMt1KG8PVgS2nxddmRh5d4XEXy30p6zZjEwptKuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785603869; c=relaxed/simple;
	bh=OcVIA3sclPgP1vjzAQ34v6kDmRYxAGfyKYzK4rz6iPw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UdxTjb3rWH2GiPa9EZ8Fl3bznx70fZPLDsByN3AmRJ41B6WsW7MrT9y5PlUJ6G2XWo+nfAN9qHpO3o8pX0k/3og5/uWHRGWs3sGWNgjtbYy5QRss1pOR31Czqh87g7k9el1GbqhGWaB6bGDX+ZvFJ/z1z5NaCnTUARzif64M8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RABdH4To; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RABdH4To"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63A01F00AC4;
	Sat,  1 Aug 2026 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785603868;
	bh=Cy1RN5fQOC//CpuAT4V4z5ECAYwdX1naVIu2mcnbeXw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RABdH4ToTQeQHfLTgDiGglzvAoQR4MN/Ubmx9eHkjgnM1wuOzacO8NtzOT0BYk3gl
	 5QKXNhL+s2YbC2WyX2SI0ryBOmwV1E42EtGHnyqIO9tdMtUcgZBEXEuXmbmLDD48XI
	 SQnpPT9+HUGEdUBeHtYMCXQx28qAAkNoxXQcom6JhglqQ8uFHxm80/R43bhuJLTM+T
	 ahoSyB/II1FHTkf3jZvNCLKCAUWGkFuZoSu8Dfv9vscZPFNd3yjAsdzjaIHbNwoXne
	 IZVuLhTstmWc4QgQXaoKpFCwP8uOXuvxGSZCZ1c84Z1fMOF6i8UfebbLmq3iQO4BbF
	 Gx8kHvJ1mvMkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A36380820D;
	Sat,  1 Aug 2026 17:03:52 +0000 (UTC)
Subject: Re: [GIT PULL] i2c fixes for v7.2-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <am2wqRZRr--FHRR0@zenone.zhora.eu>
References: <am2wqRZRr--FHRR0@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <am2wqRZRr--FHRR0@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.2-rc6
X-PR-Tracked-Commit-Id: b08c9857aa1f5f3a81d375d6d4bb1d8b92f22ebc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d2338c93da79b3bfe4b6099a931d9468d539952
Message-Id: <178560383089.1167361.16383602923518259377.pr-tracker-bot@kernel.org>
Date: Sat, 01 Aug 2026 17:03:50 +0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 1 Aug 2026 10:45:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d2338c93da79b3bfe4b6099a931d9468d539952

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
