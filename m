From: Romain Porte <romain.porte@nokia.com>
Subject: [PATCH v3 3/3] Update man pages for risky_addr
Date: Mon, 29 Jan 2018 14:57:28 +0100
Message-ID: <20180129135728.2313-4-romain.porte@nokia.com>
References: <20180105150248.3170-1-romain.porte@nokia.com>
 <20180129135728.2313-1-romain.porte@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0101.outbound.protection.outlook.com ([104.47.0.101]:29206
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751547AbeA2N6P (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 29 Jan 2018 08:58:15 -0500
In-Reply-To: <20180129135728.2313-1-romain.porte@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: jdelvare@suse.de, peda@axentia.se, linux-i2c@vger.kernel.org, Romain Porte <romain.porte@nokia.com>

Describe the new -a option in man pages of modified tools.

Signed-off-by: Romain Porte <romain.porte@nokia.com>
---
 tools/i2cdump.8     | 4 ++++
 tools/i2cget.8      | 4 ++++
 tools/i2cset.8      | 4 ++++
 tools/i2ctransfer.8 | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/tools/i2cdump.8 b/tools/i2cdump.8
index fb7217e..1b98b64 100644
--- a/tools/i2cdump.8
+++ b/tools/i2cdump.8
@@ -7,6 +7,7 @@ i2cdump \- examine I2C registers
 .RB [ -f ]
 .RB [ "-r first-last" ]
 .RB [ -y ]
+.RB [ -a ]
 .I i2cbus
 .I address
 .RI [ "mode " [ "bank " [ bankreg ]]]
@@ -40,6 +41,9 @@ Disable interactive mode. By default, i2cdump will wait for a confirmation
 from the user before messing with the I2C bus. When this flag is used, it
 will perform the operation directly. This is mainly meant to be used in
 scripts.
+.TP
+.B -a
+Allow using risky addresses between 0x00 - 0x02 and 0x78 - 0x7f. Not recommended.
 .PP
 At least two options must be provided to i2cdump. \fIi2cbus\fR indicates the
 number or name of the I2C bus to be scanned. This number should correspond to one
diff --git a/tools/i2cget.8 b/tools/i2cget.8
index a1a1276..26a0ea0 100644
--- a/tools/i2cget.8
+++ b/tools/i2cget.8
@@ -6,6 +6,7 @@ i2cget \- read from I2C/SMBus chip registers
 .B i2cget
 .RB [ -f ]
 .RB [ -y ]
+.RB [ -a ]
 .I i2cbus
 .I chip-address
 .RI [ "data-address " [ mode ]]
@@ -34,6 +35,9 @@ Disable interactive mode. By default, i2cget will wait for a confirmation
 from the user before messing with the I2C bus. When this flag is used, it
 will perform the operation directly. This is mainly meant to be used in
 scripts. Use with caution.
+.TP
+.B -a
+Allow using risky addresses between 0x00 - 0x02 and 0x78 - 0x7f. Not recommended.
 .PP
 There are two required options to i2cget. \fIi2cbus\fR indicates the number
 or name of the I2C bus to be scanned.  This number should correspond to one of
diff --git a/tools/i2cset.8 b/tools/i2cset.8
index 19887bd..4faa061 100644
--- a/tools/i2cset.8
+++ b/tools/i2cset.8
@@ -8,6 +8,7 @@ i2cset \- set I2C registers
 .RB [ -y ]
 .RB [ "-m mask" ]
 .RB [ -r ]
+.RB [ -a ]
 .I i2cbus
 .I chip-address
 .I data-address
@@ -54,6 +55,9 @@ be the case, as neither I2C nor SMBus guarantees this.
 Read back the value right after writing it, and compare the result with the
 value written. This used to be the default behavior. The same limitations
 apply as those of option \fB-m\fR.
+.TP
+.B -a
+Allow using risky addresses between 0x00 - 0x02 and 0x78 - 0x7f. Not recommended.
 .PP
 There are three required options to i2cset. \fIi2cbus\fR indicates the number
 or name of the I2C bus to be scanned.  This number should correspond to one of
diff --git a/tools/i2ctransfer.8 b/tools/i2ctransfer.8
index 0dd43c9..cf8dae7 100644
--- a/tools/i2ctransfer.8
+++ b/tools/i2ctransfer.8
@@ -7,6 +7,7 @@ i2ctransfer \- send user-defined I2C messages in one transfer
 .RB [ -f ]
 .RB [ -y ]
 .RB [ -v ]
+.RB [ -a ]
 .I i2cbus desc
 .RI [ data ]
 .RI [ desc
@@ -61,6 +62,9 @@ It will print infos about all messages sent, i.e. not only for read messages but
 .TP
 .B -V
 Display the version and exit.
+.TP
+.B -a
+Allow using risky addresses between 0x00 - 0x02 and 0x78 - 0x7f. Not recommended.
 
 .SH ARGUMENTS
 .PP
-- 
2.11.0
