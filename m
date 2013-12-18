From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V2 04/13] i2c: isch: Use devm_request_region()
Date: Wed, 18 Dec 2013 10:48:07 +0900
Message-ID: <007501cefb93$32ca0df0$985e29d0$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
 <002801cefaf4$69243d70$3b6cb850$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002801cefaf4$69243d70$3b6cb850$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jean Delvare' <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_request_region() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
Changes since V1:
- Remove unnecessary 'res' variable from smbus_sch_remove().

 drivers/i2c/busses/i2c-isch.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index 8c38aaa..af21304 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -275,7 +275,8 @@ static int smbus_sch_probe(struct platform_device *dev)
 	if (!res)
 		return -EBUSY;
 
-	if (!request_region(res->start, resource_size(res), dev->name)) {
+	if (!devm_request_region(&dev->dev, res->start, resource_size(res),
+				 dev->name)) {
 		dev_err(&dev->dev, "SMBus region 0x%x already in use!\n",
 			sch_smba);
 		return -EBUSY;
@@ -294,7 +295,6 @@ static int smbus_sch_probe(struct platform_device *dev)
 	retval = i2c_add_adapter(&sch_adapter);
 	if (retval) {
 		dev_err(&dev->dev, "Couldn't register adapter!\n");
-		release_region(res->start, resource_size(res));
 		sch_smba = 0;
 	}
 
@@ -303,11 +303,8 @@ static int smbus_sch_probe(struct platform_device *dev)
 
 static int smbus_sch_remove(struct platform_device *pdev)
 {
-	struct resource *res;
 	if (sch_smba) {
 		i2c_del_adapter(&sch_adapter);
-		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-		release_region(res->start, resource_size(res));
 		sch_smba = 0;
 	}
 
-- 
1.7.10.4
