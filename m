Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8383054C7;
	Sat,  1 Aug 2026 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785573958; cv=none; b=YZYaDgGKNcmvL6/nBeiz8uYrYtTlKalj2PITFxRbFOWYQwiJPdc3K1uu2ioipuAuMjydwLMxoSjR9iEZhDt0elFLNkfGV74Jd6MQWg95dNiDe6PViddIA79cbDo6cO7gWl9gMxJg+C09sLZdDNxT33yumsdH3+39pPx1MYx0A6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785573958; c=relaxed/simple;
	bh=zCAxEljrur9odA+qh0nM4P/FHuvKPbxW2hIadiZdFMk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VOC7vcNu4yyBKMgKbUHXSZuarR66r1c2KNxonBr2JxEiFNfnnop37oTf9B8YvuPh0balzejyZMGn+6qKktakRmFV2hhJFZOYnlX1s2WUV+MjrYDCnvuaYMgWnHEbTcevuqUXskGI3/hC/7gPBpeuVcFHsCio4sAbBqrwi0RYpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eylcH71H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eylcH71H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5851F00AC4;
	Sat,  1 Aug 2026 08:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785573956;
	bh=iSX0L0nxWq4IppLTFIgpwh06rcMhTSaZJTIQeiq/T1s=;
	h=Date:From:To:Cc:Subject;
	b=eylcH71HyJwDwbfIsBycrP0DbM9tDeHrLJfy61pCXw6ZqgMd5LG2z/EGQ/PW2oZXM
	 OWR606XDIai+oh0Kwd1BzuwIy/A8rSGULj/uZHCxPGImkiweQPE+h4KqqcZf/NTsmX
	 MrRiNmkpXZXdnJWwihbKQ99SrSJgU44srP/c+k7rehxyGxF0tY4hxgLjaNoria6Bdu
	 5VWS6wIngrl3YxUeNr00sU/d7a13V2UseWCsgK38i9TbNprypDMSlJGstlM7cR+sxZ
	 NAhuH27434tpDfTVzPhOZmNYCDPqUkBfo43v7/xI9k/6zw1kbCVt3/mlFZKLl/rwIE
	 Uep9pQYFm6ThQ==
Date: Sat, 1 Aug 2026 10:45:52 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c fixes for v7.2-rc6
Message-ID: <am2wqRZRr--FHRR0@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

given the holiday period, I squeezed two fixes cycles in this
request for -rc6.

It contains a set of fixes across several host controller
drivers. The largest part addresses three issues in the i.MX
driver, while the remaining changes fix probe ordering, power
management, timeout recovery and error handling.

Thanks,
Andi

The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-fixes-7.2-rc6

for you to fetch changes up to b08c9857aa1f5f3a81d375d6d4bb1d8b92f22ebc:

  i2c: qcom-cci: drop custom suspend/resume and rely on runtime PM helpers (2026-07-28 23:34:16 +0200)

----------------------------------------------------------------
i2c-fixes for v7.2-rc6

- amd-mp2: unregister callback if adapter registration fails
- designware: defer probe until child GPIO controllers are bound
- imx:
  - mark adapter suspended while hardware is powered down
  - fix stale slave pointer and shared IRQ registration race
  - stop slave timer before clearing slave pointer
- iproc: reset controller if START_BUSY remains set after timeout
- jz4780: cache clock rate to avoid clk_get_rate() deadlock
- qcom-cci: rely on runtime PM helpers for system sleep
- spacemit: request interrupt after clock initialization

----------------------------------------------------------------
Carlos Song (1):
      i2c: imx: mark I2C adapter when hardware is powered down

H. Nikolaus Schaller (1):
      i2c: jz4780: Cache host clock rate at probe to prevent CCF prepare_lock deadlock

Hardik Prakash (1):
      i2c: designware: defer probe if child GpioInt controllers are not bound

Jonas Gorski (1):
      i2c: iproc: reset bus after timeout if START_BUSY is stuck

Liem (2):
      i2c: imx: Fix slave registration race and error handling
      i2c: imx: Cancel hrtimer before clearing slave pointer

Linmao Li (1):
      i2c: spacemit: request IRQ after controller initialization

Myeonghun Pak (1):
      i2c: amd-mp2: Unregister callback on adapter add failure

Wenmeng Liu (1):
      i2c: qcom-cci: drop custom suspend/resume and rely on runtime PM helpers

 drivers/i2c/busses/i2c-amd-mp2-plat.c       |  4 +++-
 drivers/i2c/busses/i2c-bcm-iproc.c          | 11 +++++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-imx.c                | 54 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/i2c/busses/i2c-jz4780.c             |  5 ++++-
 drivers/i2c/busses/i2c-k1.c                 | 10 +++++-----
 drivers/i2c/busses/i2c-qcom-cci.c           | 18 +-----------------
 7 files changed, 153 insertions(+), 29 deletions(-)
