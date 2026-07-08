Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A12042087C
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513006; cv=none; b=j9TDyaRhwvSovzZfkZe7ngzZVYOzC2C3+eGIVICckZOXGj+HRipFGz22jTN9HZLdK5Q5G9otUg/TKiO1MAQkM77Lv/tyNSBtIbT7y/KSd8vxD3sOTfEz1jBubW6CgKm0Pcw6wsDWg768wT8XYfwNk98Ct7NqItJTX9AIXpuzIuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513006; c=relaxed/simple;
	bh=UH6WXd1A7TOA+jomnMou8AxdHi42KaWaeRP10BptZIg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oy+NqDDMN3fDL4FLKlSENkME3tF2vxOv3845J7g/exwp6dLvK3rlnLYR73tGXkk+uj88Hwg1kQ9wWlchZAsy/3GiKMvkM5mSo9PRfzxifzDZ8rUCTAc/BJmLSekhA+e53IRUGOGFPnVBB5ciCF4TfZM69qe93Sovu2K1ItMplYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i71yOstG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i71yOstG"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso579743e87.2
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783513003; x=1784117803; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H6h1ekmaSTtjJSpPBZJdBYqSUeMJt6eOzQLcvOzljDs=;
        b=i71yOstG7aXZRY1L5XLmUh/djtJVNU2xUyc1rc/zJ8SZnTcyBThi8+IJOSXv8gEVxD
         fYf/43J4b/Dej4DOAI7hOMqPySIhFI13YzwnnRWECByCAKfBSWD9qazc0XtAuNhcBnNI
         i8+B0NMRG8Har2DlFFvBAReNpNFbC/2ij5NwOlYB3bJATFcFWjNeA6VBURusEQS2Issj
         1R/pnVxSqnTViVKcO/rcKh7JqwX6NPxy6Gy8g/hxzi2FX6I/5qUFAmuFOIBQBz10GOgu
         vpxE4lnB1rUGcJHt/tWvw1/87P4ae/KkovCX/bicNnM0CXhxgsivyIQR22YvRgsr4AkN
         UmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783513003; x=1784117803;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H6h1ekmaSTtjJSpPBZJdBYqSUeMJt6eOzQLcvOzljDs=;
        b=K7JIJN5djkQivR3MflGNLQxotkfgD1Y/1iOy7JWo3+oaknWXJLMPpgwPboQLXbtF3H
         +xCqVCaRTkE0K9Uu/DgSugtz99tHfLelpwUbhQt73T788bbL2IMpedjgqvfbaiPiI2vB
         gW1tMQ2Bz/qxi5o40sHKsvlg3zHfDKQ0s9eMMkvX349nJEJ2hBMKYFfB2ExUIknCmZxw
         PGjSludNRkoOYDo6UrZmvZ1NqGesBvDRpLcdLBIUqangWHf/eQuO8021vckb5wD/QMlx
         KRhAJnRPXQaD01mp0zykKy7iAxh4paLphLSfINlfYOKARudJ1N0tImhXMqYxu5nh1UU1
         R9ww==
X-Gm-Message-State: AOJu0YxXIc8rY3WsfRvhNYrXMTnxUJC087YgzmQ//QIpNqjRAnTDiVL0
	6XIaP6v9qYSDlxeSOgtCNPfIo+lEBvtnPC1ct/O5ezus8ToZ5+GILb4G
X-Gm-Gg: AfdE7ckbKvYtt92whw0I/qvpQlkdcyoR0SIFLRfR4V43SoMBTn/nI09QH1TKVBm0P3F
	NQGwe0r2YEwX8ztE5Q3lDUzNrW7ina2bQS6SAqZoqXr/shtjMpF/VoB3wFwONTr/lZwsxsOVkGD
	zCOcBzHzSNkqtl5FSew/6IEYeecqdHgO2mhqg3EFt7FWymgZljFqZr7lF/5BTOnyX70qJzpxGJM
	clLX3Pd4EWTb8OdSSzsOeR5lyxMow2MHryhTSh1LIvkl2t0os/jtCFdjgy9Qir6mdglVVenfBAK
	Vzv4EhoB+i89pokCzLJI7wpOtJ94gFtGDE5kc0dQUBlr8X/h9PyVszeDpR1yFfratcymSK3s08M
	C9GtHigJp01ZskaoDrrSraZICrT5rNiiSzgVafHKs2Mx+HVGPkI4iCLinzGx9d2N3gaySEWgdfT
	hlaP+yaMVEwAmM4N+8+dxbh8q97DrrUY0oNSb9A3r/JapdybrQNu5Ou76Trg==
X-Received: by 2002:a05:6512:6683:20b0:5ae:b2a0:24af with SMTP id 2adb3069b0e04-5b011499e49mr429897e87.31.1783513003038;
        Wed, 08 Jul 2026 05:16:43 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bbbc6sm4471459e87.41.2026.07.08.05.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:16:41 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v10 0/7] I2C Mux per channel bus speed
Date: Wed, 08 Jul 2026 14:16:12 +0200
Message-Id: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XQy07DMBAF0F+pvCZoPH4OK/4DsfBj0lqiTZVAV
 FT133EraEyznJHPnSufxcRj4Um8bM5i5LlMZTjUQcLTRqRdOGy5K7kuBAIaIKm6gqnbf526CGB
 VZgyss6ivjyP35XSLenuv865Mn8P4fUue5XX7m4F4z5hlBx36RDpYCaTgdbsP5eM5DXtxzZjx7
 iRA47C6aMkbq1MmYx+dahzC4lR1BD4kk/paRD06/ecsSPSL09VlZk2J0dm06mkWh80fzaa6PmK
 KPZGjuLpnW2cXZ689I6Pn1GfHK+cah809Vx0nZyJK7aQPj84vTkm9OH/rKZ3yQeceVo4ah42j6
 gwSRrDgUf/reblcfgCHqbtUXwIAAA==
X-Change-ID: 20250913-i2c-mux-b0063de2ae4d
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Peter Rosin <peda@lysator.liu.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5591;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=UH6WXd1A7TOA+jomnMou8AxdHi42KaWaeRP10BptZIg=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqTj+OvwDeZk9ceUpr4PMRs8vPmEkP/ByqakEf4
 hHbWo6TkKaJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCak4/jgAKCRCIgE5vWV1S
 MmCNEACB6ewGlvwtPSU/0Cx+sIMzVNZgzQJocDBlLz+Q5fAP9nd2SZMSYYt37OFlvP4lH2DH/YV
 Z5lTzmHbl6p6JHx/fSR3dfRCPt/aDPUJNwRJddkQrm2AtNviSi4PfCOvRnV+ODOLkRF9RkcS2O9
 u5k3ZAcYKdtmuQ8wEtNc3GZeAxCqkndGk7rC4uNzRIa9DOYYQMjqkNnwcDc/u/31Hu3q1wFYBxo
 ImHGZmo1D17utpZ7Z9lRuDMUbW2tTW/mHqwIKUi8O5dX4I5M3TU4gonVFuxcKUJt7pB2BJlNXij
 +DOEjHVD531x7o7M55yCHXtN17w42DkE55wEyAsDtwOir62b9yk3K+AUquUEyqkNtkynVCWJDhh
 w5QYIJYmXxBsA8Yfes4mUsPW54vdfc1uZizDqpNDullUBdLnutN8MaTgIji12GedY/WHbxyQazr
 BCzMoXylyDrwi59bDZEOMTHXHLHs095z1yVzhUpjcsZAwVRiQX29/Jop+3UL4HezK+H+pBVGW7h
 VmNA99Y+PTYK8i+ghm2K5Pzc62j2DI/bkSfMYMXrfrTk4E3hYfKacmqLcPBT6P1XkoovcAf7FxD
 4KP/KS5bcS91sgm3EJ+wS5R0ser14gyJzb1EYoAgM6PEvyC7wtRpi4pZDFLTq01PkF0OF8sOe47
 4r1gmzkgoleZjVw==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

This was a RFC on how to implement a feature to have different bus
speeds on different channels with an I2C multiplexer/switch.
As no major complaints on the design came up during the review, I
decided to submit the series without the RFC tag.

The benefit with this feature is that you may group devices after
the fastest bus speed they can handle.
A real-world example is that you could have e.g. a display running @400kHz
and a smart battery running @100kHz using the same I2C controller.

There are many corner cases where this may cause a problem for some
hardware topologies. I've tried to describe those I could think of
in the documentation, see Patch #5.

E.g. one risk is that if the mux driver does not disconnect channels
when Idle, this may cause a higher frequency to "leak" through to
devices that are supposed to run at lower bus speed.
This is not only a "problem" for changing bus speed but could also be
an issue for potential address conflicts.

This patchset has been used and tested heavily the last months
on a custom board based on a da850 (DaVinci) platform.

The implementation is split up into several patches:

Patch #1 Introduce a callback for the i2c controller to set bus speed
Patch #2 Introduce functionality to adjust bus speed depending on mux
         channel.
Patch #3 Cleanup i2c-davinci driver a bit to prepare it for set_clk_freq
Parch #4 Implement set_clk_freq for the i2c-davinci driver
Parch #5 Update documentation with this feature

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Changes in v10:

- Fix gramatics in documentation
- Move {__,}i2c_adapter_set_clk_freq() to i2c-mux.c
- Make set_clk_freq() return actual frequency
- Reimplement idle_state (from earlier version)
- Implement example on idle_state for ltc4306
- Link to v9: https://lore.kernel.org/r/20260324-i2c-mux-v9-0-5292b0608243@gmail.com

Changes in v9:
- Fix stray blank line
- Link to v8: https://lore.kernel.org/r/20260314-i2c-mux-v8-0-fb1738a4df0a@gmail.com

Changes in v8:
- Fix gramatics and change %d to %u were appropriate
- Link to v7: https://lore.kernel.org/r/20260223-i2c-mux-v7-0-ec75b214718a@gmail.com

Changes in v7:
- Remove code for finding first mux-locked ancestor
- Introduce a unlocked (i2c_adapter_set_clk_freq) and unlocked
  (__i2c_adapter_set_clk_freq) variant
- Let the locking be handled in __i2c_adapter_set_clk_freq
- Use I2C_MAX_STANDARD_MODE_FREQ instead of magic numbers where
  appropriate 
- Link to v6: https://lore.kernel.org/r/20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com

Changes in v6:
- Change logic to find which ancestor to lock with I2C_LOCK_ROOT_ADAPTER
  It now find the first mux-locked ancestor and then lock its parent.

- Remove bus_freq_hz in i2c-davinci and only use clock_hz instead
- Mention in commit message that clock_hz can be used to store frequency in an uniform way

- Swap order for change freq/deselect to keep symmetry
- Only allow bus frequency to be lowered in select()
  This to not allow an intermediate frequency to be set when it is not
  supposed to

- check if(ret) instead of ret(<0) where appropriate
- Fix typos in documentation
- Change i2c_adapter.clock_hz from int to u32
- Simplify i2c_adapter_set_clk_freq() by removing 'ret'
- Link to v5: https://lore.kernel.org/r/20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com

Changes in v5:
- Take the lock of the top-most mutex locked mux to make sure that the
  root is locked
- Link to v4: https://lore.kernel.org/r/20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com

Changes in v4:
- Rebase on master
- Swap order for printing warning about "channel %u is slower than
  parent on a non parent-locked mux\n"
- Fix typo in comment, adaper->adapter
- Link to v3: https://lore.kernel.org/r/20251020-i2c-mux-v3-0-908ac5cf9223@gmail.com

Changes in v3:
- Return -EINVAL if channel is faster than parent (kernel test robot)
- Link to v2: https://lore.kernel.org/r/20251002-i2c-mux-v2-0-b698564cd956@gmail.com

Changes in v2:
- Changed bus_freq field to bus_freq_hz in davinci_i2c_dev (Bartosz Golaszewski)
- Removed idle_state from mux core (Peter Rosin)
- Link to v1: https://lore.kernel.org/r/20250922-i2c-mux-v1-0-28c94a610930@gmail.com

To: Andi Shyti <andi.shyti@kernel.org>
To: Peter Rosin <peda@lysator.liu.se>
To: Bartosz Golaszewski <brgl@kernel.org>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

---
Marcus Folkesson (7):
      i2c: core: add callback to change bus frequency
      i2c: mux: add idle_state property to i2c_mux_core
      i2c: mux: add support for per channel bus frequency
      i2c: davinci: calculate bus freq from Hz instead of kHz
      i2c: davinci: add support for setting bus frequency
      i2c: mux: ltc4306: set correct idle_state in i2c_mux_core
      docs: i2c: i2c-topology: add section about bus speed

 Documentation/i2c/i2c-topology.rst  | 178 ++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-davinci.c    |  39 +++++---
 drivers/i2c/i2c-mux.c               | 162 +++++++++++++++++++++++++++++---
 drivers/i2c/muxes/i2c-mux-ltc4306.c |   3 +
 include/linux/i2c-mux.h             |  26 ++++++
 include/linux/i2c.h                 |   5 +
 6 files changed, 389 insertions(+), 24 deletions(-)
---
base-commit: 50938ff6aa9a0e5d5a3e647f976286f4c5bd1b06
change-id: 20250913-i2c-mux-b0063de2ae4d

Best regards,
--  
Marcus Folkesson <marcus.folkesson@gmail.com>

