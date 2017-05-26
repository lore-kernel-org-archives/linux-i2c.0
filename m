From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 6/8] docs: i2c: dev-interface: adapt to new filenames of the i2c core
Date: Fri, 26 May 2017 10:20:57 +0200
Message-ID: <20170526082101.4746-7-wsa@the-dreams.de>
References: <20170526082101.4746-1-wsa@the-dreams.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170526082101.4746-1-wsa@the-dreams.de>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The I2C core files were renamed, adapt the textfile to it.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/i2c/dev-interface | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
index bcf919d8625ceb..5ff19447ac4420 100644
--- a/Documentation/i2c/dev-interface
+++ b/Documentation/i2c/dev-interface
@@ -191,7 +191,7 @@ checking on future transactions.)
 4* Other ioctl() calls are converted to in-kernel function calls by
 i2c-dev. Examples include I2C_FUNCS, which queries the I2C adapter
 functionality using i2c.h:i2c_get_functionality(), and I2C_SMBUS, which
-performs an SMBus transaction using i2c-core.c:i2c_smbus_xfer().
+performs an SMBus transaction using i2c-core-smbus.c:i2c_smbus_xfer().
 
 The i2c-dev driver is responsible for checking all the parameters that
 come from user-space for validity. After this point, there is no
@@ -200,13 +200,13 @@ and calls that would have been performed by kernel I2C chip drivers
 directly. This means that I2C bus drivers don't need to implement
 anything special to support access from user-space.
 
-5* These i2c-core.c/i2c.h functions are wrappers to the actual
-implementation of your I2C bus driver. Each adapter must declare
-callback functions implementing these standard calls.
-i2c.h:i2c_get_functionality() calls i2c_adapter.algo->functionality(),
-while i2c-core.c:i2c_smbus_xfer() calls either
+5* These i2c.h functions are wrappers to the actual implementation of
+your I2C bus driver. Each adapter must declare callback functions
+implementing these standard calls. i2c.h:i2c_get_functionality() calls
+i2c_adapter.algo->functionality(), while
+i2c-core-smbus.c:i2c_smbus_xfer() calls either
 adapter.algo->smbus_xfer() if it is implemented, or if not,
-i2c-core.c:i2c_smbus_xfer_emulated() which in turn calls
+i2c-core-smbus.c:i2c_smbus_xfer_emulated() which in turn calls
 i2c_adapter.algo->master_xfer().
 
 After your I2C bus driver has processed these requests, execution runs
-- 
2.11.0

