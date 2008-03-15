From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: [PATCH] I2C: Introduce irq_flags in i2c_boardinfo and
	i2c_client
Date: Sat, 15 Mar 2008 14:47:15 +0200
Message-ID: <1205585237-21492-2-git-send-email-me@felipebalbi.com>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1205585237-21492-1-git-send-email-me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, David Brownell <david-b-ZKR15rr3LjGsTnJN9+BGXg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Drivers like isp1301_omap.c are used in several different
boards and thus we need different irq_flags. Instead of
keeping conditional code in the driver only because of
irq_flags we can get it from i2c_boardinfo.

Signed-off-by: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    1 +
 include/linux/i2c.h    |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index fd84b2a..5a290f6 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -254,6 +254,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->flags = info->flags & ~I2C_CLIENT_WAKE;
 	client->addr = info->addr;
 	client->irq = info->irq;
+	client->irq_flags = info->irq_flags;
 
 	strlcpy(client->driver_name, info->driver_name,
 		sizeof(client->driver_name));
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 365e0df..fe715f6 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -175,6 +175,7 @@ struct i2c_client {
 	struct i2c_driver *driver;	/* and our access routines	*/
 	struct device dev;		/* the device structure		*/
 	int irq;			/* irq issued by device (or -1) */
+	int irq_flags;			/* flags for irq		*/
 	char driver_name[KOBJ_NAME_LEN];
 	struct list_head list;		/* DEPRECATED */
 	struct completion released;
@@ -227,6 +228,7 @@ struct i2c_board_info {
 	unsigned short	addr;
 	void		*platform_data;
 	int		irq;
+	int		irq_flags;
 };
 
 /**
-- 
1.5.4.3.447.gc95b3


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
