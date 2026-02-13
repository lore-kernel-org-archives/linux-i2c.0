Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D95354AEC
	for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980877; cv=none; b=Ljrmd8bcxUQzJweI7n8hSGwXdWcq950g+lcHevEbdjW+ZADunlzJpKSfDasHDQ/LMZiRcOt7/jKLD651xkhV4jLH5TLHbNjULnyJ9C3aVxKsLqwdB0PYqzDrOpHmCCGrnHp4x4z0YEaIjlt6Xbf/dEWjEV9+maHiZykpXMFzguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980877; c=relaxed/simple;
	bh=6Zg5zzVF8oCDJTjErI+gpu9LtMPTNvBI/8T4SJ08IMw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ul3s/d08kM0F0zQ8ZsCKXNzZiqCUmUCSCrm5SRko9RvUcyvFXUL6Ma3uW01eT9do13eHiL6/xZ25FApDdUisAHIH5zsYeDbbJHD3ufdVI+m42xR5N7rf60lFRvBvjJGGpVOoYS24dUmi1UNgQp8T7KklSOUIr2tb3rD/HrrtjjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsQz7tiK; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsQz7tiK"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38709888abeso6234741fa.1
        for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 03:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770980874; x=1771585674; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8qjLa07Snj3KltW2TJr3+SAb5Y1SXhPe7Ar7X2Wa5FI=;
        b=AsQz7tiKOurikD2Djp0qzq98rzuwPvXzLxNqk5EZ9UVSCs8GlMDW61ie8AxRyhvNpy
         TNaS9K/oDV8IYvMAQ4/PTSiB2e3HxO1mSv+rEJ5M/zAlUe2H27b4NNnHZPigK5p8S9+u
         kMYtbo/IPSXyH0WHUbO/tcJnyLsjo/Fkla36pFYHATHhhqKwj9bqUsWYj27v08Y6w00D
         Ia2qDwdDOY/D3Z3xpg1YnNYCkU194SQPnbXm4pY6pcDwz8UL93CltXOsbAmUI7xvUrbq
         txbISipMOj/45aakz8C9HpM3ZN+dWx+66CvECv20IaLjJROElZyhjNijIC9u/7FGIJ3k
         ZAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770980874; x=1771585674;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qjLa07Snj3KltW2TJr3+SAb5Y1SXhPe7Ar7X2Wa5FI=;
        b=UJD/+LbLhkrkdJp2gE8SzscBsID4EwWl+IUxKT+TEBt/Ex5/wfev/8O1AtdTCLoarK
         oP106kuphJZrDaIm48GnpP+TbSct0TI0DQpYhkqJkvyvnfzUKP4hY9n+RWZc4WDZNDjs
         avf82zI5WC69oK+7qZhixTMsw7Rqwvd3HPa3Ma0jP3nM1sUUTtSWpBJKRAsSumwSnTyh
         xNryOOE892VNYMDmnrO8Rs6eC4HCadN4/NDdcBkVxPvd3LUhoyBkqCUP/G75WIqyEIUc
         mXbLCNQ8BokTHG9Yt3xnNQfGmaZfqu/mSeC6TUFlVmsx6ld1BDTe6P2E9n3x75TNJ/Gk
         plcw==
X-Gm-Message-State: AOJu0YxIbNQCizhMjnWhlI8MqUGEllgEuZnnDTx9Zpu68zGfWOSPIJ17
	xBgMtXL7eDWIsOinLg5XdPfk8fnOcMx25XEym6pYGb2JAprDM6b12Lsn
X-Gm-Gg: AZuq6aJQHbmAcuGH14SV1I6r4B/9zPzpecYj9jpBVxYTqPeGZ27Nb7ZqQbAw46O/RPV
	nxNsOopLiVOKG0wUDeLTGNHgb22aRep6oyMlj2o7VM1sw8n/XxS4lgZ3fKKITOntfRKCSpQR1Jb
	pcalQZ1ep4vgGqcK7zCvUDFPfxA/Fu3jyccdq25rZLdA+bmI3M81ATnYfA9b/Q6QvWxzrrr7WXi
	EbIadPdpxNYaP6YdWHs83+XbO9xq7BmnV5dnk2XhCNDa2wHWQyEaabhcYOJsNiQqyIJAy+TXBE5
	488fDQK6P9AUZ5JXVftEF4OvC1OS4gEbBNyztw7LcthZP0j9qO4JBokeFKbWeRzVyAzx28jBwdE
	p89/WKqvUrKgSNLC3F6ZhGuUYcDlGNe+R44VCyQdHRxhuPdNu/gG+oJkEOPcUnzz/CGMO12H6tA
	RA23Xe/WrErgNTvC7XSnpF8AOPENF1kDZWcyNCk/keCUarjnPkUoKsWIcIx3cZuZWDmAwj
X-Received: by 2002:a05:651c:507:b0:382:56ff:5207 with SMTP id 38308e7fff4ca-388106bd9d1mr4862141fa.36.1770980874089;
        Fri, 13 Feb 2026 03:07:54 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-387068924c3sm13635831fa.1.2026.02.13.03.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:07:52 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v5 0/5] I2C Mux per channel bus speed
Date: Fri, 13 Feb 2026 12:06:49 +0100
Message-Id: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13OywrCMBCF4VeRrI1MJhcbV76HuIiTqQaslVZLp
 fTdjeK1yxPy/cwgWm4St2I1G0TDXWpTfcrDzmeCDuG0Z5li3gIBLXilZUKS1bWXOwCnI2NgE0X
 +fW64TP2ztNnmfUjtpW5uz3CnHq+vBuKn0SkJEgvyJjgFXsN6X4V0XFBdiUejw49TAD8Os9s5X
 1hnKHrrpk7/OISv09l5KAJZKvMheurM2zlQWHydyS4yG0+MS0d/d47jeAccwntKRgEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3260;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=6Zg5zzVF8oCDJTjErI+gpu9LtMPTNvBI/8T4SJ08IMw=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpjwX5HtrqcmkQPSZpwqBn6R0i9TqyIcMWVcVMk
 PpEcN1G6tWJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaY8F+QAKCRCIgE5vWV1S
 MnK7D/9iXOEt0lu1Aeo2dDh7ZbVIPwdDLEUFRVq9sonqV1yUmY3Q0eqZOZq8AARVHZVHxWQvqln
 +OS7RBmfRa7btWLF+te5ZrIQNkyVoa11KZ4KPlijkiz0LVGfQOidacqfXzrHJyMX1XdpohtbRD9
 r8ptcxhCUHSrk5VSzE31fcZxaEgeflr1T290hfRlf8JMArQz7R184gk6tSgqSvX1gTHYGoq/aze
 iSh44xgC47QDogKy6bvkaGI7zjbocQS8hqSprU/xxXom2/32Cq9+6Th3pOl8K6tbUdSwLU8RLGj
 h7BT5v3u/zoEp5R/p95pPe/rJsBVZQKvX9xn6Uj1ffQC/0B8lfZb45cup+QFpYzrFOpMcpUYWYi
 PR3bjpxIp33OO4HK6GSlFrEEK/DD66csG6dIkiV050VMJ4zPtehCx5IG+OK84sRrJDfAYUV4bgh
 2psciGnK3gwrBN9J2cIBNr8mtRs97NNnt/bWHqzaNjN99Mt73G/TuqQTS2HLHzvPcfSMqANlr1A
 O+QqOXFSJRCOi5p+fsGWpw9fSgfLMkBCgNTC/OixPMp2ow2X6pMSdb6nWiCfR8YmjmTx43/dh0D
 uS1sEB2lvZySAAbhp+9LCpWbdYR+LHq3Xh83ITrIHPyBVABAprH3lOCrrIrjJqv8r43feZd5HT7
 pMrPfNS+tLl6jFw==
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

 Documentation/i2c/i2c-topology.rst | 176 +++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-davinci.c   |  41 ++++++---
 drivers/i2c/i2c-mux.c              | 145 +++++++++++++++++++++++++++---
 include/linux/i2c.h                |  13 +++
 4 files changed, 353 insertions(+), 22 deletions(-)
---
base-commit: 1f97d9dcf53649c41c33227b345a36902cbb08ad
change-id: 20250913-i2c-mux-b0063de2ae4d

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>

