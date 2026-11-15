Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794761741;
	b=FZmjjaqUN9rw2hPHKBqDvSxEvo7PLrpufeQGgt1LKKPrEXaH7ArD1RmCZugdai8sz7Js
	 KgW/zSExDTnnMD9d7kXPKgneJldCiqhSxT0xMvXMrzw43Jy396YgH3OeMSyhILoNTDHsN
	 YLyHr9oRyeW70zVZEp9fIJgmOZPpRuB5pas7M29EsLwFIrGJYOCHxy3SJljtfeAwQoLBP
	 OItswiNeP+J4bNSxQUtWSA+w9jZqrP2L5r5H5l0W9lJGzFiTJygcZKlwAan5nOSCZtFH2
	 k0POCgVSCNKCrwa4yjRzvRlMDFVrPcxfngE9mY7WTWxINW9V1nD0pGWREKkJbH+uYxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794761741;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=jMKnQ7V2+ZIf3c5qP6jPaOt7u2SLPfZMFARUAJHcPtE=;
	b=rCyh/wBph31xs83fIM1u06e1vXSZHZfD1cSDqDOCGk+h1KHlsKy+chdNOWXgK3c7UXdB
	 bjJnOWk7FC4qQFoo0IgVFxd1dxeyLoNrsP/DLeNciVZTeim54MaCsGFtCbDhI7Va0KFym
	 qb/p95X5Hno7SzRvVOH9dCl+9sP+ejaydNTXEg7Il+MaRs6dEOwnKFHtuOeRhEZxXqEWV
	 OhMle7IiY9X7aJOQCsBpzkMZKAxJsGUJp8S2fQwbf7uJSc0Lt1Z/cEeH7Rme0AYRSdT7H
	 TgEb9DJB0xIuzi6AKAOp4/nyaBmqyXB0oQQUxIFGgC382kaNn83/YK2hliLnuD2SYYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRsAA+UC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB0606A881;
	Sun, 15 Nov 2026 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRsAA+UC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794761741;
	b=zRqGBRcAn886Y+6MyTkMLMmHd0/zZBmB41smDGRzSkpr3pov6wLuqng3c+mPRhSlnaws
	 dGQZauqFlc5ppdV02IwZyDa1qUyu4/fAkbr2repjOft6ZdcsclYleaQbefmn/JGXg7+wO
	 S7HJ/Zud/j83Um3Jcs0FTCpxsz6zNXkftwjBDsRHSVG0nDG+PVCD3NSRxfIplJjlLHZ5k
	 0Gih7sJEEn2jPOEl2+ed/nnS37zcr1uS30Ra3t2S3O6racexavMhwpESyguFTWCowEoCu
	 1bARvKCP7nNfLPr/dO0PkmN8Y6VIQgORx2enP4x7KvjomvZahVr3fqvq+umlHkS4ZZQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794761741;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=jMKnQ7V2+ZIf3c5qP6jPaOt7u2SLPfZMFARUAJHcPtE=;
	b=p9gTHYAF+diQRDCUfQCzsNUYje44r+U6cdBS6zL1cXxMisIzXVBSS1ndrYLXLSOapEnc
	 ZGcLZAfeV8eeLU9WYa5WRsppHOEnz+Z5GyzzSMiXb4UWrFusnpbfdSHs0iF+TrZiOK9H/
	 49WNBKCIANsooHefOe16x3RXD6h10lvSxoBb73gmW7BGjgRIWMgatYbor412F0/JFAUP6
	 FFIljMBSinn/UMyPjYumoFpQ/ccG7J/rMysMRdsqt42BJ4OfqMq9TKWivTpQTVV2LMzwn
	 Ds2hfGs+g9oe4WIbtU0YPUDSjwlnSNp+SQ1Ml6oxxKQgBg1RAgNh7SEXhoTCuyYRLKA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 81E551F000C5;
	Sun, 15 Nov 2026 16:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794761741;
	bh=jMKnQ7V2+ZIf3c5qP6jPaOt7u2SLPfZMFARUAJHcPtE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=QRsAA+UChRWu4Kfg2pT/q0qjr1d4TgifZ3aUCfW3fqosr/E15as2Con56/1fj6ATq
	 NnJnY5s72GPULCsvU1Ks0sk19f43XbPRKxyVCnsoQdpLxIwaDyB5VZnT6Sp8iDhwTq
	 N01sbW1o1qUg6ZQzumcis6ZStDkfWwtlQID/PRgWqQOViOgI8o0lX6vjFq0plYVc5h
	 SkOb4vbUdboDuIdCgyjdo8WAY28NEpGs5evzbpfAlgBGmW14SlXPOUo7pwTHgrJXZr
	 3Ke7ET15rjVGPd2WgxLuR+qTRoTG0tFVTmaP6HusvaQOdalTxXkVwnWN6+QgBYi5vj
	 bL/JPnnQj5DLA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D781D4A117;
	Sun, 15 Nov 2026 16:55:38 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Subject: [PATCH v4 0/2] i2c: Add Cortina Systems CS75xx I2C controller
 driver
Date: Sun, 15 Nov 2026 19:55:36 +0300
Message-Id: <20261115-cs75xx-i2c-v4-0-4b16eea98a78@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIzNDA0NT3eRic9OKCt1Mo2RdSxOTFCNzI2PDJJNkJaCGgqLUtMwKsGHRsRB
 +cWlSVmpyCcgEpdpaADPuZP1uAAAA
X-Change-ID: 20261015-cs75xx-i2c-944d27231b4c
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794761737; l=3602;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=eFQYkfpNPLfFX0ZZ400z9FMiWSI3VJbnU0bEeCAdNpk=;
 b=gtSIudZvDq5W2NJPwUjGeO3EJvA5+gjpec1EgeOlSQQO43CkUH6c0zMaU7rOEaHdHJIpHmB7u
 F6fi0Llq/thCcEKLzCLfmomqiRmST7iDuOyNsM1Nz+Sv01qg49i0kBJ
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
now split per subsystem: the driver builds with COMPILE_TEST and does
not depend on the platform series [1], which is under review separately.
The device tree nodes will follow with the other CS75xx dts changes once
the platform is merged.

There is no public documentation; the register layout comes from the GPL
vendor kernels. Tested on a Securifi Almond+ (CS7542) with the SX8650
touchscreen controller at 0x48: reads are ACKed, an empty address returns
-ENXIO without timeouts. Repeated START between messages has not been
exercised on the board.

[1] https://lore.kernel.org/all/20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com/

---
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
 drivers/i2c/busses/i2c-cs75xx.c                    | 392 +++++++++++++++++++++
 4 files changed, 460 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261015-cs75xx-i2c-944d27231b4c

Best regards,
--  
Fil Dunsky <filipp.dunsky@gmail.com>


