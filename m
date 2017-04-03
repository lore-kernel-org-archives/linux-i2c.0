From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH i2c-tools 2/2] i2ctransfer: grammar fixes in manpage
Date: Mon,  3 Apr 2017 19:36:13 +0200
Message-ID: <20170403173613.2238-2-wsa+renesas@sang-engineering.com>
References: <20170403173613.2238-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170403173613.2238-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 tools/i2ctransfer.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/i2ctransfer.8 b/tools/i2ctransfer.8
index 28b3388..d17df3c 100644
--- a/tools/i2ctransfer.8
+++ b/tools/i2ctransfer.8
@@ -74,7 +74,7 @@ This number should correspond to one of the busses listed by
 The next parameter is one or multiple
 .I desc
 blocks.
-The number of blocks is limited by the Linux Kernel and defined in I2C_RDWR_IOCTL_MAX_MSGS (42 as of v4.10).
+The number of blocks is limited by the Linux Kernel and defined with I2C_RDWR_IOCTL_MAX_MSGS (42 as of v4.10).
 .I desc
 blocks are composed like this:
 
@@ -86,7 +86,7 @@ specifies if the message is read or write
 .TP
 .B <length_of_message>
 specifies the number of bytes read or written in this message.
-It is parsed as an unsigned 16 bit integer, but note that the Linux Kernel apply an additional upper limit (8192 as of v4.10).
+It is parsed as an unsigned 16 bit integer, but note that the Linux Kernel applies an additional upper limit (8192 as of v4.10).
 .TP
 .B [@address]
 specifies the 7-bit address of the chip to be accessed for this message, and is an integer.
-- 
2.11.0
