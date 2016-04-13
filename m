From: Axel Lin <axel.lin@ingics.com>
Subject: [RFT][PATCH 2/2] i2c: sun6i-p2wi: Prevent potential division by zero
Date: Wed, 13 Apr 2016 08:54:30 +0800
Message-ID: <1460508870.6009.3.camel@ingics.com>
References: <1460508570.6009.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36469 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757912AbcDMAyf (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 12 Apr 2016 20:54:35 -0400
Received: by mail-pa0-f66.google.com with SMTP id k3so2483864pav.3
        for <linux-i2c@vger.kernel.org>; Tue, 12 Apr 2016 17:54:35 -0700 (PDT)
In-Reply-To: <1460508570.6009.1.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-i2c@vger.kernel.org

Make sure we don't OOPS in case clock-frequency is set to 0 in a DT. The
variable set here is later used as a divisor.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/i2c/busses/i2c-sun6i-p2wi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index 7668e2e..6448291 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -202,6 +202,11 @@ static int p2wi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (clk_freq == 0) {
+		dev_err(dev, "clock-frequency is set to 0 in DT\n");
+		return -EINVAL;
+	}
+
 	if (of_get_child_count(np) > 1) {
 		dev_err(dev, "P2WI only supports one slave device\n");
 		return -EINVAL;
-- 
2.5.0
