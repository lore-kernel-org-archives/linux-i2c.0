From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 2/2] apds9802als: fix als sensing range value
Date: Tue, 28 Sep 2010 13:21:28 +0100
Message-ID: <20100928122127.492.81083.stgit@localhost.localdomain>
References: <20100928122109.492.4630.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100928122109.492.4630.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Hong Liu <hong.liu@intel.com>

The 4K and 64K in the hw spec acutally means 4095 (12bit) and 65535 (16bit).

Signed-off-by: Hong Liu <hong.liu@intel.com>
---

 drivers/misc/apds9802als.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/drivers/misc/apds9802als.c b/drivers/misc/apds9802als.c
index cfd004a..a55a215 100644
--- a/drivers/misc/apds9802als.c
+++ b/drivers/misc/apds9802als.c
@@ -55,9 +55,9 @@ static ssize_t als_sensing_range_show(struct device *dev,
 	if (val < 0)
 		return val;
 	if (val & 1)
-		return sprintf(buf, "4000\n");
+		return sprintf(buf, "4095\n");
 	else
-		return sprintf(buf, "64000\n");
+		return sprintf(buf, "65535\n");
 }
 
 static ssize_t als_lux_output_data_show(struct device *dev,
@@ -111,7 +111,7 @@ static ssize_t als_sensing_range_store(struct device *dev,
 	/* Reset the bits before setting them */
 	ret_val = ret_val & 0xFA;
 
-	if (val == 1) /* Setting the continous measurement up to 8k LUX */
+	if (val == 1) /* Setting the continous measurement up to 4k LUX */
 		ret_val = (ret_val | 0x05);
 	else /* Setting the continous measurement up to 64k LUX*/
 		ret_val = (ret_val | 0x04);
