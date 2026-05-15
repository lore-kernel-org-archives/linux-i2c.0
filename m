Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4B93CE0B2;
	Fri, 15 May 2026 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840469; cv=none; b=g3uoDLYwdjPyg9eRpvCA//4daHgJLNYP2q/53xL6JLSPO4iU3zuYe76x18bsvA9qFVYR7k1nxozxfjUnskYw3WZdlF9TLTlRLKsWOXyehe8M2/piMe0UEbRmr5DPQvFw3wlTszoViFx5YH+Uwa0krd0hNWf24yzt/cVChpUYAGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840469; c=relaxed/simple;
	bh=XNZ8zOAbXGHWzHDLULZWF9WHl5NmZeg2qUmHdpSMK0w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oTyJ7T2HzrNx8kK3z0/Yq8Of/QOuoWj/H4vD0g6v5ePmlVt5/ZmMKpEPbi13cxnSGAEe8nzw4eD8l8Q8zlmZh6fXx/hs6ojJe3hGWXW6fxUhIp9w+A2agu3nYs+k2BHbfLA+y+3BdodHsLBm6xDR6pnPKSXumu/CpycA5nDaWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC0roWRB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC0roWRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AD9C2BCB0;
	Fri, 15 May 2026 10:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778840468;
	bh=XNZ8zOAbXGHWzHDLULZWF9WHl5NmZeg2qUmHdpSMK0w=;
	h=Date:From:To:Cc:Subject:From;
	b=KC0roWRBlLytRjnF6tSPy06U9CGKD92+qXqHKKQvf/elB2WGOl1K5vZU14W5LLt5o
	 jpQSkotnCorWgdCrg3TXTZkpNhbbfVVt+AxmGTJ/1UieA4xDfLUU0VO5ivrmwsIp+3
	 7IBMPMj06du+/P4WNKCNACPQX+WoYyTcEZYO+dhhimaaRQ1zOxyXKwFmUIumAgXQjR
	 HAmdns97hm+ocSK5sfrzWF0Aj8GD/AO1xdN83YRtI6Fp8DJ77lEW159dPehSPm7rCZ
	 lSspMcwpei3NT9K6tBHYB5AivsxVJGvdLe+aEUA22wTmZXP0fVp5ubreH2FH3rUnwN
	 YOo1IDxW9jEKw==
Date: Fri, 15 May 2026 12:20:59 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: i2c-host-fixes for v7.1-rc4
Message-ID: <agby5qiVRXNQGvky@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wolfram,

Two Tegra fixes in this pull request.

Have a great weekend,
Andi

The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-host-fixes-7.1-rc4

for you to fetch changes up to 30792d12842901f5276f466a960962d5bfa15cc8:

  i2c: tegra: make tegra_i2c_mutex_unlock() return void (2026-05-14 00:14:20 +0200)

----------------------------------------------------------------
i2c-host-fixes for v7.1-rc4

- tegra:
  - drop runtime PM reference when exiting on mutex_lock failure
  - preserve transfer errors when releasing the mutex

----------------------------------------------------------------
Saurav Sachidanand (2):
      i2c: tegra: fix pm_runtime leak on mutex_lock failure
      i2c: tegra: make tegra_i2c_mutex_unlock() return void

 drivers/i2c/busses/i2c-tegra.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)
