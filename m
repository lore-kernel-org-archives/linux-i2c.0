Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83958411FBF;
	Thu, 17 Sep 2026 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635548; cv=none; b=ntbkzdt9ZaTP8eCn38aL183+R7nkIoQQvkb4fM0V388Praecwkagpw1F0yyzg/R/a7sbVTAUtpkPDvLWiG+JZhsLkFFqWEnhc7Wdu2Xjlzxl0oolk3zaK0yAi2gCas787YEm/LdxVuEWSi2sh0TDRavEicZVGghUdy75z7BAe6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635548; c=relaxed/simple;
	bh=d8OZXXA3/j9FC+/Jd6gcls4IlNBIslKKM7gOayq1wAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c+KvZv4oG7h6BTqOMddiWwaiYy3oUwIB5o6FkSCjbVhTlBlY4e8inuDvP1K/FDpcd7etYQPQap7mCOJjiqkPLQiv4dPWTEjQ/NA+XXil2lv8YD56K0JCOa/BTNjI/rpX3lMQi/0vTKzxvlJNLEi0qondXJKMJDkevAu9/wy4bMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F85E200044;
	Thu, 17 Sep 2026 10:59:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 58F812002C8;
	Thu, 17 Sep 2026 10:59:00 +0200 (CEST)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2C360180006C;
	Thu, 17 Sep 2026 16:58:59 +0800 (+08)
From: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peda@lysator.liu.se,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Subject: [PATCH v2 0/2] Add NXP PCA9641 I2C bus master arbiter support
Date: Thu, 17 Sep 2026 14:28:50 +0530
Message-Id: <20260917085852.552079-1-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This series adds device tree bindings and an I2C mux driver for the NXP
PCA9641 2-to-1 I2C bus master arbiter. The PCA9641 lets two upstream I2C
masters share a single downstream slave bus using a lock/grant protocol:
a master asserts LOCK_REQ, waits for LOCK_GRANT, sets BUS_CONNECT to open
the switch, performs its transactions, and then clears LOCK_REQ to release
the bus. The driver plugs into the i2c-mux core as an I2C_MUX_ARBITRATOR
and supports interrupt-assisted arbitration (via INT0/INT1 wired to a
GPIO) with a fallback to polling when no interrupt is configured.

Changes in v2:
- Binding: add Acked-by from Conor Dooley (no functional changes).
- Driver: drop IRQF_SHARED from the threaded IRQ request.
- Driver: clear the latched LOCK_REQ on every timeout path in
  select_chan() so a master that gives up does not block the peer.
- Driver: reorder probe interrupt setup - mask all sources and clear
  stale INT_STATUS before requesting the IRQ, then unmask LOCK_GRANT
  and BUS_LOST.
- Driver: re-mask interrupts if i2c_mux_add_adapter() fails.
- Driver: unregister the child adapter before masking interrupts in
  remove().
- Driver: use a named initializer for the i2c_device_id table.

Shiv Prakash Gupta (2):
  dt-bindings: i2c: Add NXP PCA9641 I2C bus master arbiter
  i2c: mux: Add NXP PCA9641 I2C bus master arbiter driver

 .../devicetree/bindings/i2c/nxp,pca9641.yaml  | 109 +++++
 MAINTAINERS                                   |   7 +
 drivers/i2c/muxes/Kconfig                     |  15 +
 drivers/i2c/muxes/Makefile                    |   1 +
 drivers/i2c/muxes/i2c-mux-pca9641.c           | 420 ++++++++++++++++++
 5 files changed, 552 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nxp,pca9641.yaml
 create mode 100644 drivers/i2c/muxes/i2c-mux-pca9641.c

-- 
2.34.1

