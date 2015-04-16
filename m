From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 1/2] macintosh: therm_windtunnel: drop using attach adapter
Date: Thu, 16 Apr 2015 15:23:02 +0200
Message-ID: <1429190583-17517-2-git-send-email-wsa@the-dreams.de>
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
 drivers/macintosh/therm_windtunnel.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 835ca8be4c1632..57909a3ce67bf2 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -422,7 +422,6 @@ static struct i2c_driver g4fan_driver = {
 	.driver = {
 		.name	= "therm_windtunnel",
 	},
-	.attach_adapter = do_attach,
 	.probe		= do_probe,
 	.remove		= do_remove,
 	.id_table	= therm_windtunnel_id,
@@ -435,7 +434,29 @@ static struct i2c_driver g4fan_driver = {
 
 static int therm_of_probe(struct platform_device *dev)
 {
-	return i2c_add_driver( &g4fan_driver );
+	struct i2c_adapter *adap;
+	int ret, i = 0;
+
+	adap = i2c_get_adapter(0);
+	if (!adap)
+		return -EPROBE_DEFER;
+
+	ret = i2c_add_driver(&g4fan_driver);
+	if (ret) {
+		i2c_put_adapter(adap);
+		return ret;
+	}
+
+	/* We assume Macs have consecutive I2C bus numbers starting at 0 */
+	while (adap) {
+		do_attach(adap);
+		if (x.running)
+			return 0;
+		i2c_put_adapter(adap);
+		adap = i2c_get_adapter(++i);
+	}
+
+	return -ENODEV;
 }
 
 static int
-- 
2.1.4
