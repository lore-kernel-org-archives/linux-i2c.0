Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E31653D0D3;
	Tue,  8 Sep 2026 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871355; cv=none; b=JcfSs27/mPHWeUI6T7F+LUyNR0X8wLUSdC+JzIFg/8IpRVlf6xNMs2EdBxKxf4w2YXg7gtt4EhJE6zvSvTVEHDJGdDbjDvXwT/XS31iUJ3eESYS1Z/A+rIn+RWAishT5srCS5TsvQS3BvEpapFqDFBwLeu3+KINOyyOfMBknSyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871355; c=relaxed/simple;
	bh=6qCT5APCzY0OyYr0mc5qAIkaNGMtgovLSnJ/xkVonsg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PEYOQsYdJVwMIdmCTaJ1NtfW6WzLn+cpGkeAaX+F2qLNf2yLTgAdMuqqwD+8X3BtX5kbaNEN5tg+iZv0jc2BgoF5YF+K9w18KUheWXr96vO5iVaa5j9t3sEc//yp4/Ozf5q3mG2vUTkioEhF1EpzqaFnYmhdWetSKn4iIVrK0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3DAAC1A004A;
	Tue,  8 Sep 2026 14:32:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 03ACA1A0043;
	Tue,  8 Sep 2026 14:32:30 +0200 (CEST)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 60BAE18000B6;
	Tue,  8 Sep 2026 20:32:27 +0800 (+08)
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
Subject: [PATCH 0/2] i2c: mux: Add NXP PCA9641 I2C bus master arbiter
Date: Tue,  8 Sep 2026 18:01:44 +0530
Message-Id: <20260908123146.1839854-1-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This series adds support for the NXP PCA9641 2-to-1 I2C bus master arbiter.

The PCA9641 allows two upstream I2C masters to share a single downstream
slave bus using a hardware lock/grant arbitration protocol. It provides
dedicated interrupt outputs (INT0/INT1) per upstream master and a 16-bit
inter-master mailbox.

The driver supports two arbitration modes:
- Interrupt mode: uses INT0/INT1 GPIO interrupt, with automatic fallback
  to polling when no IRQ is configured
- Polling mode: used when no interrupt is configured

Patch 1 adds the devicetree binding schema.
Patch 2 adds the driver with Kconfig, Makefile, and MAINTAINERS entries.

Shiv Prakash Gupta (2):
  dt-bindings: i2c: Add NXP PCA9641 I2C bus master arbiter
  i2c: mux: Add NXP PCA9641 I2C bus master arbiter driver

 .../devicetree/bindings/i2c/nxp,pca9641.yaml  | 109 +++++
 MAINTAINERS                                   |   7 +
 drivers/i2c/muxes/Kconfig                     |  15 +
 drivers/i2c/muxes/Makefile                    |   1 +
 drivers/i2c/muxes/i2c-mux-pca9641.c           | 395 ++++++++++++++++++
 5 files changed, 527 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nxp,pca9641.yaml
 create mode 100644 drivers/i2c/muxes/i2c-mux-pca9641.c

-- 
2.34.1
