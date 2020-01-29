From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH v3 17/28] docs: i2c: smbus-protocol: fix typo
Date: Wed, 29 Jan 2020 16:19:42 +0100
Message-ID: <20200129151953.31582-18-luca@lucaceresoli.net>
References: <20200129151953.31582-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:46449 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727161AbgA2QWx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 29 Jan 2020 11:22:53 -0500
In-Reply-To: <20200129151953.31582-1-luca@lucaceresoli.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org


The subject is plural, fix the verb.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Jean Delvare <jdelvare@suse.de>

---

Changes in v2:
 - fix subject line (Jean Delvare)
---
 Documentation/i2c/smbus-protocol.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/smbus-protocol.rst b/Documentation/i2c/smbus-protocol.rst
index 3c0fb3a2044d..de7285de5e93 100644
--- a/Documentation/i2c/smbus-protocol.rst
+++ b/Documentation/i2c/smbus-protocol.rst
@@ -145,7 +145,7 @@ SMBus Write Word
 Implemented by i2c_smbus_write_word_data()
 
 This is the opposite of the Read Word operation. 16 bits
-of data is written to a device, to the designated register that is
+of data are written to a device, to the designated register that is
 specified through the Comm byte.::
 
   S Addr Wr [A] Comm [A] DataLow [A] DataHigh [A] P
-- 
2.25.0
