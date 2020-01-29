From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH v3 23/28] docs: i2c: old-module-parameters: fix internal hyperlink
Date: Wed, 29 Jan 2020 16:19:48 +0100
Message-ID: <20200129151953.31582-24-luca@lucaceresoli.net>
References: <20200129151953.31582-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200129151953.31582-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


Use ReST syntax so that a proper hyperlink is generated.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Jean Delvare <jdelvare@suse.de>

---

Changes in v2:
 - re-add the reference to the section (Jean Delvare)
---
 Documentation/i2c/old-module-parameters.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/old-module-parameters.rst b/Documentation/i2c/old-module-parameters.rst
index 78a6950e5763..1a18e2b0f593 100644
--- a/Documentation/i2c/old-module-parameters.rst
+++ b/Documentation/i2c/old-module-parameters.rst
@@ -12,8 +12,8 @@ address), "force" (to forcibly attach the driver to a given device) and
 With the conversion of the I2C subsystem to the standard device driver
 binding model, it became clear that these per-module parameters were no
 longer needed, and that a centralized implementation was possible. The new,
-sysfs-based interface is described in the documentation file
-"instantiating-devices", section "Method 4: Instantiate from user-space".
+sysfs-based interface is described in :doc:`instantiating-devices`, section
+"Method 4: Instantiate from user-space".
 
 Below is a mapping from the old module parameters to the new interface.
 
-- 
2.25.0
