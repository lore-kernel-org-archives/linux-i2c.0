From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH trivial 09/16] i2c: Spelling s/than/that/
Date: Tue, 11 Mar 2014 11:23:43 +0100
Message-ID: <1394533430-4746-9-git-send-email-geert@linux-m68k.org>
References: <1394533430-4746-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394533430-4746-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
---
 Documentation/i2c/functionality |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/functionality b/Documentation/i2c/functionality
index b0ff2ab596ce..4556a3eb87c4 100644
--- a/Documentation/i2c/functionality
+++ b/Documentation/i2c/functionality
@@ -46,7 +46,7 @@ A few combinations of the above flags are also defined for your convenience:
                                   and write_block_data commands
   I2C_FUNC_SMBUS_I2C_BLOCK        Handles the SMBus read_i2c_block_data
                                   and write_i2c_block_data commands
-  I2C_FUNC_SMBUS_EMUL             Handles all SMBus commands than can be
+  I2C_FUNC_SMBUS_EMUL             Handles all SMBus commands that can be
                                   emulated by a real I2C adapter (using
                                   the transparent emulation layer)
 
-- 
1.7.9.5
