Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA90318B9B;
	Thu, 22 Jan 2026 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054014; cv=none; b=TGd4Dvoq2p7TSi13yIXO849/TBLxLHd5i/Fg+vA7G0Z1CI7U5YEgxgWte9bbzIVpbtYf8aBBqbi9W7fea9WAQeasUqT6prFFrnhp9X1Ws6Uece+VhhuJSpPKt7elzDghalG7D/E/5uSQ/xEzq/aCl/KdH3dRT5AWIk99Xnmu5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054014; c=relaxed/simple;
	bh=BsH5qp5mxn9oN1eQAvbNOgB+hDjXd7cRQq++eYiHMgU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BD6RNJ7Oq9ckeOy52x2UFZ3Ol7DwlN2LOafp9nxf+xEDcTlw3cdN+JUZBuShNiA4F166LPvSww5glRBeY0SrmzuHyg8y8PIpdZJrP5UKFcmzefW4h/uETuT0IBxOE7DEUhtCKJ0D86yGDh3GALUNEthlyL9N0FE9s0mVzpbXlIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVGaS1X/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVGaS1X/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EB43C116C6;
	Thu, 22 Jan 2026 03:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769054013;
	bh=BsH5qp5mxn9oN1eQAvbNOgB+hDjXd7cRQq++eYiHMgU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uVGaS1X/EO3n7dMzgO0K976K2bbmMs51JgLMjNlnGpy1UE7DKuZ04SyWItDAoO0Gg
	 87fOCswC9trWo4Uc1fAR6Ivvfp4McOQKpLgSFwjZXzq+npXd89DxgC8V9OKpLyrElO
	 aRRqwpXCuhccN/qrs3PqyeKTDJzePwrC8f4UNhzA4QOFY0PLGGhN/HYRPj9Fe6S9bh
	 wpMdsne68vUXakdyoiNFjX4kjNrm2ov19vbL49erda9vChYLasfGStstTQ+PfMS04L
	 8CA5b1ZusYTpJFurl1ri6T+HkfrRCEJm2WxaYjnhrZCkUf6smkFa6JsqJdhDs7CMBr
	 dT9blE3pCu9Pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C53DC44536;
	Thu, 22 Jan 2026 03:53:33 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Subject: [PATCH v2 0/4] i2c: add support for Andes platform
Date: Thu, 22 Jan 2026 11:53:17 +0800
Message-Id: <20260122-atciic100-v2-0-7559136d07cf@andestech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC2fcWkC/yWNQQ6CMBAAv0J6tmS7VSqe/Ifh0JZF1sRi2ko0h
 L9L8TjJZGYRiSJTEpdqEZFmTjyFDfBQCT/acCfJ/cYCARtQCNJmz+wVgOytJt+cB+PcUWz+K9L
 An7116/6c3u5BPpdAMUZOeYrffTar4pXuCRAMoGpR19gq1EZLJR0Fo8zVhp5SJj/WfnqKbl3XH
 5AJcgezAAAA
X-Change-ID: 20260120-atciic100-da3ec68f7bb4
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769054012; l=2312;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=BsH5qp5mxn9oN1eQAvbNOgB+hDjXd7cRQq++eYiHMgU=;
 b=MzvB4SwtZthro9prrDLjur33srf2OFFh7FyyKgieW7Q//4XlEJTYGkomf6WXTQ7XV4Aqe+l5H
 /xnw830+t18AaR7mzJb9MsFvGludOxKRas+WLy5wD7W+nhB+fNx2FOB
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
base-commit: aa5804b8fb64f446260cee45e7e8a722ac7ca839
change-id: 20260120-atciic100-da3ec68f7bb4

Best regards,
--  
Ben Zong-You Xie <ben717@andestech.com>


