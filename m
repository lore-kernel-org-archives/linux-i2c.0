Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62A41B8DC;
	Mon, 24 Aug 2026 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572544; cv=none; b=CHjHFGjy06GA8alWZiS3vMrn5yQOTBOrAPsvHvBU+plElHb3bngyzP4is6vX+9p9Z3uJnUrlRliEi6CrnA251ZVf/78mztuBOYsm0ANx9wOHxypuROsaYR0mqkJWGRJkCzVcnPCxRgdhYcVr5n/uLN+0QugvK5dUMotEevGIZQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572544; c=relaxed/simple;
	bh=cGf1sygcGiPhHd3XxC+6Aa5kx/Y9r11a8kNuqKnpo5o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LuFyAOnz2n3XU5JkCKjMeDl+SnSN6/jYu4qGL4PNX4/qFLvn1oesSdyNG/m+IMdUpn7FhA/q2IMDaXG0Rt719iEYexypgtvVRagmjX0hcnuM0aXsDk9iMFH+GggYbFi8rls8WAx/IwXjhTuEwO6eRlhaChViVK3fOLlAx6JoTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwjIyjOd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwjIyjOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357371F000E9;
	Mon, 24 Aug 2026 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787572543;
	bh=M4gsGnhVYSkdID2J6IDzNAR2N4/SfkC6YX47f6yp+ko=;
	h=Date:From:To:Cc:Subject;
	b=FwjIyjOdMHrLDCbFQTEtkVyVFEn1kgyxaEZPqWpirN86Emkmrx0DDaes8I3RQaUQc
	 1MlBDQsWyQUf4tn6QLpuo9ViY+stbFPTLhV2lWUlXiCUR93L/WEMRfcrm8DWR3Xe33
	 R/TbGx/tWkM/P2/Dal3pOIDp6WnUXyQ6Qu83G/kt6E5gmPjChrUqVwVe1UbwahtKWp
	 l0hVdtNx7w3hSyeNs3T4pQFrVVJDP764GrkyOxIxgsV423DL5yGNF+lLT4aHWyogX+
	 ajQaWouA6a/Iz/zMhnd83ib7FozeEuVl4IGcGJJ727nx8W8DKeZz0maJ7SteXWK5pG
	 ZTF0sd+5cvMaQ==
Date: Mon, 24 Aug 2026 13:55:39 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c for v7.3, part 2
Message-ID: <aowtbUKLY8W2kln8@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

as anticipated, here is the second part of the I2C pull request
for v7.3. I waited a little before sending it because I wanted
to give the branch a few more days of testing after merging the
Rust pull request.

It contains a few small fixes and cleanups around probe error
handling, resource management and a minor Rust cleanup.

(I added this short introduction to the tag log, as I noticed
you copied it from there in the past.)

The branch is rebased onto your I2C part 1 merge commit.

That should be all from I2C for v7.3.

Thank you,
Andi

The following changes since commit abea5c349368a683e40fdc2e745099aaaacc89d7:

  Merge tag 'i2c-7.3-part1' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux (2026-08-19 09:23:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.3-part2

for you to fetch changes up to d576a9561a1c80ae593539fb0ce0743d66825ac2:

  Merge tag 'rust-i2c-for-7.3' into i2c/i2c (2026-08-22 14:19:34 +0200)

----------------------------------------------------------------
i2c for v7.3, part 2

Fixes and cleanups around probe error handling, resource
management and a minor Rust cleanup.

Drivers:
- several drivers: drop duplicate IRQ error reporting
- imx-lpi2c: improve probe initialization and error cleanup
- mxs: fix DMA channel leak on probe failure
- ocores: fix clock cleanup on resume failure
- rcar: handle reset controllers without status support

Muxes:
- demux-pinctrl: fix OF node leak on allocation failure

Rust:
- mark trivial I2cAdapter reference-counting methods inline

----------------------------------------------------------------
Andi Shyti (1):
      Merge tag 'rust-i2c-for-7.3' into i2c/i2c

Carlos Song (2):
      i2c: imx-lpi2c: properly unwind resources on probe failure
      i2c: imx-lpi2c: reset controller in probe stage

Linkai Gong (1):
      i2c: mux: demux-pinctrl: fix OF node leak on kstrdup failure

Nicolás Antinori (1):
      i2c: rust: mark I2cAdapter methods as inline

Pei Xiao (1):
      i2c: busses: drop redundant dev_err_probe() around irq helpers

Ruoyu Wang (2):
      i2c: ocores: Disable clock on failed resume
      i2c: mxs: fix DMA channel leak on probe error

Wolfram Sang (1):
      i2c: rcar: fix reset handling for Gen5

 drivers/i2c/busses/i2c-amd-asf-plat.c      |  4 ++--
 drivers/i2c/busses/i2c-bcm-iproc.c         |  3 +--
 drivers/i2c/busses/i2c-gxp.c               |  2 +-
 drivers/i2c/busses/i2c-hisi.c              |  2 +-
 drivers/i2c/busses/i2c-imx-lpi2c.c         | 40 ++++++++++++++++++++++++++++------------
 drivers/i2c/busses/i2c-imx.c               |  2 +-
 drivers/i2c/busses/i2c-k1.c                |  4 ++--
 drivers/i2c/busses/i2c-ls2x.c              |  2 +-
 drivers/i2c/busses/i2c-microchip-corei2c.c |  3 +--
 drivers/i2c/busses/i2c-mlxbf.c             |  2 +-
 drivers/i2c/busses/i2c-mxs.c               |  5 +----
 drivers/i2c/busses/i2c-nomadik.c           |  3 +--
 drivers/i2c/busses/i2c-ocores.c            |  6 +++++-
 drivers/i2c/busses/i2c-qcom-geni.c         |  3 +--
 drivers/i2c/busses/i2c-rcar.c              | 27 ++++++++++++---------------
 drivers/i2c/busses/i2c-riic.c              |  3 +--
 drivers/i2c/busses/i2c-rzv2m.c             |  2 +-
 drivers/i2c/busses/i2c-sprd.c              |  4 +---
 drivers/i2c/busses/i2c-st.c                |  3 +--
 drivers/i2c/busses/i2c-stm32f4.c           |  6 ++----
 drivers/i2c/busses/i2c-stm32f7.c           |  4 ++--
 drivers/i2c/busses/i2c-sun6i-p2wi.c        |  4 +---
 drivers/i2c/busses/i2c-synquacer.c         |  2 +-
 drivers/i2c/busses/i2c-uniphier-f.c        |  2 +-
 drivers/i2c/busses/i2c-uniphier.c          |  2 +-
 drivers/i2c/busses/i2c-viai2c-wmt.c        |  3 +--
 drivers/i2c/busses/i2c-viai2c-zhaoxin.c    |  3 +--
 drivers/i2c/busses/i2c-xlp9xx.c            |  2 +-
 drivers/i2c/muxes/i2c-demux-pinctrl.c      |  1 +
 rust/kernel/i2c.rs                         |  3 +++
 30 files changed, 78 insertions(+), 74 deletions(-
