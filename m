From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Fwd: [PATCH 2/3] I2C: at24: add kernel interface for
	reading/writing EEPROM
Date: Mon, 25 Aug 2008 23:40:50 -0400
Message-ID: <9e4733910808252040j69b10ea8n1e3e40d16e86a3ae@mail.gmail.com>
References: <200808251941.54964.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200808251941.54964.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 8/25/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> My own comments on this:
>
>         - I'd like to see at24.c use something running before
>           device_initcall, so suitably configured system can
>           have drivers calling platform_device_probe() from
>           their own initcalls and yet have access to the config
>           data from the EEPROMs.
>
>         - Seems to me that "struct at24_iface" should be more
>           generic ... the same notion works for SPI eeproms,
>           NVRAM as found in RTCs, etc.
>
>  Comments?

Would it make sense to use bus notifiers to track the detection of a
at24 chip? I have some MMC code in my tree that is using them.

+static int of_mmc_spi_notify(struct notifier_block *nb, unsigned long action,
+			     void *_dev)
+{
+	struct device *dev = _dev;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		return of_mmc_spi_add(dev);
+	case BUS_NOTIFY_DEL_DEVICE:
+		return of_mmc_spi_del(dev);
+	};
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block of_mmc_spi_notifier = {
+	.notifier_call = of_mmc_spi_notify,
+};
+

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
