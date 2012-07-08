From: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
Subject: [PATCH] i2c-mv64xxxx: allow more than one driver instance
Date: Sun,  8 Jul 2012 17:53:05 +0200
Message-ID: <1341762785-6918-1-git-send-email-ffainelli@freebox.fr>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Nicolas Schichan <nschichan-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The driver currently checks the platform device id and rejects platform
device id different from 0. This prevents the registration of a second
i2c controller on systems where a second one might be available (such as
Kirkwood 88F6282).

CC: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Signed-off-by: Nicolas Schichan <nschichan-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
Signed-off-by: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 4f44a33..6e70eea 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -528,7 +528,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	struct mv64xxx_i2c_pdata	*pdata = pd->dev.platform_data;
 	int	rc;
 
-	if ((pd->id != 0) || !pdata)
+	if (!pdata)
 		return -ENODEV;
 
 	drv_data = kzalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
-- 
1.7.9.5
