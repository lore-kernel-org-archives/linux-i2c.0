Received: from mail-m49211.qiye.163.com (mail-m49211.qiye.163.com [45.254.49.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFBC36215D;
	Thu, 13 Aug 2026 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607790; cv=none; b=RZ7DYFG8gD+rgNmbF7ExlaMAnp/ASS/+VHt96cq9Wef/1Ivyny7kr+E6sJmJQp/flNW+a0r4Sfl7dATI0tpne9PXT7RjzBACGxOyZmhwG6AuIH+dkD8QahG0lhfKF+fKLSsER2yRMcSWj4F8OE+XRb3jNkSdUNHf1lZDT1I5V9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607790; c=relaxed/simple;
	bh=1113FDagA0vvNX+6LC32uDr9rAeGzoW3zR8NJ+PRgrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov/PhDr8hmyvrUnoNEZNj2c7WuKLW7i3rvQgfCeOegh0uIEs6XbRQbhFI/9QntrdJh93AkglyZDblh650OkF8+4H8LZJm5UvMaDsUsOu3kpHhytSpbytfHv6ywu7BJM5+mIALL0+Rh/mqnwWzf3otJDTeJJEuoEQ7hTz68fAT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b=jWSkn/dZ; arc=none smtp.client-ip=45.254.49.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b="jWSkn/dZ"
Received: from 1clarkelill.hj-micro.com (unknown [122.224.241.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 49d542657;
	Thu, 13 Aug 2026 14:40:28 +0800 (GMT+08:00)
From: "clarke.li" <clarke.li@hj-micro.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	andy.xu@hj-micro.com,
	peter.du@hj-micro.com
Subject: [PATCH v4 2/2] ACPI: APD: Add clock frequency for HJMC01 I2C controller
Date: Thu, 13 Aug 2026 14:40:25 +0800
Message-ID: <20260813064025.45242-1-clarke.li@hj-micro.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813063005.42925-1-clarke.li@hj-micro.com>
References: <20260813063005.42925-1-clarke.li@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ff9d9cbe209d6kunm4b54ea4d3ed1a4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQx1PVkpPGU0fQx1IGUNISVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUlPSlVIT1lXWRYaDxIVHRRZQVlPS0hVSk
	tJT09PSFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=jWSkn/dZqyPAB8+4kI54gWJ9A8KsL6xh/2DLrz3ixxVAnLS51yqRs7eXTY0HwITtoJ+LZMXMbglHM//001rpetDpEviqecrUbl4G/9rCNUA3hsGG/2JM/bbm4mlbjeyI3QOODIVUZyJnT55BSzBoR2MtYl7znL98xM1IxxkHwp8=; s=default; c=relaxed/relaxed; d=hj-micro.com; v=1;
	bh=Q2Vs3tCI9iu/WJBoTZIFLC2cxl96URGhM1ZRNl/lDGY=;
	h=date:mime-version:subject:message-id:from;

From: Xiangyang Yu <hunter.yu@hj-micro.com>

I2C clock frequency for HJMC01 is 200MHz, define a new ACPI
HID for it.

Signed-off-by: Xiangyang Yu <hunter.yu@hj-micro.com>
Signed-off-by: Hongnan Li <clarke.li@hj-micro.com>
---
 drivers/acpi/acpi_apd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 275027ebd01f..e7366fcb76ee 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -193,6 +193,11 @@ static const struct apd_device_desc leca_i2c_desc = {
 	.fixed_clk_rate = 250 * HZ_PER_MHZ,
 };
 
+static const struct apd_device_desc hjmc_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 200 * HZ_PER_MHZ,
+};
+
 #endif /* CONFIG_ARM64 */
 
 #endif
@@ -263,6 +268,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	{ "HISI02A2", APD_ADDR(hip08_i2c_desc) },
 	{ "HISI02A3", APD_ADDR(hip08_lite_i2c_desc) },
 	{ "HISI0173", APD_ADDR(hip08_spi_desc) },
+	{ "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
 	{ "LECA0002", APD_ADDR(leca_spi_desc) },
 	{ "LECA0003", APD_ADDR(leca_i2c_desc) },
 	{ "NXP0001", APD_ADDR(nxp_i2c_desc) },
-- 
2.55.0

