From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 3/4] i2c: slave: docs: be more precise about the prerequsites
Date: Thu, 14 May 2015 14:40:04 +0200
Message-ID: <1431607205-2316-4-git-send-email-wsa@the-dreams.de>
References: <1431607205-2316-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431607205-2316-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Peter Huewe <peterhuewe-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

There was some confusion what was needed to utilize the slave support,
so let's be more precise about this. Add an introductory paragraph to
the development section while we are here.

Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Cc: Peter Huewe <peterhuewe-Mmb7MZpHnFY@public.gmane.org>
---
 Documentation/i2c/slave-interface | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/i2c/slave-interface b/Documentation/i2c/slave-interface
index 389bb5d618549e..02b086510b6c10 100644
--- a/Documentation/i2c/slave-interface
+++ b/Documentation/i2c/slave-interface
@@ -3,16 +3,16 @@ Linux I2C slave interface description
 
 by Wolfram Sang <wsa-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org> in 2014-15
 
-Linux can also be an I2C slave in case I2C controllers have slave support.
-Besides this HW requirement, one also needs a software backend providing the
-actual functionality. An example for this is the slave-eeprom driver, which
-acts as a dual memory driver. While another I2C master on the bus can access it
-like a regular EEPROM, the Linux I2C slave can access the content via sysfs and
-retrieve/provide information as needed. The software backend driver and the I2C
-bus driver communicate via events. Here is a small graph visualizing the data
-flow and the means by which data is transported. The dotted line marks only one
-example. The backend could also use e.g. a character device, be in-kernel
-only, or something completely different:
+Linux can also be an I2C slave if the I2C controller in use has slave
+functionality. For that to work, one needs slave support in the bus driver plus
+a hardware independent software backend providing the actual functionality. An
+example for the latter is the slave-eeprom driver, which acts as a dual memory
+driver. While another I2C master on the bus can access it like a regular
+EEPROM, the Linux I2C slave can access the content via sysfs and handle data as
+needed. The backend driver and the I2C bus driver communicate via events. Here
+is a small graph visualizing the data flow and the means by which data is
+transported. The dotted line marks only one example. The backend could also
+use a character device, be in-kernel only, or something completely different:
 
 
               e.g. sysfs        I2C slave events        I/O registers
@@ -43,6 +43,11 @@ behaviour and setup.
 Developer manual
 ================
 
+First, the events which are used by the bus driver and the backend will be
+described in detail. After that, some implementation hints for extending bus
+drivers and writing backends will be given.
+
+
 I2C slave events
 ----------------
 
-- 
2.1.4
