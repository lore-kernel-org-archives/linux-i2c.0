From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 048/199] Documentation/i2c/ten-bit-addresses: Checkpatch cleanup
Date: Sun, 23 May 2010 21:56:16 +0200
Message-ID: <1274644605-25181-20-git-send-email-andrea.gelmini@gelma.net>
References: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Documentation/i2c/ten-bit-addresses:1: ERROR: trailing whitespace
Documentation/i2c/ten-bit-addresses:7: ERROR: trailing whitespace
Documentation/i2c/ten-bit-addresses:14: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/i2c/ten-bit-addresses |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/i2c/ten-bit-addresses b/Documentation/i2c/ten-bit-addresses
index 200074f..e989070 100644
--- a/Documentation/i2c/ten-bit-addresses
+++ b/Documentation/i2c/ten-bit-addresses
@@ -1,17 +1,17 @@
-The I2C protocol knows about two kinds of device addresses: normal 7 bit 
+The I2C protocol knows about two kinds of device addresses: normal 7 bit
 addresses, and an extended set of 10 bit addresses. The sets of addresses
 do not intersect: the 7 bit address 0x10 is not the same as the 10 bit
 address 0x10 (though a single device could respond to both of them). You
 select a 10 bit address by adding an extra byte after the address
 byte:
-  S Addr7 Rd/Wr ....  
+  S Addr7 Rd/Wr ....
 becomes
   S 11110 Addr10 Rd/Wr
 S is the start bit, Rd/Wr the read/write bit, and if you count the number
 of bits, you will see the there are 8 after the S bit for 7 bit addresses,
 and 16 after the S bit for 10 bit addresses.
 
-WARNING! The current 10 bit address support is EXPERIMENTAL. There are 
+WARNING! The current 10 bit address support is EXPERIMENTAL. There are
 several places in the code that will cause SEVERE PROBLEMS with 10 bit
 addresses, even though there is some basic handling and hooks. Also,
 almost no supported adapter handles the 10 bit addresses correctly.
-- 
1.7.1.251.gf80a2

