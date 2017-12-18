From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: [PATCH v2] i2c: mux: reg: don't log an error for probe deferral
Date: Mon, 18 Dec 2017 17:18:39 +0100
Message-ID: <20171218161839.14821-1-alexander.sverdlin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0126.outbound.protection.outlook.com ([104.47.2.126]:10259
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935642AbdLRQTG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 18 Dec 2017 11:19:06 -0500
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
 drivers/i2c/muxes/i2c-mux-reg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index f6c9c3dc6cad..c948e5a4cb04 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -177,6 +177,9 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 			sizeof(mux->data));
 	} else {
 		ret = i2c_mux_reg_probe_dt(mux, pdev);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Error parsing device tree");
 			return ret;
-- 
2.13.2
