Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B89E43F4B7;
	Thu, 24 Sep 2026 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239190; cv=none; b=bzRVhUWcQlngxNEPN4MPhIKYpqFPiRhltsfBrcx6NkAMo0cQrP3IrWsR4AfcRATT3AYMW4lWY4F4GNun24VedMtCFxZUdualQlh0UqIyu/Lnxy96OVmw6Pyz3UW11ZSj9BLeVV8eHjTbXmhYkqYa5BqlUJAU+6MNkgil0agJCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239190; c=relaxed/simple;
	bh=0Zdvv1H2vY20qgMq7ejxgwzP9h/gzw/1guKtZBvMtyI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cWeus+u5BoZl3eNOMfV1saRqx0TqhfgmHR3MNWQPERS+VDhYxm0bDVqmaUFHt+9NAtv0SxVOhgb9VTaXGsz0DjlGHn31AR3njeQcK2VdbTLs/v+V612Vqhd15JRCeGd1OxQW8FcUYtAiN6QmHqMsVAhNDKfnHnVBkfXmWNWGcDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcN3KziG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcN3KziG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31838C2BCB3;
	Thu, 24 Sep 2026 08:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790239190;
	bh=0Zdvv1H2vY20qgMq7ejxgwzP9h/gzw/1guKtZBvMtyI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZcN3KziGgutG27SBVDaV0ndw5NE1mEgic1nLx0Dl2HKzZVLXipajJwr+SAE1qQhhD
	 D6b7oSGmwYUoyuBJOSF41BbCWnAktaeBKLX5d/OOVpDNM+O9xLd92MgaU6mkfVhsf8
	 dotZmBodZcIJzn8CX5C/tpEx//mybOTdxi1es9Ts0y3nRHzNUAlcn40TTJ6Y4wT6pU
	 S8dF1zY3zWM1pMJ0Y0b3x7pbOhwVy/sLbgvzxLINzsRi3IH5gF6gcM6RAOejCBTm3y
	 recbRcQLf+RoOT4EhoiM5a9+Y//VeA2QMcBHOQ8TDt/NV0sAcSHExvlO+omPBmClJU
	 X/3vBAK0jSVYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E054C98311;
	Thu, 24 Sep 2026 08:39:50 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/3] i2c: Add driver support Amlogic A9 I2C
Date: Thu, 24 Sep 2026 08:39:33 +0000
Message-Id: <20260924-a9-i2c-v1-0-b8ad9b46f4a8@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMXhtGoC/x3NwQqDMBCE4VeRPbvUrGLVVyk9xHRa9xIlERGC7
 27S4898MIkigiLSVCUKODTq6nOYuiK3WP8D6yc3SSN9MxrDdmQVx9J1zwEi6IeWMp5tBM/Berc
 UnsmjMI9zL/MW8NXz//N6X9cN2hcA83cAAAA=
X-Change-ID: 20260911-a9-i2c-24478e22e683
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790239188; l=891;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=0Zdvv1H2vY20qgMq7ejxgwzP9h/gzw/1guKtZBvMtyI=;
 b=nGXvSYzZAE1DmqOkbjIhGAK1rvc731QofIqzvdiWy3K17AECnFpZbcvHNlqHn4CQZF0aDxGzi
 Itu9wKqZKCdDQ0N0sYYTz4I8Oo9Kwc2sEXWQEtzFtzrVBw+2vOkgWbf
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
Junyi Zhao (1):
      i2c: amlogic: Add Amlogic A9 I2C controller driver

Xianwei Zhao (2):
      dt-bindings: i2c: add Amlogic A9 I2C controller
      MAINTAINERS: Add an entry for Amlogic I2C driver

 .../devicetree/bindings/i2c/amlogic,a9-i2c.yaml    |  61 +++
 MAINTAINERS                                        |   8 +
 drivers/i2c/busses/Kconfig                         |   9 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-amlogic-a9.c                | 504 +++++++++++++++++++++
 5 files changed, 583 insertions(+)
---
base-commit: e817a366cd24ddc8f986ef43c5d54cc3f60b0c21
change-id: 20260911-a9-i2c-24478e22e683

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


