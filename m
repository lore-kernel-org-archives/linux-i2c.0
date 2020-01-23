From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH v2 10/28] docs: i2c: i2c-protocol: use proper names for ACK and NACK
Date: Thu, 23 Jan 2020 14:50:45 +0100
Message-ID: <20200123135103.20540-11-luca@lucaceresoli.net>
References: <20200123135103.20540-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200123135103.20540-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use the proper ACK and NACK naming from the I2C specification instead of
"accept" and "reverse accept".

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
---
 Documentation/i2c/i2c-protocol.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/i2c-protocol.rst b/Documentation/i2c/i2c-protocol.rst
index 66adac3a5afd..9a4ac944cf9d 100644
--- a/Documentation/i2c/i2c-protocol.rst
+++ b/Documentation/i2c/i2c-protocol.rst
@@ -11,7 +11,7 @@ Key to symbols
 S               Start condition
 P               Stop condition
 Rd/Wr (1 bit)   Read/Write bit. Rd equals 1, Wr equals 0.
-A, NA (1 bit)   Accept and reverse accept bit.
+A, NA (1 bit)   Acknowledge (ACK) and Not Acknowledge (NACK) bit
 Addr  (7 bits)  I2C 7 bit address. Note that this can be expanded as usual to
                 get a 10 bit I2C address.
 Comm  (8 bits)  Command byte, a data byte which often selects a register on
-- 
2.25.0
