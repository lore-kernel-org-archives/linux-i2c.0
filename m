From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 2/2] sound: ppc: keywest: drop using attach adapter
Date: Thu, 16 Apr 2015 15:23:03 +0200
Message-ID: <1429190583-17517-3-git-send-email-wsa@the-dreams.de>
References: <1429190583-17517-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429190583-17517-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As we now have deferred probing, we can use a custom mechanism and
finally get rid of the legacy interface from the i2c core.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 sound/ppc/keywest.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index 0d1c27e911b8dd..d7627bae08362e 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -52,7 +52,7 @@ static int keywest_attach_adapter(struct i2c_adapter *adapter)
 		return -EINVAL;
 
 	if (strncmp(adapter->name, "mac-io", 6))
-		return 0; /* ignored */
+		return -EINVAL; /* ignored */
 
 	memset(&info, 0, sizeof(struct i2c_board_info));
 	strlcpy(info.type, "keywest", I2C_NAME_SIZE);
@@ -100,7 +100,6 @@ static struct i2c_driver keywest_driver = {
 	.driver = {
 		.name = "PMac Keywest Audio",
 	},
-	.attach_adapter = keywest_attach_adapter,
 	.probe = keywest_probe,
 	.remove = keywest_remove,
 	.id_table = keywest_i2c_id,
@@ -132,16 +131,32 @@ int snd_pmac_tumbler_post_init(void)
 /* exported */
 int snd_pmac_keywest_init(struct pmac_keywest *i2c)
 {
-	int err;
+	struct i2c_adapter *adap;
+	int err, i = 0;
 
 	if (keywest_ctx)
 		return -EBUSY;
 
+	adap = i2c_get_adapter(0);
+	if (!adap)
+		return -EPROBE_DEFER;
+
 	keywest_ctx = i2c;
 
 	if ((err = i2c_add_driver(&keywest_driver))) {
 		snd_printk(KERN_ERR "cannot register keywest i2c driver\n");
+		i2c_put_adapter(adap);
 		return err;
 	}
-	return 0;
+
+	/* We assume Macs have consecutive I2C bus numbers starting at 0 */
+	while (adap) {
+		err = keywest_attach_adapter(adap);
+		if (!err)
+			return 0;
+		i2c_put_adapter(adap);
+		adap = i2c_get_adapter(++i);
+	}
+
+	return -ENODEV;
 }
-- 
2.1.4
