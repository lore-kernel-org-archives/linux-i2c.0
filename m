From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH v3 11/28] docs: i2c: smbus-protocol: fix link syntax
Date: Wed, 29 Jan 2020 16:19:36 +0100
Message-ID: <20200129151953.31582-12-luca@lucaceresoli.net>
References: <20200129151953.31582-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200129151953.31582-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


Use the proper ReST syntax to generate a valid hyperlink.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Jean Delvare <jdelvare@suse.de>

---

Changes in v3:
 - fix subject line (Jean Delvare)
---
 Documentation/i2c/smbus-protocol.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/smbus-protocol.rst b/Documentation/i2c/smbus-protocol.rst
index e30eb1d274c6..1600b09ec0be 100644
--- a/Documentation/i2c/smbus-protocol.rst
+++ b/Documentation/i2c/smbus-protocol.rst
@@ -27,8 +27,8 @@ a different protocol operation entirely.
 Each transaction type corresponds to a functionality flag. Before calling a
 transaction function, a device driver should always check (just once) for
 the corresponding functionality flag to ensure that the underlying I2C
-adapter supports the transaction in question. See
-<file:Documentation/i2c/functionality.rst> for the details.
+adapter supports the transaction in question. See :doc:`functionality` for
+the details.
 
 
 Key to symbols
-- 
2.25.0
