Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEF8286D73;
	Mon, 30 Mar 2026 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855836; cv=none; b=FYzLeZ2o9LG6Bc+FT+rJpZzb8uN/IgT50iJ+kRuUl+rRXB/f1wkjTDSMARgAlOBql8Omc4K1YD6huaetoU+2/8L7kgbK/fRmfhkaE1Op2uEbzAuZxEScUo8CeIpeaikNeDblaxm07cA7u4xKn3EfNHERXtxLQJAheIFO1aS9Yas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855836; c=relaxed/simple;
	bh=8txCKy0cIY/YJ5xHReKfEq7kDm9ITShL2ROCT8dUI9U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l0LEKBLPf55chSfOOecEcUC7yFHBzIYjpGOFJ9sj8fT/8uw6D2FLU86yez/3xqQj2E+rp76RQL809bQM66jxqerJxBYQ9Noz0HFYFu0iqySVAJbglvm3DB2VczNvT0B15gS/4LuwflBexpaZiKV8xyuOmB8yfsNPCEBDThp0NLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGWKGfkq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGWKGfkq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0537C19423;
	Mon, 30 Mar 2026 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774855835;
	bh=8txCKy0cIY/YJ5xHReKfEq7kDm9ITShL2ROCT8dUI9U=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IGWKGfkqwh54Td5GMvd9U1Ycv1Dfnz5zcr/+jY97l23kYmfvOYsaO9N7piDwRt7BB
	 CGNMoCODz7xvJ+rgyBJiO7ULzo8+g4+N58OVQ3xztUaW6oZhwk6AEIbBUwqE2OXrLu
	 zIXl/5QsovpaPIC6b3Y5fFOFixRFxibQAuTsFmDbG7eIeN/KMxS6da3IpC3YMV+G6Z
	 CaNZp6yMpkRQ3iBw/C9Lau3FgkN8ZP89R2EXRa4jrjAYCfiP61+dr4+mFSIv1yYMCG
	 qRX/q7Z9CutqbmWOsVO46CSQP3q7PMDx2v2VIDepunteVcBrDR9r2PMFvH/3+9ETny
	 PO9pVKuYykHgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6D5FF492F;
	Mon, 30 Mar 2026 07:30:35 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Subject: [PATCH v4 0/4] i2c: add support for Andes platform
Date: Mon, 30 Mar 2026 15:30:30 +0800
Message-Id: <20260330-atciic100-v4-0-d40822f63e4e@andestech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJYmymkC/22PQQ6CMBBFr2K6tmQ6BQquvIdxAcMgNRFMi0RDu
 LstxoQYlz/5782fWXh2lr047GbheLLeDn0I6X4nqKv6C0vbhCwQMAeFIKuRrCUFIJtKM+VFa+o
 6FaF/d9za5+o6nT/ZP+or0xgFsdFZPw7utR6bVOxFbwYIBlCVqBMsFWqjpZI190aZY9U37EemL
 qHhJqJ2wi8YB+Fm0IQSpMmyUum8AUPtP1pv6WJL60AXBIAtEYaffullWd4E3EHwLwEAAA==
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
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774855834; l=2820;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=8txCKy0cIY/YJ5xHReKfEq7kDm9ITShL2ROCT8dUI9U=;
 b=IFTl0zwTqspv0YWzjnUCFXSpskVBqNcKD1vyxDFvZtJeA++FI5JhnxuKqOJgltge55RQVodOa
 Oknphz5Lj2dC10c9UTfvpN+cDkSEidymTOyj2WQwwsFP4igV6SkFQGK
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
base-commit: 46ec065d8610c5e8d11a8b205a6b7bd3c40d46b8
change-id: 20260120-atciic100-da3ec68f7bb4

Best regards,
--  
Ben Zong-You Xie <ben717@andestech.com>


