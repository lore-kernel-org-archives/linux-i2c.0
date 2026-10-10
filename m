Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5D3BFE59;
	Sat, 10 Oct 2026 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626770; cv=none; b=t+IN+ts8Os3ZdsyjgYDqvdjHj30wimC5ENJxjNtYPRVEZJ2ofmDvDLR1qRut3kJxPUuQUuZImwObTHrgSffuhEF7rrPlQE6gX9e4laj5OkNWQYFfBD9JSzXiR/WrKBnZkLYqefsi1qxCsx51EFYM0h5plnq2UJkwaYyJ/JvohPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626770; c=relaxed/simple;
	bh=ugRe0RPK621CZhwbVIwjRYB/eZRE+rQusl7Ujhfd0BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u+QoCKN4OXVsUZowA0aocg6DunqT5PKETiKDChyV+AozKafnBO0CD3QgUVBg2cnyhL9Tr3ikmzLzNlCt9ezXyrY7B7sBhLTtkN+mhbiMiueTPkz71Rd5eNatMWfNw+pe+m+ZH3YYBs4etXh3y/OLOeBiOHjd6t7Zni9a8OrHz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMcjYGL1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMcjYGL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180421F000FF;
	Sat, 10 Oct 2026 10:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791626769;
	bh=YP1uXm9bdc9erifrxlt6kFrrffVtFg5eyWFWAtgdl5U=;
	h=Date:From:To:Cc:Subject;
	b=OMcjYGL1IWmAr/NtBG4hfN+SxvwkyNgLTcclzP7YtoW2EuP44E2Oio6c9N6QJ05xT
	 u+jYvWMdcVJUJSZ4wsr1cqffXvwFKOTie8zPHyPiPtSx4BtlY6zqqsdtpm0gkrHS34
	 xyyx0TeNKsu4A/zuotzWJaz+TSxpUfXlDA8M1Mh/EhR11YRUzey8IkwdaCkDhUZSg2
	 C2J3Uq99XzBD7UYFFMP984INEN75gcEjflwXfpkRnlwDP0ReS4DZZdp16G6V81d8QP
	 EMn2Rjo3tMOBTPB5nEvgDab2oQbcqvtS9tFrEZKh+v5gGBtlMzxkZAEEWu6Y+Ychmb
	 K46oVhtxoqkSw==
Date: Sat, 10 Oct 2026 12:06:04 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c fixes for v7.3-rc7
Message-ID: <asoNklC8eK-gbsUD@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

here is the I2C fixes pull request for v7.3-rc7.

There is just one qcom-geni fix for a runtime PM reference leak
during transfer setup.

Thanks,
Andi

The following changes since commit a90ee4305c4a5df72c11b31dacfdc76e00fcf78a:

  Linux 7.3-rc6 (2026-10-04 13:45:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.3-rc7

for you to fetch changes up to ae8364085574203e7f4ea961921a1c7493bcb6de:

  i2c: qcom-geni: release runtime PM reference when set_rate fails (2026-10-05 12:10:52 +0200)

----------------------------------------------------------------
i2c-fixes for v7.3-rc7

qcom-geni: fix runtime PM reference leak on xfer

----------------------------------------------------------------
Rahul Pon (1):
      i2c: qcom-geni: release runtime PM reference when set_rate fails

 drivers/i2c/busses/i2c-qcom-geni.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
