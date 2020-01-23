From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH v2 18/28] docs: i2c: smbus-protocol: fix punctuation
Date: Thu, 23 Jan 2020 15:56:16 +0100
Message-ID: <20200123145626.8102-5-luca@lucaceresoli.net>
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

Remove misplaced dot before colon.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Jean Delvare <jdelvare@suse.de>

---

Changes in v2:
 - fix subject line (Jean Delvare)
---
 Documentation/i2c/smbus-protocol.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/smbus-protocol.rst b/Documentation/i2c/smbus-protocol.rst
index de7285de5e93..7350e4b2c2fa 100644
--- a/Documentation/i2c/smbus-protocol.rst
+++ b/Documentation/i2c/smbus-protocol.rst
@@ -146,7 +146,7 @@ Implemented by i2c_smbus_write_word_data()
 
 This is the opposite of the Read Word operation. 16 bits
 of data are written to a device, to the designated register that is
-specified through the Comm byte.::
+specified through the Comm byte::
 
   S Addr Wr [A] Comm [A] DataLow [A] DataHigh [A] P
 
-- 
2.25.0
