From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 24/26] docs: i2c: old-module-parameters: clarify this is for obsolete kernels
Date: Mon,  6 Jan 2020 08:46:39 +0100
Message-ID: <20200106074639.13763-1-luca@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200105224006.10321-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This section applies only to code for very old kernels. Avoid people
reading this unnecessarily.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/i2c/old-module-parameters.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/i2c/old-module-parameters.rst b/Documentation/i2c/old-module-parameters.rst
index 0503d2f0b127..80fb117883fd 100644
--- a/Documentation/i2c/old-module-parameters.rst
+++ b/Documentation/i2c/old-module-parameters.rst
@@ -2,6 +2,11 @@
 I2C device driver binding control from user-space
 =================================================
 
+.. NOTE::
+   Note: this section is only relevant if you are handling some old code
+   found in kernel 2.6. If you work with more recent kernels, you can
+   safely skip this section.
+
 Up to kernel 2.6.32, many I2C drivers used helper macros provided by
 <linux/i2c.h> which created standard module parameters to let the user
 control how the driver would probe I2C buses and attach to devices. These
-- 
2.24.1
