From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: s390 allmodconfig
Date: Fri, 29 Aug 2008 02:04:09 -0700
Message-ID: <20080829020409.2880013b.akpm@linux-foundation.org>
References: <20080829005217.509a6c23.akpm@linux-foundation.org>
	<20080829104533.0e65f43a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080829104533.0e65f43a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Heiko-cy1Wll9GaHOsTnJN9+BGXg@public.gmane.org, Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 29 Aug 2008 10:45:33 +0200 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Hi Andrew,
> 
> On Fri, 29 Aug 2008 00:52:17 -0700, Andrew Morton wrote:
> > drivers/i2c/busses/i2c-ocores.c: In function 'oc_setreg':
> > drivers/i2c/busses/i2c-ocores.c:68: error: implicit declaration of function 'iowrite8'
> > drivers/i2c/busses/i2c-ocores.c: In function 'oc_getreg':
> > drivers/i2c/busses/i2c-ocores.c:73: error: implicit declaration of function 'ioread8'
> > drivers/i2c/busses/i2c-ocores.c: In function 'ocores_i2c_probe':
> > drivers/i2c/busses/i2c-ocores.c:243: error: implicit declaration of function 'ioremap'
> > drivers/i2c/busses/i2c-ocores.c:243: warning: assignment makes pointer from integer without a cast
> > drivers/i2c/busses/i2c-ocores.c:279: error: implicit declaration of function 'iounmap'
> > 
> > Some missing Kconfig dependency.  s390 can't do IO :)
> 
> Where is this failure happening? In Linus' tree, I2C depends on
> HAS_IOMEM (which s390 doesn't have), and I2C_OCORES depends on I2C. So
> I fail to see how a make allmodconfig can select I2C_OCORES on s390.
> Can you share the .config file?
> 

<bisects>

It's
power-support-for-texas-instruments-bq27x00-battery-managers.patch,
which does

--- a/drivers/power/Kconfig~power-support-for-texas-instruments-bq27x00-battery-managers
+++ a/drivers/power/Kconfig
@@ -62,4 +62,17 @@ config BATTERY_PALMTX
 	help
 	  Say Y to enable support for the battery in Palm T|X.
 
+config BATTERY_BQ27x00
+	tristate "BQ27x00 battery driver"
+	help
+	  Say Y here to enable support for batteries with BQ27000 or
+	  BQ27200 chip.
+
+config BATTERY_BQ27200
+	bool "BQ27200 battery driver"
+	depends on BATTERY_BQ27x00
+	select I2C
+	help
+	  Say Y here to enable support for batteries with BQ27200(I2C) chip.
+


which enables I2C stuff in s390 allmodconfig.  Should it be `depends on'?

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
