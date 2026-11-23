Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795409494;
	b=5rYF2MUvJqn/UMRJ2+E1z4vmgmE7kZdq5OMMiyqUmWFqnEjpxIzdCPj8L7TQ7M1i3ZjJ
	 7lp9W+SZ4USKcXjABHQJ8m3PR1kVMtD2PetB4y49AWa1jCNEkW6dAQhu+0PMnUVY44euQ
	 lsPLUzAGilbHcUWXBjNQMndVo2QohAfwL4MAU3dqWJTd9LYx+viI4SWHX9fwXhKOAJFLF
	 AOZAWztaKk8+bPRCWuiQ3H820uOoN5ptL0f4t2z3Mr51xqS7JFYvcPg3Clz0Ekf2D99s4
	 xHUWJyWFOD/KvrwDxbxbGigle30aO5JcflhdV0VkeJg6ZZcVVylmrgu7hq9TpfFS6ZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409494;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=XLg2hjZC1G2djzwWn8oQA+kDooRHaA9EI+qF4JhV/eM=;
	b=p8nZxdAlf+QGRs+TSOmbU6HCIzpS9y3zjwrvb8Oyd2NLpr1yS6K/VlQxeiXS+6oc3hXy
	 JvQtIa10cAWSTjT5zv1i663uxIy+DsENcDTS4Zl70BUt81ZuqrxkWUzgIle5TxnU8hDx8
	 5C1uWKEkMzmTQp28G7b+uk5TMu98f4wbZNZVgG0tvU6c12BVbKG5QHU++XzWqvsBHWlZO
	 ni2EG4LBzfj7C/l4IBKAH1WQUmVYC6NHdl6nN30+NuZN7ci9WaR8BwPAhgXxxkdQaFQ/1
	 gqV1sNnyGDLebbt3HOwbdC4SzUDfLnimyGbVEp6IOtyUk7TRokv6yYTZXocjT8VYaHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6QGKoug;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125F606A32C;
	Mon, 23 Nov 2026 04:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6QGKoug
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795409493;
	b=1cRfAzti2ELit5mO7vK78g/JPJCoAV9RJGANFlCToM3KSayfKUXD99LP1v65DifS3EzX
	 3YCQ+4iXvSVsWESsehlxyBCKSBua50uTP2BlFaFBPT54oilHzynF2ODDJiEKPBTm7IFzl
	 jiEoHIsjX53Yllba4HaAazauCX3e7bdm0AZVhRM2+TXPliPuCkjHn8Sti4CqnUoSnb3zN
	 A3qzmt/2x7bIQYPfr3I4S91gPlBvh6Ks40rf5j4mxTPO5CFNXnD/r+VRNH9LMgsHnsI/S
	 3hRWQ0q3r4G+FvhaWXTxOe5Kdwl6V1OxkjZfQ9lv+SmnMWwLli+r2e+I0RW/o4busTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795409493;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=XLg2hjZC1G2djzwWn8oQA+kDooRHaA9EI+qF4JhV/eM=;
	b=gV/n7PizDthgESwR1bdEUTIZnq9k5+v9vxVUb4anXRPWrRO2RWO1u+j3rCPrD1KWlr/M
	 5NpnbT5tlSWTu9yI1QXp+Lie30LN+IofoNnTkZtPFTsUmZsXP7FDy5JRkGChuPHiYGwXX
	 CLC7mVHs1LGad36/ZY5uxP3NbaaJEiHwjDb648/xB6I+bcHBUYdqlAjmJ/wvUgdMKvVFa
	 W/9lBkt/Lr/5/OH2QsBfjKHPEMpPEg9p7K0ZnJc6R+JjLY0xOirArsW41uHZ4hGfC64pG
	 brZZg36jcr5oFj+EH+TwkjB6x7hTbQy8IJITpgynXCXJm4dI/NbM62JwwvqCf1J2n5Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E92BE1F000CF;
	Mon, 23 Nov 2026 04:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795409493;
	bh=XLg2hjZC1G2djzwWn8oQA+kDooRHaA9EI+qF4JhV/eM=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=U6QGKougkOIYc0Ud81ynvLsQGfDr4UvwirSSpb/9fSJWI2J7Wn3bIjPFoLfbnLFpC
	 k4euLqz3dih8VfuLswRt7zOxa1EGT2st8Nbh6aexxuAED5N30RFE3FD4wqdo2owrd4
	 lgPJOX4zUn4tfGFYJOKiwcmNRnLakAEaG9p8L2xdoM3hgqeQ6riWDTS7i02Y+nQYTS
	 NIHdH+jQy+2GEyPj77h0Pb8G4ZBpoIlBFNPsqZeZGHF5njbGuZYSN37ZsqJkSXVbS5
	 jm40oW3MlfOtVzmLlja1C9I1HvOhjubKK0Y74YLRiQCBJGhF/BRSaBT7ou9HvKhopV
	 9haOIPCdzyJ0g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4B38C4C34E;
	Mon, 23 Nov 2026 04:51:25 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Subject: [PATCH v6 0/2] i2c: Add Cortina Systems CS75xx I2C controller
 driver
Date: Mon, 23 Nov 2026 07:51:07 +0300
Message-Id: <20261123-cs75xx-i2c-v6-0-2504375e4342@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNyw6DIBQFf8WwLg0g+Oiq/9F0AXirt2m1AUtsj
 P9e0I0uJzkzZyYeHIInl2wmDgJ6HPoIxSkjttN9CxSbyEQwUXDGFbW+VNNEUVhaS9mIUuTcSEu
 i8HHwwGmN3e4b+695gh1TIS069OPgfutbkGm3hfkxHCRlVBpeAOi60mV1bd8aX2c7vEkKB7VTB
 TuoKqosN2CFFFrJeq8uy/IH5mddb/EAAAA=
X-Change-ID: 20261015-cs75xx-i2c-944d27231b4c
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795409484; l=4600;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=GEyKhMRI/2+fxUWiuafhtbmysPTdFZ5xY723G1kKjF8=;
 b=7CSkes5p7tI36RifhQtdxRs7zr5ZzH0dCSmV0IruhuWCJuItknRbbk52rJEe7JM4wxcq8K9g7
 R/M4Hm0cqMXCH71XgwC/Eg+l9XQuKnr0aIMctaRd5cgrfnT0l1Xx7sF
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


