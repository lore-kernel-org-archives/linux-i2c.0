From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: I2c client driver + ACPI on Baytrail & kernel 4.4.2 = ?
Date: Sun, 13 Mar 2016 12:43:46 +0000
Message-ID: <CA+V1LzrWqmx2GH6cs65mS=YHkvx+6wnnq7RpeYChH886pn5fog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33522 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbcCMMnr (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 13 Mar 2016 08:43:47 -0400
Received: by mail-qk0-f173.google.com with SMTP id s5so65287078qkd.0
        for <linux-i2c@vger.kernel.org>; Sun, 13 Mar 2016 05:43:47 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hi All,
Please help to correct create i2c client with ACPI support for device
(touchscreen) on i2c on vanilla 4.4.2 kernel x86_64 Baytrail,
disrtibutive = Arch.
========================================================
According kernel Documentation I have created such skeleton:


#define DEVICE_NAME  "testme"

static const struct acpi_device_id icn_ts_acpi_match[] = {
    { "CHPN0001", 0 },
    { "PNP05C0", 0 },
    { },
};
MODULE_DEVICE_TABLE(acpi, icn_ts_acpi_match);


static int ts_probe(struct i2c_client *client, const struct i2c_device_id *id){
    printk("Hello from %s",__func__);

    printk(&client->dev, "%s: got a device named %s at address 0x%x,
IRQ %d, flags 0x%x\n", __func__, client->name, client->addr,
client->irq, client->flags);

return 0;
}

static struct i2c_driver icn_ts_driver = {
    .probe = ts_probe,
    .remove = ts_remove,
    .id_table = ts_i2c_id,
    .driver = {
        .name = DEVICE_NAME,
        .owner = THIS_MODULE,
        .acpi_match_table = ACPI_PTR(icn_ts_acpi_match),

    },
};

static const struct i2c_device_id ts_i2c_id[] = {
    { DEVICE_NAME, 0 },
    { }
};
MODULE_DEVICE_TABLE(i2c, gsl_ts_i2c_id);


module_i2c_driver(icn_ts_driver);

===============================================


As result - nothing until I create i2c device with the name testme. I
am using user space way from kernel doc: echo testme 0x30 >
/sys/bus/i2c/devices/i2c-3/new_device.

ONLY AFTER this (Creating i2c device) I receive output from .probe function.
And as result I do NOT receive NOTHING ACPI related because i2c device
was created manually and all information is taken from my manual
created dev (bus address and bus number), no irq - nothing while DSDT
HAS THIS INFO!


>                        I2cSerialBus (0x0030, ControllerInitiated, 0x00061A80,
>                             AddressingMode7Bit, "\\_SB.I2C4",
>                             0x00, ResourceConsumer, ,
>                             )
>                         Interrupt (ResourceConsumer, Level,
> ActiveHigh, Exclusive, ,, )
>                         {
>                             0x00000044,
>                         }
>                         GpioIo (Exclusive, PullDefault, 0x0000,
> 0x0000, IoRestrictionOutputOnly,
>                             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>                             )
>                             {   // Pin list
>                                 0x001A
>                             }


MAIN QUESTIONS:

1) What is wrong with i2c client driver code? Why it is NOT obtain
info from ACPI DSD table?

2) In which way should be created i2c dev while registering i2c acpi
driver? Who\where\what and how should create this i2c device?


3) how to obtain info from ACPI DSD table?
In kernel doc there is a few lines but there is no enough detail explanation:


"This means that when ACPI_HANDLE(dev) returns non-NULL the device was
enumerated from ACPI namespace. This handle can be used to extract other
device-specific configuration."

PS: In Android I have seen some technic when 1st is created platform
driver, then via ACPI handle it gather all DSDT info.

Could some one example this with code (skeleton) and how then move
from platfrom driver to i2c client driver?

Regards,
                 Serge Kolotylo.
