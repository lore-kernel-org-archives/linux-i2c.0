From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] i2c: Document the implementation details of the
 /dev interface
Date: Sat, 6 Sep 2008 12:25:42 +0200
Message-ID: <20080906122542.76b1e843@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I wrote this explanation to answer a question on the i2c mailing list,
and thought it would be good to have in the kernel documentation.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/dev-interface |   45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

--- linux-2.6.27-rc5.orig/Documentation/i2c/dev-interface	2008-09-06 12:19:47.000000000 +0200
+++ linux-2.6.27-rc5/Documentation/i2c/dev-interface	2008-09-06 12:20:19.000000000 +0200
@@ -167,3 +167,48 @@ The above functions are all inline funct
 the i2c_smbus_access function, that on its turn calls a specific ioctl
 with the data in a specific format. Read the source code if you
 want to know what happens behind the screens.
+
+
+Implementation details
+======================
+
+For the interested, here's the code flow which happens inside the kernel
+when you use the /dev interface to I2C:
+
+1* Your program opens /dev/i2c-N and calls ioctl() on it, as described in
+section "C example" above.
+
+2* These open() and ioctl() calls are handled by the i2c-dev kernel
+driver: see i2c-dev.c:i2cdev_open() and i2c-dev.c:i2cdev_ioctl(),
+respectively. You can think of i2c-dev as a generic I2C chip driver
+that can be programmed from user-space.
+
+3* Some ioctl() calls are for administrative tasks and are handled by
+i2c-dev directly. Examples include I2C_SLAVE (set the address of the
+device you want to access) and I2C_PEC (enable or disable SMBus error
+checking on future transactions.)
+
+4* Other ioctl() calls are converted to in-kernel function calls by
+i2c-dev. Examples include I2C_FUNCS, which queries the I2C adapter
+functionality using i2c.h:i2c_get_functionality(), and I2C_SMBUS, which
+performs an SMBus transaction using i2c-core.c:i2c_smbus_xfer().
+
+The i2c-dev driver is responsible for checking all the parameters that
+come from user-space for validity. After this point, there is no
+difference between these calls that came from user-space through i2c-dev
+and calls that would have been performed by kernel I2C chip drivers
+directly. This means that I2C bus drivers don't need to implement
+anything special to support access from user-space.
+
+5* These i2c-core.c/i2c.h functions are wrappers to the actual
+implementation of your I2C bus driver. Each adapter must declare
+callback functions implementing these standard calls.
+i2c.h:i2c_get_functionality() calls i2c_adapter.algo->functionality(),
+while i2c-core.c:i2c_smbus_xfer() calls either
+adapter.algo->smbus_xfer() if it is implemented, or if not,
+i2c-core.c:i2c_smbus_xfer_emulated() which in turn calls
+i2c_adapter.algo->master_xfer().
+
+After your I2C bus driver has processed these requests, execution runs
+up the call chain, with almost no processing done, except by i2c-dev to
+package the returned data, if any, in suitable format for the ioctl.


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
