Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793786465;
	b=xiIkUXLSbw6qoeh3nXzgAfO1UyHxsdWUA4hWUqj2b2F/stkdWmjStlwsTZkL+H6LVmzi
	 ad6YHLDNoZgcu3Qr2ti/P3o2rdSVLCiM/T33crMJyER5UikoS8dJpZMGy+8Qv1RSmPZ/j
	 t1RT6dAhNgAWuiCsQgafQFRIujTeOZgHKi9I0rhUq+dMsjS1djfEhRqSH+eG2Jfk07mRB
	 wDRVZtHFyf4t61z5/Rzyr9Uezf9Bj1GMqcIGb2NvQjVotlwKR6oGIwA13ZaKEYHeGtk/C
	 wJGxbVoOD2lzMQWrpprRYSfN4cJt38QtiB1HuxccDr8psudzEQZ6S37xze0SdqWj7MQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786465;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=GkPWc5hCznn7HXFHBwX1ZIlu/ZMs6unOTa3W9BeK67w=;
	b=KDb7B+QCG75z/fNYVmrtuqi9TuerVSNJu+bTZixxw/N2/t8hC4B7jCgWSKX2FW2h/rqL
	 pdzdwdSgXjZBgsluWsQxjeDJamXJChzSTcPyDj8gBo67BgSIMiXP0af5XmXKo1C1C3peT
	 5YprSUe1WTuikvT98IqilJ1lhmCE7mo69BX2QS6MePx/d4iLBBFDha9O2zqjMI2cy52eK
	 suoDdLps/3mHgzzvgWYIWXAgQpjbWJEWz+GsW5z16OMc0D7sH+117Zc2it5SrkXdopQ0o
	 oJ0elMNBQU7bdV9VJVNPB2qiMLgjpGx430KueV5IdmY2MuBzGsOBFUOyWip0aNmCxew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LXZy/z2t";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A99606A328;
	Wed,  4 Nov 2026 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXZy/z2t
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793786464;
	b=sB5VCNufEEse63soe0F2DK+JJwgf1I6Pr9Ku/AJD14ibmwGbm4wERG6/mmlJUOpG2VqP
	 zSBVt2MOjBxEy4M2RcUHeYyC+PzeV3b0lwfxOsnsJbsTE/PGhfbTKDwUoh2XepNcN/nue
	 eS+LirYutW/OqUblFgH+Xmk6LanyD4SWbvfokuhYMIWxq0r9lZd8e50tC5NgTX8ZxrXfQ
	 0AWR4WTXVZR6u9woWPO1BDxnQYYqCaCLqYNusrGFyRucej705pICQ3qqpjxtMhOsyW83A
	 eCtLhb0/QZdrmRrDU8YC7YeA4PfyqCTsvOOzwMecnVsD2ht6W5Pk4dVt16gyF1GMcPw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793786464;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=GkPWc5hCznn7HXFHBwX1ZIlu/ZMs6unOTa3W9BeK67w=;
	b=H0vIZiVED56KMdY5YpvvGN/uY1VN2kAA6yPwI+7V/6mJM8PRA2FlQetF56o5ihB/Dd3b
	 2AI5YPx/BLK4mumeS1V9Sdn6dz6UzjT6TGO9vDB+FqmFKPvP8Dx8alBwCvVcJ83I357s9
	 PLdTbnb6XnzdLw4bsDgOpPaw3Nmgv0pQM1Qb0DLt0cQt9AUCp+SW+h6derCXNinzAmbTj
	 tu1qFZqxCIrYpRdOJBZAf/sOb0y+MbMm34bPL/aUed/4OMY9rBbaMpIneisHvwub1f+yK
	 SJlPYruIaUOKMkhBZtBARcOg5prrY2v5wWrxw4VzxBeLANtHLYJSCMYrsUmy/EqNGHQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 604731F000C1;
	Wed,  4 Nov 2026 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793786464;
	bh=GkPWc5hCznn7HXFHBwX1ZIlu/ZMs6unOTa3W9BeK67w=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=LXZy/z2t3/PexzURPFvSN3arUJzuTEGhJUoodCTnPK09A40Qrf7TFJH92ewmMv3ai
	 4QcTQ9gWvkj+HzGxCnDcKWd8fYMVOYJjXQoW4crI1MJOES26Rpw9czeKgxu1bAPgb3
	 Hy7ZX6MqILkUcdRepuUCmxkl8jghH01ZAIyjAZR1BGJaDn7n9DIcfb6EBaYthhpb9r
	 DsJufWHThi3VGpjpZMYo7wUuw0LXfTWETGIkZQX3C6t7vylOi+DWqu97S259Wz2/Rf
	 6eYlTUAvdPkgYhN75QFUinsobjduMC+FBE/Ipc4/yJe5jCdanNLHbgkr+4DP+gasD9
	 UcwjmEzBRWryw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CC8AC46D91;
	Wed,  4 Nov 2026 10:01:03 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v7 0/2] i2c: Add driver support Amlogic A9 I2C
Date: Wed, 04 Nov 2026 10:00:58 +0000
Message-Id: <20261104-a9-i2c-v7-0-b31f2b53faf4@amlogic.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFoC62oC/23QTW7DIBAF4KtErEsLw39XvUfVBeAhRmrsCEdWq
 sh3L0StY9VdDryPJ+ZGJiwZJ/J6uJGCc57yONTBPB1I7P1wRJq7OhNgoJnjnHpHM0QKUhqLAKi
 tIDUc/IQ0FD/EvsVr5KXFBrxe2vW5YMrXe8/7R537PF3G8nWvnXk7/WkA+dswc8posL5zQeokv
 X3zp8/xmONzHE+kPTLDCjkDWCFUKBWKiIkbFdIeii10KxQVmiBYjJExJcQeygescoWyQuW5dsB
 VsOj2UG2hWKGq0OoEXey4cd0/f9Rb+FiObsvxXnPDE+j0By7L8g04HW4t2gEAAA==
X-Change-ID: 20260911-a9-i2c-24478e22e683
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793786462; l=2523;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=vW3AT4pvQk4g8bNIqB+xYCeCb73QmptprCE/Oot1+eM=;
 b=6BwzhTGQPeaRRMF8CT/qD/8uagFtJYqzJ8Hxp9dxdpThw0G1+iDqC3IOzlOM/xcE8SyqKVo12
 3lqX6bmQoG4CgK2VdUY08TKnPxt5gXE4lxJSjKhGsp/wDDcFA8ziMVI
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add a Device Tree binding and driver for the I2C controller found on the
Amlogic A9 SoC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v7:
- Move complete(done) out of lock, and when state = idle not complete(done) in irq func.
- Link to v6: https://lore.kernel.org/r/20261104-a9-i2c-v6-0-baa6171f26f8@amlogic.com

Changes in v6:
- use xfer instead of master_xfer interface, and when div=8 remain valid.
- Optimized the function.
- Link to v5: https://lore.kernel.org/r/20261103-a9-i2c-v5-0-86f2dcd179d8@amlogic.com

Changes in v5:
- Mask out I2C_FUNC_SMBUS_QUICK and return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK).
- Link to v4: https://lore.kernel.org/r/20261102-a9-i2c-v4-0-5a169215b8e9@amlogic.com

Changes in v4:
- Repocess xfer len equal 0 use I2C_AQ_NO_ZERO_LEN, and Optimized the function.
- Disable A9_RX_THRESH_READ/A9_TX_THRESH_WRITE enables of irq when xfer timeout.
- Use guard(spinlock_irqsave) instead for direct call spinlock in xfer timeout process.
- Link to v3: https://lore.kernel.org/r/20261029-a9-i2c-v3-0-7b30ccc00533@amlogic.com

Changes in v3:
- Based on the questions raised by the robot, the data flow was reorganized.
- Some processing was optimized according to Andi's and Markus's suggestions.
- Link to v2: https://lore.kernel.org/r/20261022-a9-i2c-v2-0-45e3cef175bf@amlogic.com

Changes in v2:
- dtbinding: make some minor modifications, suggestted by Conor and robot.
- driver: Make some adjustments, including macro definitions, format adjustments,
          adding quirks, process optimization, and so on. According to Andi and robot's suggestion
- Give up MAINTAINERS file the separate submission, make it together with the driver.
- Link to v1: https://lore.kernel.org/r/20260924-a9-i2c-v1-0-b8ad9b46f4a8@amlogic.com

---
Junyi Zhao (1):
      i2c: amlogic: Add Amlogic A9 I2C controller driver

Xianwei Zhao (1):
      dt-bindings: i2c: add Amlogic A9 I2C controller

 .../devicetree/bindings/i2c/amlogic,a9-i2c.yaml    |  56 +++
 MAINTAINERS                                        |   9 +
 drivers/i2c/busses/Kconfig                         |   8 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-amlogic-a9.c                | 432 +++++++++++++++++++++
 5 files changed, 506 insertions(+)
---
base-commit: 4ec2365c08de306f52650d8736aef5862baedb8d
change-id: 20260911-a9-i2c-24478e22e683

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


