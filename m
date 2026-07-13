Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1414369D6D
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927236; cv=none; b=jeyprZ498k22gXzufynZHrmueZEiyUA4NhsI/3jPWtPghyaXZO1xofnlvNtD22NTSF2OcwOQxgG38oU01MfGQyuiRDvsae0sNTsPUIEBm77+oW2YHJkx89RXFrhBTmazlpLoU/E1LXNqjlAQdUo5wjFL/pzVDqMY+zObO2oO5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927236; c=relaxed/simple;
	bh=lBVOEHcgR/+EUN3QZeEazgbQy7z8mFKpITAKUv2savI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N/JvRTLHab1XDklt1/IuxHJzRG9GFgNHkp+N4BjfqU0hRkwCzUvLfLr8vLHeWoQDUSShZQO/lRLhvdULE4R6HdQCVWJou5aj7pfkB4Y/bGkNkEh0CGGn2w/fJjCzUaK2N67WU3X4u1ltNGyHLRgP7ly66W9RYodmaLkTwwtIfCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4JKa5rR; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4JKa5rR"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c62764c7cso31570451fa.0
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 00:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783927233; x=1784532033; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y0qmoCVXgpX+u8fgoHxAJQh+CGwEp5tlW1YVdGxVV00=;
        b=O4JKa5rR+32rdeqLlyPF1rO+IxyQhH2GXSEzppJkC5cW4s9Hg29qWTZcUHge15pnpg
         RaAIdI8IuKDtyXeSY7bSZb9+tiipCyUltciABzcSFM6D1jsuALXAdZYxUeEe2FQgfaNy
         rsBPPubcZk9yn9yixEUU59AVIhFdlU3WA723A8+UxheJYpJ+NIUK9Y7Kfbq3UVgBh3nv
         dqJmTeyqQ3Z51UHP7CMKbqb//ksO5Wflawniv+ekydr4yT7aykJcBmFu8ZNw7tbPZKBm
         vsJPh1fz3Eez/797oUj8BzVYIwjhHcvXGPxN4op+wI1jDgV/1nrR9Zn7LdrSD5ttP0bt
         njYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927233; x=1784532033;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y0qmoCVXgpX+u8fgoHxAJQh+CGwEp5tlW1YVdGxVV00=;
        b=JtQE0qOfpcsh+2kvfQ8Mws7vaXiNQ82PqiV0AHqt73yyY/nHdZLuZB3FFvLa887peD
         vNWjicxFr9NNR9XdocDR3u7Cq93fEVI7CZrN29hKoiyD35W/gg/xf9cLQTz5OPAwaMSj
         nYkSX59gruvAYbhPljaizK4csj93VJ7cEBRZuN0hXtdc+hqOZ1GSwKASN9oHYhA72SOF
         aU2+cYMwrHgQf136XLx+mjV5hARI8v7oLQDofksPQCHXsFIRTUm0u+F0U7yekKKZHPAD
         WPL0Gcc02C3fDL2eH0eV69B+3S0MzfvtUN+1BhL+YHYeAPfU7deJqBo5EMYYghaqzLHV
         Mmdw==
X-Gm-Message-State: AOJu0YzYSXCXkMfDSk5Rt+DO43iH7bLHFJ7fV5YfOnOUyXvxAaxY7J4W
	q64L8z0RviYA/wRC7UxQKi9XCbRISfwSjoKmK/ftuZcsVXusmoELw7cZ
X-Gm-Gg: AfdE7cn8dtmzV9b079rDfbpUiC5XyHXWy4lNDtfE1UQb53PMOhKFYdPl8ipRkKmIS2/
	kZeWi636WWBnYvY8j9/fd9uXSU+F3XvFq0GQEH+f/8h04CdnhDiuGpjBvFXqKX3+QlfUn0G9UFg
	z0HwdvL2fmETJ0j6rQl8tDEtied5AJbKvdYU2CciyROEPwwsNBj32Nz2V7EtqyWtNt78Y46BiiH
	+9RKVMn/fx09teu+nIHNmJ2tfm4AxxLhvmEVHe59ahrp7VP2n7N64MR5plmQ9KLGi5a5Qj3HzGx
	OxyxRBwd5wMd5wLI+gaICY8j8xP0mn5PeZJKHp9PwZVhCLGHrZ9/fEqKBIDsBUe9W+2yXO7fekm
	BHFXyhyiu3OXOMYj9VvtAmJBdUjqF7O0EL07BRz4uTFyLUaPkdWUwcyUFLvDMa1uNAfKWrAR50k
	kETluWDn3STB63c7mO/qLt6fO0pATutUXVlEj883wG2CVKHkw8Za66L4yMOQ==
X-Received: by 2002:a05:6512:3f26:b0:5b0:15ed:e1a with SMTP id 2adb3069b0e04-5b02ba2ecc6mr1192752e87.26.1783927232778;
        Mon, 13 Jul 2026 00:20:32 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca55723sm2625636e87.35.2026.07.13.00.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:20:32 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v11 0/7] I2C Mux per channel bus speed
Date: Mon, 13 Jul 2026 09:19:56 +0200
Message-Id: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XQy04DMQwF0F+psmaQ7bxZ8R+IRR6eNhJt0QyMi
 qr+O2kFTdRZxsq5vvJZzDwVnsXL5iwmXspcjof6QHzaiLQLhy0PJdeBICANHuVQKA3779MQAYz
 MTIFVFvX358RjOd2i3t7re1fmr+P0c0te8Dr9yyC6Zyw4wEAueRUMgpfwut2H8vGcjntxzVjo7
 hCgc1RdNN5po1L22jw62TmC5mR1HlxIOo21iHx06t8ZQHLNqeoys/KJyZq06qmbo+5Gi65ujJT
 i6L31cbXP9M40Z649I5PjNGbLK2c7R90+Wx0nqyOhsujCo3PNSVTNuVtPtNIFlUdYOd856pyvT
 pOnCAYcqVVPhAYtdAdFqBJ8TgFkcgF1Ly+Xyy+yuh7ymQIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5783;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=lBVOEHcgR/+EUN3QZeEazgbQy7z8mFKpITAKUv2savI=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqVJGryXqXPvdGut8q8BY2A4SyIBuk8mJ0cXEH/
 A/GVMJdv9yJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalSRqwAKCRCIgE5vWV1S
 Ml5fEADP8Om4hZTbY9dK0Vc4VU/u7lsZodbe2Yo+9lEAT4bqA3bUk3EK8Cc6e1iXGwRwtVhWrUh
 52rdPf2i9b/GJowi0zTO6qlMMxUiNU3O56Wc2aAYMTOfepqMbCMvnSB9wFkufYOrHUrBXGnwwoo
 y3iau21PXBW/Fom8Q/LweNixNeL1g2ublUmvhRMdlYt35f8mW9iWabFZ444HcKG0VcoJu7JrUc/
 UbrV198oKggwODbPu7cJq+moWxOgYip0m38UByFNFgiXe1JRrgSbbvWKlGrWe91hY6/j3asRaXP
 xaYhn9I+UU8XiL/CQKhQckuDpKnXnTdQvq558oDYoDwx82jSrUBmm3RLmYZFyxK1osXUFw0ZsOK
 NO1IUQHSzqiJmox/jXXBnely7WpuO8eWZ46sDPobnOLY+5W2+iwxhT2/85TpcdzfQmIij39kPdd
 l+YYK78dtbzsFO/cuM1tRi+n6rhw+Mlt+hGF6GaqrCTotP7ekSr04h6lYRvc8SEvBw46DQaKAqZ
 fkTPdE+0VBwnSHCAOeZ1momRrCnhViYm745WadeUHH/c6r+EINCBqh7zh83CfAwpSGIFpZt234+
 LYBBX0wi46P2mp6WVEmcxYlzfNt+wCAab7dJQ2UJdwt8xM06QSl0mNRs1XNJDPBxAf2VcxLYKur
 xLGDINN7deq7g+A==
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
Changes in v11:
- Rebased on i2c-next
- Use _Hz instead of _hz for local variables in i2c-davinci.c.
- Link to v10: https://patch.msgid.link/20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com

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
 drivers/i2c/busses/i2c-davinci.c    |  35 +++++--
 drivers/i2c/i2c-mux.c               | 162 +++++++++++++++++++++++++++++---
 drivers/i2c/muxes/i2c-mux-ltc4306.c |   3 +
 include/linux/i2c-mux.h             |  26 ++++++
 include/linux/i2c.h                 |   5 +
 6 files changed, 388 insertions(+), 21 deletions(-)
---
base-commit: 8dddadd35e2acf1d8a5f840df428f9c34770bb9c
change-id: 20250913-i2c-mux-b0063de2ae4d

Best regards,
--  
Marcus Folkesson <marcus.folkesson@gmail.com>

