From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4/6] i2c-parport: use new parport device model
Date: Wed, 20 May 2015 20:57:00 +0530
Message-ID: <1432135622-8288-5-git-send-email-sudipm.mukherjee@gmail.com>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Waugh <tim@cyberelk.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Modify i2c-parport driver to use the new parallel port device model.

Tested-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

i2c_parport_cb is made local, devmodel added to driver structure,
and probe removed.	       

 drivers/i2c/busses/i2c-parport.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
index 155da95..138347e 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -185,11 +185,15 @@ static void i2c_parport_attach(struct parport *port)
 		printk(KERN_ERR "i2c-parport: Failed to kzalloc\n");
 		return;
 	}
+	memset(&i2c_parport_cb, 0, sizeof(i2c_parport_cb));
+	i2c_parport_cb.flags = PARPORT_FLAG_EXCL;
+	i2c_parport_cb.irq_func = i2c_parport_irq;
+	i2c_parport_cb.private = adapter;
 
 	pr_debug("i2c-parport: attaching to %s\n", port->name);
 	parport_disable_irq(port);
-	adapter->pdev = parport_register_device(port, "i2c-parport",
-		NULL, NULL, i2c_parport_irq, PARPORT_FLAG_EXCL, adapter);
+	adapter->pdev = parport_register_dev_model(port, "i2c-parport",
+						   &i2c_parport_cb, i);
 	if (!adapter->pdev) {
 		printk(KERN_ERR "i2c-parport: Unable to register with parport\n");
 		goto err_free;
@@ -283,9 +287,10 @@ static void i2c_parport_detach(struct parport *port)
 }
 
 static struct parport_driver i2c_parport_driver = {
-	.name	= "i2c-parport",
-	.attach	= i2c_parport_attach,
-	.detach	= i2c_parport_detach,
+	.name		= "i2c-parport",
+	.match_port	= i2c_parport_attach,
+	.detach		= i2c_parport_detach,
+	.devmodel	= true,
 };
 
 /* ----- Module loading, unloading and information ------------------------ */
-- 
1.8.1.2
