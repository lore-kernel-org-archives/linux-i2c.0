From: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: RE: [PATCH v5 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Tue, 22 Nov 2011 17:26:18 +0100
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B40D16B@wm021.weinmann.com>
References: <D99582E5322435468A77E74BB0039E7B1D1655BF4D@SRV02.hamburg.garz-fricke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <D99582E5322435468A77E74BB0039E7B1D1655BF4D-6hi2BFpdtA3X4XV0xjfKZxOngtiEHj0sqGK+G5UkneY@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Carsten Behling' <carsten.behling-0M7HhAU3Y85FsXB23wyQUg@public.gmane.org>
Cc: "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

Carsten Behling wrote on 2011-11-22:
> +static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
> +{
> +       *dev->buf = at91_twi_read(dev, AT91_TWI_RHR) & 0xff;
> +
> +       /* send stop if second but last byte has been read */
> +       if (--dev->buf_len == 1)
> +               at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
> 
> 
> 
> If dev->buf_len =1 at the beginning of a read transfer, a stop condition will
> never be send.

this case is already catched in at91_do_twi_transfer():

+       if (dev->msg->flags & I2C_M_RD) {
+               unsigned start_flags = AT91_TWI_START;
+
+               /* if only one byte is to be read, immediately stop transfer */
+               if (dev->buf_len <= 1 && !(dev->msg->flags & I2C_M_RECV_LEN))
+                       start_flags |= AT91_TWI_STOP;
+               at91_twi_write(dev, AT91_TWI_CR, start_flags);

Thanks for reviewing,
Niko
