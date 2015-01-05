From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V1 1/1] iio: Added Capella cm3232 ambient light sensor
 driver.
Date: Mon, 05 Jan 2015 05:09:56 -0800
Message-ID: <1420463396.2652.8.camel@perches.com>
References: <1420071030-888-1-git-send-email-ktsai@capellamicro.com>
	 <CAEnQRZBD2NMYRp1cW0J2ssT4CT=0jSM=X6ByHQiUrA0ueV8fRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEnQRZBD2NMYRp1cW0J2ssT4CT=0jSM=X6ByHQiUrA0ueV8fRA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Kevin Tsai <ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Archana Patni <archana.patni-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 2015-01-05 at 12:51 +0200, Daniel Baluta wrote:
> On Thu, Jan 1, 2015 at 2:10 AM, Kevin Tsai <ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org> wrote:
> > CM3232 is an advanced ambient light sensor with I2C protocol interface.
> > The I2C slave address is internally hardwired as 0x10 (7-bit).  Writing
> > to configure register is byte mode, but reading ALS register requests to
> > use word mode for 16-bit resolution.
> 
> This looks good to me.  Few comments inline.
[]
> > diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
[]
> > +/**
> > + * cm3232_reg_init() - Initialize CM3232 registers
> > + * @chip:      pointer of struct cm3232.
> > + *
> > + * Initialize CM3232 ambient light sensor register to default values.
> > + *
> > +  Return: 0 for success; otherwise for error code.
> > + */
> > +static int cm3232_reg_init(struct cm3232_chip *chip)
> > +{
> > +       struct i2c_client *client = chip->client;
> > +       struct cm3232_als_info *als_info;
> > +       s32 ret;
> > +
> > +       /* Identify device */
> > +       ret = i2c_smbus_read_word_data(client, CM3232_REG_ADDR_ID);
> > +       if (ret < 0)
> > +               return ret;
> > +       if ((ret & 0xFF) != 0x32)
> > +               return -ENODEV;
> > +
> > +       /* Disable and reset device */
> > +       chip->regs_cmd = CM3232_CMD_ALS_DISABLE | CM3232_CMD_ALS_RESET;
> > +       ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
> > +                               chip->regs_cmd);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       /* Initialization */
> > +       als_info = chip->als_info = &cm3232_als_info_default;
> > +       chip->regs_cmd = CM3232_CMD_DEFAULT;
> > +
> > +       /* Configure register */
> > +       ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
> > +                               chip->regs_cmd);
> 
> You could directly return i2c_smbus_write_byte_data(..).

Sometimes it's better to return a specific value
for the error instead of depending on correctness
of all the indirect functions in the call chain.

In this case, all the smbus_xfer functions must
return 0 on success.  Do they?

Inspecting the codebase for correctness or not
depending on that correctness is sometimes better
to avoid doing.

> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return 0;
> > +}


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
