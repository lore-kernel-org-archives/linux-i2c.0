From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4/4] staging: panel: use parport in device-model
Date: Wed, 15 Apr 2015 13:18:44 +0530
Message-ID: <1429084124-2271-5-git-send-email-sudipm.mukherjee@gmail.com>
References: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, dan.carpenter@oracle.com
Cc: linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

modified the required functions to start using the new parport
device-model

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/panel/panel.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/panel/panel.c b/drivers/staging/panel/panel.c
index ea54fb4..475c690 100644
--- a/drivers/staging/panel/panel.c
+++ b/drivers/staging/panel/panel.c
@@ -2188,25 +2188,26 @@ static struct notifier_block panel_notifier = {
 	0
 };
 
-static void panel_attach(struct parport *port)
+static int panel_attach(struct parport *port,
+			struct parport_driver *drv)
 {
 	if (port->number != parport)
-		return;
+		return -ENODEV;
 
 	if (pprt) {
 		pr_err("%s: port->number=%d parport=%d, already registered!\n",
 		       __func__, port->number, parport);
-		return;
+		return -EAGAIN;
 	}
 
-	pprt = parport_register_device(port, "panel", NULL, NULL,  /* pf, kf */
+	pprt = parport_register_dev(port, "panel", NULL, NULL,  /* pf, kf */
 				       NULL,
 				       /*PARPORT_DEV_EXCL */
-				       0, (void *)&pprt);
+				       0, (void *)&pprt, drv);
 	if (pprt == NULL) {
 		pr_err("%s: port->number=%d parport=%d, parport_register_device() failed\n",
 		       __func__, port->number, parport);
-		return;
+		return -ENODEV;
 	}
 
 	if (parport_claim(pprt)) {
@@ -2230,7 +2231,7 @@ static void panel_attach(struct parport *port)
 			goto err_lcd_unreg;
 	}
 	register_reboot_notifier(&panel_notifier);
-	return;
+	return 0;
 
 err_lcd_unreg:
 	if (lcd.enabled)
@@ -2238,6 +2239,7 @@ err_lcd_unreg:
 err_unreg_device:
 	parport_unregister_device(pprt);
 	pprt = NULL;
+	return -ENODEV;
 }
 
 static void panel_detach(struct parport *port)
@@ -2270,7 +2272,7 @@ static void panel_detach(struct parport *port)
 
 static struct parport_driver panel_driver = {
 	.name = "panel",
-	.attach = panel_attach,
+	.attach_ret = panel_attach,
 	.detach = panel_detach,
 };
 
@@ -2380,7 +2382,7 @@ static int __init panel_init_module(void)
 		return -ENODEV;
 	}
 
-	err = parport_register_driver(&panel_driver);
+	err = parport_register_drv(&panel_driver);
 	if (err) {
 		pr_err("could not register with parport. Aborting.\n");
 		return err;
-- 
1.8.1.2
