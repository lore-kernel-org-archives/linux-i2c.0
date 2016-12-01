From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/39] Annotate hardware config module parameters in
 drivers/i2c/
Date: Thu, 01 Dec 2016 12:30:47 +0000
Message-ID: <148059544784.31612.17605303556663485588.stgit@warthog.procyon.org.uk>
References: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gnomes@lxorguk.ukuu.org.uk, Jean Delvare <jdelvare@suse.com>, minyard@acm.org, Wolfram Sang <wsa@the-dreams.de>, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

When the kernel is running in secure boot mode, we lock down the kernel to
prevent userspace from modifying the running kernel image.  Whilst this
includes prohibiting access to things like /dev/mem, it must also prevent
access by means of configuring driver modules in such a way as to cause a
device to access or modify the kernel image.

To this end, annotate module_param* statements that refer to hardware
configuration and indicate for future reference what type of parameter they
specify.  The parameter parser in the core sees this information and can
skip such parameters with an error message if the kernel is locked down.
The module initialisation then runs as normal, but just sees whatever the
default values for those parameters is.

Note that we do still need to do the module initialisation because some
drivers have viable defaults set in case parameters aren't specified and
some drivers support automatic configuration (e.g. PNP or PCI) in addition
to manually coded parameters.

This patch annotates drivers in drivers/i2c/.

Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Wolfram Sang <wsa@the-dreams.de>
cc: Jean Delvare <jdelvare@suse.com>
cc: linux-i2c@vger.kernel.org
---

 drivers/i2c/busses/i2c-elektor.c       |    6 +++---
 drivers/i2c/busses/i2c-parport-light.c |    4 ++--
 drivers/i2c/busses/i2c-pca-isa.c       |    4 ++--
 drivers/i2c/busses/scx200_acb.c        |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
index 8af62fb3fe41..5416003e0605 100644
--- a/drivers/i2c/busses/i2c-elektor.c
+++ b/drivers/i2c/busses/i2c-elektor.c
@@ -323,9 +323,9 @@ MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 ISA bus adapter");
 MODULE_LICENSE("GPL");
 
-module_param(base, int, 0);
-module_param(irq, int, 0);
+module_param_hw(base, int, ioport_or_iomem, 0);
+module_param_hw(irq, int, irq, 0);
 module_param(clock, int, 0);
 module_param(own, int, 0);
-module_param(mmapped, int, 0);
+module_param_hw(mmapped, int, other, 0);
 module_isa_driver(i2c_elektor_driver, 1);
diff --git a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
index 1bcdd10b68b9..faa8fb8f2b8f 100644
--- a/drivers/i2c/busses/i2c-parport-light.c
+++ b/drivers/i2c/busses/i2c-parport-light.c
@@ -38,11 +38,11 @@
 static struct platform_device *pdev;
 
 static u16 base;
-module_param(base, ushort, 0);
+module_param_hw(base, ushort, ioport, 0);
 MODULE_PARM_DESC(base, "Base I/O address");
 
 static int irq;
-module_param(irq, int, 0);
+module_param_hw(irq, int, irq, 0);
 MODULE_PARM_DESC(irq, "IRQ (optional)");
 
 /* ----- Low-level parallel port access ----------------------------------- */
diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
index ba88f17f636c..946ac646de2a 100644
--- a/drivers/i2c/busses/i2c-pca-isa.c
+++ b/drivers/i2c/busses/i2c-pca-isa.c
@@ -197,9 +197,9 @@ MODULE_AUTHOR("Ian Campbell <icampbell@arcom.com>");
 MODULE_DESCRIPTION("ISA base PCA9564/PCA9665 driver");
 MODULE_LICENSE("GPL");
 
-module_param(base, ulong, 0);
+module_param_hw(base, ulong, ioport, 0);
 MODULE_PARM_DESC(base, "I/O base address");
-module_param(irq, int, 0);
+module_param_hw(irq, int, irq, 0);
 MODULE_PARM_DESC(irq, "IRQ");
 module_param(clock, int, 0);
 MODULE_PARM_DESC(clock, "Clock rate in hertz.\n\t\t"
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 0a7e410b6195..e0923bee8d1f 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -42,7 +42,7 @@ MODULE_LICENSE("GPL");
 
 #define MAX_DEVICES 4
 static int base[MAX_DEVICES] = { 0x820, 0x840 };
-module_param_array(base, int, NULL, 0);
+module_param_hw_array(base, int, ioport, NULL, 0);
 MODULE_PARM_DESC(base, "Base addresses for the ACCESS.bus controllers");
 
 #define POLL_TIMEOUT	(HZ/5)
