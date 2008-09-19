From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 1/2] i2c: expand I2C's id.name to 23 characters
Date: Fri, 19 Sep 2008 22:03:39 +0400
Message-ID: <20080919180339.GA13899@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

It was discussed[1] that we should match on the first (most specific)
entry in the device tree.

The most lengthy I2C compatible entry for the MPC8349E-mITX MCU
devices is "mc9s08qg8-mpc8349emitx" (w/o vendor name). This means
that we have to allow longer IDs to be used in the I2C subsystem.

[1] http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg21196.html

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 include/linux/mod_devicetable.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index c4db582..9d9d1f5 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -379,7 +379,7 @@ struct virtio_device_id {
 
 /* i2c */
 
-#define I2C_NAME_SIZE	20
+#define I2C_NAME_SIZE	23
 #define I2C_MODULE_PREFIX "i2c:"
 
 struct i2c_device_id {
-- 
1.5.6.3
