Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE34A21;
	Sun, 15 Feb 2026 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771174690; cv=none; b=f2gbpO29Ghj7fFhf9M/hVZmv7b/XO3YbVjX0ILW0aZpexNPWfjFD++BQWJpJ1585+sK3dVgdJ49UYH6RB/x0ZL+DoY4uc4ZF+VoNPkr1YMWMswdU/FE+hQICRX5QML3R/w9LdiseTYb5AxGpxR8LwOqb39Ns4EX68OCVACBaYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771174690; c=relaxed/simple;
	bh=XNmOhLOTcbAw0IPeVxgTzJsM7mPKb8kFk0XR+mlF5uI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RHewREISJxoEvJexW0I9p/xXz2CGMVmyxY1H6k9Fv90SfvAh09vi08kutTrV1sXY4dXwpPKOSr2w+6nSKaVC8oOvA4/jhEXoniT77FpJIapVgwEHGlp05338HSkDA4WRXZWMZm1dtfUjSkJYNyZmehEIkKzXw8+me/rimQTIS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJTBJOag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJTBJOag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614DBC4CEF7;
	Sun, 15 Feb 2026 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771174690;
	bh=XNmOhLOTcbAw0IPeVxgTzJsM7mPKb8kFk0XR+mlF5uI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AJTBJOag7fMShjmVqWQA/ecbE42DcZC0k+tjWQ7eAVf4ZWEQZDbJVhvxmowRQt/eC
	 EcD8WvKsSM5mysjasVVvUM2mhqUZkzhAKxbxya83WJTQ6tz5oEKuQo4OeryT+R/LU/
	 BKB7TM2dJExgSIj9Kk/8ER2Fr7BZUam3WG9VX8Owt06CMPi0clXnZ/qkZNbX/HZsLc
	 SidsftJ3id200vhqSLz9kDLxVOp46nqTeQw/cR4wGPVx7FVYG61Pkl8Sr54l9RxnHH
	 uUEhoevfk6MUe4P/VZsPA3PI+dYkV5YoVAiJxf3QdUEFkm7hH5vHO/itv6qGknW2CX
	 0pz0jCErlyLxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 854053930925;
	Sun, 15 Feb 2026 16:58:04 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aZGaVvjGs7vP4lHv@ninjato>
References: <aZGaVvjGs7vP4lHv@ninjato>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aZGaVvjGs7vP4lHv@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-rc1
X-PR-Tracked-Commit-Id: efdc383d1cc28d45cbf5a23b5ffa997010aaacb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb7a3fc2c976b5d0deb35a54ca237519816d7ba9
Message-Id: <177117468313.3131369.2739110656678118290.pr-tracker-bot@kernel.org>
Date: Sun, 15 Feb 2026 16:58:03 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 15 Feb 2026 11:05:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb7a3fc2c976b5d0deb35a54ca237519816d7ba9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
