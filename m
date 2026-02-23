Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6429ACCD
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857231; cv=none; b=nlRXE1NrkK78MKIc05tTtuGf27/IVj160qceOxjb7A5H6EgbEVylZ+QrfVplOSL6D8oYOMFn8gp0w15VxYiufJYqX2PUm6bzB3MTnWmzW5s7sMUrFdNhc6+2aSTKj8mG7s9jf2fkz4nkcnicPawdAhxETM4WoE8watn1tWAiyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857231; c=relaxed/simple;
	bh=mCCRKMHtlBgmqWNXcSQwKAWkgQ/vQ+w7dOXdt7vYJB4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LIp/bCz1Eq4Zbv0Gt745Lbsxtd/5aWzMe8XkNLcj2lcpY4oAOiY6L6/bb2wJZo3r2Dh2HeghTcp1EXc5BxgYmAtRSLX3jCLvNFsGZg97UJyqWZ5XCCyrZtBSHbkj7/kAytdG4B7ZKkNJ4GgphzxvI/aLe9R6vEoWAsnVG2/0DXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB+cNXjN; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB+cNXjN"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e5f52b13eso5357305e87.2
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 06:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771857227; x=1772462027; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pe8kS/HsQYwBP5zgL7z8pBoY1N27zjF7IHjDKICG/rE=;
        b=HB+cNXjN6X+Ld8NbDjZC/Vxqiq1gKrF5cSD4somfwRGOepS+xGkDysnMcrPUkBXtPo
         WINi1MOwBgF5vwJF0dvPVurbX9Xe+Y6W/UgdMwuVBfnWBsqbyGjFcPo8lASrGe5o4yIM
         d3B25hX7n7Q/rOyBmK1hWgiuv11RrU4gCR8vt4n3OGURTcPJ3mOYOKJi/gsnKYftIS8b
         m0ErmSb+ZreeAFCj9PJj+5b8Py+gAi3lS6jC8FRRCPGWEUhP1NXvRHp4GpZFuIILDVJE
         pVYhDpvIGRhTljtPtqgRd6MuP78SG+C/JT+R/+ZNNIrATRCXQiDEdzfMLIOmE6mHCG08
         vG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771857227; x=1772462027;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe8kS/HsQYwBP5zgL7z8pBoY1N27zjF7IHjDKICG/rE=;
        b=H+E1HMyWz249kHNGhTu8eFA7Q6Coq5DKUMN9zvaio69nvjjeSsvcbpjBCpmG56N6tI
         S9cqbc94FfQgU+7J954KpHiiTwFtC9T5kXLhHEYDcw71sSXL5K7zRmgMhtHokznizlzH
         dItUtNq0z4S1ckmqayzu/eN246mPnnOCPGKEFYpQTO0CHdUKaupKJQqGkuSBR3ULcwS6
         +dZdt8ZsIucUCC0U0qg1vzIpV7HdZ9GxkG9Xaf2R0lpUQ7RiRe+SVbbu0lNJQq+v6XD+
         7Jn2QvnAkAr3hYFcQ/kf32GiYva3nFTiEm7we3r+xhS4QT16ttFI7QLuVXt0JD0qxslw
         7Eyg==
X-Gm-Message-State: AOJu0YywvuOxfacErcGrugV0Q5aHF+GzzJu4p8DNEUIhF6Sh8imp8MxE
	UVl6uzmnBJdCxNbrZw0stEEiFfEWa/NtuaWHGxp42opwEed/vhUTJDEC
X-Gm-Gg: AZuq6aJfYLPSVbpl92hvys+uJN3Sk+Lvb3EN7RtDUfsQV2bppFLbYn2vVUIYMdRv4Vk
	VSkMop9PYfAc0wpGLSYwDCcDoUiUiz/ILwpOTadYQ/y0d6HurNmQ3nsB8ZuPEKtRKfisB/Iw2+c
	BQNy89zR9rBPz8JETy1BSQju7zw5ujGLzmuHlJF2NkVVVt2rTVfhzp3nAUaRSu/+elKB34x892U
	cPzUlVD72viC3831tiHYKLRKQZO6msr4VK2kCxWBk7y0RC+eSMpToX6C7L9UhEKpyy+pxJhMcHH
	1VKs0uV0C0/2HYZ4U1vC47rF0cway1fhBJV4rg7ZzGegrIlmYFZh0SIwdMGtpE/Fvawa7QV+/or
	uVz/hznGyigHEVT7pB3tPESW9qDxjKc0oTX8vo+gXWGfl4Cos8a8qs2V+LczmBG7uMDJiNl4WBH
	VL+R5tpxS72RqWkl483gP673x4HhzNBtv9TsHbVGVPkPOBsJQkNM77io3JnQIJBftiqc1K
X-Received: by 2002:a05:6512:130b:b0:5a0:f5b0:401 with SMTP id 2adb3069b0e04-5a0f5b00a51mr671916e87.27.1771857226970;
        Mon, 23 Feb 2026 06:33:46 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb16344sm1631709e87.37.2026.02.23.06.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:33:46 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v7 0/5] I2C Mux per channel bus speed
Date: Mon, 23 Feb 2026 15:33:49 +0100
Message-Id: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XQTW7DIBAF4KtErEs1DD+GrnqPqgszjBOkOo7sF
 qWKfPfiqI3dZPkQ3+OJi5h4zDyJl91FjFzylIdjDc3TTtChPe5Z5lSzQEALQWmZkWT/dZYRwOn
 E2LJJot4+jdzl87Xp7b3mQ54+h/H7WlzUcvrbgXjrKEqCRE/BtE5B0PC679v88UxDL5aOgjenA
 DYOq4sueOsMpWDdvdMbh7A6XV0A35Klrg7R9878OQcK/epMdYnZBGJsHD3stKvDzR8VW10XkWI
 XQhPiw3tu69zq3LIzMnqmLjX8z83z/AObzOzptgEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4457;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=mCCRKMHtlBgmqWNXcSQwKAWkgQ/vQ+w7dOXdt7vYJB4=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpnGVPQ0nZwdk3uxE+uw/9EflWtmk7bBklAPLD3
 2yZUWYqF2uJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaZxlTwAKCRCIgE5vWV1S
 MkDxD/9ochrRo0neboyepOM6GpwWUs/3INBmv+86oHhHBoyycSsEOmJHQjpHvkPyKeiJc5P6OZb
 76WLe20FxmuQJ37JoIYfHcnOxoltRG7IyVpx2BRnUtwYP9kXJVzgduQQk5nXyhbMJA7N4/Kpi4F
 wPyhFWmEimO4g4cvrscjnGScievyf3+7lcCXMDOTM/TUHMvSy1y2wjjHi3U5hgkWux4+Ts/uL6F
 koMnjJMVjKzr/AFKQiRwysFFJ9oeUIzsCiBhWjbfgj8oIKlzR5+8/CBAMPLQaNPEni17ARunbXO
 RpRzmq7xT9K7JVWX89bof4ruCS89j/PlzvMjgSZV+6/HdeZjs1r8oD73Mt1Tni7eTjX8tstr6om
 m2uXlu+XU0jRzUbk9SKa4lzvz1TmPmUHuCcMoQG1ZfCejzH6xN+6NXHXSCWYuRCyrIvrM/E7Otr
 KRnuuEjG30uDBwhURdVyeXerpR/sT0tzXeV/GuaYZszAcPAvdEP2msfnYYS8hU3pOI2YrhoLdRY
 CgeM1NWQLB9Bxixkpbh9ZRIZsuqJgD30PBqwaWqgt6hedZ1HgRFN5ZAaP5o6VqaAKxtP6JgTxpj
 9RLUt5o0SFCpCUVIpKyxhHMoVeT66eFcQYi7GDFpXoY4JAaIm/K86t3QtQSqaG+i4aM3Na5u7JC
 P5chRZjJ3Xn1edw==
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
 drivers/i2c/busses/i2c-davinci.c   |  42 ++++++---
 drivers/i2c/i2c-mux.c              | 107 +++++++++++++++++++---
 include/linux/i2c.h                |  34 +++++++
 4 files changed, 338 insertions(+), 23 deletions(-)
---
base-commit: 1f97d9dcf53649c41c33227b345a36902cbb08ad
change-id: 20250913-i2c-mux-b0063de2ae4d

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>

