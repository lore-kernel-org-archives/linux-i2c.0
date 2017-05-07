From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/2] i2c: mux: reg: rename label to indicate what it does
Date: Sun, 7 May 2017 08:16:29 +0200
Message-ID: <1494137789-32395-2-git-send-email-peda@axentia.se>
References: <1494137789-32395-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494137789-32395-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

That maintains sanity if it is ever called from some other spot, and
also makes the label names coherent.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 91b10afc8c34..17026b3d39a2 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -229,7 +229,7 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		ret = i2c_mux_add_adapter(muxc, nr, mux->data.values[i], class);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
-			goto add_adapter_failed;
+			goto err_del_mux_adapters;
 		}
 	}
 
@@ -238,7 +238,7 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 
 	return 0;
 
-add_adapter_failed:
+err_del_mux_adapters:
 	i2c_mux_del_adapters(muxc);
 err_put_parent:
 	i2c_put_adapter(parent);
-- 
2.1.4
