Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795410660;
	b=y4nzEzF3y+fiR5IMJGe0zDc9/E2kkYpH8TeOK8I9yD4hyURlR2EohLw4Qcb/1zgh9yq9
	 CI5rW9/M23YSjesidK3mEuQV9aYI8deFDCFk3DPKP5bUIqo7tTnyH2JCjm+cMFbW9H8oj
	 JiIxbJbhqzbB1TBqFybE0i3IGznaXKsaktDyk8LUacQ3/w2dfhHWIyThtHMBBKSA8TAka
	 j1KsdJp+u36FhOm7TFKLJaTrAmnKWlpTrqMLGgBEYlaARJkjqBRh1px8MeQpRc+6jOdrn
	 ppuFTDrqsuNbzuH9hjXoDLMTBsBsyxeHFsMEnE7WAEHW2oX5yRvmWCvtDEQQNWbYgOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410660;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=KpCVQm8sazBmaUxbSaoPtIvbUj/i9wYjIRteHG/i/IA=;
	b=Kbn4/36g9lWbAnr6n53ReIYdbmX3StEM2cRWpbSoEngbdmoOGlVkfrYVQJ3C0mlQB3S3
	 qusu74yL9vNxyBNhGhdxpm2QgJZ+0f4mwD1D1XAlAVYbxnJEwo9RnCZtz8qzv4s3MX3T5
	 /PiY1ceNIWflwzrriVcg7pTNbzWdJ3pa+BH0ouAjNbe3ZskjuDuPLGxrP27pyVbWC6PuS
	 uPTeqxe6CnNopTZg3UIstDnoWInX2zey9W5cV257dAzO3QPcowWI8k2Xgy9QSIRRwYItS
	 9KAqDpsVL6RRCBFA3tB6ui0dWUFeF1T7Kjk91XdG+2D41jCz1I/eVaxh7RP/bzRxtYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFLUVE4L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E65606A31A;
	Mon, 23 Nov 2026 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFLUVE4L
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795410659;
	b=Ojs3TJTWYxfkI/PiQnP6VFE+IKhlFrRUrki0em0Q57hGHdWSiUb3tbAHi+X1224q1odY
	 MHP99PZnocuryxaROjDuvB5RKAOTQ5jdeGtijkRo793Sc49ZL9t/bobLhKrXaZFOdeNeh
	 PBTH2T7DawxNi7xjEITPJtQO688t+93vynPObwJcYx1goxku7l8Q1hgSw/vDxgYrwXrdV
	 g3cJo1p9iC31gvZqqtn4aEDCR5Hj0zqade78Vn4GrLliDspuxCplpy7aeZRts/FLIVF1P
	 0NlqkwXSmECiirsk4IeRTT/MKYbYeNRVhwf1BdAL+bX7Cq77gCbFQ0m7T0LpDM6YCuQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795410659;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=KpCVQm8sazBmaUxbSaoPtIvbUj/i9wYjIRteHG/i/IA=;
	b=FleIXvvkt+Y5IFvDxn8s+5o7c1MTqVHz/dij7ry9t0rfwXGjSxrEJTxahAUyqmdfJjsg
	 xsD6+ro6t+ztwXIjgBXo9j8Ij2j3+lNt5ZKnslFW8B/HJD06rOuUA+sS1A2saGuGGoZGT
	 XuKTFiw4Xf1YKNlgd3zB136IQJ61jKj8uM4vK97yqXz488KHgmkLvJmh/1odULVaex0NE
	 Uaheji+1CR8/IXREjRyX508L/Vj+OYmFCbVr8mz2IsLuKDGRKy8XuouxP2ZwusiJ94LAd
	 7NiB0ndBWXQbiYmyA0C3/7btAzpXcsJujUzCU57dapw7ovYvMrxoWWmdcLgsRdSloIg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B7CB51F000C6;
	Mon, 23 Nov 2026 05:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795410659;
	bh=KpCVQm8sazBmaUxbSaoPtIvbUj/i9wYjIRteHG/i/IA=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=YFLUVE4LBFqd0GUNlmOjV0aW37+Y8fClIzuiCiSusKyJ2rWlMf0jWv9/49vH+grug
	 JUI9qwuZmRY0Txgm+Eihh1PaNxe1wSgM2DvQZT2nArSQrfP5TuRV1avdfRgRNNnkKO
	 7CRyXNSC+SR9no40J/k47B7yDsb9GDHGDaBw7GNsw91BFJOeKMIkD4/1X04vUdcBsg
	 a52gc0P/l8+2QIUqZrBpYCyLRCxUdqVLMWllq5yYKEh0ZXOx3ZsP6CKXYNBt2kSDPL
	 6NKrNQGTcjbAoLri6OIL3rNwZdsrQ3oNEDdIQQQKTaDf9RBHL9Chnoq22WDCJEIJWr
	 27aJsqS8S9ZjA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1DD6E4C356;
	Mon, 23 Nov 2026 05:10:53 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Subject: [PATCH v7 0/2] i2c: Add Cortina Systems CS75xx I2C controller
 driver
Date: Mon, 23 Nov 2026 08:10:36 +0300
Message-Id: <20261123-cs75xx-i2c-v7-0-42080ecf30be@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13NQQ6CMBCF4auYrq1pp9NWXHkP46Ito9YoGIoEQ
 7i7BTfg8iXz/TOwRE2kxA6bgTXUxRTrKg+73bBwc9WVeCzzZiDASCE1D8nqvucRAi8QS7CgpMf
 AMng1dIn9HDudfzu9/Z1COxWmi1tMbd185m8dTne/sFyHO+SCo5eGyBV7Z/fH69PFxy7UTzaFO
 72gIFZUZyqUpwAITmPxT82SqhU1mYIWqKwmVAhLOo7jFwFOIrAsAQAA
X-Change-ID: 20261015-cs75xx-i2c-944d27231b4c
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795410652; l=5039;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=HT4fxKXmIukg5/BNp/RMBje9xBUThhOWmB92qEoAFKQ=;
 b=uRX1jTG7oj+OjnSPYUUrB01WueEIZjGBHSX4UHbyT9N8qiTtw63DKYH6M9/pczNvXbyIkEVC5
 jwS+NlWSeTwBzUK0uCQ3TH0Cg+q3FfCXPVok1XYfJWIYtD3zucatp+0
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

AI assistance: Codex reordered the binding and ran the v7 checks.

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
 drivers/i2c/busses/i2c-cs75xx.c                    | 393 +++++++++++++++++++++
 4 files changed, 461 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261015-cs75xx-i2c-944d27231b4c

Best regards,
--  
Fil Dunsky <filipp.dunsky@gmail.com>


