Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694343;
	b=RNx0AuitBDsVRySQoj8wC8jEUJlC1tU6XoiOw0iRbKJ2yErgymj1IJsKp61Ycva0Qpul
	 QotImXhUrgaB9rJRo+hAfYdp1nDgoYGssj8uquztBOoqKZW7YfXApm3Ex947Stl5eogJT
	 MBbHBq87w3Y6OobRcNXiw0E72ljtz6ZxffM42C7QRBIeIyAdcOhVRYM5DjsHw6+g3kO9J
	 Xd5d3/MC3NWF+GjPNO0fMIF6TUzYBxHfyu4RQLvuZzDT4PYE8MpopoQH4qJXYYsRjoGEs
	 6my1RtZBQwuIKL+UD36TqkvdpjVdsyzyPMNkmwRwqD+OM6/ATMXV1Fa/Voss7/XhBTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694343;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=KyZDAvnqtpCeYz8dbkVgGvl5lbRs/74vb300UkxxS1g=;
	b=cjsbPGjYBJxLK7r5ufWbTb3wj7SY+xVqHFxocXxY63wuN1LuXrOTvIa0k/jBOuS5TZw8
	 kRXfWbq4xR53bTqRAsFkB+XsZO2lx2V/79eDsHcmSk808M3B7O+Ab8WUYDOEYK2Xe1ELd
	 xKz/BVcyWHsqNeeNdngji/losqG/KlQO5PcqQYszzohW1h3u7l2Ig6BbbuZ7LlsZD0KW3
	 n0Hn3yDRBalra9ug8nEKzT+2J8ZgFIZn7X5+JY4q6fFeK36x2AG23Bz+zdyzJwyzm/ndo
	 kNaMGxgnj9oxaFmVUo4oyY0YMmwzxCTXOaIryLOc1Fx3Jd8DjTjLnjeuyA1ZdvO4sAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTScJktC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73C606B423;
	Thu, 22 Oct 2026 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTScJktC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525C31F031E4;
	Thu, 22 Oct 2026 18:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792694342;
	bh=KyZDAvnqtpCeYz8dbkVgGvl5lbRs/74vb300UkxxS1g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=NTScJktCyho6Cmi2J6tlnWxR3mQse5dc58M5K1HjHw0wazn4OYclYtEJtp3OWG7Rl
	 5+wtTg4ezifgZGsbnJyx373SZpzmtiMzr8y5AZ+jhWkjDOuPgRdzeOzaYbO6HaKmy1
	 pE0tJkVy4tfyQvs4/0M7hZwEHPaxA3HDY86I2LH+jxZN7EMtlN+tRxaefEKsBdLNIn
	 4gd41MMxFSvcwY57lsR9EPpoixxt7konQqzWwyLICTCgXliVpeDhBXNucx5rIeMcTN
	 3Ct3pd/3S/xF4Phi3wQD5YVXbqwRllSkZYzFwRXcbNRuEs/yqqlR816o63+zTxfPeI
	 cS+W4+0mSB1IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 444EF3808222;
	Thu, 22 Oct 2026 18:39:02 +0000 (UTC)
Subject: Re: [GIT PULL] i2c for v7.4, part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <atfu5GAnLLhoGn9N@zenone.zhora.eu>
References: <atfu5GAnLLhoGn9N@zenone.zhora.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <atfu5GAnLLhoGn9N@zenone.zhora.eu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.4-part1
X-PR-Tracked-Commit-Id: 0f6be986ad0eb6fe7338d963a14eaf0dee87677d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb436f2a8568d14f176475c79b0d5069f0a6f9e3
Message-Id: <179269434093.110555.10750096119750222755.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 18:39:00 +0000
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

The pull request you sent on Wed, 21 Oct 2026 00:57:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.4-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb436f2a8568d14f176475c79b0d5069f0a6f9e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
