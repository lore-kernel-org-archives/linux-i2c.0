From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 1/7] i2c: add sanity check for parameter of i2c_verify_client()
Date: Thu, 20 Feb 2020 18:23:57 +0100
Message-ID: <20200220172403.26062-2-wsa+renesas@sang-engineering.com>
References: <20200220172403.26062-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200220172403.26062-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-i3c@lists.infradead.org, Kieran Bingham <kieran@ksquared.org.uk>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Luca Ceresoli <luca@lucaceresoli.net>, Jacopo Mondi <jacopo@jmondi.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vladimir Zapolskiy <vz@mleia.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

We export this function, so we should check the paramter to make it
NULL-compatible.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index cefad0881942..8f46d1bb8c62 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -517,7 +517,7 @@ EXPORT_SYMBOL_GPL(i2c_client_type);
  */
 struct i2c_client *i2c_verify_client(struct device *dev)
 {
-	return (dev->type == &i2c_client_type)
+	return (dev && dev->type == &i2c_client_type)
 			? to_i2c_client(dev)
 			: NULL;
 }
-- 
2.20.1
