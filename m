From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Moving to new driver model: probe never called
Date: Fri, 1 May 2009 19:51:46 +0200
Message-ID: <20090501195146.4da8edf5@hyperion.delvare>
References: <1241193404.31476.6.camel@homestead>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1241193404.31476.6.camel@homestead>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shane Dixon <shane.dixon-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Shane,

On Fri, 01 May 2009 09:56:44 -0600, Shane Dixon wrote:
> I'm trying to port a working driver from the old device driver model to
> the new.  I have a printk in the first line of my probe function, which
> never gets printed after doing a modprobe.  Hooking up a scope shows
> that nothing is sent at all to the device.  Below is the relevant
> snippets of code:
> 
> #define DEVICE_NAME "atpm"
> 
> static struct i2c_device_id atpm_idtable[] = {
>   { DEVICE_NAME, 0 },
>   { }
> };
> MODULE_DEVICE_TABLE(i2c, atpm_idtable);
> 
> static struct i2c_driver atpm_driver =
> {
>     .driver = {
>       .name         = DEVICE_NAME,
>       .owner        = THIS_MODULE,
>     },
>     .probe          = atpm_probe,
>     .remove         = __devexit_p(atpm_remove),
>     .id_table       = atpm_idtable,
>     .detect         = atpm_detect,
>     /* .address_data   = &addr_data */

.detect is ignored without .address_data. From i2c-core.c:

static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver)
{
	const struct i2c_client_address_data *address_data;
	(...)

	address_data = driver->address_data;
	if (!driver->detect || !address_data)
		return 0;

Additionally, you must define atpm_driver.class, otherwise
atpm_driver.detect will never be called.

> };
> 
> static int __init atpm_init(void)
> {
>   printk(DEVICE_NAME ": adding i2c driver\n");
>   return i2c_add_driver(&atpm_driver);
> }
> 
> static void __exit atpm_exit(void)
> {
>   i2c_del_driver(&atpm_driver);
>   printk(DEVICE_NAME ": deleting i2c driver\n");
> }
> 
> module_init(atpm_init);
> module_exit(atpm_exit);
> 
> Any help would be appreciated.

What is this "atpm" device? Can it be reliably detected? In general it
is better to instantiate I2C devices explicitly, for example through
platform data. Why don't you do that?

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
