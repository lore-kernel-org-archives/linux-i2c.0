From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 3/7] of: fill the archdata for I2C devices
Date: Thu, 16 Oct 2008 21:12:56 +0400
Message-ID: <20081016171256.GC5515@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20081016171222.GA24812-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Steven A. Falco" <sfalco-7/gz0mrWfc7QT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

For I2C devices we just setting the the node pointer in the archdata.
This is needed so that the other code would know device's node.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 drivers/of/of_i2c.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 6a98dc8..f9e18ed 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -24,6 +24,7 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 
 	for_each_child_of_node(adap_node, node) {
 		struct i2c_board_info info = {};
+		struct dev_archdata dev_ad = {};
 		const u32 *addr;
 		int len;
 
@@ -41,6 +42,9 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 
 		info.addr = *addr;
 
+		dev_archdata_set_node(&dev_ad, node);
+		info.archdata = &dev_ad;
+
 		request_module(info.type);
 
 		result = i2c_new_device(adap, &info);
@@ -51,6 +55,13 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 			irq_dispose_mapping(info.irq);
 			continue;
 		}
+
+		/*
+		 * Get the node to not lose the dev_archdata->of_node.
+		 * Currently there is no way to put it back, as well as no
+		 * of_unregister_i2c_devices() call.
+		 */
+		of_node_get(node);
 	}
 }
 EXPORT_SYMBOL(of_register_i2c_devices);
-- 
1.5.6.3


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
