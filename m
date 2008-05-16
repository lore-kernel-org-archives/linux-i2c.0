From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: [patch 3/3] i2c: add support for i2c bus on Freescale
 CPM1/CPM2 controllers
Date: Fri, 16 May 2008 21:27:30 +0200
Message-ID: <482DE022.8050502@scram.de>
References: <200805142314.m4ENEjPV026316@imap1.linux-foundation.org>	<20080516083743.GA4180@pengutronix.de>
	<20080516210818.26bf8cb8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080516210818.26bf8cb8-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, htoa-hi6Y0CQ0nG0@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, tmbinc-hi6Y0CQ0nG0@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

>> Bummer! This should not be I2COM_MASTER but I2COM_START! Otherwise no
>> I2C communication will happen.
>>
>> After applying this change, the driver works fine on an MPC8260 (like
>> the previous version did).
> 
> Would you have the possibility to review and ack this patch (with the
> suggested fix above, of course)?

I'd like to add yet another small change:

It doesn't make sense to add fsl,cpm-i2c as second compatible entry in the
device tree just for loading the driver. The match table can use
fsl,cpm1-i2c and fsl,cpm2-i2c directly.

Thanks,
Jochen

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 2bd0512..7c0f6d4 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -693,7 +693,10 @@ static int __devexit cpm_i2c_remove(struct of_device *ofdev)
 
 static const struct of_device_id cpm_i2c_match[] = {
 	{
-		.compatible = "fsl,cpm-i2c",
+		.compatible = "fsl,cpm1-i2c",
+	},
+	{
+		.compatible = "fsl,cpm2-i2c",
 	},
 	{},
 };

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
