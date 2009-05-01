From: Shane Dixon <shane.dixon-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: Moving to new driver model: probe never called
Date: Fri, 01 May 2009 13:14:10 -0600
Message-ID: <1241205250.31476.86.camel@homestead>
References: <1241193404.31476.6.camel@homestead>
	 <20090501195146.4da8edf5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090501195146.4da8edf5-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean,

Thank you for the help.  This is only my 2nd driver I've ever written
(the first one being the i2c legacy version of the same driver!)  I
think that did it.  The device is a tpm, but the I2C_CLASS_HWMON seems
to help it get a little farther to the detect function.  I also had to
make sure I had the normal_i2c[] struct present because I know the
device listens on 0x29.  This isn't something I can modify the
board_info for because it's just wires jumping the device over to a
development board (for a demo), so it's not permanently soldered on.  I
don't think it would be correct to use the board_info to treat it like a
static device.

--
Shane

On Fri, 2009-05-01 at 19:51 +0200, Jean Delvare wrote:
> Hi Shane,
> 
> On Fri, 01 May 2009 09:56:44 -0600, Shane Dixon wrote:
> > I'm trying to port a working driver from the old device driver model to
> > the new.  I have a printk in the first line of my probe function, which
> > never gets printed after doing a modprobe.  Hooking up a scope shows
> > that nothing is sent at all to the device.  Below is the relevant
> > snippets of code:
> > 
> > #define DEVICE_NAME "atpm"
> > 
> > static struct i2c_device_id atpm_idtable[] = {
> >   { DEVICE_NAME, 0 },
> >   { }
> > };
> > MODULE_DEVICE_TABLE(i2c, atpm_idtable);
> > 
> > static struct i2c_driver atpm_driver =
> > {
> >     .driver = {
> >       .name         = DEVICE_NAME,
> >       .owner        = THIS_MODULE,
> >     },
> >     .probe          = atpm_probe,
> >     .remove         = __devexit_p(atpm_remove),
> >     .id_table       = atpm_idtable,
> >     .detect         = atpm_detect,
> >     /* .address_data   = &addr_data */
> 
> .detect is ignored without .address_data. From i2c-core.c:
> 
> static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver)
> {
> 	const struct i2c_client_address_data *address_data;
> 	(...)
> 
> 	address_data = driver->address_data;
> 	if (!driver->detect || !address_data)
> 		return 0;
> 
> Additionally, you must define atpm_driver.class, otherwise
> atpm_driver.detect will never be called.
> 
> > };
> > 
> > static int __init atpm_init(void)
> > {
> >   printk(DEVICE_NAME ": adding i2c driver\n");
> >   return i2c_add_driver(&atpm_driver);
> > }
> > 
> > static void __exit atpm_exit(void)
> > {
> >   i2c_del_driver(&atpm_driver);
> >   printk(DEVICE_NAME ": deleting i2c driver\n");
> > }
> > 
> > module_init(atpm_init);
> > module_exit(atpm_exit);
> > 
> > Any help would be appreciated.
> 
> What is this "atpm" device? Can it be reliably detected? In general it
> is better to instantiate I2C devices explicitly, for example through
> platform data. Why don't you do that?
> 

-- 
Shane Dixon
Linux Engineer
Atmel Corporation
E-mail: shane.dixon-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
