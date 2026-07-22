Received: from mail-m49210.qiye.163.com (mail-m49210.qiye.163.com [45.254.49.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16AD18A6CF;
	Wed, 22 Jul 2026 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705771; cv=none; b=RLXPoXLGlRlhG9xXn2HcH91ReCy5WXF9Nk/GUgW4ZjgiuCwW21IMD3UldFjsBEEQFtH+GYUM/NkuQF85wNa9CJD1OIitsUteixlGjv92NSG1zHMGkWZ8zjOdY1QwpZS2J4+59O1MRZnIEXWGrwMs4kpWPL8VFuWRoCjlg6O9oZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705771; c=relaxed/simple;
	bh=TLK1Rv1AmlTbINIklcoklmnRTZ4ZvCjAGAtyQka5Ay4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgRPqYANGyDVcmM1N2Yh7TL+0LME3Ddmk2K5+RZtj85FjE5SJSuXBLwKmsIHSLmpw3Os2bb7SlEzVoygD9eRrs3qrGehYew3EsViV8J4dsnm2CTYcJcJZKK2YX+T4G4hxlNkZNqRNn7txoc3ca5vFH2wv2t6tqu7sr+s9iHUyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b=NH3naXSF; arc=none smtp.client-ip=45.254.49.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b="NH3naXSF"
Received: from 1clarkelill.hj-micro.com (unknown [122.224.241.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 472001f3d;
	Wed, 22 Jul 2026 15:30:44 +0800 (GMT+08:00)
From: "clarke.li" <clarke.li@hj-micro.com>
To: andi.shyti@kernel.org,
	andriy.shevchenko@linux.intel.com,
	rafael@kernel.org,
	jarkko.nikula@linux.intel.com,
	jsd@semihalf.com,
	lenb@kernel.org
Cc: andy.xu@hj-micro.com,
	linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	peter.du@hj-micro.com,
	clarke.li@hj-micro.com
Subject: [PATCH v3] ACPI: APD: Add clock frequency for HJMC01 I2C controller
Date: Wed, 22 Jul 2026 15:30:31 +0800
Message-ID: <20260722073031.1078080-1-clarke.li@hj-micro.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <yha25jhjmd5qh4prwnyhqr2sfxvw7v2hzwhhv66twtx7ft4siz@fk3d4t2d73dj>
References: <yha25jhjmd5qh4prwnyhqr2sfxvw7v2hzwhhv66twtx7ft4siz@fk3d4t2d73dj>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f88bbe95209d6kunm3d6ca45574ff2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHhhPVk4eGhkeQkMZH0IeH1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUlPSlVIT1lXWRYaDxIVHRRZQVlPS0hVSk
	tJT09PSFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=NH3naXSFaXBIzGRfddkOrgdPTg9lSUDJeZ1o0yzq+3S2ypChpKmAujiECJylIN8xbj1GBgJ9+hqygF7Mph4aK70DHiPKMJ+JqrhW5kid25ZwzLdEjMiuy4Zxv+Yg3jJTLL01h0WJ0YGvJen4SKxqF4Bd3u/jMZy7ztdQqkVjVCI=; s=default; c=relaxed/relaxed; d=hj-micro.com; v=1;
	bh=ge/pmYth0IkVKjCzXp0bEbXzIs6tKqipYycsTpVSGP4=;
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
index 008bd0552cb7..a193d8a6538e 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -192,6 +192,11 @@ static const struct apd_device_desc leca_i2c_desc = {
 	.fixed_clk_rate = 250000000,
 };

+static const struct apd_device_desc hjmc_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 200000000,
+};
+
 #endif /* CONFIG_ARM64 */

 #endif
@@ -264,6 +269,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	{ "HISI0173", APD_ADDR(hip08_spi_desc) },
 	{ "LECA0002", APD_ADDR(leca_spi_desc) },
 	{ "LECA0003", APD_ADDR(leca_i2c_desc) },
+	{ "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
 	{ "NXP0001", APD_ADDR(nxp_i2c_desc) },
 #endif
 	{ }
--
2.55.0

