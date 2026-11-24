Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795509233;
	b=ueD+j4vCkyzI9307ANiglRz174yEHcQRhMPlJIZnlBKaMso4EOAZE7nUZYL/LdVVT16l
	 +dyNcyVWAu+5KpL3da269YM/HbIOJE9c81i2n1irxha5Wda/90tO5/qh9acnS+zlnhQiF
	 vgo214zwmO2XsMSTz1aeL6sTrBl0QtL3Zu7GjsR2tJQir3IxHrf04J1jjj/HKwYzTJL6M
	 G0HIE4rjP3W854xZ+PuGIXvPNajGLyg7FYjEyidihi2eCLFhCun+MFgrnm97Karz9dTsA
	 CUlOT3Lauuvr0PdCUj1zP3SKdxciGs8nHPeHPWqdi4UPb4FldiYCUFoYDPsAY/dBfCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509233;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=bMGutusCWizYXok4KAQ0DcRKoi01uW7e+2Ks5VTygpw=;
	b=VleEU2W3zM7K0xw7bEvBf8+sPEOihlnmUkQZxfIRBcm8iDy5amTZlEZRXeKUqrYtmPGs
	 xvUb7dmbEvRMW8e57yLzmuF1UMuBf178pek9upJiDyUVlxZ/Lyh63X6OHuaa2MLM8zYAB
	 05FGdgFOcWhPCk2yNSNO2jibLx6bLbUPrqqEnZDNIaigh/7ovVnCDQpTnCmXFwGhtfhoP
	 KjULYRj3de1ddINvGPPXqdOJKl69W794ddq6m2TL0ziFKBTqOgZ4Ksbs46LWiYjQyXqMq
	 Y8IvudNLN1nLYH5fTxgOVzlcULJpfQQ7oaQImvOI9rhBsvOIM3D5gKdx2kjhjLKr/7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SBbXOvbb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB53606A33E;
	Tue, 24 Nov 2026 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SBbXOvbb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795509233;
	b=CC4bfturL8GBjrOPL85zrgzc6w3SI91jec+05P0PNxWQSgDvS8umlcEm5v+q8pJW1HeH
	 y6nAjZfjmHjQw8ahHQeayzD5BAGNj3pUmxzRM5O4aUzjyp3izrlcItoEBQpSOaXcqGC5F
	 FSX4yCSlXxt0UdQRtHzZ16tCRo2gFH3vILupS0KN8GFG11jaWNHc+rzrmMpJiSmU89VCN
	 X9iS7tO9DyDg30U+2N7tzaq3HqmUY0xwION3eMu6lgpGIdahnkO0jT6Miczw0BtDswB1O
	 zpINVmKFNPCm/ojYtBgL5DyZhsc/9FT4FpU/yTsE3+/17/nc8qiRkGEOEPZsYP2I39w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795509233;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=bMGutusCWizYXok4KAQ0DcRKoi01uW7e+2Ks5VTygpw=;
	b=3DusnGzqGLsZFqlnZ5hGQECNy+n1PBemH22ZXrtypUBOwjcyjY5TPseYsEk7MDyQNrZR
	 dTlRzAcIcFfkv2Pqx03o3Ht8yQa+YfpigQ4JhuTcbB/E7PlJfdA+NghOh42WvmTf7QJKc
	 +A6+odFhzq2FXs9BXipt+43cbZBN2aQUrTENGGNM5hNdAIJOl02mWhG3nt1Ar8W6eWXRP
	 CJEP2vlWBhPnfLREAZkNzV53Sd9iatDgUA+1z6kui3YcYyvOv0jiHui6wpcoR2ewAACsI
	 IQv6hEOqGbF4d6YeKA9kWgAvAuprq8nQu1e4LqcB8W40KPTtdJK2Qqcx3ne0lnB7l4g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 13FDE1F000C4;
	Tue, 24 Nov 2026 08:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795509233;
	bh=bMGutusCWizYXok4KAQ0DcRKoi01uW7e+2Ks5VTygpw=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=SBbXOvbbeTD5+XjNWwmaXPj03rA5GxfBZzhjkqYOdZjrxS1MWgxM+vVheI48IaoFz
	 UNFrhMkW2j5+RgtrBuhWXFq/09L5l+M3SHohDhFcABPKgjMfI/r7qcI93J503l0Fcw
	 ZuWnYmaOGdE9fOwrtWXVH1lRoEt/ULmrd/40u7D4eNy/5YfumrB7U9FnAKeB1EH0XI
	 hsUw08CkaGPOgEUppSuhV9IfmsxBlKzdSec6BZpV8fUeFjjHDDVRyxWQM/rfRTB/9/
	 TaI66ohtCLIlB5nKjRb6hJNwgYFwiFEODwRCXTHQFkOG4bPpg6yZM66HyPW0Semhnd
	 jPzqRhWBSaUKg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9595E4C945;
	Tue, 24 Nov 2026 08:33:42 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Subject: [PATCH v8 0/2] i2c: Add Cortina Systems CS75xx I2C controller
 driver
Date: Tue, 24 Nov 2026 11:33:41 +0300
Message-Id: <20261124-cs75xx-i2c-v8-0-d0800b967886@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOQW7DIBCF4atErEM1DIOxs+o9oi4ATxKqxK5MY
 rmKfPeCs7Ejdfmk+X54isRD5CQOu6cYeIwp9l0e9X4nwsV1Z5axzVsgYKVAGRmSNdMkIwbZELV
 oUStPQWTwM/ApTkvs+PXa6eG/OdxLoVxcYrr3w+/y2kjl7hVW2/BIEiR5VTG7pna2/jzfXLx+h
 P4mSng0K4qwoSZT0J4DEjpDzTut1lRvaJUpGiBtDZMmfKf2f2rLhxFq4HDS4HlN53n+A6Sd51d
 nAQAA
X-Change-ID: 20261015-cs75xx-i2c-944d27231b4c
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795509221; l=5461;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=12oZJRAbn5pcMnzdV46XLYCoHoe0xUgOhjJv5sF0cBM=;
 b=OW4c397SmskB8de/DOxAbl110UZ8MF5OmQzL3TsjN3RzlTv1I6pbkYF/U412bhqbVyQe9+v1e
 STYqokLCsP5BguJU2dBUnhJZndndheNqa4zZ6ThEDhDXRLKwXtwYzy7
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

[1] https://lore.kernel.org/all/20261122-b4-cs75xx-v9-0-1fc1b90bd097@gmail.com/

---
Changes in v8:
- Complete arbitration loss immediately with -EAGAIN rather than
  submitting a STOP command after losing bus ownership. Keep the
  existing STOP completion handling for NACK and other errors.
- Exercise the actual state-machine code with recording MMIO mocks
  and compile the updated driver as an ARM module on Linux7.4 and6.18.
  No new multi-master hardware test is claimed.
- Link to v7: https://patch.msgid.link/20261123-cs75xx-i2c-v7-0-42080ecf30be@gmail.com

Changes in v7:
- binding: put clocks before interrupts in properties, required and
  the example; keep clock-frequency next to clocks (sashiko-bot)
- no change to the driver or to the schema constraints
- Report: https://lore.kernel.org/all/sashiko-outbox-228684@kernel.org/
- Link to v6: https://patch.msgid.link/20261123-cs75xx-i2c-v6-0-2504375e4342@gmail.com

Changes in v6:
- refresh the link to the independently posted platform series (v9)
- remove the unused CS75XX_I2C_CTRL_DONE definition (sashiko-bot)
- document that IRQ acknowledgement uses CTRL read/writeback, as in the
  vendor driver; keep that tested sequence without a functional change
- Link to v5: https://patch.msgid.link/20261120-cs75xx-i2c-v5-0-03bec242a549@gmail.com

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
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Fil Dunsky (2):
      dt-bindings: i2c: Add Cortina Systems CS7542 I2C controller
      i2c: Add Cortina Systems CS75xx I2C controller driver

 .../bindings/i2c/cortina,cs7542-i2c.yaml           |  56 +++
 drivers/i2c/busses/Kconfig                         |  11 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-cs75xx.c                    | 393 +++++++++++++++++++++
 4 files changed, 461 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261015-cs75xx-i2c-944d27231b4c

Best regards,
--  
Fil Dunsky <filipp.dunsky@gmail.com>


