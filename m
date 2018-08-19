From: Sedat Dilek <sedat.dilek@credativ.de>
Subject: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler warning
Date: Sun, 19 Aug 2018 15:51:35 +0200
Message-ID: <20180819135135.8801-1-sedat.dilek@credativ.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sedat Dilek <sedat.dilek@credativ.de>, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-i2c@vger.kernel.org

This can be dropped with commit 771c035372a036f83353eef46dbb829780330234
("deprecate the '__deprecated' attribute warnings entirely and for good")
now in upstream.

Please, use the kbuild infrastruture to disable compiler warnings.
This should be...

CFLAGS_i2c-core-base.o := $(call cc-disable-warning, deprecated-declarations)

This has the advantage to check if other compilers like GCC support this.

NOTE: My compiler is a prerelease of LLVM/Clang version 7.

[1] https://clang.llvm.org/docs/DiagnosticsReference.html#wdeprecated-declarations

CC: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sedat Dilek <sedat.dilek@credativ.de>
---
[ v2: Fix typo s/no-deprecated-declarations/deprecated-declarations. -dileks ]
 drivers/i2c/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 72c94c60fdd1..bed6ba63c983 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -18,4 +18,3 @@ obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
 obj-$(CONFIG_I2C_SLAVE_EEPROM)	+= i2c-slave-eeprom.o
 
 ccflags-$(CONFIG_I2C_DEBUG_CORE) := -DDEBUG
-CFLAGS_i2c-core-base.o := -Wno-deprecated-declarations
-- 
2.18.0
