Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755D264A86
	for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784474242; cv=none; b=aSBEnjYs/A3cOAVPd/FJtxLX+glcox1VU+DcNIUaY711dJfoUJ9pEdezDE1mvjbhXXc5ekBORnlQua76+CgaPC+LBbgDOl6JmYqcvOoE0waUURp7BcjrH+lT26s80OXBdowBgFyNg9QKOO3HW0uH6nCWez32FeX6oXIe6TM2DsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784474242; c=relaxed/simple;
	bh=bcWDFKcgyhIs5bog7jMtKo6/CTYa/LKbmtC2jB5pRu8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AN4KL/NEBiP9dO5jOHEBDRNkJgIImBl9wa5xWLJT7ERJXEtKEpCAMse2BRAiXckC/iVSlRJ3zcTdszq/fAqreMjaKvKA39A4ZHcQU3ea2kLfj6ybNvK9ZlZwHiAzk/YRwK1iNTdyvUnh/7cJH6pu4gIOj25AI0vX9dq60DoTwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qm4wCYnj; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm4wCYnj"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b01cb18515so8909440e87.2
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784474238; x=1785079038; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I/LnTSHiKky2n5cLQsA/ffverxrdv8v0OCOhlGCMi5k=;
        b=Qm4wCYnjC3Kw3XXEqK5L8aNyay4W1uuR3BF1LZHvbXFTEZzGTGz/P5f+cbAWoyHEEe
         +ut5swPEeSQt8RFwfKXd7w0Vwl0RjW3kuxL5ao2nT1wxQacQ08zTfzXqZ3yo4pYyczxB
         6jZkyq4pwSsYkrU9D6iWId4x4JhgYKXVvB/9afAnOxlT2HEfphKs2uAmjaI67ihu/csx
         zqKG82Hflctowgo7bwVuaq8C/MpGk/HBfl4oP/ebdNgNCSWeWFsCa0b8QjEvFwSMJGT6
         nJg4PgT6PovCnp57uJoxEec4nosWup9GLsQoJkmEhcYFWs5CMf+iPlUt+UW6AqA9tC6t
         JKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784474238; x=1785079038;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I/LnTSHiKky2n5cLQsA/ffverxrdv8v0OCOhlGCMi5k=;
        b=URZLXUSUE97K6a/0pT0f7aZWBCLCi0zhR/aF3eOfVhzNC6LtaYfJnkhj3t4NFMIwdr
         sG6crR87sF36152V7uVgNS/CPl2jX8aQEYduVUaAvOrKTv1OcI4EhZ53bjn3M6uA44aW
         UJDBj6JRD2B4tWt2PT7r4+9uqYSub1UBZ1GzkQ3l3T7MDCLsBUiI9/mPqVhnJrvQZ2JT
         37oTTirywOqLLWv4/gX+O6zr21kJrjH/yDnilPYroz1ckXe+kmdUjiZxH2pPeIM2r3Kz
         PrtSeh5D/riBbqyUYCjXXFozCMN8OwMjDmyxQPxYHikospgfw1uXVK10QQ3v3kNrIODz
         9CJQ==
X-Gm-Message-State: AOJu0Yxr8jVEJWzjZz80ifYOyzKhoAj4+xTy7RHxdIqJCe/B2a43B+B8
	7SB4lhiwcZZApYXYM67qyAPuKHFckRZkYhImyRuG1aLdoFdKAFnWuMvD
X-Gm-Gg: AfdE7cm7JvmPzWmltWCz9KQUvB7NKZFcDddzkuSIuFCDaJrKynYn0m8k2+qzi4Pu8Bn
	E6Bo8krGQg/+Ka/i+nsuSspRgM8iWQ0aPR2eTUBWQhoDT/i00dXnKTdox/KRYB7OmPRQO8f5TDd
	cquk7RXwLTYc0C9IYhdG4grNgimuXjjo5QgJx6zqY6QmR4m3CeRc8K/t+CHxMyddjTTR+QW3ltB
	Q7vct9qGCKEDzTaJg1pWwCkCjSSVdt41/H9ho0Wzo/ZulYLDD586Ypj9BTmMXVHHwl45Lgio8CE
	cUakCzL8iKzFnuGxXydabqHEDqmFIpm0V9VLchX8QOwmFLEj0WeEMUdR6pUwn/rZBotqKJCzkf3
	hjFu0+a3mbdBslA357zWiP3FYQ5heyFxPKQixtQm4eCzyl9bNqHL49KLYQae4wnYkLSfWeDhrBw
	gDYdLX5KyNPUlcNvbCVv5c3jpQ/viPMfFwI+us3MgOyQKz4vc=
X-Received: by 2002:ac2:4846:0:b0:5b2:8ad7:93b7 with SMTP id 2adb3069b0e04-5b28fabf50cmr1657172e87.53.1784474237928;
        Sun, 19 Jul 2026 08:17:17 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e26e5fsm1835096e87.80.2026.07.19.08.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:17:17 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v12 0/7] I2C Mux per channel bus speed
Date: Sun, 19 Jul 2026 16:59:43 +0200
Message-Id: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XSTU7DMBAF4KtUWRM0M/5nxT0QC3s8aS3RFiUQF
 VW9O24FjdUsPfL3/DTyuZtkLDJ1L5tzN8pcpnI81APS06bjXTxspS+5DjoCMhBQ9YW433+f+gR
 gVRaKonNXb3+OMpTTLertvZ53Zfo6jj+35Bmv078MonvGjD305DnoaBGCgtftPpaPZz7uu2vGT
 HeHAI2j6pIN3ljNORj76FTjCBanqgvgIxseahH16PS/s4DkF6eryyI6sJCzvOppFkfNjmZT3ZC
 I0xCCC2n1nm2dXZy99kxCXnjITlbONY6a91x1ws4kQu3Qx0fnF6dQL87feqJTPuo8wMqFxlHjQ
 nWGAiWw4EmveiIs0EGzUIQqIWSOoNhHNCuJjWxXitc/4yglHwcv4rmVl8vlFx27YNvTAgAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6027;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=bcWDFKcgyhIs5bog7jMtKo6/CTYa/LKbmtC2jB5pRu8=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqXOpwiRwuBmWCPUKepGUL76+q6Ng3w2ml+qoCd
 jxG142Efw+JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalzqcAAKCRCIgE5vWV1S
 MqVeD/99aADfF4PSI4PHuRo1pm5Bs7RjOmUroMsbXTA3Jprxg9xCJO9pA8aOjCqtWxomd5SvjwJ
 /3Gl3cJl3cxIiz3VIg4Vmu5BoR1IbEOCiGg68nzIqvbu8nKiln8WbDCpuBFK3BRXE7bsQpFvqEp
 tO0gkepp+n58aXP33KZ3hNMnlXb/yRdh0iCk1sWO8d4sWYihGf0d2l5JUxL3GtG0HZR1kWWbVLN
 4c1H2Mag5vDQhGYI2OY/aRdYFV+E3CJU08qIXFVjxr0tEebr16H74U7jo6ltkQlCGvZwsX9M+sk
 5H1uT3Cg/WZYuPEtWAmNvwV9hm1FC5Kp7iyAGuR6M63hjqI012zL6lkpVmFQqD1sEZyKfJYrzGa
 xN0Xs5PxkjpMB9b6JZZ59iQVl8GUXrx2W6GJ8xlJLEQy0apBz6scg5k8Ajnyz7MEhf2d5OEKJAH
 vC5BkWYtUE+EbbCASr1lqBmkrihQXVHYSr61gbMlPTEn0wbjJYxHfSqWtsie4ml1OfR0yc1M3la
 r1J0UJa2HoGAaOmpt4/JCmAzWCKELqqmQg6DXTm4Pj6mvciDOcsKOMhN1kpiAtNZXucPbBw7/SH
 tWW+S1QmsANk5f1V1OUqbljbQkSNLLqM9mry/QMRjKhMztKMR8t+xjfAfVinvjoKZa8Emjjw+F0
 CR7Yz9uUWmZIlGQ==
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
Changes in v12:
- Defined new idle states in i2c-mux.h
- Replaced _hz with _Hz where appropriate
- Reword comment and commit message about idle states
- Link to v11: https://patch.msgid.link/20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com

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
 include/linux/i2c-mux.h             |  30 ++++++
 include/linux/i2c.h                 |   5 +
 6 files changed, 392 insertions(+), 21 deletions(-)
---
base-commit: 5489063ced8c6afdd1f4134a1a05a666b0834b31
change-id: 20250913-i2c-mux-b0063de2ae4d

Best regards,
--  
Marcus Folkesson <marcus.folkesson@gmail.com>

