From: bhanuprakash bodireddy <bhanuprakashbodireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Transaction timeout issue with Temperature sensor driver on
 2.6.32 kernel.
Date: Tue, 17 Jul 2012 17:52:57 +0530
Message-ID: <CALPjBuUYJPOwTqZ+9gr2AVYigTD6N4B_2K6Erns+0vSX9biR+A@mail.gmail.com>
References: <CALPjBuW+B2=Y3g9n_Sqe2QOT18XHyJc4t77WGjvsm-0ik+NmAg@mail.gmail.com>
	<20120717131738.7f7aaf80@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120717131738.7f7aaf80-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> Why was this driver not submitted for inclusion into the kernel tree?
> Or was it? Are you sure there is no compatible driver already in the
> tree?

This driver wasn't submitted to the kernel tree. This was written
keeping in mind
to service a user space program which uses ioctl calls.

> You did not just enable them, you added some of your own, or you aren't
> using the original i2c-i801 driver from your kernel version.

True, I may not using the original i2c-i801 as the code is from MontaVista CGE6
and as i see the bus driver code is bit different to what i see on
kernel tree for
same version. That makes the debugging even more difficult for me :(

>> Is this driver issue or the bus problem on my Target board?
>
> It is impossible to tell without seeing the temperature sensor driver
> source code and the bus driver source code. It _looks_ like a bus
> driver issue, but if the same code worked in kernel 2.6.21 there's no
> reason why it would fail in kernel 2.6.32 (unless the hardware changed
> too.)

Below is my driver code.

PECI_ADDR = 0x29;
#define BYTE_CNT_1               0x01
#define PECI_STOP_POLLING             0x00

static struct i2c_device_id peci_idtable[] = {
        { "PECI", 0 },
        { }
};
MODULE_DEVICE_TABLE(i2c, peci_idtable);

struct i2c_driver peci_driver = {
        .driver         =
        {
                .owner      = THIS_MODULE,
                .name       = "PECI",
        },
        .probe          = peci_probe,
        .remove         = peci_remove,
        .id_table       = peci_idtable,
};

xxx_probe()
{
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
        struct i2c_client *pNewClient;
#else
        struct device *dev = &pAdapter->dev;
        struct i2c_adapter *adapter = pAdapter->adapter;
 #endif

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
        if (!i2c_check_functionality(pAdapter,
I2C_FUNC_SMBUS_BYTE|I2C_FUNC_SMBUS_BYTE_DATA))
#else
        if (!i2c_check_functionality(pAdapter->adapter,
I2C_FUNC_SMBUS_BYTE|I2C_FUNC_SMBUS_BYTE_DATA|I2C_FUNC_SMBUS_BLOCK_DATA))
#endif
        {
                printk(KERN_ERR "i2c_check_functionality() fail!\n");
                return -1;
        }
}

xxx_init_conf()
{
        u8                  aVal[I2C_SMBUS_BLOCK_MAX]={0,};

        memset(aVal, 0, I2C_SMBUS_BLOCK_MAX);
        bCnt = BYTE_CNT_1;

        aVal[0] = bCnt;
        aVal[1] = PECI_STOP_POLLING;
        rslt = i2c_smbus_write_block_data(pClient,
PECI_CMD_STOP_POLLING , bCnt+1, aVal);
        if(rslt)
                return -EFAULT;

        rslt = i2c_smbus_read_block_data(pClient, PECI_CMD_STOP_POLLING, NULL);
        if(rslt < 0)
                return -EFAULT;
}

xxx_init()
{
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
        static int bus_id = 0;
        struct i2c_adapter *adapter;
        struct i2c_board_info peci_device;

        memset(&peci_device, 0, sizeof(struct i2c_board_info));
        peci_device.addr = PECI_ADDR;
        strlcpy(peci_device.type, "PECI", I2C_NAME_SIZE);

        adapter = i2c_get_adapter(bus_id);
        if (!adapter) {
                return -ENODEV;
        }

        pClient = i2c_new_device(adapter, &peci_device);
        i2c_put_adapter(adapter);
        if (!pClient) {
                         peci_exit();
        }
#endif

     xxx_init_conf();
}


tree /sys/bus/i2c
/sys/bus/i2c
|-- devices
|   |-- 0-0029 -> ../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0029
|   `-- i2c-0 -> ../../../devices/pci0000:00/0000:00:1f.3/i2c-0
|-- drivers
|   |-- PECI
|   |   |-- 0-0029 -> ../../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0029
|   |   |-- bind
|   |   |-- module -> ../../../../module/peci_ctrl
|   |   |-- uevent
|   |   `-- unbind
|   |-- dev_driver
|   |   |-- bind
|   |   |-- uevent
|   |   `-- unbind
|   `-- dummy
|       |-- bind
|       |-- uevent
|       `-- unbind
|-- drivers_autoprobe
|-- drivers_probe
`-- uevent


> You can try the standalone i2c-i801 driver from:
>   http://khali.linux-fr.org/devel/misc/i2c-i801/
> and see if it helps.

Sure Jean, will try this out and see if it helps  me.

--- Bhanu Prakash
