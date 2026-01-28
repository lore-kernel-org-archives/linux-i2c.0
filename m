Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049FE34B40A
	for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594108; cv=none; b=dV97eWWi5ga26pMIhzlfBV5BLErT999qwrTXpRXpvch7wVW6h46wgSLOTMevnbRMoeHz+Q63O+XnqoMYD441Cv2oQsUi9zwaz+AO5wxhSjF0PZAJ8LNNyoi2oXTbpBrKAs96yQGCPPuRjXIjXTtZlhm4xvZWhAXtmZD0SxnCHl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594108; c=relaxed/simple;
	bh=+CISfVCWLwA3gPyAi83Po3/pIRtcfyYDHJJqqYesR2k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XobiNUxeubscI5kDIIkJbFwjj1gRxpNUKPzWJpT/IJE//G/dk/PvJ9zirhu0ftRBy5d83eT3ZzDjTSBQJdMORFrXNANIgaRAyk9Hi7cIbs3DYF1vwaa35J/Y/xt8j/f61OVk1IcGAcEedkZKc2Fvp4sgnLPrcBRfS5/Y+Va6FME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agAcetDy; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agAcetDy"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-385b6a15affso7164831fa.0
        for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 01:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769594104; x=1770198904; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Asb2Rs1/PzTSQv5NAEyRr76hV3C7vZRHFKpOD2/+xVE=;
        b=agAcetDy/hn2jwIoGnnv435cKrr38PsiSLTBjVRmgpkCDFH0O1kY2POmTnbx9SCuJZ
         ps4grIr3sH4BWKdYDV0z68z0NE22PCt6qBSWsplP2G23O+HUaXecaJbnIXFfnNhS8frG
         ZrgywQnTjjEc0KfRCQ/8+Y3oyGp2NHDPTpX5hr6GOMWxwgD8nIRlL7/6anxlNpeAl2qO
         mV7WSFFqFG9kwBTVpr8ki3KZcLjiTlE+tTXFy8kLpGD3L61fkFpeK2NnwciG8QDlcJ7P
         bG0AOTP2iggXP06GQVVj+mkqRd1MDFNFrWLjZ7oPXhuDLV5ZP0KgX6y4GUkNZbIijHQZ
         3EIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594104; x=1770198904;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Asb2Rs1/PzTSQv5NAEyRr76hV3C7vZRHFKpOD2/+xVE=;
        b=OuIqFa/sy8MSNI9zxXZjuLcVZ0nUoXicn6COph1wgi5cO13fAoRqR/aIrC/5ODOi+O
         qy6BSJlMhO6kDaQV0x3T/z9Wo8Hgfcp1Fbb06EiL0G15C/zcnynk5rcEP2nGesqPy6Za
         KkqGlPEq+9Dq9MH/SkqhRu9cOxM+bTsZTs5dZne3JOOqBdZHoTh8Fk2LRbO0nOvG7dEH
         CkP3/oXf3hXFlZ+Ul6sF2BRqFyV4h8XdxOJljIi8LidQAO0rXQhitRK9+ipUVEwpAfMp
         HUKNL/KiCgr10Jk9hzAwzqY5Uk6kUgEiSVoFbExZJIpOm5h11bq5bmdsqipeeNX6eIqF
         iTGg==
X-Gm-Message-State: AOJu0YwhXGPFKmkCFDTqoQgn47YxzOliGnMe5SJWIJry3I7MNzDfoinP
	yNxUoI9nlxTh+2xVq/FKKOm+/xaMBN//rz3B6X6IBhMN/PpKJ1GD9mzL
X-Gm-Gg: AZuq6aLznmESzQm7R9rRuBDQEYGYOZsc/FiGIa9knQU7NpbuWmyzeOeAxjZNsysPMy+
	IWn2sI106qxiQsUto1ljmpBmsvSAuftoncXPIEyjV/CmS8a+mdU62UT+lsa7wAsQU+bSZTDjGNR
	ppwnChzA0ZDDkn7Vz+mfVLCnxdGr2/raBxxO6ZUAIqc0Hgx+NXtpP5qd0IaKgB9fKAqh0t5cbKl
	PA2Ja25P14DqOCsNhgSnaZzorTUg07vpRZDdgmLBTrULAPjvsxCK5J3fdoHUD3+GA2Xy1pFJiTA
	vade5sA5puXOfd3GYW8lGowJzVXH5pa8CBXciMbqazhTwn/1t+w0ERLNW9A+ztFLADCz1qP/ce1
	hjQGGXgLf+lOpwg7bRxKfYaNP6iLHaUrLrGmLHnLwWsmRL2uAvCzMoFnDC+ldvt1E66I1Bu2n4/
	jMbj7+Uwh1fRPElFrEINJUOAvMjWvwdIx6ShATIdtebkkgfzCe2SMlI/o1
X-Received: by 2002:a05:6512:6ce:b0:59b:b3dd:4675 with SMTP id 2adb3069b0e04-59e04024326mr1875400e87.5.1769594103639;
        Wed, 28 Jan 2026 01:55:03 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074bfe83sm459483e87.97.2026.01.28.01.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:55:02 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v4 0/5] I2C Mux per channel bus speed
Date: Wed, 28 Jan 2026 10:54:26 +0100
Message-Id: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13O3w6CIBTH8VdxXEc7HP5Muuo9WheIqGyZDYrZn
 O8eumauy98Zn++YSHTBu0hOxUSCSz764Z6HOBTEdubeOurrvAkCStCMU4+W9q+RVgCK1w6NEzX
 Jrx/BNX5cS5dr3p2PzyG813Biy/XbQNwaiVGgWFotjGKgOZzb3vjb0Q49WRoJN8cAdg6zq5Qup
 RK21lL9O75zCD/Hs9NQGittkz/C926e5w872VkkDgEAAA==
X-Change-ID: 20250913-i2c-mux-b0063de2ae4d
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3060;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=+CISfVCWLwA3gPyAi83Po3/pIRtcfyYDHJJqqYesR2k=;
 b=kA0DAAoBiIBOb1ldUjIByyZiAGl53NehzMc33RiC+bTLMTj+/cEfkSOYbDFzHAEeTUGaF/9DS
 4kCMwQAAQoAHRYhBAVRoui2bLVNZMEsZYiATm9ZXVIyBQJpedzXAAoJEIiATm9ZXVIysrgQALF4
 kR7pbgh3IklPT/fQvo6T9WdcM2ot9vwlfBeUehM0cM9d4+oGMtnH6eTdRdglc7Y9GKYlwQ+DBaF
 FI55Mak5HcmtaVGgXyWe7ItH5r4n3uA19bZiut00olAQYvtmeJdqkSsAZckfIQpwb633DQoDgrA
 R5SBUIWiRWIB/5A2smTFmM0yAXGvcfINhOE4v6Qxbgow8X5WFM9h+364sLsNqj2KMt0SlmpwxYb
 EXk8GVhpLCwe3mvuyAegJDtY6Tf3uoWsj8cT1NNtxyZPNGonRvMJC4FkJZk3RE2qzur9mT7r76x
 iutcY/h7q48ggdcRiygTLEnMM4+j4uYP711hMvo+mDnvGmtLWuxoy/dmKrJDfCzYvcx3pxW3uXQ
 TQHR2hleF3L2PtR8Q2gZAHyUO+klFD90Ho3xU2ykkZmVzt3beRPLfVYmfMwvmNWtZfe1JNZQIZt
 +aQ4PdkN45PjSmI3A8V/NWbxThCleZfT6B6gByprN3Zh+7vjXx7sarRmVNdbcV3L5EeaLCviv/W
 U5XWHlb9VNK/3UMFEmWEPFL1UVmUNlH4l3QCeG6fpVYhCDElcCkaDf/QepoHdRAXdNq7LiKRX5Z
 vxreqKsT+BJlRH52wlDgeOQEALfOAUcxdPlJ2cNpJvUhnCRQECkSMQrOzrX11doi6tCb6IycHXm
 HpbGb
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

 Documentation/i2c/i2c-topology.rst | 176 +++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-davinci.c   |  41 ++++++---
 drivers/i2c/i2c-mux.c              | 116 +++++++++++++++++++++---
 include/linux/i2c.h                |  13 +++
 4 files changed, 324 insertions(+), 22 deletions(-)
---
base-commit: 1f97d9dcf53649c41c33227b345a36902cbb08ad
change-id: 20250913-i2c-mux-b0063de2ae4d

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>

