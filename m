Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771823;
	b=ZZNbjRi+PTd9PxT3xtnOirdSISG8aBavbOx9hGeFtdCnbBl7OTeGmMDjASTU+BSwmmky
	 PqZXgsvb4Gs/oGhpeEEy8HpGeOJvs2SOrVuo8jQnpi1A+AkoYn1YDq4Z7MrumOqfyVjHY
	 7nlop0p/y1vCyXOj6NJnLUb2/PbZCrIw6I4KWXwfEtPwNY/dXLRfsqcLn8r/7c6+nEoZb
	 +HnMbMcEIYEHmA9Mi0bDkaCytzWjRPZDPssMqIiOvyLjWFw55fadUYFjVC0jKsT/ICOSr
	 WgWdCapuft9Gnogb52yWh/WMxd/58bmKu7tM5ojzq8MxOMjx9zIqiEmp40PZ6Kt+ZQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771823;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=TDhUaSwpExXoEPbKoY0XsshOXew9PCQKh0NIxEseP88=;
	b=QADvff60n5RhszlSnKvB6s6SDvfBLVU68EYVvYwpR92Uq00tyycX5jX1R3k0NsgPDpGp
	 8/6jKD7fkJongF9Sj8LWRAbIXzwDRWy3TLqiOgxWsaULB7ipGigScQEOPxi6f2YkYP/LO
	 2AqB6XhdsawOkGuoBNFakQcRnxsKEIRjVXCHtOKKDYEJLwpei7cOs4U+Y4NkGL+I0ERb+
	 4XzKoFChysZW/dxiyrI3Q0h5DkBNMKeBsMaw1ybOMM1jI+7ZbqOSVJVcKR/E8UijR8+Fu
	 hwxsiw5MTc6fv1OO+TUATgW87c+f4OfwFmyAOK/CY+m8axDrUeOmnN3V5/qF/OTSuOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.13
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B611606A31E;
	Fri, 27 Nov 2026 09:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B611606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 83E6F1A0031;
	Fri, 27 Nov 2026 10:30:21 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4EA121A0030;
	Fri, 27 Nov 2026 10:30:21 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 79B3418000B5;
	Fri, 27 Nov 2026 17:30:18 +0800 (+08)
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
Subject: [PATCH v3 0/2] Add NXP PCA9641 I2C bus master arbiter support
Date: Fri, 27 Nov 2026 15:00:11 +0530
Message-Id: <20261127093013.2857245-1-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This series adds a device tree binding and an I2C mux driver for the NXP
PCA9641 2-to-1 I2C bus master arbiter. The PCA9641 lets two upstream I2C
masters share a single downstream slave bus using a lock/grant protocol:
a master sets LOCK_REQ, waits for LOCK_GRANT, sets BUS_CONNECT to close
the switch, performs its transactions and then clears LOCK_REQ to release
the bus. The driver plugs into the i2c-mux core as an I2C_MUX_ARBITRATOR.
Ownership is awaited by polling or, when an interrupt is described and
its provider is suitable, with the INT0/INT1 output.

Changes in v3:
- Binding: unchanged, the Acked-by from Conor Dooley is retained.
- Driver: the interrupt is now an exclusive hard IRQ that is disabled
  while idle and armed only during select. The handler does not access
  the bus; it disables the line and wakes the waiter, which masks and
  acknowledges the sticky status under the parent adapter lock.
- Driver: unmask only LOCK_GRANT and always verify LOCK_GRANT in CONTR,
  so a spurious or missing interrupt only causes bounded polling.
- Driver: use polling when the interrupt provider needs bus locking, when
  the trigger is neither level low nor falling edge, or when the request
  fails.
- Driver: return -EOPNOTSUPP from select and deselect in atomic context;
  atomic transfers are not supported.
- Driver: cancel pending lock requests on failed acquisition and retry
  failed bus releases and interrupt cleanup from delayed work while the
  device remains bound.
- Driver: set the Reserve Time register to 0.
- Kconfig: describe only the implemented functionality.
- MAINTAINERS: move the entry to its alphabetical position.

Changes in v2:
- Binding: add Acked-by from Conor Dooley; no functional changes.
- Driver: drop IRQF_SHARED from the IRQ request.
- Driver: clear the latched LOCK_REQ on every timeout path in
  pca9641_select_chan() so a master that gives up does not block the
  peer master.
- Driver: reorder probe interrupt setup: mask all sources and clear
  stale INT_STATUS before requesting the IRQ.
- Driver: re-mask interrupts if i2c_mux_add_adapter() fails.
- Driver: unregister the child adapter before masking interrupts in
  pca9641_remove().
- Driver: use a named initializer for the i2c_device_id table.

Shiv Prakash Gupta (2):
  dt-bindings: i2c: Add NXP PCA9641 I2C bus master arbiter
  i2c: mux: Add NXP PCA9641 I2C bus master arbiter driver

 .../devicetree/bindings/i2c/nxp,pca9641.yaml  | 109 ++++
 MAINTAINERS                                   |   7 +
 drivers/i2c/muxes/Kconfig                     |  15 +
 drivers/i2c/muxes/Makefile                    |   1 +
 drivers/i2c/muxes/i2c-mux-pca9641.c           | 476 ++++++++++++++++++
 5 files changed, 608 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nxp,pca9641.yaml
 create mode 100644 drivers/i2c/muxes/i2c-mux-pca9641.c

-- 
2.34.1

