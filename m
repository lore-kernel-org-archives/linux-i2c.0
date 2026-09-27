Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403829D26E;
	Sun, 27 Sep 2026 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790503429; cv=none; b=freN0AQRDD+RGGwA6FLk92XG7L5LJwP7dKAsFyccqAm+5aImTZnkzGqjgCRHiPJagIutq/ezSIdQ4lzYjScuYqgICRtprm0DbGaYAjv6cntwmsZrPhZlH1QoXd3XtlMl8SKl2+vI1BqilvaQzooCz1VDOIQZ4xnwzmD+hPgLwcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790503429; c=relaxed/simple;
	bh=yS7D3PKGt17HrzzprLFopJVoodHQoDVBs1G7BU7B5Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vn0/pVlOMvOmY+YwSXlXdq5SqOBLliL3LoT4BgMwZER3iqNqzs1nnVyal2wKd0l8WN7izXBCl+U82S/A93zm5mTO6Olrl1xnH0oi4BJud+k3US5iZfYgip5VZ0RpKU13LCx7HHeciUd/PoU0xHnmEl9pd7rMSdJvTdPoUkXVCdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOmf88K+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOmf88K+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E190A1F000FF;
	Sun, 27 Sep 2026 10:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790503427;
	bh=qDbKiQM8+c0G4cyeb9xmRXidwHXaAeau7kS17YjyRNo=;
	h=Date:From:To:Cc:Subject;
	b=gOmf88K+U03zi8y88sqGSPH8QbJcWzJ9I0+8qfqUuP9b9xJrnu7E3TjGoplEYoXHr
	 DjzO+4R7rytCMVepGPlR7gcorxVFBcZbYmETpDR69i7HQo48MfUVwQgJ0v7y9tmvVJ
	 nmtWU5TcQIglEHdKMG68S1yfSjUam9GyURRl0DAOGOPB5KeA3jhrDjJLl+3rq4mOar
	 5XmplMHSz9cj4jTC6rfpYFSI3GolE5d4eoY9d5qiwfmJiPeqiyrZToP10da6A5yrbi
	 FdljZEDJnD9aSqIzLdsGM460YWwtE4y2/z7AUHBpiWYa/lbM3o7NmhwXPQXDAmU3bJ
	 Gz+qX5BwcqwjA==
Date: Sun, 27 Sep 2026 12:03:43 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c fixes for v7.3-rc5
Message-ID: <arjpVJwkFP8ozdq_@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

here is the I2C fixes pull request for v7.3-rc5.

There is just one fix correcting the qcom-geni clock selection.

Thanks,
Andi

The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc5

for you to fetch changes up to cb97bf3d4f91453b881acaf8e9f0cc47bb40b604:

  i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL (2026-09-24 22:52:30 +0200)

----------------------------------------------------------------
i2c-fixes for v7.3-rc5

- qcom-geni: select the correct source clock table entry

----------------------------------------------------------------
Viken Dadhaniya (1):
      i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL

 drivers/i2c/busses/i2c-qcom-geni.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)
