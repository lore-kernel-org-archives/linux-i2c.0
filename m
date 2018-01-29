From: Romain Porte <romain.porte@nokia.com>
Subject: [PATCH v3 2/3] Update help message for risky_addr option
Date: Mon, 29 Jan 2018 14:57:27 +0100
Message-ID: <20180129135728.2313-3-romain.porte@nokia.com>
References: <20180105150248.3170-1-romain.porte@nokia.com>
 <20180129135728.2313-1-romain.porte@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr10112.outbound.protection.outlook.com ([40.107.1.112]:13952
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751387AbeA2N6O (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 29 Jan 2018 08:58:14 -0500
In-Reply-To: <20180129135728.2313-1-romain.porte@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: jdelvare@suse.de, peda@axentia.se, linux-i2c@vger.kernel.org, Romain Porte <romain.porte@nokia.com>

Add [-a] option to short help message of i2c tools. This is the option
that the user needs to activate for using the risky_addr feature.

Signed-off-by: Romain Porte <romain.porte@nokia.com>
---
 tools/i2cdump.c     | 4 ++--
 tools/i2cget.c      | 4 ++--
 tools/i2cset.c      | 4 ++--
 tools/i2ctransfer.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/i2cdump.c b/tools/i2cdump.c
index be0d93f..3bd6d39 100644
--- a/tools/i2cdump.c
+++ b/tools/i2cdump.c
@@ -36,9 +36,9 @@
 static void help(void)
 {
 	fprintf(stderr,
-		"Usage: i2cdump [-f] [-y] [-r first-last] I2CBUS ADDRESS [MODE [BANK [BANKREG]]]\n"
+		"Usage: i2cdump [-f] [-y] [-r first-last] [-a] I2CBUS ADDRESS [MODE [BANK [BANKREG]]]\n"
 		"  I2CBUS is an integer or an I2C bus name\n"
-		"  ADDRESS is an integer (0x03 - 0x77)\n"
+		"  ADDRESS is an integer (0x03 - 0x77, or 0x00 - 0x7f if -a is given)\n"
 		"  MODE is one of:\n"
 		"    b (byte, default)\n"
 		"    w (word)\n"
diff --git a/tools/i2cget.c b/tools/i2cget.c
index acc5236..9aa2d01 100644
--- a/tools/i2cget.c
+++ b/tools/i2cget.c
@@ -41,9 +41,9 @@ static void help(void) __attribute__ ((noreturn));
 static void help(void)
 {
 	fprintf(stderr,
-		"Usage: i2cget [-f] [-y] I2CBUS CHIP-ADDRESS [DATA-ADDRESS [MODE]]\n"
+		"Usage: i2cget [-f] [-y] [-a] I2CBUS CHIP-ADDRESS [DATA-ADDRESS [MODE]]\n"
 		"  I2CBUS is an integer or an I2C bus name\n"
-		"  ADDRESS is an integer (0x03 - 0x77)\n"
+		"  ADDRESS is an integer (0x03 - 0x77, or 0x00 - 0x7f if -a is given)\n"
 		"  MODE is one of:\n"
 		"    b (read byte data, default)\n"
 		"    w (read word data)\n"
diff --git a/tools/i2cset.c b/tools/i2cset.c
index 87c8cf3..7e9984e 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -38,9 +38,9 @@ static void help(void) __attribute__ ((noreturn));
 static void help(void)
 {
 	fprintf(stderr,
-		"Usage: i2cset [-f] [-y] [-m MASK] [-r] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]\n"
+		"Usage: i2cset [-f] [-y] [-m MASK] [-r] [-a] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]\n"
 		"  I2CBUS is an integer or an I2C bus name\n"
-		"  ADDRESS is an integer (0x03 - 0x77)\n"
+		"  ADDRESS is an integer (0x03 - 0x77, or 0x00 - 0x7f if -a is given)\n"
 		"  MODE is one of:\n"
 		"    c (byte, no value)\n"
 		"    b (byte data, default)\n"
diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
index e6e9f0a..256fca7 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -42,7 +42,7 @@ enum parse_state {
 static void help(void)
 {
 	fprintf(stderr,
-		"Usage: i2ctransfer [-f] [-y] [-v] [-V] I2CBUS DESC [DATA] [DESC [DATA]]...\n"
+		"Usage: i2ctransfer [-f] [-y] [-v] [-V] [-a] I2CBUS DESC [DATA] [DESC [DATA]]...\n"
 		"  I2CBUS is an integer or an I2C bus name\n"
 		"  DESC describes the transfer in the form: {r|w}LENGTH[@address]\n"
 		"    1) read/write-flag 2) LENGTH (range 0-65535) 3) I2C address (use last one if omitted)\n"
-- 
2.11.0
