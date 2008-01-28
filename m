From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] Rename i2c-mpc to i2c-mpc-drv in preparation for
	breaking	out common code.
Date: Mon, 28 Jan 2008 09:42:04 -0500
Message-ID: <20080128144204.8410.98868.stgit@terra.home>
References: <20080128144202.8410.14647.stgit@terra.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-reply-to: <20080128144202.8410.14647.stgit-+J+k29bDNxlBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Rename i2c-mpc to i2c-mpc-drv in preparation for breaking out common code.

Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

 drivers/i2c/busses/Makefile      |    2 
 drivers/i2c/busses/i2c-mpc-drv.c |  421 ++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-mpc.c     |  421 --------------------------------------
 3 files changed, 423 insertions(+), 421 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-mpc-drv.c
 delete mode 100644 drivers/i2c/busses/i2c-mpc.c


diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index ea7068f..171800d 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the i2c bus drivers.
 #
 
+i2c-mpc-objs	:= i2c-mpc-drv.o
+
 obj-$(CONFIG_I2C_ALI1535)	+= i2c-ali1535.o
 obj-$(CONFIG_I2C_ALI1563)	+= i2c-ali1563.o
 obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc-drv.c
similarity index 100%
rename from drivers/i2c/busses/i2c-mpc.c
rename to drivers/i2c/busses/i2c-mpc-drv.c


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
