Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FD41D5CC6
	for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480149; cv=none; b=W40lCy7OZ4xCfRTtNtmPsvQXkYMamJ1wFBC+T7sEgi6WLalbq6dLGYG7Fdn0P1UcMi8fqAXv2Yw+RASi0b0nq2G/gXDxBM0TgQKuiZIl0Bd4rZT+uRQEZrI1IwmkT+zUU4jBSbpJOh5cILIvo9j57KTuIyEjeSN9d1LLWgWfrJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480149; c=relaxed/simple;
	bh=VPBWgcC4wpA2GlhOA6ITAbA8Il+EFF0hmoMjPfKTzjk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mTzU6y7pUoCiIEPKjyrn/aewzF7+t8Tf5ucAdCTw7P6G6ka7N45CqpOMv50omY5tea1DPoTaQYYWunz9M96haRmg7LGUE+C4eoXhXm2OExyJq9vUwf58AXy13XC0sarv12H0I1bFQT0fMRZD5yCiuZzH1ImYczhVD41hN8yhuMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx/abM4K; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx/abM4K"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38a3225d59fso22237671fa.0
        for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773480145; x=1774084945; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYxaEEn7u3csmiCG92Q3G3wjBNBi59o3OR0VoKtdW3k=;
        b=mx/abM4K5/VpY+fad4ql5DvWga7yS9MMDErquzoOUAu6Bnc1L/iAxAlN5oCXPNd6Pg
         /+21tFXxlugHVt6YAkCS8A4QF2XuIwPFAoH+kh0YXIX89K5s10AMJ15QU08reMWEb+D9
         2BHbE0crj1ScgL8QQDl6nRMVPJk7DNpdTaq4m++ASCNg1I20lg5wcS56QurvTfg7ao8L
         VwiYH4ItT/zWiEmPY6X9l3rzZRoEavaf7TylDGc7K61XDjMWZ5XubltO3rVE4P0sJ9Mh
         hwum6AZLuEUk9NBLSazj4mlgcpI+EJzc21bW+wWeDd0szujYOQWfl0JNWzHDydulkvhZ
         0r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773480145; x=1774084945;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYxaEEn7u3csmiCG92Q3G3wjBNBi59o3OR0VoKtdW3k=;
        b=Jh23GgApwCbFgTjS48U+nnJi3ZFg37MGl97T0F5yh8qQ+bHu2swRODiw72JkXhHzaO
         REVZmR5rQl3NULQ85jUQyiRTe6+5YSh0qaVAWLOy+ZZD9nnd1/9p8MtEaiMNmmWS8ynz
         hTtdJbP7QlvbaQWkQyJUbi+6JAwGo6pWcxwzBTcuVcMj5CKt2Yve4GpwYOAUKcG9AAv/
         Nxnyt2T2+vwaef3KNlb66zb/SxXsXACo+ImmA3JqsiNyIdNOyxwv9ULCBjrOBsesfMAB
         I/p5x34/xIZvLGb4c2PSRpZx3B2SXj0ImLYenwADmlYsGYdJiWAlLqD6a1OSCVF0zOfq
         dN4g==
X-Gm-Message-State: AOJu0YzXen85hPqUzT5D/ePmEOZDBI4crgcUyOkr1uwGJbY5SFXzAyBh
	emMYJQz1GLplrGGX4WwFvJtRm7EtB4L7Iyb5f/LkT7MFjx+3mupEvap2
X-Gm-Gg: ATEYQzzS7JUzcbzf5O/ABnOLFAxXh8zjxJSrCgTWXxXQDHYs0h+q8/1gkDUb4/KjAGq
	aAkeecNL1qktshd6h1IWQhKzHo95cFOCXrtTZZhMs5z1yEyzrEpKQfgEAxiFwelqXRbpvyGwEki
	oEyveSaE47923xRVQUDuio/rNfJB/42hlSFoLmhhaTl0MkhRJUOkEG5A4SThUn8k8ctiNEPASvC
	zWytxGNNgBz07SOzlhTNYvd2iERMXHbygrkS6uQa2PmR6G0f39L/VGgHv35hH0keYWUV9EsNuye
	yWUy8VTBFpPlr/7NTQbaVeBYOFqONFlPwNNpTeyVMBT6v7WvZFEqopVaZ2pvNWxr3oc2cVx5VSs
	DLFXEBvHCDRiCDrDMgsWiPhpCm+5ZR3hdWt75RtZTBCgP1v6V7mQd5J7Ufx2d9roZgQcJebpm5Y
	6GkebaoFofxY8w+RMU0++T7jNs+xRGFmHx60wIhUL1cvkjiybWuV+kphu7Z7ESleKKCh6v
X-Received: by 2002:a2e:bc20:0:b0:38a:75aa:8961 with SMTP id 38308e7fff4ca-38a897bd81bmr21045201fa.36.1773480144972;
        Sat, 14 Mar 2026 02:22:24 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ec94sm18454261fa.22.2026.03.14.02.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 02:22:24 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v8 0/5] I2C Mux per channel bus speed
Date: Sat, 14 Mar 2026 10:22:39 +0100
Message-Id: <20260314-i2c-mux-v8-0-fb1738a4df0a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XQy07DMBAF0F+pvMZoPH6z4j8QCz8mrSXSoASio
 ir/jlNBYzXLsXzuXM2VTTQWmtjL4cpGmstUhnMd3NOBpVM4H4mXXGeGgBq8kLxg4v33hUcAIzN
 hIJVZ/f05Ulcut6S39zqfyvQ1jD+34Fmsr38ZiPeMWXDg6JJXwQjwEl6PfSgfz2no2Zox490Jg
 MZhddF4p41K2Wvz6GTjEDYnq/PgQtKpq0Xko1P/zoBAtzlVXSZSPhFak3Y99eawudGsq+sipth
 5b33c7TOtM5sza89I6Ch12dLO2cZhs89WR8nqiEJZ4ULrlmX5BXk3Cv7uAQAA
X-Change-ID: 20250913-i2c-mux-b0063de2ae4d
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4616;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=VPBWgcC4wpA2GlhOA6ITAbA8Il+EFF0hmoMjPfKTzjk=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBptSjkdlAQKVunlBPJPIUUneGpkmW32RJ4mD/Vh
 REJo0zbcZiJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCabUo5AAKCRCIgE5vWV1S
 MoL2D/kBqQZOMmhKGZXBi9lk0qCzu9bqkl2tOAjdtxwxRfYMiZtvRefw7nBFYwsOZv6EcbieFZ1
 M+L25DhMGgxPFctF+W9MCPKahikbh3sGiI65RHA8xPEhe7PfK6pfLhQhB4pPjXYwwvXjyZud18V
 guxWZ4iEtREk3hEQcdDnMDbqGCUCNkFPiqMl3yiZ3POTkSAY+M2lcJ55S5MRxjD76OB93HyMuKv
 zzH41/H+x1H1ZmNc59RtM5XRcZAYiP1KmUhLMX7tJf7y4P+CuQ9elFcqqDfPhWMRyJUpTNi3n/B
 A+HquZUvmaaNYLIvSD0fCyXnRDTcKxj7/cTtSSNzJGlEeSWReLvgBD9TDJbvHdXTT8EbrehaRhF
 T2roMUTcddIR6TSkfCqchrTkJOk1dsIbgjJkRtR4fwcqRjmgWMuBpX5CCzFsH+oUtzWw5T5DAxb
 vOgJMzb4WDIMzAZFDYfg8gB5OqtZCxVHMFhqhcIy57S2onmCYg7bdV/Tz3iY8MeHZavCQk9WtBD
 zkfmUuRFWDCsEhz7E+wMKw6oUMkIppwlvW3LVsoq7Lr8Kp0F6MAO835j3Jh7gOyVDXZDrtgZc8J
 j+0wHpWcKClbEROM5OjFLh0egLZ5k/JSWfNclpcKtscc4q5/Tmt8lUF0cq5x4bdp9efd1GC8FYy
 K0LvYB2GXPSLVfQ==
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

---
Marcus Folkesson (5):
      i2c: core: add callback to change bus frequency
      i2c: mux: add support for per channel bus frequency
      i2c: davinci: calculate bus freq from Hz instead of kHz
      i2c: davinci: add support for setting bus frequency
      docs: i2c: i2c-topology: add section about bus speed

 Documentation/i2c/i2c-topology.rst | 178 +++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-davinci.c   |  44 ++++++---
 drivers/i2c/i2c-mux.c              | 107 +++++++++++++++++++---
 include/linux/i2c.h                |  35 ++++++++
 4 files changed, 340 insertions(+), 24 deletions(-)
---
base-commit: 1f97d9dcf53649c41c33227b345a36902cbb08ad
change-id: 20250913-i2c-mux-b0063de2ae4d

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>

