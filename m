Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1371991CB;
	Sat, 27 Jun 2026 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782542746; cv=none; b=SBEvMF+nUyl43lyrFJQ2GDxRqPFV2gZnHhraVAmggG464v09xpj06gkageBA5u5fd91bJ04ljXk92wZr49XepE1Qipyn5fwMKRe1+5gDtvgGp7IEmEDwvce+93yECrRXoTQjO+uBvuRusLC9LbXda3Dk0nNuaU9CT9DWGD+RJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782542746; c=relaxed/simple;
	bh=bYcixaePtROSNnWfTEy1OEKq2jJQhrk0Ci+5Jfy3cwg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tCq5FvctHdgJ4w6SqdJjxCclKsETVKWHKmYHT+UyrdzAfePisT4ydnzeQTYXA2uyR7+4zeTxrdYEVl151SZxWCfMOPNmv0pig9/TXG46AJdz7098CITD3bIXbcWHOHds7gnGXfRMQaEn7Z95sFlpV5MfNvaDJGEab0yizEVlIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH53k9Cz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH53k9Cz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902AE1F000E9;
	Sat, 27 Jun 2026 06:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782542745;
	bh=ZVVBiZOJ4B2imcIwQ1EYfXb1C+7YzXZs3NcAHvT7w2M=;
	h=Date:From:To:Cc:Subject;
	b=XH53k9Cz1Tk0pB0N7dwcA19IQECtQ7s6QZEC3ZcH2iEr69iN/e42nNUM7iu7IMrkH
	 NUJLvuA+icVJT7+56vFVOq1FKHCFfe4hvCQh6w3IcJWKt0LTolnnhaQ9+l9ENfUZGZ
	 GyyhqISur/7OYbrYds8QuJdbHFTFHXjK9sPUgNNSGxe49sNEt8Ee/DrjgM5wyFwhuL
	 3WP4kkzqX6D7zK9W78iDF1UpBmW0MWsQ2QtYZQhsQL+m72FhwAffh3xq8HpWc3gjdJ
	 S7zCNk/zc6NRQ5/O4cnDs7V5Wi5CMLhQqbljE+GuMpvV54S8pKvlHMmGWeSMzq6/34
	 l3KbyT4nQUiAg==
Date: Sat, 27 Jun 2026 08:45:41 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c fixes for v7.2-rc1
Message-ID: <aj9wIlxL13xmq2UJ@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

here is a small i2c-fixes pull request to start the 7.2 cycle.
The branch is based on top of your latest i2c merge commit.

Thanks,
Andi

The following changes since commit 1dc18801be29bc54709aa355b8acd80e183b03cd:

  Merge tag 'i2c-7.2-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux (2026-06-22 09:30:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.2-rc1

for you to fetch changes up to 10dd1a736d557e310a77117832874729a0175d57:

  i2c: i801: fix hardware state machine corruption in error path (2026-06-23 17:53:08 +0200)

----------------------------------------------------------------
i2c-fixes for v7.2-rc1

- i801: fix error path in smbus transfer
- mpc: fix timeout calculation

----------------------------------------------------------------
Andy Shevchenko (1):
      i2c: mpc: Fix timeout calculations

Mingyu Wang (1):
      i2c: i801: fix hardware state machine corruption in error path

 drivers/i2c/busses/i2c-i801.c | 2 +-
 drivers/i2c/busses/i2c-mpc.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
