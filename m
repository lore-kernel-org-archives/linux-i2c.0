From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2 1/5] i2c: rcar: (cosmetic) remove superfluous parenthesis
Date: Thu, 12 Sep 2013 14:36:44 +0200
Message-ID: <1378989408-10618-2-git-send-email-g.liakhovetski@gmx.de>
References: <1378989408-10618-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1378989408-10618-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
List-Id: linux-i2c@vger.kernel.org

A recent patch added even more superfluous parenthesis to those, which
already were there. Remove them again.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/i2c/busses/i2c-rcar.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index d2fe11d..15eef94 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -306,7 +306,7 @@ scgd_find:
 	/*
 	 * keep icccr value
 	 */
-	priv->icccr = (scgd << (cdf_width) | cdf);
+	priv->icccr = scgd << cdf_width | cdf;
 
 	return 0;
 }
-- 
1.7.2.5

