From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 13/17] i2c: include/linux/i2c.h: fix a doc warning
Date: Tue, 17 Mar 2020 15:54:22 +0100
Message-ID: <24cbf9166b21531186e5b6d37a3f9201f957abef.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Don't let non-letters inside a literal block without escaping it, as
the toolchain would mis-interpret it:

./include/linux/i2c.h:518: WARNING: Inline strong start-string without end-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/i2c.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f834687989f7..f6b942150631 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -506,7 +506,7 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
  * @smbus_xfer_atomic: same as @smbus_xfer. Yet, only using atomic context
  *   so e.g. PMICs can be accessed very late before shutdown. Optional.
  * @functionality: Return the flags that this algorithm/adapter pair supports
- *   from the I2C_FUNC_* flags.
+ *   from the ``I2C_FUNC_*`` flags.
  * @reg_slave: Register given client to I2C slave mode of this adapter
  * @unreg_slave: Unregister given client from I2C slave mode of this adapter
  *
@@ -515,7 +515,7 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
  * be addressed using the same bus algorithms - i.e. bit-banging or the PCF8584
  * to name two of the most common.
  *
- * The return codes from the @master_xfer{_atomic} fields should indicate the
+ * The return codes from the ``master_xfer{_atomic}`` fields should indicate the
  * type of error code that occurred during the transfer, as documented in the
  * Kernel Documentation file Documentation/i2c/fault-codes.rst.
  */
-- 
2.24.1
