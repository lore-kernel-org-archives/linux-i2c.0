From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 09/26] docs: i2c: i2c-protocol: remove unneeded colons from table
Date: Sun,  5 Jan 2020 23:49:55 +0100
Message-ID: <20200105225012.11701-9-luca@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200105225012.11701-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

These colons are not needed: the columns already nicely separate the
symbold from their description. They are also inconsistently preceded by
whitespace.

Remove the colons completely to simplify and clean up.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/i2c/i2c-protocol.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/i2c/i2c-protocol.rst b/Documentation/i2c/i2c-protocol.rst
index c090003f55ed..66adac3a5afd 100644
--- a/Documentation/i2c/i2c-protocol.rst
+++ b/Documentation/i2c/i2c-protocol.rst
@@ -8,19 +8,19 @@ Key to symbols
 ==============
 
 =============== =============================================================
-S             : Start condition
-P             : Stop condition
-Rd/Wr (1 bit) : Read/Write bit. Rd equals 1, Wr equals 0.
-A, NA (1 bit) : Accept and reverse accept bit.
-Addr  (7 bits): I2C 7 bit address. Note that this can be expanded as usual to
+S               Start condition
+P               Stop condition
+Rd/Wr (1 bit)   Read/Write bit. Rd equals 1, Wr equals 0.
+A, NA (1 bit)   Accept and reverse accept bit.
+Addr  (7 bits)  I2C 7 bit address. Note that this can be expanded as usual to
                 get a 10 bit I2C address.
-Comm  (8 bits): Command byte, a data byte which often selects a register on
+Comm  (8 bits)  Command byte, a data byte which often selects a register on
                 the device.
-Data  (8 bits): A plain data byte. Sometimes, I write DataLow, DataHigh
+Data  (8 bits)  A plain data byte. Sometimes, I write DataLow, DataHigh
                 for 16 bit data.
-Count (8 bits): A data byte containing the length of a block operation.
+Count (8 bits)  A data byte containing the length of a block operation.
 
-[..]:           Data sent by I2C device, as opposed to data sent by the
+[..]            Data sent by I2C device, as opposed to data sent by the
                 host adapter.
 =============== =============================================================
 
-- 
2.24.1
