From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/5] i2c: ocores: Make of_device_id array const
Date: Wed, 07 May 2014 17:54:23 +0900
Message-ID: <022101cf69d1$f1311200$d3933600$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Peter Korsgaard' <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, 'Andreas Larsson' <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 1f6369f..0e10cc6 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -250,7 +250,7 @@ static struct i2c_adapter ocores_adapter = {
 	.algo		= &ocores_algorithm,
 };
 
-static struct of_device_id ocores_i2c_match[] = {
+static const struct of_device_id ocores_i2c_match[] = {
 	{
 		.compatible = "opencores,i2c-ocores",
 		.data = (void *)TYPE_OCORES,
-- 
1.7.10.4
