From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Convert pfc8563 i2c driver from old style to new
	style
Date: Fri, 25 Jan 2008 12:16:46 -0500
Message-ID: <9e4733910801250916o15e9a64an754997dd79ebcff5@mail.gmail.com>
References: <20080121200901.15517.30253.stgit@terra.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080121200901.15517.30253.stgit-+J+k29bDNxlBDLzU/O5InQ@public.gmane.org>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Any final objections to this patch? Jean can you pick it up?

On 1/21/08, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Convert pfc8563 i2c driver from old style to new style.
>
> Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>
>  drivers/rtc/rtc-pcf8563.c |  107 +++++++++++----------------------------------
>  1 files changed, 27 insertions(+), 80 deletions(-)
>
>
> diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> index b3317fc..8eff549 100644
> --- a/drivers/rtc/rtc-pcf8563.c
> +++ b/drivers/rtc/rtc-pcf8563.c
> @@ -25,10 +25,6 @@
>   * located at 0x51 will pass the validation routine due to
>   * the way the registers are implemented.
>   */
> -static const unsigned short normal_i2c[] = { I2C_CLIENT_END };
> -
> -/* Module parameters */
> -I2C_CLIENT_INSMOD;
>
>  #define PCF8563_REG_ST1                0x00 /* status */
>  #define PCF8563_REG_ST2                0x01
> @@ -72,9 +68,6 @@ struct pcf8563 {
>         int c_polarity; /* 0: MO_C=1 means 19xx, otherwise MO_C=1 means 20xx */
>  };
>
> -static int pcf8563_probe(struct i2c_adapter *adapter, int address, int kind);
> -static int pcf8563_detach(struct i2c_client *client);
> -
>  /*
>   * In the routines that deal directly with the pcf8563 hardware, we use
>   * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
> @@ -257,98 +250,52 @@ static const struct rtc_class_ops pcf8563_rtc_ops = {
>         .set_time       = pcf8563_rtc_set_time,
>  };
>
> -static int pcf8563_attach(struct i2c_adapter *adapter)
> +static int pcf8563_remove(struct i2c_client *client)
>  {
> -       return i2c_probe(adapter, &addr_data, pcf8563_probe);
> +       struct rtc_device *rtc = i2c_get_clientdata(client);
> +
> +       if (rtc)
> +               rtc_device_unregister(rtc);
> +
> +       return 0;
>  }
>
> +static struct i2c_device_id pcf8563_id[] = {
> +       {"pcf8563", 0},
> +       {"rtc8564", 0},
> +       {},
> +};
> +MODULE_DEVICE_TABLE(i2c, pcf8563_id);
> +
> +static int pcf8563_probe(struct i2c_client *client, const struct i2c_device_id *id);
> +
>  static struct i2c_driver pcf8563_driver = {
>         .driver         = {
> -               .name   = "pcf8563",
> +               .name   = "rtc-pcf8563",
>         },
>         .id             = I2C_DRIVERID_PCF8563,
> -       .attach_adapter = &pcf8563_attach,
> -       .detach_client  = &pcf8563_detach,
> +       .probe = &pcf8563_probe,
> +       .remove = &pcf8563_remove,
> +       .id_table       = pcf8563_id,
>  };
>
> -static int pcf8563_probe(struct i2c_adapter *adapter, int address, int kind)
> +static int pcf8563_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
> -       struct pcf8563 *pcf8563;
> -       struct i2c_client *client;
> +       int result;
>         struct rtc_device *rtc;
>
> -       int err = 0;
> -
> -       dev_dbg(&adapter->dev, "%s\n", __FUNCTION__);
> -
> -       if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
> -               err = -ENODEV;
> -               goto exit;
> -       }
> -
> -       if (!(pcf8563 = kzalloc(sizeof(struct pcf8563), GFP_KERNEL))) {
> -               err = -ENOMEM;
> -               goto exit;
> -       }
> -
> -       client = &pcf8563->client;
> -       client->addr = address;
> -       client->driver = &pcf8563_driver;
> -       client->adapter = adapter;
> -
> -       strlcpy(client->name, pcf8563_driver.driver.name, I2C_NAME_SIZE);
> -
> -       /* Verify the chip is really an PCF8563 */
> -       if (kind < 0) {
> -               if (pcf8563_validate_client(client) < 0) {
> -                       err = -ENODEV;
> -                       goto exit_kfree;
> -               }
> -       }
> -
> -       /* Inform the i2c layer */
> -       if ((err = i2c_attach_client(client)))
> -               goto exit_kfree;
> -
> -       dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
> +       result = pcf8563_validate_client(client);
> +       if (result)
> +               return result;
>
>         rtc = rtc_device_register(pcf8563_driver.driver.name, &client->dev,
>                                 &pcf8563_rtc_ops, THIS_MODULE);
> -
> -       if (IS_ERR(rtc)) {
> -               err = PTR_ERR(rtc);
> -               goto exit_detach;
> -       }
> +       if (IS_ERR(rtc))
> +               return PTR_ERR(rtc);
>
>         i2c_set_clientdata(client, rtc);
>
>         return 0;
> -
> -exit_detach:
> -       i2c_detach_client(client);
> -
> -exit_kfree:
> -       kfree(pcf8563);
> -
> -exit:
> -       return err;
> -}
> -
> -static int pcf8563_detach(struct i2c_client *client)
> -{
> -       struct pcf8563 *pcf8563 = container_of(client, struct pcf8563, client);
> -       int err;
> -       struct rtc_device *rtc = i2c_get_clientdata(client);
> -
> -       if (rtc)
> -               rtc_device_unregister(rtc);
> -
> -       if ((err = i2c_detach_client(client)))
> -               return err;
> -
> -       kfree(pcf8563);
> -
> -       return 0;
>  }
>
>  static int __init pcf8563_init(void)
>
>
> _______________________________________________
> i2c mailing list
> i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
