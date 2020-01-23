From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH v2 05/28] docs: i2c: fix typo
Date: Thu, 23 Jan 2020 14:50:40 +0100
Message-ID: <20200123135103.20540-6-luca@lucaceresoli.net>
References: <20200123135103.20540-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200123135103.20540-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Fix "issus" -> "issues".

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Acked-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
---
 Documentation/i2c/i2c-topology.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/i2c-topology.rst b/Documentation/i2c/i2c-topology.rst
index 0875090d6aeb..b413ef6a6773 100644
--- a/Documentation/i2c/i2c-topology.rst
+++ b/Documentation/i2c/i2c-topology.rst
@@ -169,7 +169,7 @@ PL1. If you build a topology with a parent-locked mux being the child
      of another mux, this might break a possible assumption from the
      child mux that the root adapter is unused between its select op
      and the actual transfer (e.g. if the child mux is auto-closing
-     and the parent mux issus I2C-transfers as part of its select).
+     and the parent mux issues I2C-transfers as part of its select).
      This is especially the case if the parent mux is mux-locked, but
      it may also happen if the parent mux is parent-locked.
 
-- 
2.25.0
