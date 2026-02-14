Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A8D29D281;
	Sat, 14 Feb 2026 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771110385; cv=none; b=nfrpl1zc7sW+YoAlQpg/dhQKiBaPaWY7HgxLiu/hzefJJ9O8v7cyA3s1IoGoIAyPDIFG4iGv68WPmJ1K5klBDcEuNtZY3OoArtPe/0lsddMMVZtrvDFZkA5tXIGDJSjkpHKARdnjiuopaN9O4MqfAbDLk4qx0hfSeBfoxdX08T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771110385; c=relaxed/simple;
	bh=ZC2qAkYYp6f7Ld3CaV3YmeydmPPBNOl4INl2IoyQHjA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aVR7JQNsH6ylXREWn+K6F4O66+2cQCnXnWU/t8VgsDZ3FJkPUPNqk7TbmdHj9Aldnu9EsGguvML4mYPi2vUfsqCyaZmYt3lsbGK8HTUN1kraghjAptth3GimNVazCqMkfeoOIZDFWm1PiuBw2V091wQGa7q6QODdGFQXuytutjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayrcqKN2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayrcqKN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD847C16AAE;
	Sat, 14 Feb 2026 23:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771110385;
	bh=ZC2qAkYYp6f7Ld3CaV3YmeydmPPBNOl4INl2IoyQHjA=;
	h=Date:From:To:Cc:Subject:From;
	b=ayrcqKN2bNbmM9q32AXI9uqKOGyVyfVtD90XWM3UJc36r4dIEFCn9no0+lrDryCe6
	 KpIuuNTQnVQgz+uRaCkmyhfzf5XdJ45bO6GJAi7c+qrkNkSBohXKLlSZjKBEV4PUbT
	 QWepvChKFUYDaLikNvmNX78yvfr2ghy8nXoNh+5C+xFILwEgdnHc4Jsa3dSSWb4iBX
	 FNzpw/muUr8rbhLQPwtNywxgRULpE91I0TvTj91AqnsDNGpe5c80qJ3/x+Wg1fHVvg
	 BH4vI80CoWr27R2gwMJ2AxZ0hHcId8RFlNmUXhhzRQtRYx0VzhE4ha3BEuD4yJW7eC
	 AFYN9mWkvJqPw==
Date: Sun, 15 Feb 2026 00:06:20 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c-host for v6.20, part 2
Message-ID: <aZD9aby8PsJHlq5T@zenone.zhora.eu>
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

as agreed, here is the second part of the merge window pull
request.

I did not carry over anything from last week. All patches
included here have been in my branches for roughly two weeks and
should be safe to merge at this point.

This pull request mainly contains designware updates for
I2C_M_STOP, runtime PM handling, and START/STOP limitations, plus
qcs8300-cci support and a few amd8111 cleanups.

Thank you,
Andi

The following changes since commit 51e8ce3630878fa6083e1eec84f58f49ec85089b:

  i2c: designware: Remove an unnecessary condition (2026-01-22 14:43:57 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c-host-6.20-pt2

for you to fetch changes up to 079a015b5a630a87632f5585247d1ff7fd80086b:

  dt-bindings: i2c: Add CP2112 HID USB to SMBus Bridge (2026-02-07 01:20:05 +0100)

----------------------------------------------------------------
i2c-host for v6.20, part 2

designware:
- refactor the transfer path to support I2C_M_STOP
- handle pm runtime by using the active auto try macros
- handle controllers lacking explicit START and STOP conditions
- general cleanups

qualcomm: add support for qcs8300-cci
amd8111: general cleanups

----------------------------------------------------------------
Andy Shevchenko (1):
      i2c: designware: Remove dead code in AMD ISP case

Artem Shimko (2):
      i2c: designware-platdrv: simplify reset control
      i2c: designware-platdrv: fix cleanup on probe failure

Benoît Monin (3):
      i2c: designware: Implement I2C_M_STOP support
      i2c: designware: Use runtime PM macro for auto-cleanup
      i2c: designware: Support of controller with IC_EMPTYFIFO_HOLD_MASTER disabled

Danny Kaehn (1):
      dt-bindings: i2c: Add CP2112 HID USB to SMBus Bridge

Filippo Muscherà (2):
      i2c: amd8111: Remove spaces in MODULE_* macros
      i2c: amd8111: switch to devm_ functions

Nihal Kumar Gupta (1):
      dt-bindings: i2c: qcom-cci: Document qcs8300 compatible

 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml  |   2 +
 Documentation/devicetree/bindings/i2c/silabs,cp2112.yaml | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-amd8111.c                         |  30 +++++---------
 drivers/i2c/busses/i2c-designware-amdisp.c               |  13 +-----
 drivers/i2c/busses/i2c-designware-common.c               |  20 ++++++++++
 drivers/i2c/busses/i2c-designware-core.h                 |   3 ++
 drivers/i2c/busses/i2c-designware-master.c               | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 drivers/i2c/busses/i2c-designware-platdrv.c              |  42 +++++++-------------
 8 files changed, 266 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/silabs,cp2112.yaml
