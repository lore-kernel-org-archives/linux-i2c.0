From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/6] staging: panel: use new parport device model
Date: Wed, 20 May 2015 20:56:58 +0530
Message-ID: <1432135622-8288-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Waugh <tim@cyberelk.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Converted to use the new device-model parallel port.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

The comment about panel_cb.flags can be removed, it is kept just
for the comment to remind us that it might be better to use
PARPORT_DEV_EXCL.

 drivers/staging/panel/panel.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/panel/panel.c b/drivers/staging/panel/panel.c
index 1d8ed8b..70f0ac6 100644
--- a/drivers/staging/panel/panel.c
+++ b/drivers/staging/panel/panel.c
@@ -2190,6 +2190,8 @@ static struct notifier_block panel_notifier = {
 
 static void panel_attach(struct parport *port)
 {
+	struct pardev_cb panel_cb;
+
 	if (port->number != parport)
 		return;
 
@@ -2199,10 +2201,11 @@ static void panel_attach(struct parport *port)
 		return;
 	}
 
-	pprt = parport_register_device(port, "panel", NULL, NULL,  /* pf, kf */
-				       NULL,
-				       /*PARPORT_DEV_EXCL */
-				       0, (void *)&pprt);
+	memset(&panel_cb, 0, sizeof(panel_cb));
+	panel_cb.private = &pprt;
+	/* panel_cb.flags = 0 should be PARPORT_DEV_EXCL? */
+
+	pprt = parport_register_dev_model(port, "panel", &panel_cb, 0);
 	if (pprt == NULL) {
 		pr_err("%s: port->number=%d parport=%d, parport_register_device() failed\n",
 		       __func__, port->number, parport);
@@ -2256,8 +2259,9 @@ static void panel_detach(struct parport *port)
 
 static struct parport_driver panel_driver = {
 	.name = "panel",
-	.attach = panel_attach,
+	.match_port = panel_attach,
 	.detach = panel_detach,
+	.devmodel = true,
 };
 
 /* init function */
-- 
1.8.1.2
