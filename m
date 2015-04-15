From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/4] parport: update TODO and documentation
Date: Wed, 15 Apr 2015 13:18:42 +0530
Message-ID: <1429084124-2271-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, dan.carpenter@oracle.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-i2c@vger.kernel.org

as parport starts using the device-model, update the documentation
to show the newly added functions and update TODO with some other
planned modifications.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 Documentation/parport-lowlevel.txt | 49 ++++++++++++++++++++++++++++++++++++++
 drivers/parport/TODO-parport       |  4 ++++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/parport-lowlevel.txt b/Documentation/parport-lowlevel.txt
index 120eb20..4c180af 100644
--- a/Documentation/parport-lowlevel.txt
+++ b/Documentation/parport-lowlevel.txt
@@ -7,9 +7,11 @@ Described here are the following functions:
 
 Global functions:
   parport_register_driver
+  parport_register_drv
   parport_unregister_driver
   parport_enumerate
   parport_register_device
+  parport_register_dev
   parport_unregister_device
   parport_claim
   parport_claim_or_block
@@ -222,6 +224,26 @@ SEE ALSO
 
 parport_unregister_driver, parport_register_device, parport_enumerate
 
+
+parport_register_drv - register a device driver with parport
+--------------------
+
+Everything is same as parport_register_driver, but it will use the device-model
+and will register the driver under /sys/bus/parport/driver. Just like
+parport_register_driver it will also call the attach callback function but the
+differences being attach wil now return its success or error code and the
+reference of the driver is also passed to the attach so that it can be used
+when calling parport_register_dev.
+
+static int lp_attach (struct parport *port, struct parport_driver *drv)
+{
+	...
+	private = kmalloc (...);
+	dev[count++] = parport_register_dev (...);
+	...
+}
+
+
 parport_unregister_driver - tell parport to forget about this driver
 -------------------------
 
@@ -442,6 +464,33 @@ SEE ALSO
 
 parport_unregister_device, parport_claim
 
+
+parport_register_dev - register to use a port
+-----------------------
+
+SYNOPSIS
+
+#include <linux/parport.h>
+
+typedef int (*preempt_func) (void *handle);
+typedef void (*wakeup_func) (void *handle);
+typedef int (*irq_func) (int irq, void *handle, struct pt_regs *);
+
+struct pardevice *parport_register_dev(struct parport *port,
+                                          const char *name,
+                                          preempt_func preempt,
+                                          wakeup_func wakeup,
+                                          irq_func irq,
+                                          int flags,
+                                          void *handle,
+					  struct parport_driver *drv);
+
+DESCRIPTION
+
+It is same as parport_register_device, and it should be only used if your
+driver is using the device-model, that is you have registered your driver
+using parport_register_drv.
+
 parport_unregister_device - finish using a port
 -------------------------
 
diff --git a/drivers/parport/TODO-parport b/drivers/parport/TODO-parport
index 089b14e..bdfbf50 100644
--- a/drivers/parport/TODO-parport
+++ b/drivers/parport/TODO-parport
@@ -17,4 +17,8 @@ Things to be done.
 
 4. A better PLIP (make use of bidirectional/ECP/EPP ports).
 
+5. Show base, irq information in the sys tree.
+
+6. Module autoloading based on the connected device.
+
 See <URL:http://people.redhat.com/twaugh/parport/>.
-- 
1.8.1.2

