From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] i2c: mux: pca954x: Move device_remove_file() out of pca954x_cleanup()
Date: Thu,  5 Mar 2020 17:53:51 +0200
Message-ID: <20200305155352.39095-4-andriy.shevchenko@linux.intel.com>
References: <20200305155352.39095-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38464 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgCEPx4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 5 Mar 2020 10:53:56 -0500
In-Reply-To: <20200305155352.39095-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

device_create_file() is called the last in ->probe() but pca954x_cleanup(),
which is called earlier in error path, tries to remove never created file.
Move device_remove_file() call outside of pca954x_cleanup() to make it
slightly closer to what pca954x_init() is doing.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index fe4320fc0b91..2f8f034040cb 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -383,11 +383,8 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
 static void pca954x_cleanup(struct i2c_mux_core *muxc)
 {
 	struct pca954x *data = i2c_mux_priv(muxc);
-	struct i2c_client *client = data->client;
 	int c, irq;
 
-	device_remove_file(&client->dev, &dev_attr_idle_state);
-
 	if (data->irq) {
 		for (c = 0; c < data->chip->nchans; c++) {
 			irq = irq_find_mapping(data->irq, c);
@@ -531,6 +528,8 @@ static int pca954x_remove(struct i2c_client *client)
 {
 	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
 
+	device_remove_file(&client->dev, &dev_attr_idle_state);
+
 	pca954x_cleanup(muxc);
 	return 0;
 }
-- 
2.25.1
