Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E80D385D7F;
	Sun, 30 Aug 2026 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102447; cv=none; b=HItz4qxbYJstwFJrlfU36NK1Nhf6ZnboDa1HMEtj1Zn4PkuuJDuabjkrnm0/iu4gSwtkvIHajvD/IVxZI/ZLUsl1Q3dfnTm93jl+q0vlVxdqR/KzHP+ge33XHnof6uX3kfzP7j04DW3qncmJGr8UpASdjUaZpiGpo5kE1vUT0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102447; c=relaxed/simple;
	bh=+/JTs2j0yHRFkid8fzPD4BRlIX9cJAEhtv2HTTAEONw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gox1pEgX5dQO2h5B2OwRUGL1Hk8wTSUT6YE3lO6zGeiAMKhQQpVB4lCJkAk12iWzN4ZkZ5H1MGwGlASxJCqepAcHaPNa0Cn4K8cIZLq2NgMa9Pw9h/s8nh8UgtxlPnZWoOpcAkgx4mETmM6dWD+hlEWQbnRzmEa4TCOQHnwk/Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0AVGzpu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0AVGzpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E2D1F000E9;
	Sun, 30 Aug 2026 15:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788102445;
	bh=kNU5UKcUoiTDgnQxbU0a5z1W5IhbhmieDlkzbQWUEyM=;
	h=Date:From:To:Cc:Subject;
	b=I0AVGzpuKAinFrlRfBZn2D9Uc5VyhL7ihBSBXPbgfHY2LJF9ImElXJIcueZYLVKQe
	 IuMpoP9X4WWth96KkMxBxbomjbMMXsh5HXCzlpHhFRoCsNiV+NBM+dYj1+aWmnOEsA
	 Zk68uPmZwtYD5OE0x21s9/YYg1WsKWxspI5F8DDeFB6plfCVz6kb702ddEJw8OKwgR
	 FIQ1ekiKcgA4rsiLNknUlgrRNH68WfjegayOx8agb7HEjENrPcUostwYp+RIc03LeV
	 Jt6nA1TTWP83oM/WFcAy+8zziOEVWuHmxjYoTPzFhShHlElh+EJDLPCAHMs4vE1W9e
	 U/EYMvpg162nQ==
Date: Sun, 30 Aug 2026 17:07:20 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c fixes for v7.3-rc1
Message-ID: <apRF7F65GhuKEF1j@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

here's the pull request for the new fixes cycle.

It contains fixes mainly for teardown and resource handling,
runtime PM and hardware-specific controller issues.

It's based on your latest I2C merge commit.

Thank you,
Andi

The following changes since commit 47096fc3d064a07c0842f748b99ebf01be120f2b:

  Merge tag 'i2c-7.3-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux (2026-08-24 09:07:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc1

for you to fetch changes up to b15b548d52b43ba8ac4652bc2c7244a8dd1e9622:

  i2c: core: fix debugfs UAF on adapter removal (2026-08-28 03:12:01 +0200)

----------------------------------------------------------------
i2c-fixes for v7.3-rc1

Fixes mainly for teardown and resource handling, runtime PM and
hardware-specific controller issues.

- core: fix debugfs use-after-free when removing the adapter
- designware: apply interrupt mask quirk for HJMC3001
- imx-lpi2c: avoid target accesses on master-only controllers
- mux: release channel node when adapter registration fails
- qcom-cci: fix autosuspend and runtime PM cleanup on removal
- qcom-geni: fix timing parameters for 32 MHz clock

----------------------------------------------------------------
Ahmad Byagowi (1):
      i2c: mux: Fix channel node leak on adapter add failure

Carlos Song (1):
      i2c: imx-lpi2c: avoid accessing target registers on master-only controllers

Guangshuo Li (1):
      i2c: qcom-cci: fix autosuspend cleanup

Hongbo Yao (1):
      i2c: designware: Enable interrupt mask workaround for HJMC3001

Kathiravan Thirumoorthy (1):
      i2c: qcom-geni: update frequency table to fix timing parameters

Vasileios Almpanis (1):
      i2c: core: fix debugfs UAF on adapter removal

 drivers/i2c/busses/i2c-designware-platdrv.c |  2 +-
 drivers/i2c/busses/i2c-imx-lpi2c.c          | 27 +++++++++++++++++++++++----
 drivers/i2c/busses/i2c-qcom-cci.c           | 11 ++++-------
 drivers/i2c/busses/i2c-qcom-geni.c          |  4 ++--
 drivers/i2c/i2c-core-base.c                 |  6 ++++++
 drivers/i2c/i2c-mux.c                       |  1 +
 6 files changed, 37 insertions(+), 14 deletions(-)
