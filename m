From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] ASoC/TLV320AIC3X: Stop I2C driver ID abuse
Date: Thu, 20 Mar 2008 17:35:50 +0100
Message-ID: <20080320173550.0c60326c@hyperion.delvare>
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
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Please stop using random I2C driver IDs.

Also removed a pointless initialization to 0 of a static struct member.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
I will push this to Linus through my i2c tree by the end of the week.

 sound/soc/codecs/tlv320aic3x.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.25-rc6.orig/sound/soc/codecs/tlv320aic3x.c	2008-03-20 17:03:40.000000000 +0100
+++ linux-2.6.25-rc6/sound/soc/codecs/tlv320aic3x.c	2008-03-20 17:03:42.000000000 +0100
@@ -1187,10 +1187,8 @@ static struct i2c_driver aic3x_i2c_drive
 		.name = "aic3x I2C Codec",
 		.owner = THIS_MODULE,
 	},
-	.id = I2C_DRIVERID_I2CDEV,
 	.attach_adapter = aic3x_i2c_attach,
 	.detach_client = aic3x_i2c_detach,
-	.command = NULL,
 };
 
 static struct i2c_client client_template = {


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
