From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 02/26] docs: i2c: summary: extend introduction
Date: Sun,  5 Jan 2020 23:49:48 +0100
Message-ID: <20200105225012.11701-2-luca@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200105225012.11701-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

 - state the "official" name (I²C, not I2C, according to the spec) at
   the beginning but keep using the more practical I2C elsewhere
 - mention some known different names
 - add link to the specification document

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/i2c/summary.rst | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/i2c/summary.rst b/Documentation/i2c/summary.rst
index 3a24eac17375..b7d3e620155b 100644
--- a/Documentation/i2c/summary.rst
+++ b/Documentation/i2c/summary.rst
@@ -2,12 +2,18 @@
 I2C and SMBus
 =============
 
-I2C (pronounce: I squared C) is a protocol developed by Philips. It is a
-slow two-wire protocol (variable speed, up to 400 kHz), with a high speed
-extension (3.4 MHz).  It provides an inexpensive bus for connecting many
-types of devices with infrequent or low bandwidth communications needs.
-I2C is widely used with embedded systems.  Some systems use variants that
-don't meet branding requirements, and so are not advertised as being I2C.
+I²C (pronounce: I squared C and written I2C in the kernel documentation) is
+a protocol developed by Philips. It is a slow two-wire protocol (variable
+speed, up to 400 kHz), with a high speed extension (3.4 MHz).  It provides
+an inexpensive bus for connecting many types of devices with infrequent or
+low bandwidth communications needs.  I2C is widely used with embedded
+systems.  Some systems use variants that don't meet branding requirements,
+and so are not advertised as being I2C but with different names, e.g. TWI
+(Two Wire Interface), IIC.
+
+The official I2C specification is the `"I2C-bus specification and user
+manual" (UM10204) <https://www.nxp.com/docs/en/user-guide/UM10204.pdf>`_
+published by NXP Semiconductors.
 
 SMBus (System Management Bus) is based on the I2C protocol, and is mostly
 a subset of I2C protocols and signaling.  Many I2C devices will work on an
-- 
2.24.1
