Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793262820;
	b=FeyHLBL5TsLKTDXejmqpRh0O0+eHOIZESNvmE01fwqnEm+FZktUeDeR/hr/2/Z8y6idn
	 EBKhBCf254kEZsbYfZc0mufbG14QvPTbPuyJEGg65gZWe0wWDQ1UOz46lLD18f+TprH16
	 eXaa6fpHGnwIX/Tg7JkUnni/4rSh+SsoniN+IXEPuirw2Uy71pGvazk4s894QRriAOA64
	 c2WSc7gv5kB80BGn3uhlvdcX09hM/mTLE/kGGBjs2BY5GnLl/g3oPcjKPypyVBbwD1c/Z
	 Hy/IQSrmY8r/fadivJSE2eNgw7pqFsQcJ4mJBYbskkhwMT7wyYoOK+EX8U2pXXgwAjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262820;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=BzARfS5/7dLSqXJF9f5MKXR4suI8wxogQ9p/0F1+hbM=;
	b=k0nH50Fh3TqHgrMwO0rwO9KN3nXFgtPfdMTzoVOoRNa7WwkxWTuzSCL2coGGqBz8xUjB
	 rvKgrxjIlOuZU926kkp8SegD+wZNGV2jUEfNQUeBipCojaboEHnbXWBFHEYNpPV7xfHDh
	 Lu9HlnfsG3dZvEmZMZmISFaMQeHIoIpnflM1k0JqfFtim/8QAd41x5t8aTxwZAiT8TH7y
	 g5J328DlPcDZLaCap6AqlJ082kaElA7j5AwxS9spk8eTHiYg/ILOeGqDW/09ePLlXD/GK
	 ymOhFafg31ghavuhfXvyWFaPjrHYPmPGzzO8RUfIqX3O4sfmcIl9aedLWxPtg9MfO/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuGsWiB5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A9606A31C;
	Thu, 29 Oct 2026 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuGsWiB5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793262819;
	b=MCXJEh20S6YOdrZwvpZEmgZU11tQTpcbEObVqIqN2t8IiT0M+/fq/okcIH7dqsVM5xmB
	 HRJ6g12L2FqdZiYcXJtwKzDBovTzqSefUuGbzako5jVzSNW4b6N08KjVSFzeEoY//7SIf
	 M0mnE0jd4aQtoXdAVzIBN+F+Dhc5swxACnX5R5HkCNkZs1Ho3JHCinX4VSOvfVFGI8uM/
	 l0p34sfEYQSgdpfgd/ur3CgjtF7tiqPuOuhxj6SLyQNRfxmahH/SxoTBCDHPrl/OCMuR4
	 BGWy3pVMvV4LIlPMdHJZENjGAY+RFev/Br8GOV1826rk2HUYLw7sl9u1m/1SRK/3a5A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793262819;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=BzARfS5/7dLSqXJF9f5MKXR4suI8wxogQ9p/0F1+hbM=;
	b=gMYh4oK4ES0N9bXoOoW4Tj1mWpE9qIfXk6etBJRmZfGt+5y9fr+Tn4e17Gm6LnUXAA44
	 dftSDfkvdLaab3SvI4H38x118ll1q1eqmyv1qArG2cvu97sGu4GLrAEWiUT4j5c6sfjdP
	 XbY8iQ3zqgOVpnZhot/O6+MMB5kxkuVpO1tZ7HyOCEMG/xbvBQFMovVRxFEkB8v7fKpIo
	 EY+DFMDYyqERyJqPrQ3HyO4nyndFfbkrvhST34Ul+123nQc8HHlntOAK8pNIgv8bJsH+W
	 wJMz84+w3N74TuK9+RR1V1aYLoDT5NhE814sYME2rhmx0SKYNCeCW+oH4pbRfc1YXZQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B803B1F01829;
	Thu, 29 Oct 2026 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793262819;
	bh=BzARfS5/7dLSqXJF9f5MKXR4suI8wxogQ9p/0F1+hbM=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=AuGsWiB5bRI1ncZL5tGug+tgBNrP208cBdoWTqBXkem/LEWcK1FH2yn92JqBCS2nl
	 YsuEQlBqkNw1g4uUtsIYeABf/xcUL+LZbZyRNGSIdvtBUm9PwrDSUsv0M8MDIf3IKx
	 NKXRcw7e1aP2UoJNcwBdRNuw/phz8QtSIJrc7NZvfRusQ6/hAoZisZIiEnGtOBbGo3
	 3/0ooFFNlNyLgTd7hqmF3JKpTxQg1Dt3nVEdLUH8cNei+RWtMfs2m6OGSsmjAhlS1b
	 TI4Bq1XUMWZPFXmAvbgdGqMJFYVKoiMrhfRbElJqH89GxoKhUlUGajCWvL9jCa4E5M
	 Fjzyp53eJUcVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 18FEB4579B;
	Thu, 29 Oct 2026 08:33:38 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v3 0/2] i2c: Add driver support Amlogic A9 I2C
Date: Thu, 29 Oct 2026 08:33:30 +0000
Message-Id: <20261029-a9-i2c-v3-0-7b30ccc00533@amlogic.com>
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
X-B4-Tracking: v=1; b=H4sIANsE42oC/1WNwQ6DIBAFf8VwLq2sqNhT/6PpAXBRkooNGGNj/
 PeCaU16fMsMs5KA3mIg12wlHmcb7OjiKE4Z0b10HVLbxk0ghypvGKOyoRY0Bc5rgQBYiYJEWMm
 AVHnpdJ/wiFwS5nCZ0vPLo7HL3rk/4u5tmEb/3rMzS9dvAfivMDOaUyVk2yheGS7FTQ7PsbP6r
 MeBpE9mOESWAxwiRJGXWGg0rC6V+Re3bfsA4HZeDPYAAAA=
X-Change-ID: 20260911-a9-i2c-24478e22e683
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793262816; l=1553;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=kkji73amQnq/o1U1e1LnkN9YbZJt+h7urd8kw2klnlM=;
 b=sdgJZWmkoNDUdFU37ska6hHqgSroWpJqdJP7CwvquZDnoSuEOtJ+JHnvI8tt18KjrxbGC4riL
 zy3S4uoc8XiClZwNiCggHZj7xmNILDpBED5zvCcWhyrl72+ZmMGNIG4
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
 drivers/i2c/busses/i2c-amlogic-a9.c                | 445 +++++++++++++++++++++
 5 files changed, 519 insertions(+)
---
base-commit: 4ec2365c08de306f52650d8736aef5862baedb8d
change-id: 20260911-a9-i2c-24478e22e683

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


