From: Shane Dixon <shane.dixon-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Moving to new driver model: probe never called
Date: Fri, 01 May 2009 09:56:44 -0600
Message-ID: <1241193404.31476.6.camel@homestead>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I'm trying to port a working driver from the old device driver model to
the new.  I have a printk in the first line of my probe function, which
never gets printed after doing a modprobe.  Hooking up a scope shows
that nothing is sent at all to the device.  Below is the relevant
snippets of code:

#define DEVICE_NAME "atpm"

static struct i2c_device_id atpm_idtable[] = {
  { DEVICE_NAME, 0 },
  { }
};
MODULE_DEVICE_TABLE(i2c, atpm_idtable);

static struct i2c_driver atpm_driver =
{
    .driver = {
      .name         = DEVICE_NAME,
      .owner        = THIS_MODULE,
    },
    .probe          = atpm_probe,
    .remove         = __devexit_p(atpm_remove),
    .id_table       = atpm_idtable,
    .detect         = atpm_detect,
    /* .address_data   = &addr_data */
};

static int __init atpm_init(void)
{
  printk(DEVICE_NAME ": adding i2c driver\n");
  return i2c_add_driver(&atpm_driver);
}

static void __exit atpm_exit(void)
{
  i2c_del_driver(&atpm_driver);
  printk(DEVICE_NAME ": deleting i2c driver\n");
}

module_init(atpm_init);
module_exit(atpm_exit);

Any help would be appreciated.
-- 
Shane Dixon
Linux Engineer
Atmel Corporation
E-mail: shane.dixon-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
