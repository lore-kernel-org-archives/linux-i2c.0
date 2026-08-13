Received: from mail-m60199.netease.com (mail-m60199.netease.com [210.79.60.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689341A4F6;
	Thu, 13 Aug 2026 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602658; cv=none; b=HZqwTMwFRQGpVQ+g+pYWwqjv8w0Q+Glx3dOugtX3uvR33jiGlXk9SsMCYx3ox7EfjSnHcYtlQ6hI5+kttBykHB2mq8uL1iVXwHxuE46DLmZRaN+5ExdMKRk6VtCrN7dgaWOP9GxqvzE10sSxIQj1pG2rVU4W8uvlU0Xhjlv15ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602658; c=relaxed/simple;
	bh=XFMM5bqs/AO41XLvj+2fa+9/dMCWI2BOAliSlrA6yfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOmhepO2LypzIv339K6FT5ZwqS7lhrlkgp0MoMgpS40z6IiKOihx2tTA/Ol6feFcP1AgTG+ehanbz5N3IVqGAeaYTOpjomCSPtkJ77ggtTl7lPjfwioCrOlmM9VA6gRGTL1hxxDR8O3uLK1sSd2+m26fhtMSePuhRDsMOgepaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b=ORVD9QRG; arc=none smtp.client-ip=210.79.60.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b="ORVD9QRG"
Received: from 1clarkelill.hj-micro.com (unknown [122.224.241.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 49d4e2e55;
	Thu, 13 Aug 2026 14:30:35 +0800 (GMT+08:00)
From: "clarke.li" <clarke.li@hj-micro.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	andy.xu@hj-micro.com,
	peter.du@hj-micro.com,
	Hongnan Li <clarke.li@hj-micro.com>
Subject: [PATCH v4 1/2] ACPI: APD: Convert fixed clock rates to use HZ_PER_MHZ
Date: Thu, 13 Aug 2026 14:30:04 +0800
Message-ID: <20260813063005.42925-1-clarke.li@hj-micro.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722073031.1078080-1-clarke.li@hj-micro.com>
References: <20260722073031.1078080-1-clarke.li@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ff9d0bfb709d6kunmebbce19d3eb22b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTBgeVk1MHk8dHkIaThpKHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUlPSlVIT1lXWRYaDxIVHRRZQVlPS0hVSk
	tISkpCTVVKS0tVSkJZBg++
DKIM-Signature: a=rsa-sha256;
	b=ORVD9QRG0gVXT//M+ul0h0JW6MQGVdP73fzOqC0ROOsNUxEnvHQ3T6IHLXASiU4dZ2KSMKDHJ70wWqEKGpWDpzO6kCIHAXFfpQgCII6rrAs5BcpxBWhpDH0XzAQiEIUBmHLVlq1UgoQjcoWRghfS1//r+zdOJtShFw+Ttno0Cz0=; s=default; c=relaxed/relaxed; d=hj-micro.com; v=1;
	bh=KJNrRzQ2oIZdJYb182wGJCuIuqJuvEH6CreRJX73yyE=;
	h=date:mime-version:subject:message-id:from;

From: Hongnan Li <clarke.li@hj-micro.com>

Use HZ_PER_MHZ multiplier for fixed_clk_rate values to
improve readability.

Signed-off-by: Hongnan Li <clarke.li@hj-micro.com>
---
 drivers/acpi/acpi_apd.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 008bd0552cb7..275027ebd01f 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/platform_data/clk-fch.h>
 #include <linux/platform_device.h>
+#include <linux/units.h>
 
 #include "internal.h"
 
@@ -110,17 +111,17 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 
 static const struct apd_device_desc cz_i2c_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 133000000,
+	.fixed_clk_rate = 133 * HZ_PER_MHZ,
 };
 
 static const struct apd_device_desc wt_i2c_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 150000000,
+	.fixed_clk_rate = 150 * HZ_PER_MHZ,
 };
 
 static const struct apd_device_desc wt_i3c_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 125000000,
+	.fixed_clk_rate = 125 * HZ_PER_MHZ,
 };
 
 static struct property_entry uart_properties[] = {
@@ -132,7 +133,7 @@ static struct property_entry uart_properties[] = {
 
 static const struct apd_device_desc cz_uart_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 48000000,
+	.fixed_clk_rate = 48 * HZ_PER_MHZ,
 	.properties = uart_properties,
 };
 
@@ -144,52 +145,52 @@ static const struct apd_device_desc fch_misc_desc = {
 #ifdef CONFIG_ARM64
 static const struct apd_device_desc xgene_i2c_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 100000000,
+	.fixed_clk_rate = 100 * HZ_PER_MHZ,
 };
 
 static const struct apd_device_desc vulcan_spi_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 133000000,
+	.fixed_clk_rate = 133 * HZ_PER_MHZ,
 };
 
 static const struct apd_device_desc hip07_i2c_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 200000000,
+	.fixed_clk_rate = 200 * HZ_PER_MHZ,
 };
 
 static const struct apd_device_desc hip08_i2c_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 250000000,
+	.fixed_clk_rate = 250 * HZ_PER_MHZ,
 };
 
 static const struct apd_device_desc hip08_lite_i2c_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 125000000,
+	.fixed_clk_rate = 125 * HZ_PER_MHZ,
 };
 
 static const struct apd_device_desc thunderx2_i2c_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 125000000,
+	.fixed_clk_rate = 125 * HZ_PER_MHZ,
 };
 
 static const struct apd_device_desc nxp_i2c_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 350000000,
+	.fixed_clk_rate = 350 * HZ_PER_MHZ,
 };
 
 static const struct apd_device_desc hip08_spi_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 250000000,
+	.fixed_clk_rate = 250 * HZ_PER_MHZ,
 };
 
 static const struct apd_device_desc leca_spi_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 400000000,
+	.fixed_clk_rate = 400 * HZ_PER_MHZ,
 };
 
 static const struct apd_device_desc leca_i2c_desc = {
 	.setup = acpi_apd_setup,
-	.fixed_clk_rate = 250000000,
+	.fixed_clk_rate = 250 * HZ_PER_MHZ,
 };
 
 #endif /* CONFIG_ARM64 */
-- 
2.55.0

