Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157413;
	b=T9OmlBFqbGMp/Xt7gfj97CcUBiC0AMRh+URLxk05jGmr66ZxOoqWtkotYbZuvX7bDyBT
	 1ZOPAImdOZC3On3Sr+lw7hgLUp1EfHrS+qLbafbgipG+ot9EJcYdsdmaiMEbnwP9nR0vd
	 9AkP30eu2u6JY9b5trpLkqmZzBtf+9S0NEMx6kRGzCpVJZYrsvlbVinW5YzhiDIXoi7bi
	 GEiqML5z/gv/+XX0tlCYMte6+mUATjeUHYu5SBvMBLk9AG7e0vpMDy7VTvHTD8y0tqWP9
	 WCWHbaH/EIzD7XXGmvOkXnJ5apm55/BQqig401wj/FmsPv7/vb6zFk4Mhoi5RVLSduA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157413;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=fphJrXwqi5waN4URtgt47m703CKnWB5bi67O2O8Dy5Y=;
	b=XNysZpIKnrj1unfv0qYUOpOTTzsAbTNd3XtxfZ6cCEU/F9M/VZ+ifb80UWo+JryVj/KR
	 cz0MBkBje5dPwxjPcl1HWGecoArQwTp+s5VG/ci1tU2unFxYzt0ZjVAdUbbIE9hOlCd78
	 hBlpi/BjcZJl0qYqfilZDr7JJt7kBSg3CCT6y9R18PmV8VqLBs+yWyG9A7H47fAdMmWS1
	 Dw2/FLUDNknM+iHZH81+JiNxXrHntE7HqFpw+QTOnKfdRperiX+FtEPxww8egLjCLTku7
	 xrFAbjGKU6FlrHtOCMD+0w1F6/Qt5KlbAJt7ybZWfqMWbYodcl2rfv9iBcKc248ENCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKLEtSDs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C5606A325;
	Fri, 20 Nov 2026 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKLEtSDs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795157412;
	b=coaoxvRvP6/zLSrp0TiShijTth3Apf0bDDoR87VccLR+VcrEJ4YWIMj9Bn1ZK17t5FaF
	 uBF3h82KbxJWHA5e5QY/IW6XjG+UhGSLVPt/nKhBFpxvbD8j4PKcW9UaN7ZA7hrcLuRh0
	 u8HpWyx7ui9E5FjEEY3U4DzHOtU/zTdSgGf3uymt53qgd6mtyRFVOWj8Mxt2h+IXDn9kA
	 KoLrBAW9n8qEApdaQrti2fjbHa+HRh0m0rGkoytlzU+DFGnzbgpL20I7VQFbqRNzGnZ8c
	 9QS2QMOsyWsiOfUL9xEO6OKkWajzj+gm6jRl0JBf6/XXKNpu7eWASNoaLHTCWe/VURA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795157412;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=fphJrXwqi5waN4URtgt47m703CKnWB5bi67O2O8Dy5Y=;
	b=cBhgP58wwTuN2KbXT4PY+1fmvMDsZTLsW7VR2EoSU22qkOkbgdztRCWVLIU+tVqlmQr9
	 1gTtTUPlQlBsr5ZI5dxj9DRENIquvTakotnXbsgj576Lwm9qwc8elZx47ldL54FxryVRr
	 ekC9NcqRgH8w9eixXX9s2yIaKmk27FcWz0Ygk/xNbF92chPiamHOifsWe2EYobuNbJQLb
	 MBgFpknpoTRk21Dkh7YKQc5e+JwyOggnCYMYKYWkbYwYTKxp6q7HMaLrpK8/vCVQrwH6X
	 28gacXUOXNNR2qzNHsIDFXjYRBwPOkLnuOa7+Tovufu5+FvP/UGTu5QTF/XAuPrx89Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 94E601F000C4;
	Fri, 20 Nov 2026 06:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795157412;
	bh=fphJrXwqi5waN4URtgt47m703CKnWB5bi67O2O8Dy5Y=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=QKLEtSDse56JwztLXruD5t9DcWAdS1VM7Av+EOzXMCT+lYPkmBUzM6wuDoFIC+YpN
	 h2n0d9uXgctg7j/lGx5iYvfPTERWm15MCV+sDrgZ21PSyherj1Xd7Am9i53t7iyx0w
	 SdvEV3sPWcAc6PlOw5tyFYLEUN9n/wmw3d5zdIsgYQ034ShNz3lYxmPvYd644Ilz+X
	 4/k0lZOd6aNtTuFX8KaoPoJA/n1c/NTQxJ69XG8ldcy+P/XCaoN2wJKNTYC0rbiDIp
	 cB6XYBaE8fqoH6CtfQ4MnltHGBJMmV7Hnri9g6M8KDFMMOfyXjHFmuJKjY6DPHlq+r
	 o7xKmcFyxN8MA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 269424971D;
	Fri, 20 Nov 2026 06:50:11 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Subject: [PATCH v5 0/2] i2c: Add Cortina Systems CS75xx I2C controller
 driver
Date: Fri, 20 Nov 2026 09:49:43 +0300
Message-Id: <20261120-cs75xx-i2c-v5-0-03bec242a549@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNyw6CMBBFf4XM2pq2tjxc+R+GRSkjjBFqWiQYw
 r/bwsrlSc49d4WAnjDANVvB40yB3BhBnzKwvRk7ZNRGBsllLrjQzIZCLwsjaVmlVCsLeRGNshA
 Hb48PWvbYvT44fJon2ikVktFTmJz/7m+zSt4RFv/hWTHOVCNyRFOVpihv3WDodbZugHrbth8+p
 SCytgAAAA==
X-Change-ID: 20261015-cs75xx-i2c-944d27231b4c
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795157409; l=4213;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=ZF8nx2IQ8HACgl8vWRQJt54cQk/RO3BGOD/Pq4aDOZA=;
 b=6oa3JGk5fIR6mAcJu0RKPtFyuHbAaLULpX5OSj8xkLuwa4CBuCnPRVzcVgcf+iS+4yxMXlPb8
 R1Uiwjopm5lB3Wm13FyXEM32t/PIakcJNY3ZsKv06EJJVHNWy0keOTR
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

The I2C ("Bi-Wire") controller of the Cortina Systems CS75xx
("Goldengate G2") SoCs transfers one byte per command, with a command
register much like the OpenCores one, and raises an interrupt when a
command has completed. This series adds the binding and a driver for
plain I2C and emulated SMBus, without quick commands (every message
carries at least one data byte) and without 10-bit addresses.

The driver used to be part of a series with the interrupt controller,
GPIO and watchdog drivers and the device tree changes. That series is
now split per subsystem. The driver depends on OF and HAS_IOMEM and has
no dependency on the platform series [1], which is under review
separately. The device tree nodes will follow with the other CS75xx dts
changes once the platform is merged.

There is no public documentation; the register layout comes from the GPL
vendor kernels. Tested on a Securifi Almond+ (CS7542) with the SX8650
touchscreen controller at 0x48: reads are ACKed, an empty address returns
-ENXIO without timeouts. The v5 late-interrupt change was checked with a
host regression test of the transfer state machine; it has not been
exercised on the board. Repeated START between messages has not been
exercised on the board.

[1] https://lore.kernel.org/all/20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com/

---
Changes in v5:
- replace the dependency on ARCH_CORTINA_ACCESS || COMPILE_TEST with OF,
  retaining HAS_IOMEM, so the driver can be merged without the platform
- build built-in and modular on ARM and x86-64 with COMPILE_TEST=n,
  without the platform series
- ignore a late interrupt of a timed out transfer before looking at the
  arbitration lost bit (sashiko-bot)
- Link to v4: https://patch.msgid.link/20261115-cs75xx-i2c-v4-0-4b16eea98a78@gmail.com

Changes in v4:
- rebase on v7.4-rc1
- split out of "Cortina Systems CS75xx: interrupt controller, GPIO, I2C
  and TWD watchdog" so that each driver can go through its own tree; no
  longer based on the platform series
- binding: limit clock-frequency to 400 kHz instead of listing 100 and
  400 kHz, which is what the driver accepts; I kept Rob's Reviewed-by
  from v3 for this one-line change
- collect Reviewed-by tags
- use fsleep() and device_set_node(); sort the Kconfig and Makefile
  entries
- Link to v3: https://patch.msgid.link/20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com

Changes in v3:
- rebase on v6 of the platform series
- reset the controller with its interrupt disabled, check the prescaler
  against the field width exactly, wait for a bus held by another master
  up to the adapter timeout (sashiko-bot)
- Link to v2: https://patch.msgid.link/20261013-b4-cs75xx-s2-v2-0-94f8c0a90cda@gmail.com

Changes in v2:
- rebase on v5 of the platform series
- do not include <linux/mod_devicetable.h> (Uwe)
- complete a failed transfer only once its stop condition is done, so
  that the stop interrupt cannot race with the next transfer; take the
  lock over the whole interrupt handler; report a NACK of the last byte
  of a write; enable the interrupt again after a reset on timeout; fail
  with -EBUSY when the bus stays busy (sashiko-bot)
- Link to v1: https://patch.msgid.link/20261012-b4-cs75xx-s2-v1-0-8a7641b7b79c@gmail.com

To: Andi Shyti <andi.shyti@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

---
Fil Dunsky (2):
      dt-bindings: i2c: Add Cortina Systems CS7542 I2C controller
      i2c: Add Cortina Systems CS75xx I2C controller driver

 .../bindings/i2c/cortina,cs7542-i2c.yaml           |  56 +++
 drivers/i2c/busses/Kconfig                         |  11 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-cs75xx.c                    | 394 +++++++++++++++++++++
 4 files changed, 462 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261015-cs75xx-i2c-944d27231b4c

Best regards,
--  
Fil Dunsky <filipp.dunsky@gmail.com>


