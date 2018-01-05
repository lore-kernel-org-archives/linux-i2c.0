From: Romain Porte <romain.porte@nokia.com>
Subject: [PATCH 2/3] Update help message for risky_addr option
Date: Fri, 5 Jan 2018 16:02:47 +0100
Message-ID: <20180105150248.3170-3-romain.porte@nokia.com>
References: <20180105150248.3170-1-romain.porte@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0126.outbound.protection.outlook.com ([104.47.1.126]:4800
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751514AbeAEPDj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 5 Jan 2018 10:03:39 -0500
In-Reply-To: <20180105150248.3170-1-romain.porte@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: jdelvare@suse.de, Romain Porte <romain.porte@nokia.com>

Add [-a] option to short help message of i2c tools. This is the option
that the user needs to activate for using the risky_addr feature.

Signed-off-by: Romain Porte <romain.porte@nokia.com>
---
 tools/i2cdump.c     | 2 +-
 tools/i2cget.c      | 2 +-
 tools/i2cset.c      | 2 +-
 tools/i2ctransfer.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/i2cdump.c b/tools/i2cdump.c
index be0d93f..733edaa 100644
--- a/tools/i2cdump.c
+++ b/tools/i2cdump.c
@@ -36,7 +36,7 @@
 static void help(void)
 {
 	fprintf(stderr,
-		"Usage: i2cdump [-f] [-y] [-r first-last] I2CBUS ADDRESS [MODE [BANK [BANKREG]]]\n"
+		"Usage: i2cdump [-f] [-y] [-r first-last] [-a] I2CBUS ADDRESS [MODE [BANK [BANKREG]]]\n"
 		"  I2CBUS is an integer or an I2C bus name\n"
 		"  ADDRESS is an integer (0x03 - 0x77)\n"
 		"  MODE is one of:\n"
diff --git a/tools/i2cget.c b/tools/i2cget.c
index acc5236..6660991 100644
--- a/tools/i2cget.c
+++ b/tools/i2cget.c
@@ -41,7 +41,7 @@ static void help(void) __attribute__ ((noreturn));
 static void help(void)
 {
 	fprintf(stderr,
-		"Usage: i2cget [-f] [-y] I2CBUS CHIP-ADDRESS [DATA-ADDRESS [MODE]]\n"
+		"Usage: i2cget [-f] [-y] [-a] I2CBUS CHIP-ADDRESS [DATA-ADDRESS [MODE]]\n"
 		"  I2CBUS is an integer or an I2C bus name\n"
 		"  ADDRESS is an integer (0x03 - 0x77)\n"
 		"  MODE is one of:\n"
diff --git a/tools/i2cset.c b/tools/i2cset.c
index 87c8cf3..5c3d6d7 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -38,7 +38,7 @@ static void help(void) __attribute__ ((noreturn));
 static void help(void)
 {
 	fprintf(stderr,
-		"Usage: i2cset [-f] [-y] [-m MASK] [-r] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]\n"
+		"Usage: i2cset [-f] [-y] [-m MASK] [-r] [-a] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]\n"
 		"  I2CBUS is an integer or an I2C bus name\n"
 		"  ADDRESS is an integer (0x03 - 0x77)\n"
 		"  MODE is one of:\n"
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
