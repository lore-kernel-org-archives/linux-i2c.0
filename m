From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/4] i2c-parport: use device-model parport
Date: Wed, 15 Apr 2015 13:18:43 +0530
Message-ID: <1429084124-2271-4-git-send-email-sudipm.mukherjee@gmail.com>
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

modified the functions to use the new device-model of parport.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/i2c/busses/i2c-parport.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
index a1fac5a..9464e74 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -160,20 +160,24 @@ static void i2c_parport_irq(void *data)
 			"SMBus alert received but no ARA client!\n");
 }
 
-static void i2c_parport_attach(struct parport *port)
+static int i2c_parport_attach(struct parport *port,
+			      struct parport_driver *drv)
 {
 	struct i2c_par *adapter;
 
 	adapter = kzalloc(sizeof(struct i2c_par), GFP_KERNEL);
 	if (adapter == NULL) {
 		printk(KERN_ERR "i2c-parport: Failed to kzalloc\n");
-		return;
+		return -ENOMEM;
 	}
 
 	pr_debug("i2c-parport: attaching to %s\n", port->name);
 	parport_disable_irq(port);
-	adapter->pdev = parport_register_device(port, "i2c-parport",
-		NULL, NULL, i2c_parport_irq, PARPORT_FLAG_EXCL, adapter);
+	adapter->pdev = parport_register_dev(port, "i2c-parport",
+					     NULL, NULL,
+					     i2c_parport_irq,
+					     PARPORT_FLAG_EXCL,
+					     adapter, drv);
 	if (!adapter->pdev) {
 		printk(KERN_ERR "i2c-parport: Unable to register with parport\n");
 		goto err_free;
@@ -230,13 +234,14 @@ static void i2c_parport_attach(struct parport *port)
 	mutex_lock(&adapter_list_lock);
 	list_add_tail(&adapter->node, &adapter_list);
 	mutex_unlock(&adapter_list_lock);
-	return;
+	return 0;
 
  err_unregister:
 	parport_release(adapter->pdev);
 	parport_unregister_device(adapter->pdev);
  err_free:
 	kfree(adapter);
+	return -ENODEV;
 }
 
 static void i2c_parport_detach(struct parport *port)
@@ -268,7 +273,7 @@ static void i2c_parport_detach(struct parport *port)
 
 static struct parport_driver i2c_parport_driver = {
 	.name	= "i2c-parport",
-	.attach	= i2c_parport_attach,
+	.attach_ret	= i2c_parport_attach,
 	.detach	= i2c_parport_detach,
 };
 
@@ -286,7 +291,7 @@ static int __init i2c_parport_init(void)
 		return -ENODEV;
 	}
 
-	return parport_register_driver(&i2c_parport_driver);
+	return parport_register_drv(&i2c_parport_driver);
 }
 
 static void __exit i2c_parport_exit(void)
-- 
1.8.1.2
