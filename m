From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: i2c-st: Use %pa to print 'resource_size_t' type
Date: Thu, 10 Jul 2014 20:23:25 -0300
Message-ID: <1405034605-21757-1-git-send-email-festevam@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: maxime.coquelin-qxv4g6HH51o@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

When building multi_v7_defconfig with CONFIG_ARM_LPAE=y the following warning
is seen:

drivers/i2c/busses/i2c-st.c:818:2: warning: format '%x' expects argument of type
'unsigned int', but argument 4 has type 'resource_size_t' [-Wformat=]

Use %pa to print 'resource_size_t' type to fix the warning.

Reported-by: Olof's autobuilder <build-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 95b94767..fc767dd 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -815,7 +815,7 @@ static int st_i2c_probe(struct platform_device *pdev)
 
 	adap = &i2c_dev->adap;
 	i2c_set_adapdata(adap, i2c_dev);
-	snprintf(adap->name, sizeof(adap->name), "ST I2C(0x%x)", res->start);
+	snprintf(adap->name, sizeof(adap->name), "ST I2C(0x%pa)", &res->start);
 	adap->owner = THIS_MODULE;
 	adap->timeout = 2 * HZ;
 	adap->retries = 0;
-- 
1.8.3.2
