Received: from mail-m3293.qiye.163.com (mail-m3293.qiye.163.com [220.197.32.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AA3385B9;
	Wed, 26 Aug 2026 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787728886; cv=none; b=cuIASpFZv21aat6LtqJbPN72xw5Xhsb1qD0jyg/8uBaXUq/mxaOb8TX4hfronACK7WqduAFR2AKu6upM024zboiMMzcE7ylcURtZSfL6SVzcyEP9MdS+hUoJ3xRmWpTGstCxqxkpMli3197FARqsdClHOMgUTNm/Vybe86KMQ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787728886; c=relaxed/simple;
	bh=FoPI1AL9EJh+RKPRZgggQYZVP0ZzmGovErjxxaWGdG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2vFWvLtHQcw592sTmwYbjjtkXDqKZZYvwDQkCqIkJQBzS4hQXgj1cKno/TlxDORrhc8CpYchhHWgtouQa34aa7/TbJGx7OKYxf4fmh6mwzr5mxUrN3YbXeADuuVzQTgeSoHrnDM9wEx9PkplSc4ihv9DpDjRCab3EwmeRtsj0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b=V9WBV0zF; arc=none smtp.client-ip=220.197.32.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b="V9WBV0zF"
Received: from localhost.localdomain (unknown [122.224.147.158])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b5fd3e7f;
	Wed, 26 Aug 2026 15:05:53 +0800 (GMT+08:00)
From: Hongbo Yao <andy.xu@hj-micro.com>
To: mika.westerberg@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peter.du@hj-micro.com,
	gwilym.wu@hj-micro.com,
	clarke.li@hj-micro.com,
	Hongbo Yao <andy.xu@hj-micro.com>
Subject: [PATCH] i2c: designware: Enable interrupt mask workaround for HJMC3001
Date: Wed, 26 Aug 2026 15:05:47 +0800
Message-ID: <20260826070547.268672-1-andy.xu@hj-micro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa03ce3bec503aekunm322dfa57173bae
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHUxJVh5DGh4dTR1JGBlLSFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUpPTFVKTkNZV1kWGg8SFR0UWUFZT0tIVU
	pLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=V9WBV0zF24mSegWjhy0T9nTuj6YPV8G2K3OesaRxnUOdZ4GOsVqm+8Dk9ZlgNKeW/e7L6JHO/fKGM2eXRQFfZWh2LapWWBi4fIIe8A0QxfAfIkqSW0gPXjgueXPEpNkFhzb+wm/CvC5FauJ399RGd6QG6a2wougvQ1Pb0eJZzO8=; s=default; c=relaxed/relaxed; d=hj-micro.com; v=1;
	bh=OuwAV37EhEcI+VQt9z5O7EYJ9Mk0bkktvZ5wmn3RfRY=;
	h=date:mime-version:subject:message-id:from;

On HJMicro ARM64 servers, the DesignWare I2C controller does not
retrigger a pending interrupt if the interrupt status changes after
the current status bits have been cleared.

The issue is exposed under heavy system load when the corresponding
SPI is routed across sockets to a core in the remote socket. The
interrupt is then lost and the I2C transfer times out.

Enable ACCESS_INTR_MASK for HJMC3001. This toggles DW_IC_INTR_MASK
before returning from the interrupt handler and retriggers any
pending interrupt.

Fixes: 6816ce57c479 ("i2c: designware: Add a new ACPI HID for HJMC01 I2C controller")
Signed-off-by: Hongbo Yao <andy.xu@hj-micro.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6d6e81242f74..447af5523c2e 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -272,7 +272,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "HISI02A1", 0 },
 	{ "HISI02A2", 0 },
 	{ "HISI02A3", 0 },
-	{ "HJMC3001", 0 },
+	{ "HJMC3001", ACCESS_INTR_MASK },
 	{ "HYGO0010", ACCESS_INTR_MASK },
 	{ "INT33C2", 0 },
 	{ "INT33C3", 0 },
-- 
2.43.0

