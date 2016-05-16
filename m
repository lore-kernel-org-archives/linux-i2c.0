From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: [PATCH v2 5/5] i2c: demux: Use changeset helpers for clarity
Date: Mon, 16 May 2016 19:41:28 +0300
Message-ID: <1463416888-22044-6-git-send-email-pantelis.antoniou@konsulko.com>
References: <1463416888-22044-1-git-send-email-pantelis.antoniou@konsulko.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37211 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbcEPQlo (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 16 May 2016 12:41:44 -0400
Received: by mail-wm0-f42.google.com with SMTP id a17so145431408wme.0
        for <linux-i2c@vger.kernel.org>; Mon, 16 May 2016 09:41:43 -0700 (PDT)
In-Reply-To: <1463416888-22044-1-git-send-email-pantelis.antoniou@konsulko.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Pantelis Antoniou <panto@antoniou-consulting.com>

The changeset helpers are easier to use, use them instead of
using the static property.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 8de073a..ddaca9e 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -37,8 +37,6 @@ struct i2c_demux_pinctrl_priv {
 	struct i2c_demux_pinctrl_chan chan[];
 };
 
-static struct property status_okay = { .name = "status", .length = 3, .value = "ok" };
-
 static int i2c_demux_master_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
 	struct i2c_demux_pinctrl_priv *priv = adap->algo_data;
@@ -219,7 +217,8 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 		priv->chan[i].parent_np = adap_np;
 
 		of_changeset_init(&priv->chan[i].chgset);
-		of_changeset_update_property(&priv->chan[i].chgset, adap_np, &status_okay);
+		of_changeset_update_property_string(&priv->chan[i].chgset,
+				adap_np, "status", "okay");
 	}
 
 	priv->num_chan = num_chan;
-- 
1.7.12
