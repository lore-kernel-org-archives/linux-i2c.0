Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23F772634
	for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771245514; cv=none; b=AfjPyB5RZtqu+d+fLGFtiby2QcYumBwvM/WhHgoi0sQfTrUuugwFmkdO4wM9FpjRTw+/G/A4elC7lxZ7y5rzAvv0PqzgCUBTrwiyjnld4ZQ1Dm/uE0RGcqdAw7edl1lX/RZ6w8HftpflUMc+ehixcf/DUq/P7hnE2RwC3FH9jHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771245514; c=relaxed/simple;
	bh=zoK8Y4JjjpVli0tYldWuwlOtwBvcNGDImLpHHn+2UNs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R9wqmZA9Vat9+RX5ANOftA/nSU+Wb/cbnYvy2c77wI3iBdGFDuw/DsRIF9JZvYYfmLDKMxq+9MHCHhfrhET5Y15f3PFkgtkwYZDIwG/4+zaIr8fqs1o6jJl+5BW76ErRrHc9pwv1Dd+TTCYIdIp0wHJ43RBiMQ6Q6NtlKwEH+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUs1Mf+9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUs1Mf+9"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e6491f1a2so3235243e87.0
        for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 04:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771245511; x=1771850311; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Au9YGUWXJMl0Z1GJQIR2WyTwbfIwDLuybPtxyXmyVug=;
        b=OUs1Mf+9nuVBf+pwzsI/zJ0pK5YJiwdSXWvMaAbRkqBqaIaE4PvgGw33i8o4ySZWM/
         kMKSwr44w8ZfsV2WnVC6QqrI4C2R56kgq8LXt35vl1PxhetL8htxD+0Adm9XdM5Ebdjf
         0HOmVYU8Y5y6UO/pXdGrE9uC+0LHChWWMdJt3Q3+4xlm6n2Jr4+lnNyUkIchxvYLgIvK
         NQWVHQZpIUppOgR3DpNBL+Ay3QBysp2dZUksAwj5jjSksVCoIAmkfLUwIBtdcdo26dEv
         m2FuOVUdT98PRD04WaFzMazLsy4Dj9pW12WJvRQ2YSDeMmXDaRBv+F2p/Ody3dYSuGbA
         XT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771245511; x=1771850311;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Au9YGUWXJMl0Z1GJQIR2WyTwbfIwDLuybPtxyXmyVug=;
        b=LNlW6mmNbFwzd+xRRXS3uNpp92pIVsXcpyx8iRxNmFstjvE0qyUygF4S34zRI0MUJ3
         Tq1hLxj1Be3QkjlXL0dt3iuEOmbsVxFaSe5rHxEArrFTrTvOHT4X7Sxx/cvlwaxg0wUV
         223Gd4L1/MIkylbiIDKhhyQzVsPgJjyk0KF2imAXDTMm/UrKkId1Mp5yp8hHiFoI/yW1
         ivIBpuGAhbamxlZjCSzcQUXI9sk+kPDIhNl2g5feEutNOA/cG9iq5wkHlNi58XlLYrbZ
         FOCaX99U/j4euhmsfBZ2lv7ea1lACXRDFnpfhS8w3yJAH/YqwpE+NA2VeVzvfrCovo9J
         E36Q==
X-Gm-Message-State: AOJu0YyddH6CwUv1PLzsaRJ9jW+uOn3oLDa+M6nAgvVz8T/2NausUnwt
	afX2ma3lM7hjtpPDZE2ferAJQNRzxyGYxiq+VnqMKw1wHPtdn7Q3Y+wy
X-Gm-Gg: AZuq6aLdVCQsumviTzaDzajfpIk9Cw9qNT2jOTt+VlT0Zff78AIaClp+cqExa60CWul
	Yl+ZhbSDLkQLj1qzyxu4Gen+sy53Sv74PIqUV80FosQleHkOAquyP7Jrc+j6XWNH/4e6pKOB3is
	+dVfoBeYp1Ql5yJN95sa94K4+0JTmlsvWBfREuUPA4pzghIj/xjNBuMI9Nm2SX+2Can8azmz14r
	yho25z8ERHO3vMhoo1tM8UEwwBMxrkUyQ63Bwr38UUCfRa+JAAt0F7+OxZyiOqjyZsmL584in/Z
	y8nK336W7FU0V6quZ1YpQ8ClHynMzGzqvKy42nDEl7nDRrBcHbMtupSOLLMSHTBlm2iHX7ymQLb
	qBhP+JatZLKVwg/HdmjP/d6WR0zVi3fi1rcJ4UlaP8GRFm/8uN33jFghUeQR/VX6azkrMEgGSM/
	n7i9/0gvZmhAkhQLsHQlRrchxCo1rpCME0Jz3ZvT1FFIz6vETBC38X5gK2EWJRAKp54Yvu
X-Received: by 2002:a05:6512:4019:b0:59e:13e8:fdbf with SMTP id 2adb3069b0e04-59f6d009bcdmr2231639e87.23.1771245510612;
        Mon, 16 Feb 2026 04:38:30 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5b0577sm3175920e87.71.2026.02.16.04.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 04:38:28 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v6 0/5] I2C Mux per channel bus speed
Date: Mon, 16 Feb 2026 13:38:12 +0100
Message-Id: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XQ3U7DMAwF4FeZck2Q4/ys5or3mLhIHXeLRFfUs
 mho6ruTTbCWcXkif8dWLmqSMcukXjYXNUrJUx6ONYSnjeJDPO5F51SzQkAPZKzOyLo/nXULEGw
 SjOKSqtMfo3T5fGvavdV8yNPnMH7diou5vv50IN47itGgsWFyMRggC6/7Pub3Zx56de0oeHcGY
 OWwujZQ44PjRD48OrtyCIuz1RE0kT139RD76NyvC2CwWZyrLok4YsFt4H93+sXh6o+Kr65rkdu
 OaEvtn33zPH8D17xOKn4BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4059;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=zoK8Y4JjjpVli0tYldWuwlOtwBvcNGDImLpHHn+2UNs=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpkw+3UKjjGG+HArNi7qEWkJojo+VcEAN8Y3wlQ
 Q1POYGf2MCJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaZMPtwAKCRCIgE5vWV1S
 Mk0CEACatGJ4NqlrpfxA+XkfhhVARSh35cMDQN6ViZwxsLi+JJRZ4J3aRHwrDirMr3xpV880EpA
 kioBXdZ5wXemW/i5NIYXEmV/0AlPtFlqHC0CAPBds0SoPI32vRfDG9T3JYMR6+qF47+x50qg7ZU
 P5p+3tVnFF6+D5gHodrpZkNrENg8qr5YLZB+KKVXVnEmC423iPOlV9IZc0DsSqK1hixy71Eka+X
 u1NI5RE4NoAqoWSGVee/7AEQzNEabgsNVMd7moFXT4pSBObkkv9Y2IGhoBxqXuVuo7KfcV6hm7k
 wFzX2FJ3s4QeaIJ0EVgvQgUHpb9tQr5/7MW9G2XyiCVhRKLSmlGTE5SxS5UndeTL0g5dq+nD6hS
 8PYVZm4Chs9FLU4PUhkIb5TFagxfSNqCjBje5Mw4N+erOuAllfdm2dxAJReOtocz/SaOramP4Kz
 6tYOYF8x2OUk9PmLFr0Tuk/+vAsuP2bmHFVQxl9oRpcK12jjrm5F5icsbTjppkJK0Aztlgv1o8j
 tqOeocyvcnUzK0rPnys/GbTSiftBAXvs0Z+sYqfylTshqTHN4WyRmh1kZ5zHLxX9amDfGOXTu5+
 zv6ZAfkzHhrFmls57wPSZtpyRLZgVQGuq+J30l5W9VXmNq0cveVJ5Sfc67Z3iCYwX566yBY4pEo
 ShGxwREsHqbflWw==
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
 drivers/i2c/busses/i2c-davinci.c   |  42 ++++++---
 drivers/i2c/i2c-mux.c              | 145 +++++++++++++++++++++++++++---
 include/linux/i2c.h                |  11 +++
 4 files changed, 353 insertions(+), 23 deletions(-)
---
base-commit: 1f97d9dcf53649c41c33227b345a36902cbb08ad
change-id: 20250913-i2c-mux-b0063de2ae4d

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>

