Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF03F3BD63B;
	Fri, 27 Mar 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616282; cv=none; b=HTMa0uXLWh7Pa4tuCrjJJXDnQDb3qVJDpTRgb9fD/wXpFVPBWkvclyXWKO9436yNzVv2r0FYea2rXXErZUO0RklWHAoPDQv1uSvltGddwpmHpDp1X9ejC/NHSNWQWbIfkfyiRdgK71iP+4NJJdrk6g8NMCFojzFeIuoKFdLpm0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616282; c=relaxed/simple;
	bh=CRPuBFW5ySU1B//8Y58WVzYgdDh/go+1LEbi+0sdrhE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JLJi3b+mKkBR8aOCUv20IuMOkI4gnr4mHnFKqQsKr0rBRttUwh72zqA7NHrLTRDsuiwAPBtXq+UtbL1vzpGUoVyezwtVync4Bf4H62V3m6L++9YosqDh4Y/BZtoVq4GRamSIZXk+fLS8zyRm8NzQAmKCPSn1JD7ZNMD0TH/UweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWmo0wRX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWmo0wRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302F9C19423;
	Fri, 27 Mar 2026 12:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774616281;
	bh=CRPuBFW5ySU1B//8Y58WVzYgdDh/go+1LEbi+0sdrhE=;
	h=Date:From:To:Cc:Subject:From;
	b=rWmo0wRXJ591uaQmaHosV/ZhEFcHqAGc4pLXi57f5oPV1nDncYHjH2+KmCbMetDa3
	 nFiCRqjT1nMDXU6EBLRhVrbs4sv8XDS2ZXBUWWLLWxbAZgE0gO7/rYe58dwvXwTcmE
	 qsRUpXe7fFDLoKECJj5+lO5e9KGLGVv5UT4zFkR3+5KqZ3y5zErVNtPO/Ou9ByU+Ao
	 WLevsPaWrWQAfB5NlhrjfQT0jBIqKTOZdG8E0DQ0tIeYmCjSxr9H1CQOySDInWTm9i
	 vqKyjzT84CWnraaOdyvU36lSWD8lmYmJ0vk0tqczW1zUhibujx54teKpiu9/b5dUdI
	 3SPMSjrHbIfUQ==
Date: Fri, 27 Mar 2026 13:57:56 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c-host-fixes for v7.0-rc6
Message-ID: <acZnOtLJANk9wbZR@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wolfram,

here is the fixes pull request for v7.0-rc6. It contains three
fixes in designware and imx.

Thanks, and I wish you a great weekend,
Andi

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-host-fixes-7.0-rc6

for you to fetch changes up to e2f1ada8e089dd5a331bcd8b88125ae2af8d188f:

  i2c: designware: amdisp: Fix resume-probe race condition issue (2026-03-27 13:51:21 +0100)

----------------------------------------------------------------
i2c-fixes for v7.0-rcX

designware: fix resume-probe race causing NULL-deref in amdisp
imx: fix timeout on repeated reads and extra clock at end

----------------------------------------------------------------
Pratap Nirujogi (1):
      i2c: designware: amdisp: Fix resume-probe race condition issue

Stefan Eichenberger (2):
      i2c: imx: fix i2c issue when reading multiple messages
      i2c: imx: ensure no clock is generated after last read

 drivers/i2c/busses/i2c-designware-amdisp.c | 11 +++++------
 drivers/i2c/busses/i2c-imx.c               | 51 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 25 deletions(-)
