From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 21/24] staging/iio/adc: fix dangling pointers
Date: Sat, 20 Mar 2010 15:13:02 +0100
Message-ID: <1269094385-16114-22-git-send-email-w.sang@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org
List-Id: linux-i2c@vger.kernel.org

Fix I2C-drivers which missed setting clientdata to NULL before freeing the
structure it points to. Also fix drivers which do this _after_ the structure
was freed already.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---

Found using coccinelle, then reviewed. Full patchset is available via
kernel-janitors, linux-i2c, and LKML.
---
 drivers/staging/iio/adc/max1363_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 9703881..1682fd0 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -556,6 +556,7 @@ error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
 error_free_st:
+	i2c_set_clientdata(client, NULL);
 	kfree(st);
 
 error_ret:
@@ -573,6 +574,7 @@ static int max1363_remove(struct i2c_client *client)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
+	i2c_set_clientdata(client, NULL);
 	kfree(st);
 
 	return 0;
-- 
1.7.0
