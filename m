From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Transaction timeout issue with Temperature sensor driver on
 2.6.32 kernel.
Date: Wed, 18 Jul 2012 09:24:49 +0200
Message-ID: <20120718092449.305baddb@endymion.delvare>
References: <CALPjBuW+B2=Y3g9n_Sqe2QOT18XHyJc4t77WGjvsm-0ik+NmAg@mail.gmail.com>
	<20120717131738.7f7aaf80@endymion.delvare>
	<CALPjBuUYJPOwTqZ+9gr2AVYigTD6N4B_2K6Erns+0vSX9biR+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CALPjBuUYJPOwTqZ+9gr2AVYigTD6N4B_2K6Erns+0vSX9biR+A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bhanuprakash bodireddy <bhanuprakashbodireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 17 Jul 2012 17:52:57 +0530, bhanuprakash bodireddy wrote:
> > Why was this driver not submitted for inclusion into the kernel tree?
> > Or was it? Are you sure there is no compatible driver already in the
> > tree?
> 
> This driver wasn't submitted to the kernel tree. This was written
> keeping in mind
> to service a user space program which uses ioctl calls.

Oh well, if the driver doesn't implement the standard hwmon interface
then indeed there's no point in submitting it, it won't be accepted.
OTOH I am curious why the driver doesn't stick to a well established,
widely supported interface.

> > You did not just enable them, you added some of your own, or you aren't
> > using the original i2c-i801 driver from your kernel version.  
> 
> True, I may not using the original i2c-i801 as the code is from MontaVista CGE6
> and as i see the bus driver code is bit different to what i see on
> kernel tree for
> same version. That makes the debugging even more difficult for me :(

If the code is from MontaVista, ask them for help, not us. Maybe they
know of the issue and/or have an updated driver to offer.

> > (...)
> > It is impossible to tell without seeing the temperature sensor driver
> > source code and the bus driver source code. It _looks_ like a bus
> > driver issue, but if the same code worked in kernel 2.6.21 there's no
> > reason why it would fail in kernel 2.6.32 (unless the hardware changed
> > too.)
> 
> Below is my driver code.
> 
> PECI_ADDR = 0x29;
> #define BYTE_CNT_1               0x01
> #define PECI_STOP_POLLING             0x00
> 
> static struct i2c_device_id peci_idtable[] = {
>         { "PECI", 0 },
>         { }
> };
> MODULE_DEVICE_TABLE(i2c, peci_idtable);
> 
> struct i2c_driver peci_driver = {
>         .driver         =
>         {
>                 .owner      = THIS_MODULE,
>                 .name       = "PECI",
>         },
>         .probe          = peci_probe,
>         .remove         = peci_remove,
>         .id_table       = peci_idtable,
> };
> 
> xxx_probe()
> {
> #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
>         struct i2c_client *pNewClient;
> #else
>         struct device *dev = &pAdapter->dev;
>         struct i2c_adapter *adapter = pAdapter->adapter;
>  #endif
> 
> #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
>         if (!i2c_check_functionality(pAdapter,
> I2C_FUNC_SMBUS_BYTE|I2C_FUNC_SMBUS_BYTE_DATA))
> #else
>         if (!i2c_check_functionality(pAdapter->adapter,
> I2C_FUNC_SMBUS_BYTE|I2C_FUNC_SMBUS_BYTE_DATA|I2C_FUNC_SMBUS_BLOCK_DATA))
> #endif
>         {
>                 printk(KERN_ERR "i2c_check_functionality() fail!\n");
>                 return -1;
>         }
> }
> 
> xxx_init_conf()
> {
>         u8                  aVal[I2C_SMBUS_BLOCK_MAX]={0,};
> 
>         memset(aVal, 0, I2C_SMBUS_BLOCK_MAX);
>         bCnt = BYTE_CNT_1;
> 
>         aVal[0] = bCnt;
>         aVal[1] = PECI_STOP_POLLING;
>         rslt = i2c_smbus_write_block_data(pClient,
> PECI_CMD_STOP_POLLING , bCnt+1, aVal);
>         if(rslt)
>                 return -EFAULT;
> 
>         rslt = i2c_smbus_read_block_data(pClient, PECI_CMD_STOP_POLLING, NULL);
>         if(rslt < 0)
>                 return -EFAULT;
> }
> 
> xxx_init()
> {
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
>         static int bus_id = 0;
>         struct i2c_adapter *adapter;
>         struct i2c_board_info peci_device;
> 
>         memset(&peci_device, 0, sizeof(struct i2c_board_info));
>         peci_device.addr = PECI_ADDR;
>         strlcpy(peci_device.type, "PECI", I2C_NAME_SIZE);
> 
>         adapter = i2c_get_adapter(bus_id);
>         if (!adapter) {
>                 return -ENODEV;
>         }
> 
>         pClient = i2c_new_device(adapter, &peci_device);
>         i2c_put_adapter(adapter);
>         if (!pClient) {
>                          peci_exit();
>         }
> #endif
> 
>      xxx_init_conf();
> }

The code is horrible and obfuscated, I can't help much without seeing
the real thing, unmodified. One important point though is that a large
part of the code appears to depend on the kernel version being < or >=
to 2.6.30. As you switched from kernel version 2.6.21 to kernel version
2.6.32, you are actually no longer using the same code as before. Maybe
there's a bug in the part of the code which runs on kernels >= 2.6.30.

-- 
Jean Delvare
