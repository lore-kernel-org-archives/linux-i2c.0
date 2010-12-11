From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH] i2c-i801: Include <linux/slab.h>
Date: Sat, 11 Dec 2010 20:45:31 +0000
Message-ID: <1292100331.3136.47.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-alpha-owner@vger.kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-i2c@vger.kernel.org, linux-alpha@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Commit 5a0e3ad6af8660be21ca98a971cd00f331318c05 added direct inclusion
of <linux/slab.h> to those source files that appeared to need it, but
somehow missed this.  On most architectures <linux/slab.h> is still
indirectly included, but there are exceptions such as alpha.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/i2c/busses/i2c-i801.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 02835ce..7979aef 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -72,6 +72,7 @@
 #include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/dmi.h>
+#include <linux/slab.h>
 
 /* I801 SMBus address offsets */
 #define SMBHSTSTS(p)	(0 + (p)->smba)
-- 
1.7.2.3


