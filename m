From: Lei YU <mine260309@gmail.com>
Subject: [PATCH v2] docs: i2c: Fix return value of i2c_smbus_xxx functions
Date: Tue, 19 Nov 2019 19:23:52 +0800
Message-ID: <1574162632-65848-1-git-send-email-mine260309@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lei YU <mine260309@gmail.com>
List-Id: linux-i2c@vger.kernel.org

In i2c/dev-interface.rst it said

> All these transactions return -1 on failure

But actually the i2c_smbus_xxx functions return negative error numbers
on failure, instead of -1.

Fix the document and remove the following sentence.

Signed-off-by: Lei YU <mine260309@gmail.com>
---
 Documentation/i2c/dev-interface.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/i2c/dev-interface.rst b/Documentation/i2c/dev-interface.rst
index 69c23a3..f2f2b28 100644
--- a/Documentation/i2c/dev-interface.rst
+++ b/Documentation/i2c/dev-interface.rst
@@ -163,11 +163,10 @@ for details) through the following functions::
   __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
                                    __u8 *values);
 
-All these transactions return -1 on failure; you can read errno to see
-what happened. The 'write' transactions return 0 on success; the
-'read' transactions return the read value, except for read_block, which
-returns the number of values read. The block buffers need not be longer
-than 32 bytes.
+All these transactions return a negative error number on failure.
+The 'write' transactions return 0 on success; the 'read' transactions
+return the read value, except for read_block, which returns the number
+of values read. The block buffers need not be longer than 32 bytes.
 
 The above functions are made available by linking against the libi2c library,
 which is provided by the i2c-tools project.  See:
-- 
2.7.4
