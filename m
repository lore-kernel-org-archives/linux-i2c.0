From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] i2c: mux: pinctrl: potential NULL dereference on error
Date: Thu, 17 Aug 2017 14:53:55 +0300
Message-ID: <20170817115355.fsc3z64eih7wjze6@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:39237 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdHQLyY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 17 Aug 2017 07:54:24 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org

If i2c_mux_alloc() fails then we'd have a NULL dereference here.

Fixes: c4aee3e1b0de ("i2c: mux: pinctrl: remove platform_data")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index 20b90a7a1e61..cc6818aabab5 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -173,7 +173,7 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 err_del_adapter:
 	i2c_mux_del_adapters(muxc);
 err_put_parent:
-	i2c_put_adapter(muxc->parent);
+	i2c_put_adapter(parent);
 
 	return ret;
 }
