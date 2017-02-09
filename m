From: Ben Gardner <gardner.ben@gmail.com>
Subject: Re: [PATCH] eeprom/at24: use device_property_*() functions instead of of_get_property()
Date: Thu, 9 Feb 2017 09:27:29 -0600
Message-ID: <CAE7DoPYfvdDJS=Q80P5-+Lf2L2j9sy9TcQ3eoh4CoAxtvs_yQg@mail.gmail.com>
References: <1486583636-8940-1-git-send-email-gardner.ben@gmail.com> <CAHp75Vd4iwOUaJFzS_AnDGSbmKPSg=f+9VAb6AZdkv51zpbbQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd4iwOUaJFzS_AnDGSbmKPSg=f+9VAb6AZdkv51zpbbQA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

Thanks for taking the time to look at this.

On Wed, Feb 8, 2017 at 6:07 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Feb 8, 2017 at 9:53 PM, Ben Gardner <gardner.ben@gmail.com> wrote:
> > Allow the at24 driver to get configuration information from both OF and
> > ACPI by using the more generic device_property functions.
> > This change was inspired by the at25.c driver.
> >

(snip)

> Few comments, after addressing them
>
> FWIW:
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>

(snip)

> >
> > -#ifdef CONFIG_OF
> > -static void at24_get_ofdata(struct i2c_client *client,
> > +static void at24_fw_to_chip(struct device *dev,
> >                             struct at24_platform_data *chip)
>
> "fw" here is ambiguous a bit.
> Would at24_get_pdata() work for you?

That name also works for me.

> >  {
> > -       const __be32 *val;
> > -       struct device_node *node = client->dev.of_node;
> > -
> > -       if (node) {
> > -               if (of_get_property(node, "read-only", NULL))
> > -                       chip->flags |= AT24_FLAG_READONLY;
> > -               val = of_get_property(node, "pagesize", NULL);
> > -               if (val)
> > -                       chip->page_size = be32_to_cpup(val);
> > -       }
> > +       u32 val;
> > +
> > +       if (device_property_present(dev, "read-only"))
> > +               chip->flags |= AT24_FLAG_READONLY;
> > +
>
> > +       if (device_property_read_u32(dev, "pagesize", &val) == 0)
>
> I would use default from probe here.
>
> int ret;
>
> ...
>
> ret = ..._u32(..., &val);
> if (ret) {
> /* ...long comment from ->probe()... */
>    chip->page_size = 1;
> } else
>    chip->page_size = val;

That sounds reasonable.

> > +               chip->page_size = val;
> >  }
> > -#else
> > -static void at24_get_ofdata(struct i2c_client *client,
> > -                           struct at24_platform_data *chip)
> > -{ }
> > -#endif /* CONFIG_OF */
> >
> >  static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >  {
> > @@ -621,7 +611,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >                 chip.page_size = 1;
> >
>
> >                 /* update chipdata if OF is present */
>
> This is now redundant.

Yeah, that comment doesn't seem all that useful.

> > -               at24_get_ofdata(client, &chip);
> > +               at24_fw_to_chip(&client->dev, &chip);
> >
> >                 chip.setup = NULL;
> >                 chip.context = NULL;
> > --
> > 2.7.4
> >
>
>
>
> --
> With Best Regards,
> Andy Shevchenko

I'll send an update.

Thanks,
Ben
