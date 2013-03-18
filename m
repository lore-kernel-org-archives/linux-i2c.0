From: =?utf-8?Q?=C3=89meric?= Vigier
	<emeric.vigier-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Subject: how to gracefully unload an i2c driver if chip not detected?
Date: Mon, 18 Mar 2013 10:47:26 -0400 (EDT)
Message-ID: <35709576.270615.1363618046395.JavaMail.root@mail>
References: <931575758.126890.1363615027376.JavaMail.root@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <931575758.126890.1363615027376.JavaMail.root@mail>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I work on an omap platform running linux 3.0.21. The kernel image embeds two built-in i2c drivers for two different proximity sensors.
The hardware platform embeds only one sensor, so there is a detection mechanism of which chip is present in each driver (code below).

I recently changed the sensor on my board. Leading to kernel crash when entering suspend.
Thanks to "no_console_suspend" cmdline argument, I found out that the suspend function of the "absent" chip gets called. It tries to take a mutex which has been freed in probe's "device not found" fallback code. Leading to kernel panic.

I naively tried to add "i2c_del_driver(&vcnl4010_driver);" in the driver's probe function.
But it triggers a null ptr deref in i2c_do_del_adapter().

How can I gracefully unload this i2c driver if chip is not detected, while keeping this driver built-in in the kernel?
What is the recommended method to do just that?

Thanks,
Emeric

---------

static struct i2c_driver vcnl4010_driver;

static int __devinit vcnl4010_driver_probe(struct i2c_client *client, const struct i2c_device_id *id)
{
    [...]

    if(vcnl4010_read_transfer(data, VCNL4010_PROD_ID_VER, &reg_val, 1) !=0 )
    {
        pr_err("vcnl4010: Device not found!");
        goto nochip;
    }

    if(reg_val != 0x21)
    {
        pr_err("vcnl4010: Found device isn't a vcnl4010, is a vcnl4000 installed?");
        goto badchip;
    }

    [...]

badchip:
nochip:
    input_unregister_device(data->input_dev);
dev_register_error:
    input_free_device(data->input_dev);
dev_allocate_error:
    mutex_destroy(&data->lock);
    kfree(data);
error:
    /* i2c_del_driver(&vcnl4010_driver); triggers NULL ptr deref in i2c_do_del_adapter() */
    return ret;
}

static int vcnl4010_driver_suspend(struct device *dev)
{
    struct platform_device *pdev = to_platform_device(dev);
    struct vcnl4010_data *data = platform_get_drvdata(pdev);
    mutex_lock(&data->lock); /* panic kernel if chip is not present */
    vcnl4010_write(data, VCNL4010_CMD_REG,              0x00);
    vcnl4010_write(data, VCNL4010_IR_LED_CURR,             0);
    mutex_unlock(&data->lock);

    return 0;
}

static struct i2c_driver vcnl4010_driver = {
    .probe        = vcnl4010_driver_probe,
    .remove        = vcnl4010_driver_remove,
    .id_table    = vcnl4010_idtable,
    .driver = {
        .name = DRIVER_NAME,
#ifdef CONFIG_PM
        .pm = &vcnl4010_pm_ops,
#endif
    },
};
