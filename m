From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 027/102] i2c: mv64xxx: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:31 +0200
Message-ID: <20170719152646.25903-28-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 5c4db65c5019b..887bc7d97a777 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -820,7 +820,7 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		goto out;
 	}
 
-	drv_data->rstc = devm_reset_control_get_optional(dev, NULL);
+	drv_data->rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(drv_data->rstc)) {
 		rc = PTR_ERR(drv_data->rstc);
 		goto out;
-- 
2.11.0
