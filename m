From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/8] i2c: rename core source file to allow refactorization
Date: Fri, 26 May 2017 10:20:52 +0200
Message-ID: <20170526082101.4746-2-wsa@the-dreams.de>
References: <20170526082101.4746-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170526082101.4746-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The I2C core became quite huge and its monolithic structure makes
maintenance hard. So, prepare to break out some functionality into
seperate files by renaming the source file. Note that we keep the
resulting object name constant to avoid regressions.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/driver-api/i2c.rst            | 2 +-
 drivers/i2c/Makefile                        | 4 +++-
 drivers/i2c/busses/i2c-designware-core.c    | 2 +-
 drivers/i2c/{i2c-core.c => i2c-core-base.c} | 0
 4 files changed, 5 insertions(+), 3 deletions(-)
 rename drivers/i2c/{i2c-core.c => i2c-core-base.c} (100%)

diff --git a/Documentation/driver-api/i2c.rst b/Documentation/driver-api/i2c.rst
index 0bf86a445d0135..67366d9ff7303f 100644
--- a/Documentation/driver-api/i2c.rst
+++ b/Documentation/driver-api/i2c.rst
@@ -41,5 +41,5 @@ i2c_adapter devices which don't support those I2C operations.
 .. kernel-doc:: drivers/i2c/i2c-boardinfo.c
    :functions: i2c_register_board_info
 
-.. kernel-doc:: drivers/i2c/i2c-core.c
+.. kernel-doc:: drivers/i2c/i2c-core-base.c
    :export:
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 45095b3d16a914..d459c7e5907607 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -4,6 +4,8 @@
 
 obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+= i2c-core.o
+i2c-core-objs 			:= i2c-core-base.o
+
 obj-$(CONFIG_I2C_SMBUS)		+= i2c-smbus.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_MUX)		+= i2c-mux.o
@@ -12,4 +14,4 @@ obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
 obj-$(CONFIG_I2C_SLAVE_EEPROM)	+= i2c-slave-eeprom.o
 
 ccflags-$(CONFIG_I2C_DEBUG_CORE) := -DDEBUG
-CFLAGS_i2c-core.o := -Wno-deprecated-declarations
+CFLAGS_i2c-core-base.o := -Wno-deprecated-declarations
diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index c453717b753b72..3c41995634c2f9 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -583,7 +583,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			 */
 
 			/*
-			 * i2c-core.c always sets the buffer length of
+			 * i2c-core always sets the buffer length of
 			 * I2C_FUNC_SMBUS_BLOCK_DATA to 1. The length will
 			 * be adjusted when receiving the first byte.
 			 * Thus we can't stop the transaction here.
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core-base.c
similarity index 100%
rename from drivers/i2c/i2c-core.c
rename to drivers/i2c/i2c-core-base.c
-- 
2.11.0
