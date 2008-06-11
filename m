From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fwd:  rtc pfc8563 driver lost a chip id
Date: Wed, 11 Jun 2008 09:21:45 -0400
Message-ID: <9e4733910806110621i5e28df70jb7726861d1b30676@mail.gmail.com>
References: <9e4733910806101522o1e29c404t72de63772d34f1b7@mail.gmail.com>
	<20080611090458.2c22cb43@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080611090458.2c22cb43-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I think this got dropped during the conversion to the new probe signature.

>From the Kconfig...

config RTC_DRV_PCF8563
        tristate "Philips PCF8563/Epson RTC8564"
        help
          If you say yes here you get support for the
          Philips PCF8563 RTC chip. The Epson RTC8564
          should work as well.

          This driver can also be built as a module. If so, the module
          will be called rtc-pcf8563.



---------- Forwarded message ----------
From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Date: Jun 11, 2008 3:04 AM
Subject: Re: [i2c] rtc pfc8563 driver lost a chip id
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>


Hi Jon,


 On Tue, 10 Jun 2008 18:22:50 -0400, Jon Smirl wrote:
 > It does the rtc8564 too.
 >
 > diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
 > index 0fc4c36..748a502 100644
 > --- a/drivers/rtc/rtc-pcf8563.c
 > +++ b/drivers/rtc/rtc-pcf8563.c
 > @@ -302,6 +302,7 @@ static int pcf8563_remove(struct i2c_client *client)
 >
 >  static const struct i2c_device_id pcf8563_id[] = {
 >         { "pcf8563", 0 },
 > +       { "rtc8564", 0 },
 >         { }
 >  };
 >  MODULE_DEVICE_TABLE(i2c, pcf8563_id);


Please check MAINTAINERS for the right person and list to send this
 patch to.

 --

Jean Delvare


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
