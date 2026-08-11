Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944B53F327E;
	Tue, 11 Aug 2026 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786429790; cv=none; b=h3bfuDeBx4OKC0Im6QdY0cKhHt70qfyffZ0WeLeR22ub++NYmuwO5EllVEDPVrd72c84ifXvmh/xVjf35s7ClQbdrx5wkSw4sUnyhSex89sQRELoYtgwfBzhS8nBs5kgN0ELt03JnQ8PazXWyJbOte2YbNqzBxiV9ZJ4TU2/Nz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786429790; c=relaxed/simple;
	bh=F0l8Ut4ZSPuzkllETcP01MYrU4Q5hmpjs05TRDA+HiQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Itsu6hvGeZYEoKHF5QTPrxIkO6u+MDsQScil1yyUOVLR+FFmYT20kRLxsjUMU3PXkk+Fh4pVI9XiiXyXQVf/3tlXqa47ttHFzRmFVQMTjgGTL3OZRXf0cS2tTBPE5EArnJSGh2S1d0D2ZeVxObEcxCcghcJUqELZsUFK8CIdJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK4Fsfyh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK4Fsfyh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25C79C2BCF4;
	Tue, 11 Aug 2026 06:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786429790;
	bh=F0l8Ut4ZSPuzkllETcP01MYrU4Q5hmpjs05TRDA+HiQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aK4Fsfyh2/8oYwDkn9SP0lurq0xbkGP8yaOWJ2VdEZhkZI9Vldo5tRl4KS7Hy89/Y
	 X3sPH0LE9NEfEJR3pWM1EmLv/ef66s8y5XNIqsu4uSvlEgqiWOK45+v6lB/NwFZ+mM
	 GQf4Z8Mh8i317/5j2kBOhl31Khz1GgzyqX7FIgrTZUhvZH0OSZcZ0Kmn8tvZfNkwie
	 kjEux3awDSnMIbeFw1io5etWbaxsa79BxrgMKV22F9oEOISn5pdhcpdSsnpEfT2+yA
	 HjCOLPa+BKNx9Ih6L1efv3SiGDzqn8VJvoBlXKWFT2i6+3amO4aDEXKhpQYL9Wu91u
	 32hKCckpKoUUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13431C5B569;
	Tue, 11 Aug 2026 06:29:50 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Subject: [PATCH v5 0/4] i2c: add support for Andes platform
Date: Tue, 11 Aug 2026 14:29:47 +0800
Message-Id: <20260811-atciic100-v5-0-1d306c21dba3@andestech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFvBemoC/22Q3UrEMBBGX2XJtVkmM2nTeuV7iBftZGIj2C5ND
 crSdzdZEYvs5QffOfNzVUnWKEk9nq5qlRxTXOYSmoeT4mmYX0VHX7JCwBYMgh42jpENgPYDCbd
 dcONoVelfVgnx8+Z6fvnJ6WN8E96qoDammLZl/boNy6b2qrcBBAdoeqQz9gbJkTZ6lNkZ9zTMX
 tImPJ15eVdVm/EXrAvhYaGMGrRrmt5Q68FxuEfTke6ONBW6YwAMzFhuukfbP5ro+IxsC+0tdIi
 hJbHyn973/RuQfjhnbQEAAA==
X-Change-ID: 20260120-atciic100-da3ec68f7bb4
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Ben Zong-You Xie <ben717@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15-dev-09770
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786429789; l=2993;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=F0l8Ut4ZSPuzkllETcP01MYrU4Q5hmpjs05TRDA+HiQ=;
 b=HKTFdPEC6pUA6QPei0OVVHl8dgqgE4cYDe1MsiqCWNO/e6ODJ+BEX8vpehIgjfJCIRHExBDsI
 3uKnwMHbA1jAjno/ou9kgNMNBdYEunwaYt/pdVd9kIW+oXf2JdWLAkd
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com

This patch series adds I2C support to Andes platform, such as AE350 and
QiLai SoC.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
Changes in v5:
- Rebased on andi.shyti/i2c/i2c-host-next. No logical changes.
- Link to v4: https://patch.msgid.link/20260330-atciic100-v4-0-d40822f63e4e@andestech.com

Changes in v4:
- Rebased on andi.shyti/i2c/i2c-host-next.
- (1/4)
  - Added Conor's acked by tag.

- Link to v3: https://patch.msgid.link/20260128-atciic100-v3-0-8c002fcc2bb4@andestech.com

Changes in v3:
- (1/4)
  - Rewrote the commit message to provide a detailed hardware
    description and explain the relationship between the ATCIIC100 IP,
    the AE350 platform, and the QiLai SoC. (Krzysztof)

- Link to v2: https://patch.msgid.link/20260122-atciic100-v2-0-7559136d07cf@andestech.com

Changes in v2:
- ATCIIC100 is the hardware name for the Andes I2C controller and was used
  throughout v1. However, since Device Tree bindings should reflect the hardware
  identity and driver/config naming typically follows the i2c-<soc/platform>
  convention, this version replaces occurrences of "atciic100" with more
  appropriate names, such as "i2c-andes" or "andes_i2c," to align with upstream
  standards.
- Updated cover letter title and the description.
- Rebased on andi.shyti/i2c/i2c-host-next.
- (1/4)
  - Updated the title and the description of the patch.
  - Specified what the hardware is, and modify the title and compatibles. (Krzysztof)
  - Corrected device register size.
- (2/4)
  - Updated the title and the description of the patch.
  - Replaced the readl/writel operations with regmap APIs.
  - Replaced all occurrences of atciic100 with proper names.
  - Used module_platform_driver() to initialize. (Andi)
  - Moved CONFIG_I2C_ANDES (CONFIG_I2C_ATCIIC100 in v1) to the
    "Embedded system I2C/SMBus host controller drivers" section.
  - Made CONFIG_I2C_ANDES depend on ARCH_ANDES
- (3/4) (new)
  - Added an entry to the MAINTAINERS file.
- (4/4) (new)
  - Added the I2C node to QiLai DTS.

- Link to v1: https://patch.msgid.link/20250207021923.2912373-1-ben717@andestech.com

---
Ben Zong-You Xie (4):
      dt-bindings: i2c: add support for AE350 I2C controller
      i2c: add Andes I2C driver support
      MAINTAINERS: add an entry for Andes I2C driver
      riscv: dts: andes: qilai: add I2C controller

 .../bindings/i2c/andestech,ae350-i2c.yaml          |  45 +++
 MAINTAINERS                                        |   6 +
 arch/riscv/boot/dts/andes/qilai.dtsi               |   7 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-andes.c                     | 341 +++++++++++++++++++++
 6 files changed, 410 insertions(+)
---
base-commit: 04e9bf1648f846976b543e91c1838a712433772a
change-id: 20260120-atciic100-da3ec68f7bb4

Best regards,
--  
Ben Zong-You Xie <ben717@andestech.com>


