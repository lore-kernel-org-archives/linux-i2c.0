Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D360285CBC;
	Thu, 18 Jun 2026 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791890; cv=none; b=vD2Vw4hZ3FXjhz9AZGVJa9ZFgv1+/FVnDt/8iQqN6SjZ3xwgmLcqNvJM+WFGooYD7K2Qvch2nTaIQO0ZVMMwJ/Ei3PlCBC+bECIgA141ZYRUla99ADfNqy+tTdemN2IEPyfzTqr/LO5iy0OsI20TMZ0zQpNJhT6Wa908P/1nNFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791890; c=relaxed/simple;
	bh=ib6CpK7PM3eC+bGLbP2YkPYXiYRrRFHgzh2jIkuj5i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjqQCMn3rD9gms1X+/SUEre8njIx1B2Rn6XKLsx4bLmXzZMlNgcRvfJUV6TTlElm6bSW8JnXUlolQHmuLcMwGJVojAq8FCLYaoN3D4egUoJT/Z9RwepKyWnGl3FAuHY2nKidS4ZsIR3hBtNyU9ARxj8hKIeOwwbu9ap5QSJpFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbADPevj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbADPevj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781791889; x=1813327889;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ib6CpK7PM3eC+bGLbP2YkPYXiYRrRFHgzh2jIkuj5i8=;
  b=ZbADPevjnAAVWYLODJEinj4jTNHqsS+4q+BpzEJlmz3il2ponIe6JhaT
   V9LCYq4sb13XrB4xVkjT+dc7XzlvMzAkHo6iWlW+CQVYwFzIKQRZQ/G2e
   qAqzp7nVCWuKuoAPYlCIeuLwy7HXgsBcp+DPqAuNmbU0TK6T215kIUg+M
   /YvIESHWWRyrUiYe5CeXEDIqCekPDTtn2Y7kXSPr+FzF0BQ+TKY7rghZH
   114W+waANihDa4+r3J8neOwOpGIIFURQ2p8lb5a54q4uZEMycL5gCxRsP
   tNHIKHvQso/TF+W2pecPjPJ8BPzg5SUjcHR0pF491auk3JaZJHN39BA5h
   w==;
X-CSE-ConnectionGUID: /ZlJ8gDUQiW7YgQAQpYHQQ==
X-CSE-MsgGUID: 8x848kxwQHmTqvzu9L7qbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82628700"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82628700"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:11:29 -0700
X-CSE-ConnectionGUID: IRc2AiKRQ6GqWWAtEqHUxQ==
X-CSE-MsgGUID: x/X/U1tTR4OFb7rac98JLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="244211142"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 18 Jun 2026 07:11:27 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BF3CF98; Thu, 18 Jun 2026 16:11:26 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] i2c: k1: Use generic definitions for bus frequencies
Date: Thu, 18 Jun 2026 16:11:25 +0200
Message-ID: <20260618141125.3241048-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we have generic definitions for bus frequencies, let's use them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-k1.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index 9152cf436bea..7732dd8b9074 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -91,9 +91,6 @@
 /* i2c bus recover timeout: us */
 #define SPACEMIT_I2C_BUS_BUSY_TIMEOUT		100000
 
-#define SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ	100000	/* Hz */
-#define SPACEMIT_I2C_MAX_FAST_MODE_FREQ		400000	/* Hz */
-
 #define SPACEMIT_SR_ERR	(SPACEMIT_SR_BED | SPACEMIT_SR_RXOV | SPACEMIT_SR_ALD)
 
 #define SPACEMIT_BUS_RESET_CLK_CNT_MAX		9
@@ -286,7 +283,7 @@ static void spacemit_i2c_init(struct spacemit_i2c_dev *i2c)
 		val |= SPACEMIT_CR_MSDIE;
 	}
 
-	if (i2c->clock_freq == SPACEMIT_I2C_MAX_FAST_MODE_FREQ)
+	if (i2c->clock_freq == I2C_MAX_FAST_MODE_FREQ)
 		val |= SPACEMIT_CR_MODE_FAST;
 
 	/* disable response to general call */
@@ -703,14 +700,14 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
 		dev_warn(dev, "failed to read clock-frequency property: %d\n", ret);
 
 	/* For now, this driver doesn't support high-speed. */
-	if (!i2c->clock_freq || i2c->clock_freq > SPACEMIT_I2C_MAX_FAST_MODE_FREQ) {
+	if (!i2c->clock_freq || i2c->clock_freq > I2C_MAX_FAST_MODE_FREQ) {
 		dev_warn(dev, "unsupported clock frequency %u; using %u\n",
-			 i2c->clock_freq, SPACEMIT_I2C_MAX_FAST_MODE_FREQ);
-		i2c->clock_freq = SPACEMIT_I2C_MAX_FAST_MODE_FREQ;
-	} else if (i2c->clock_freq < SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ) {
+			 i2c->clock_freq, I2C_MAX_FAST_MODE_FREQ);
+		i2c->clock_freq = I2C_MAX_FAST_MODE_FREQ;
+	} else if (i2c->clock_freq < I2C_MAX_STANDARD_MODE_FREQ) {
 		dev_warn(dev, "unsupported clock frequency %u; using %u\n",
-			 i2c->clock_freq,  SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ);
-		i2c->clock_freq = SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ;
+			 i2c->clock_freq, I2C_MAX_STANDARD_MODE_FREQ);
+		i2c->clock_freq = I2C_MAX_STANDARD_MODE_FREQ;
 	}
 
 	i2c->dev = &pdev->dev;
-- 
2.50.1

