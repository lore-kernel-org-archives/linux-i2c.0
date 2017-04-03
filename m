From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 5/9] i2c: mux: pca954x: stop double error reporting
Date: Mon, 3 Apr 2017 10:38:34 +0200
Message-ID: <1491208718-32068-6-git-send-email-peda@axentia.se>
References: <1491208718-32068-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0104.outbound.protection.outlook.com ([104.47.0.104]:28716
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752224AbdDCIhe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 3 Apr 2017 04:37:34 -0400
In-Reply-To: <1491208718-32068-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org

i2c_mux_add_adapter already logs a message on failure.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 15dfc1648716..b2a85a2d00f7 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -434,13 +434,8 @@ static int pca954x_probe(struct i2c_client *client,
 				   idle_disconnect_dt) << num;
 
 		ret = i2c_mux_add_adapter(muxc, force, num, class);
-
-		if (ret) {
-			dev_err(&client->dev,
-				"failed to register multiplexed adapter"
-				" %d as bus %d\n", num, force);
+		if (ret)
 			goto fail_del_adapters;
-		}
 	}
 
 	dev_info(&client->dev,
-- 
2.1.4
