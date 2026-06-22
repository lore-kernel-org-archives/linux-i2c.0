Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDE235B646;
	Mon, 22 Jun 2026 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118861; cv=none; b=YarnqIXlmU23ent32hwrFoDW0gn9S5vRXvMvSsAtqjNz/jDwfK+DmzTOQjy/4Ib8NWRGo9wW+Hqajs6kkpQpBZ5PvEA58Tgfauw9C+cIi+Swv7AhYHs0QAE0YryA2gbFK0zUchs9xzjpGUw2sgMgsWZkvBpE1E9z5Bcbq4Zr2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118861; c=relaxed/simple;
	bh=qHa4iSRz0OPlO02LKb4RImk/Fqxv/8w5eLCGaICgjZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SUUiHeoa3VbTgryeRZc0dNo6e9Iu8clytjPRpymYPox8Qvu8u+iaxKmcxcP/xDncHy2d04FsTL8sG7qLrW7425/XukfpFADJCAQGgwW3vj8GKphLffBfOqdP+FOYJSOCOuSwtmnAaOa3RYgZcNoVlQOes+zcbfjNwnO4txhAnu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvAHk2nj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvAHk2nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E458A1F00A3A;
	Mon, 22 Jun 2026 09:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782118859;
	bh=ilcWXeqPnil5KLR+nFy8o10WS5tYPnt+e1AMMqwvLM8=;
	h=Date:From:To:Cc:Subject;
	b=bvAHk2njIZSxKyPszZlNPmOhWapw0Z93gLj7vBpZ44yW+BdSDnqPRPeiyDL9r633k
	 x4ywdRfcTbNjygLwNY5HZPh4nOV3M/3thYTOy/H4q3TQPdaZiu3nGsCD1Bbipd0LdT
	 c4JBvayIRc6j5eGMx4a/J6xbtToG9mOYQBvNJjZ00O978nz8FxebA0Q4m+kGI3oU4D
	 sUNppVJ284HpTOsMZJ+Q21Ky5nKQFDsuaMjgf3+roGvsUVx4O9PZ/B9NyXMfUOr10a
	 oiC+q4wVFXmXJFs2/wFu3u3WbDc4M3pvkxN620ZKVNViaceInN+mJl84ZLt/hPa87y
	 knW0g2qEqQ0vg==
Date: Mon, 22 Jun 2026 11:00:53 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c for v7.2, part 2
Message-ID: <ajjUPH75tmYjbUvo@zenone.zhora.eu>
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

here is the second part of the merge window pull request.

I tried to keep this one to a minimum, with only patches
depending on part 1, the latest fixes, a few cleanups across some
drivers and core helpers and a couple of binding updates.

The i2c/i2c-host branch is based on top of your latest i2c merge
commit.

Thank you,
Andi

The following changes since commit 2779759c090ea0e78109a0cad0a81d869adfb459:

  Merge tag 'i2c-7.2-part1' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux (2026-06-16 07:43:29 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.2-part2

for you to fetch changes up to ac930b80c1e0eba283d7843180964e6d2a87369d:

  i2c: pxa: Use named initializers for the platform_device_id array (2026-06-18 12:08:49 +0200)

----------------------------------------------------------------
i2c for v7.2, part 2

- generic cleanups in qcom, qcom-cci and pxa, plus core cleanups
  in algo-bit and atr

Fixes:
- davinci: clean up cpufreq notifier on probe failure
- imx-lpi2c: suspend the adapter while hardware is powered down
- ls2x-v2: return IRQ_HANDLED after servicing error interrupts
- stm32f7: fix timing calculation accuracy

DT bindings:
- microchip: permit resets
- i2c-mux-pinctrl: update maintainer entry
- i2c-mux-reg: convert bindings to DT schema

----------------------------------------------------------------
Abdurrahman Hussain (1):
      dt-bindings: i2c: convert i2c-mux-reg to DT schema

Carlos Song (1):
      i2c: imx-lpi2c: mark I2C adapter when hardware is powered down

Conor Dooley (1):
      dt-bindings: i2c: microchip,corei2c: permit resets

David Carlier (1):
      i2c: ls2x-v2: return IRQ_HANDLED after servicing an error

Guillermo Rodríguez (1):
      i2c: stm32f7: truncate clock period instead of rounding it

Haoxiang Li (1):
      i2c: davinci: Unregister cpufreq notifier on probe failure

Krzysztof Kozlowski (1):
      i2c: qcom: Unify user-visible "Qualcomm" name

Thorsten Blum (2):
      i2c: algo: bit: use str_plural helper in bit_xfer
      i2c: atr: annotate i2c_atr_adap_desc->aliases with __counted_by_ptr

Uwe Kleine-König (The Capable Hub) (1):
      i2c: pxa: Use named initializers for the platform_device_id array

Vladimir Zapolskiy (3):
      i2c: qcom-cci: Do not check return value of cci_init()
      i2c: qcom-cci: Move cci_init() under cci_reset() function
      i2c: qcom-cci: Remove overcautious disable_irq() calls

Wolfram Sang (1):
      dt-bindings: i2c: i2c-mux-pinctrl: change maintainer

 Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml   |  2 +-
 Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt        | 74 ----------------------------------------------------------
 Documentation/devicetree/bindings/i2c/i2c-mux-reg.yaml       | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/i2c/microchip,corei2c.yaml |  3 +++
 drivers/i2c/algos/i2c-algo-bit.c                             |  5 ++--
 drivers/i2c/busses/Kconfig                                   |  2 +-
 drivers/i2c/busses/i2c-davinci.c                             |  4 +++-
 drivers/i2c/busses/i2c-imx-lpi2c.c                           | 15 +++++++++++-
 drivers/i2c/busses/i2c-ls2x-v2.c                             |  2 +-
 drivers/i2c/busses/i2c-pxa.c                                 | 10 ++++----
 drivers/i2c/busses/i2c-qcom-cci.c                            | 48 ++++++++++++++++---------------------
 drivers/i2c/busses/i2c-stm32f7.c                             |  9 +++++--
 include/linux/i2c-atr.h                                      |  2 +-
 13 files changed, 151 insertions(+), 117 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-reg.yaml
