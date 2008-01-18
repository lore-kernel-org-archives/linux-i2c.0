From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Drivers stop using the redundant client list
Date: Fri, 18 Jan 2008 09:06:05 +0100
Message-ID: <20080118090605.07d53985@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Michael Hunold <michael-nMDb6ONjQAQ@public.gmane.org>, video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The redundant i2c client list maintained by i2c-core is going away
soon, so drivers should stop using it now. Instead, they can use the
standard iterator provided by the device driver model
(device_for_each_child).

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Michael Hunold <michael-nMDb6ONjQAQ@public.gmane.org>
---
This patch goes on top of another patch by David Brownell that is
currently available here:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-dont-use-redundant-i2c_client-list.patch
I would appreciate if someone with the hardware in question could test
both patches and confirm that there is no regression.

Note: the tvmixer driver would need to be updated in a similar way, but
I am told that it is obsolete and will be deleted soon so I didn't
bother.

I plan to send this patch to Linux myself together with all other
related patched. This will avoid synchronization issues as these
patches all depend on each other and must be applied in the right
order. If this is a problem, please let me know.

 drivers/media/video/dpc7146.c |   19 +++++++++++++++----
 drivers/media/video/mxb.c     |   40 +++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 19 deletions(-)

--- linux-2.6.24-rc8.orig/drivers/media/video/mxb.c	2008-01-18 08:39:36.000000000 +0100
+++ linux-2.6.24-rc8/drivers/media/video/mxb.c	2008-01-18 08:40:35.000000000 +0100
@@ -149,10 +149,33 @@ struct mxb
 
 static struct saa7146_extension extension;
 
+static int mxb_check_clients(struct device *dev, void *data)
+{
+	struct mxb* mxb = data;
+	struct i2c_client *client = i2c_verify_client(dev);
+
+	if( !client )
+		return 0;
+
+	if( I2C_ADDR_TEA6420_1 == client->addr )
+		mxb->tea6420_1 = client;
+	if( I2C_ADDR_TEA6420_2 == client->addr )
+		mxb->tea6420_2 = client;
+	if( I2C_TEA6415C_2 == client->addr )
+		mxb->tea6415c = client;
+	if( I2C_ADDR_TDA9840 == client->addr )
+		mxb->tda9840 = client;
+	if( I2C_SAA7111 == client->addr )
+		mxb->saa7111a = client;
+	if( 0x60 == client->addr )
+		mxb->tuner = client;
+
+	return 0;
+}
+
 static int mxb_probe(struct saa7146_dev* dev)
 {
 	struct mxb* mxb = NULL;
-	struct i2c_client *client;
 	int result;
 
 	if ((result = request_module("saa7111")) < 0) {
@@ -195,20 +218,7 @@ static int mxb_probe(struct saa7146_dev*
 	}
 
 	/* loop through all i2c-devices on the bus and look who is there */
-	list_for_each_entry(client, &mxb->i2c_adapter.clients, list) {
-		if( I2C_ADDR_TEA6420_1 == client->addr )
-			mxb->tea6420_1 = client;
-		if( I2C_ADDR_TEA6420_2 == client->addr )
-			mxb->tea6420_2 = client;
-		if( I2C_TEA6415C_2 == client->addr )
-			mxb->tea6415c = client;
-		if( I2C_ADDR_TDA9840 == client->addr )
-			mxb->tda9840 = client;
-		if( I2C_SAA7111 == client->addr )
-			mxb->saa7111a = client;
-		if( 0x60 == client->addr )
-			mxb->tuner = client;
-	}
+	device_for_each_child(&mxb->i2c_adapter.dev, mxb, mxb_check_clients);
 
 	/* check if all devices are present */
 	if(    0 == mxb->tea6420_1	|| 0 == mxb->tea6420_2	|| 0 == mxb->tea6415c
--- linux-2.6.24-rc8.orig/drivers/media/video/dpc7146.c	2008-01-18 08:39:36.000000000 +0100
+++ linux-2.6.24-rc8/drivers/media/video/dpc7146.c	2008-01-18 08:40:35.000000000 +0100
@@ -87,11 +87,24 @@ struct dpc
 	int cur_input;	/* current input */
 };
 
+static int dpc_check_clients(struct device *dev, void *data)
+{
+	struct dpc* dpc = data;
+	struct i2c_client *client = i2c_verify_client(dev);
+
+	if( !client )
+		return 0;
+
+	if( I2C_SAA7111A == client->addr )
+		dpc->saa7111a = client;
+
+	return 0;
+}
+
 /* fixme: add vbi stuff here */
 static int dpc_probe(struct saa7146_dev* dev)
 {
 	struct dpc* dpc = NULL;
-	struct i2c_client *client;
 
 	dpc = kzalloc(sizeof(struct dpc), GFP_KERNEL);
 	if( NULL == dpc ) {
@@ -115,9 +128,7 @@ static int dpc_probe(struct saa7146_dev*
 	}
 
 	/* loop through all i2c-devices on the bus and look who is there */
-	list_for_each_entry(client, &dpc->i2c_adapter.clients, list)
-		if( I2C_SAA7111A == client->addr )
-			dpc->saa7111a = client;
+	device_for_each_child(&dpc->i2c_adapter.dev, dpc, dpc_check_clients);
 
 	/* check if all devices are present */
 	if( 0 == dpc->saa7111a ) {


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
