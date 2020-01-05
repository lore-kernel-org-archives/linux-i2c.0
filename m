From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 16/26] docs: i2c: smbus-protocol: fix kernel-doc function syntax
Date: Sun,  5 Jan 2020 23:50:02 +0100
Message-ID: <20200105225012.11701-16-luca@lucaceresoli.net>
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

This clarifies these are functions (and would/will adds a hyperlink to the
function documentation if/when documented).

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/i2c/smbus-protocol.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/smbus-protocol.rst b/Documentation/i2c/smbus-protocol.rst
index 997945e90419..3c0fb3a2044d 100644
--- a/Documentation/i2c/smbus-protocol.rst
+++ b/Documentation/i2c/smbus-protocol.rst
@@ -118,7 +118,7 @@ byte. But this time, the data is a complete word (16 bits)::
 
 Functionality flag: I2C_FUNC_SMBUS_READ_WORD_DATA
 
-Note the convenience function i2c_smbus_read_word_swapped is
+Note the convenience function i2c_smbus_read_word_swapped() is
 available for reads where the two data bytes are the other way
 around (not SMBus compliant, but very popular.)
 
@@ -152,7 +152,7 @@ specified through the Comm byte.::
 
 Functionality flag: I2C_FUNC_SMBUS_WRITE_WORD_DATA
 
-Note the convenience function i2c_smbus_write_word_swapped is
+Note the convenience function i2c_smbus_write_word_swapped() is
 available for writes where the two data bytes are the other way
 around (not SMBus compliant, but very popular.)
 
-- 
2.24.1
