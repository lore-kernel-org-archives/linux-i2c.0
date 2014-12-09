From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [RFC] Documentation: i2c: add fault code for not supporting 10 bit addresses
Date: Tue,  9 Dec 2014 18:48:50 +0100
Message-ID: <1418147330-5999-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
---
 Documentation/i2c/fault-codes | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/i2c/fault-codes b/Documentation/i2c/fault-codes
index 47c25abb7d52..008db43d28a9 100644
--- a/Documentation/i2c/fault-codes
+++ b/Documentation/i2c/fault-codes
@@ -35,6 +35,10 @@ Also, codes returned by adapter probe methods follow rules which are
 specific to their host bus (such as PCI, or the platform bus).
 
 
+EAFNOSUPPORT
+	Returned by I2C adapters not supporting 10 bit addresses when
+	they are requested to use such an address.
+
 EAGAIN
 	Returned by I2C adapters when they lose arbitration in master
 	transmit mode:  some other master was transmitting different
-- 
2.1.3
