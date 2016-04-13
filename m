From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC] I2C: i2c-smbus: add device tree support
Date: Wed, 13 Apr 2016 20:58:49 +0300
Message-ID: <CAHp75VepT0ztJ3sLoM_Yw+yo9E3QLJaKNae_AQ3TMH=LbNeRfQ@mail.gmail.com>
References: <1460536591-12573-1-git-send-email-andrea.merello@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460536591-12573-1-git-send-email-andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrea Merello <andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 13, 2016 at 11:36 AM, Andrea Merello
<andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> According to Documentation/i2c/smbus-protocol, a smbus controller driver
> that wants to hook-in smbus extensions support, can call
> i2c_setup_smbus_alert(). There are very few drivers that are currently
> doing this.
>
> However the i2c-smbus module can also work with any
> smbus-extensions-unaware I2C controller, as long as we provide an extra
> IRQ line connected to the I2C bus ALARM signal.
>
> This patch makes it possible to go this way via DT. Note that the DT node
> will indeed describe a (little) piece of HW, that is the routing of the
> ALARM signal to an IRQ line (so it seems a fair DT use to me, but RFC).
>
> Note that AFAICT, by design, i2c-smbus module pretends to be an I2C slave
> with address 0x0C (that is the alarm response address), and IMHO this is
> quite consistent with usage in the DT as a I2C child node.

> --- a/drivers/i2c/i2c-smbus.c
> +++ b/drivers/i2c/i2c-smbus.c

> @@ -137,20 +138,29 @@ static int smbalert_probe(struct i2c_client *ara,
>         struct i2c_smbus_alert_setup *setup = dev_get_platdata(&ara->dev);
>         struct i2c_smbus_alert *alert;
>         struct i2c_adapter *adapter = ara->adapter;
> +       struct device_node *of_node = ara->dev.of_node;

Perhaps fwnode_handle ?

>         int res;
> +       int irq_type;
>
>         alert = devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
>                              GFP_KERNEL);
>         if (!alert)
>                 return -ENOMEM;
>
> -       alert->alert_edge_triggered = setup->alert_edge_triggered;
> -       alert->irq = setup->irq;
> +       if (setup) {
> +               alert->alert_edge_triggered = setup->alert_edge_triggered;
> +               alert->irq = setup->irq;
> +       } else if (of_node) {
> +               alert->irq = irq_of_parse_and_map(of_node, 0);
> +               irq_type = irq_get_trigger_type(alert->irq);
> +               alert->alert_edge_triggered = (irq_type & IRQ_TYPE_EDGE_BOTH);
> +       }

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
