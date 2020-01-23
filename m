From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH v2 19/28] docs: i2c: smbus-protocol: improve I2C Block transactions description
Date: Thu, 23 Jan 2020 15:56:17 +0100
Message-ID: <20200123145626.8102-6-luca@lucaceresoli.net>
References: <20200123135103.20540-1-luca@lucaceresoli.net>
 <20200123145626.8102-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200123145626.8102-1-luca@lucaceresoli.net>
Sender: linux-doc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Clarify from the beginning what these transactions are, and specifically
how they differ from the SMBus counterparts, i.e. the lack of a Count byte.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
---
 Documentation/i2c/smbus-protocol.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/i2c/smbus-protocol.rst b/Documentation/i2c/smbus-protocol.rst
index 7350e4b2c2fa..0edaf6069ac1 100644
--- a/Documentation/i2c/smbus-protocol.rst
+++ b/Documentation/i2c/smbus-protocol.rst
@@ -282,9 +282,10 @@ This is implemented the following way in the Linux kernel:
 I2C Block Transactions
 ======================
 
-The following I2C block transactions are supported by the
-SMBus layer and are described here for completeness.
-They are *NOT* defined by the SMBus specification.
+The following I2C block transactions are similar to the SMBus Block Read
+and Write operations, except these do not have a Count byte. They are
+supported by the SMBus layer and are described here for completeness, but
+they are *NOT* defined by the SMBus specification.
 
 I2C block transactions do not limit the number of bytes transferred
 but the SMBus layer places a limit of 32 bytes.
-- 
2.25.0
