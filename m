From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: [PATCH] [OF] request_module() use format string
Date: Thu, 12 Jun 2008 07:02:06 +0200
Message-ID: <1213246926-10043-1-git-send-email-max@stro.at>
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
To: davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
Cc: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

similar to 326f6a5c9c9e1a62aec37bdc0c3f8d53adabe77b,
maybe writable by root thus worth fixing.

Signed-off-by: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
---
 drivers/of/of_i2c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index b2ccdcb..117de8b 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -100,7 +100,7 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 
 		info.addr = *addr;
 
-		request_module(info.type);
+		request_module("%s", info.type);
 
 		result = i2c_new_device(adap, &info);
 		if (result == NULL) {
-- 
1.5.5.1


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
