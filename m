From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: [PATCH] i2c: mux: reg: don't log an error for probe deferral
Date: Tue, 12 Dec 2017 11:12:03 +0100
Message-ID: <20171212101203.22125-1-alexander.sverdlin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr00094.outbound.protection.outlook.com ([40.107.0.94]:47856
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752473AbdLLKNe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 12 Dec 2017 05:13:34 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Tomasz Bachorski <tomasz.bachorski@nokia.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, Alexander Sverdlin <alexander.sverdlin@nokia.com>

From: Tomasz Bachorski <tomasz.bachorski@nokia.com>

It's possible that i2c_mux_reg_probe_dt() could return -EPROBE_DEFER.
In that case, driver will request a probe deferral and an error
suggesting device tree parsing problem will be reported. This is
a pretty confusing information. Let's change the error handling,
so driver will be able to request probe deferral without logging
not related errors.

Signed-off-by: Tomasz Bachorski <tomasz.bachorski@nokia.com>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index f6c9c3dc6cad..e0be96e77231 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -177,7 +177,9 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 			sizeof(mux->data));
 	} else {
 		ret = i2c_mux_reg_probe_dt(mux, pdev);
-		if (ret < 0) {
+		if (ret == -EPROBE_DEFER) {
+			return ret;
+		} else if (ret < 0) {
 			dev_err(&pdev->dev, "Error parsing device tree");
 			return ret;
 		}
-- 
2.13.2
