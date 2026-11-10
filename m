Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794298780;
	b=RUGYs4pN2MLC1kGQ05PaftIbXVTLcn7MNNaBsz4DcMkR+AcQ+0FHE5b9l8NNhtU7WOBf
	 1MNl3na4klDfNTqjODLlmH7tm0VCnGiWCfKtF6tFDm3tUm5vQG94ntIURhQKP5hCgXFl8
	 JplkLF/pr4grXeLfHKvezLHVCL3p/2/SRE9TNsRFVJeSQ7BlOJh56sc6KA4WqH0oY1kUy
	 WJgEXOnkdsb82LEesi+bfUTQIQtGsWAPvlzm79uDy6TNZgGkYpbtKQ8g23+NmXzmfl1qE
	 DaaRlHnCu+olmc82mmB5WUjAa7Qlt30dpoXf2Hv/aaQC4/pwVdFQjyJM8FC1qaPal1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298780;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=wo1lN9Ka7SbNhyRK9N5flN97TBFUTexosNLejofEZvs=;
	b=W4p/CnZtYFyKPoA5WbBKS9aZ0loA+FN7gC9Yqc/roO8+Aow47x/VeqETZ6ND92Vos7sl
	 FjsLohA8l26n5/4zM6PjG6HVmlt4Jp7h/Pqrizt5JNhkpruuRpLPdVfqT48MIg7n0tcVX
	 a6XT/LjiudVMFPYOLQoGTw3PvmnPiH2OwboPPWqj5vwqBvbpNx4U9M0wBsSzuZzkP9q7R
	 cbE7ewdVN9hie1H0ky7a/Z1zXQLB9Z1c7RwB2hX9x6+O3IurUWy+lOKsuiucRpPz7AXY/
	 XxFBpqQivXf4/Ag2WA9yOSyTri7+AdmHXXbibTEoLRwfyt764ohNIg20KXTo8XzT8jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KBVHUeCt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8760A2614;
	Tue, 10 Nov 2026 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KBVHUeCt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794298779;
	b=i/d9WJRfDxBfw+xynJkITLlNoMH8dYTpjBBfQO8/5GF443vWgxHbs+13Goe01SyjYRrc
	 WZHViCzPN+oRifscoasdxbKKjSxIu8Me3RSuTzDi51HG6kB+jAXbkfQuejaAYlrZ88eiO
	 gdXLTfnML2g5R00S3QlSSzqHgDfQjx11jCkf+gAzJaXaaNtOIphZJVmxt1d8f4S8rxRBc
	 i3oJdLEc3EhJMf9EN7Gce00tXmVbdF5yX2+s5MiZuZ5ZXXZqeHmP3sT+cAMnG8qCU25fy
	 JsgmGjzDT3Ydq4XoS1Sh8Y/Xs+dPtJRB1PcmuA8CDDsfulwQaQcQVK+39JF1L9W4yWQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794298779;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=wo1lN9Ka7SbNhyRK9N5flN97TBFUTexosNLejofEZvs=;
	b=CUiJtGz8VoTRJTqescNcQ+HQe9EtGFnZ+omx5rYOz1JFqToHuGx2hCMHUYJFH/66uj1c
	 pXjTv4VvDfUUj9OQQOnexdTz17oA38FpdRAfFuV55ikY0vlJTyETtofDuslpgOS45JLgp
	 YU2YKyCJsICy768HBfslUODdBGOW9KBGt1Bl7fQM3w/lAjYYemLHb8voL4OrbjkaeHH0L
	 dSzP0tpUS6JeYB0jSDQM9AVtm6YwovTZyJwAXLo9lmFjazuP6tfl6xLeU3TaG1tCH6FmP
	 QAK3uw5R83eyDFHcz7cfviRMnhUThJc3P0ZfAY9ZGQ8IHmte1wuaQUnTnEF1ZR03U1A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 25DEE1F008A5;
	Tue, 10 Nov 2026 08:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794298779;
	bh=wo1lN9Ka7SbNhyRK9N5flN97TBFUTexosNLejofEZvs=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=KBVHUeCtjLmA6UOXBaYU3EypVJ4+TcM2KN+lRVsw1mC2nA6PBv61bxqUSgShsKR2P
	 N8+bLmCgl7Fe+WzJRIRRMYlugN0m61dUU6i2oTSssaOsJni5+ttyLoddCHaK7lMED1
	 8XMAwUVU5KS7s7bvzvwDR281+IfxugZhufnV6gjB1Iwl/mm7CuACbja8nfvGrglPwH
	 G3j9Eh8AVRA5fJJCo7cN2I0+ZoqL4RXOwz+E3gSXmblOoJVihLNCqxlX+3LzE36QWN
	 DjLa5weEVmN9YWRB85WTopl6j84IyAgXqqwemCuplK4qRAD7UwijmUW6HYZ2V3ypD5
	 KHlzd1RoJtAow==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7BFE548A3B;
	Tue, 10 Nov 2026 08:19:38 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v8 0/2] i2c: Add driver support Amlogic A9 I2C
Date: Tue, 10 Nov 2026 08:19:32 +0000
Message-Id: <20261110-a9-i2c-v8-0-1e9d2682f86b@amlogic.com>
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
X-B4-Tracking: v=1; b=H4sIAJTT8moC/23QTW7DIBAF4KtErEsLw39XvUeVBeAhRmrsyo6sR
 JHvXohax5W9HHgfT8ydjDhkHMn74U4GnPKY+64M9uVAYuu7E9LclJkAA80c59Q7miFSkNJYBEB
 tBSnh4EekYfBdbGu8RN5qrMPrpV5/D5jy9dHzeSxzm8dLP9wetROvp78NIP8aJk4ZDdY3Lkidp
 Lcf/vzVn3J8jf2Z1EcmWCBnAAuEAqVCETFxo0LaQrGGboGiQBMEizEypoTYQvmERS5QFqg81w6
 4ChbdFqo1FAtUBVqdoIkNN67Z+aNew+dydF2O95obnkCnHWj2oalQFBSUSD7J/3Ce5x93s28IE
 wIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794298777; l=2706;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=7OD2ZHZexewbKStsaM4JRg547aSZ2bzA2tErIvhXRqg=;
 b=z4KN8ySuSHewU8QqwYLOawLI5n1jEnP8ebyfm6o+JDR6sCgCov2SbimzEEtm/Tc2GYiG7PcCw
 BuPoghEaCoWBsWR09Gu+H82vN5/A60tUcoigTlTF6PFBv58sV8bVrwA
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
Changes in v8:
- Reserve complete(done) into lock, and adjust the code process in irq func.
- Link to v7: https://lore.kernel.org/r/20261104-a9-i2c-v7-0-b31f2b53faf4@amlogic.com

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
 drivers/i2c/busses/i2c-amlogic-a9.c                | 430 +++++++++++++++++++++
 5 files changed, 504 insertions(+)
---
base-commit: 4ec2365c08de306f52650d8736aef5862baedb8d
change-id: 20260911-a9-i2c-24478e22e683

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


