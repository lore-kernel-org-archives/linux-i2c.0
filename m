Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917871C2324;
	Fri, 12 Jun 2026 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259113; cv=none; b=nHFoj7g5qUcfBM+rt/obczyPiHzlDU3v5pPq/5ZQzIXddQ19ZY3cZei16HFJDRpeR+67+yW0wMX/RlALou/QI+iCVlXhwBTFNpfki5vnJHvu3IdZBtzzInpTdI7XqWq+dVHyIFKfOdMamgxRkejGFg3AfoJLULcfFMoALA8IDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259113; c=relaxed/simple;
	bh=L5m3IMtjH741cY8D4SEHNeg698ppa12GRtkG45kEoB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H3j2WmMBm9zh/iE+prD5gFZgdk9y/nNBHDDAHJ1qFf2nPkpo+M5M/OnBXBgoUdVlAMD9zuewZMYxS2+qbkUFCMm6k+mYbB1VQtnu5d1KYfGSz08W03chQ6tWLhoENyqktzKchtI89Dotq8g2d5d4/gGL9VHY3Iy9ZBsFRV0eFcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR7Y4ON6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR7Y4ON6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDE91F000E9;
	Fri, 12 Jun 2026 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781259112;
	bh=JbQmRpyg2CxAHDEO75NIinnFIg/1oGb9PJeZsAsO0zI=;
	h=Date:From:To:Cc:Subject;
	b=cR7Y4ON6PXOn3ZZRjzQwTU1vACwmmrBTqiQ61/w4MvsKhzoZ2WTA0tYUElM8TXK0g
	 Iv8q4/hgIEnf/l2CwLS82iQqDssikI3V7EP/68An5piSGiP+xxjXg+sC0Wb3D94RBI
	 7COm7ssn3z25qAhW3495LWklBsaW374L7G8caqC1bh//LxFgGTujX801QT8pgWvIv+
	 i+YjKIe2dXF/jJ0pF3ZBNoF2kVpgBm+rhiCl3c9zizI8BSBrocoG3/Lfb3zHhzgSbs
	 vV+y8YiQesYY+r+wET9HGxXHUMuxsufE0JVrY6QzCh3dag1+0ygV75bCTPh+DssBwq
	 S+CGHnERWFWZg==
Date: Fri, 12 Jun 2026 12:11:48 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c-host-fixes for v7.1-rc8
Message-ID: <aivZw-ahxAAtnTjl@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Wolfram,

here is the i2c-host-fixes pull request for v7.1-rc8. I
expect this to become 7.2, but I am still keeping the usual
versioning inertia.

It contains a somewhat larger set of fixes across several
drivers, as a few of them were still outstanding. It also
includes the MAINTAINERS update.

Thanks a lot for everything, and I wish you a great weekend.
Andi

The following changes since commit 4549871118cf616eecdd2d939f78e3b9e1dddc48:

  Linux 7.1-rc7 (2026-06-07 15:37:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-host-fixes-7.1-rc8

for you to fetch changes up to 9bffa2a61551da9ac32171f09d556974cb96d70a:

  MAINTAINERS: hand over I2C to Andi Shyti (2026-06-12 11:11:58 +0200)

----------------------------------------------------------------
i2c-host-fixes for v7.1-rc8

- imx: keep clock and pinctrl states consistent in runtime PM
- imx-lpi2c: fix DMA resource leaks on PIO fallback
- qcom-cci: fix NULL pointer dereference on remove
- riic: fix reset refcount leak on resume_noirq error path
- stm32f7: account for analog filter in timing computation
- tegra: fix suspend/resume handling in NOIRQ phase
- tegra: update Tegra410 I2C timings to match hardware specs
- MAINTAINERS: hand over I2C maintainership to Andi

----------------------------------------------------------------
Akhil R (2):
      i2c: tegra: Update Tegra410 I2C timing parameters
      i2c: tegra: Fix NOIRQ suspend/resume

Carlos Song (2):
      i2c: imx: fix clock and pinctrl state inconsistency in runtime PM
      i2c: imx-lpi2c: fix resource leaks switching to devm_dma_request_chan()

Guillermo Rodríguez (1):
      i2c: stm32f7: fix timing computation ignoring i2c-analog-filter

Vladimir Zapolskiy (1):
      i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()

Wentao Liang (1):
      i2c: riic: fix refcount leak in riic_i2c_resume_noirq()

Wolfram Sang (1):
      MAINTAINERS: hand over I2C to Andi Shyti

 MAINTAINERS                        |  4 ++--
 drivers/i2c/busses/i2c-imx-lpi2c.c | 53 ++++++++++++++++++++++++++++++++---------------------
 drivers/i2c/busses/i2c-imx.c       | 15 ++++++++++++---
 drivers/i2c/busses/i2c-qcom-cci.c  |  2 +-
 drivers/i2c/busses/i2c-riic.c      |  4 +++-
 drivers/i2c/busses/i2c-stm32f7.c   |  6 +++---
 drivers/i2c/busses/i2c-tegra.c     | 61 ++++++++++++++++++++++++++++++++++---------------------------
 7 files changed, 87 insertions(+), 58 deletions(-)
