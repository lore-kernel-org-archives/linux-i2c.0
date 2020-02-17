From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v10 4/4] i2c: core: support bus regulator controlling in adapter
Date: Mon, 17 Feb 2020 18:45:01 +0900
Message-ID: <CAAFQd5DtnBhGV-VemTwudm7K-UtFsGg99YGuD-cyR93u0OAPuA@mail.gmail.com>
References: <20200116025637.3524-1-bibby.hsieh@mediatek.com>
 <20200116025637.3524-5-bibby.hsieh@mediatek.com> <CAAFQd5Bh9dUuu2fzxQSyuyRrEvN5o8PBqPCUTdrC5btN2Q1HVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAFQd5Bh9dUuu2fzxQSyuyRrEvN5o8PBqPCUTdrC5btN2Q1HVw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Bibby Hsieh <bibby.hsieh-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Rafael,

On Tue, Jan 28, 2020 at 4:31 PM Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>
> Hi Rafael,
>
> On Thu, Jan 16, 2020 at 11:56 AM Bibby Hsieh <bibby.hsieh-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> >
> > Although in the most platforms, the bus power of i2c
> > are alway on, some platforms disable the i2c bus power
> > in order to meet low power request.
> >
> > We get and enable bulk regulator in i2c adapter device.
> >
> > Signed-off-by: Bibby Hsieh <bibby.hsieh-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/i2c/i2c-core-base.c | 81 +++++++++++++++++++++++++++++++++++++
> >  include/linux/i2c.h         |  3 ++
> >  2 files changed, 84 insertions(+)
> >
>
> I posted some comments in a separate reply [1] and Wolfram confirmed
> that he's fine with the approach [2]. Would you have some time to take
> a look from the PM point of view? Thanks.
>
> [1] https://patchwork.ozlabs.org/patch/1223991/#2350984
> [2] https://patchwork.ozlabs.org/patch/1223991/#2351032
>
> Please let me know if you want me to CC you directly on any of those replies.

Would you have a few minutes to take a look at this?

Thanks,
Tomasz

>
> Best regards,
> Tomasz
>
> > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> > index 9333c865d4a9..9b9e96b094ca 100644
> > --- a/drivers/i2c/i2c-core-base.c
> > +++ b/drivers/i2c/i2c-core-base.c
> > @@ -306,6 +306,7 @@ static int i2c_smbus_host_notify_to_irq(const struct i2c_client *client)
> >  static int i2c_device_probe(struct device *dev)
> >  {
> >         struct i2c_client       *client = i2c_verify_client(dev);
> > +       struct i2c_adapter      *adap = client->adapter;
> >         struct i2c_driver       *driver;
> >         int status;
> >
> > @@ -371,6 +372,12 @@ static int i2c_device_probe(struct device *dev)
> >
> >         dev_dbg(dev, "probe\n");
> >
> > +       status = regulator_enable(adap->bus_reg);
> > +       if (status != 0) {
> > +               dev_err(&adap->dev, "Failed to enable power regulator\n");
> > +               goto err_clear_wakeup_irq;
> > +       }
> > +
> >         status = of_clk_set_defaults(dev->of_node, false);
> >         if (status < 0)
> >                 goto err_clear_wakeup_irq;
> > @@ -407,6 +414,7 @@ static int i2c_device_probe(struct device *dev)
> >  static int i2c_device_remove(struct device *dev)
> >  {
> >         struct i2c_client       *client = i2c_verify_client(dev);
> > +       struct i2c_adapter      *adap = client->adapter;
> >         struct i2c_driver       *driver;
> >         int status = 0;
> >
> > @@ -420,6 +428,8 @@ static int i2c_device_remove(struct device *dev)
> >         }
> >
> >         dev_pm_domain_detach(&client->dev, true);
> > +       if (!pm_runtime_status_suspended(&adap->dev))
> > +               regulator_disable(adap->bus_reg);
> >
> >         dev_pm_clear_wake_irq(&client->dev);
> >         device_init_wakeup(&client->dev, false);
> > @@ -431,6 +441,71 @@ static int i2c_device_remove(struct device *dev)
> >         return status;
> >  }
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +static int i2c_resume(struct device *dev)
> > +{
> > +       struct i2c_client *client = i2c_verify_client(dev);
> > +       struct i2c_adapter *adap = client->adapter;
> > +       int err;
> > +
> > +       if (pm_runtime_status_suspended(&adap->dev)) {
> > +               err = regulator_enable(adap->bus_reg);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       return pm_generic_resume(dev);
> > +}
> > +
> > +static int i2c_suspend(struct device *dev)
> > +{
> > +       struct i2c_client *client = i2c_verify_client(dev);
> > +       struct i2c_adapter *adap = client->adapter;
> > +       int err;
> > +
> > +       if (!pm_runtime_status_suspended(&adap->dev)) {
> > +               err = regulator_disable(adap->bus_reg);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       return pm_generic_suspend(dev);
> > +}
> > +#endif
> > +
> > +#ifdef CONFIG_PM
> > +static int i2c_runtime_resume(struct device *dev)
> > +{
> > +       struct i2c_client *client = i2c_verify_client(dev);
> > +       struct i2c_adapter *adap = client->adapter;
> > +       int err;
> > +
> > +       err = regulator_enable(adap->bus_reg);
> > +       if (err)
> > +               return err;
> > +
> > +       return pm_generic_runtime_resume(dev);
> > +}
> > +
> > +static int i2c_runtime_suspend(struct device *dev)
> > +{
> > +       struct i2c_client *client = i2c_verify_client(dev);
> > +       struct i2c_adapter *adap = client->adapter;
> > +       int err;
> > +
> > +       err = pm_generic_runtime_suspend(dev);
> > +       if (err)
> > +               return err;
> > +
> > +       return regulator_disable(adap->bus_reg);
> > +}
> > +#endif
> > +
> > +static const struct dev_pm_ops i2c_device_pm = {
> > +       SET_SYSTEM_SLEEP_PM_OPS(i2c_suspend, i2c_resume)
> > +       SET_RUNTIME_PM_OPS(i2c_runtime_suspend, i2c_runtime_resume, NULL)
> > +};
> > +
> >  static void i2c_device_shutdown(struct device *dev)
> >  {
> >         struct i2c_client *client = i2c_verify_client(dev);
> > @@ -488,6 +563,7 @@ struct bus_type i2c_bus_type = {
> >         .probe          = i2c_device_probe,
> >         .remove         = i2c_device_remove,
> >         .shutdown       = i2c_device_shutdown,
> > +       .pm             = &i2c_device_pm,
> >  };
> >  EXPORT_SYMBOL_GPL(i2c_bus_type);
> >
> > @@ -1351,6 +1427,11 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
> >                 goto out_reg;
> >
> >         dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
> > +       adap->bus_reg = devm_regulator_get(&adap->dev, "bus");
> > +       if (IS_ERR(adap->bus_reg)) {
> > +               res = PTR_ERR(adap->bus_reg);
> > +               goto out_reg;
> > +       }
> >
> >         pm_runtime_no_callbacks(&adap->dev);
> >         pm_suspend_ignore_children(&adap->dev, true);
> > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > index d2f786706657..833b81a680da 100644
> > --- a/include/linux/i2c.h
> > +++ b/include/linux/i2c.h
> > @@ -15,6 +15,7 @@
> >  #include <linux/device.h>      /* for struct device */
> >  #include <linux/sched.h>       /* for completion */
> >  #include <linux/mutex.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/rtmutex.h>
> >  #include <linux/irqdomain.h>           /* for Host Notify IRQ */
> >  #include <linux/of.h>          /* for struct device_node */
> > @@ -330,6 +331,7 @@ struct i2c_client {
> >         int init_irq;                   /* irq set at initialization    */
> >         int irq;                        /* irq issued by device         */
> >         struct list_head detected;
> > +
> >  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> >         i2c_slave_cb_t slave_cb;        /* callback for slave mode      */
> >  #endif
> > @@ -723,6 +725,7 @@ struct i2c_adapter {
> >         const struct i2c_adapter_quirks *quirks;
> >
> >         struct irq_domain *host_notify_domain;
> > +       struct regulator *bus_reg;
> >  };
> >  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
> >
> > --
> > 2.18.0
