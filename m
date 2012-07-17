From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Transaction timeout issue with Temperature sensor driver on
 2.6.32 kernel.
Date: Tue, 17 Jul 2012 13:17:38 +0200
Message-ID: <20120717131738.7f7aaf80@endymion.delvare>
References: <CALPjBuW+B2=Y3g9n_Sqe2QOT18XHyJc4t77WGjvsm-0ik+NmAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CALPjBuW+B2=Y3g9n_Sqe2QOT18XHyJc4t77WGjvsm-0ik+NmAg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bhanuprakash bodireddy <bhanuprakashbodireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 17 Jul 2012 14:20:49 +0530, bhanuprakash bodireddy wrote:
> I am porting an old INTEL temperature sensor module (written for
> 2.6.21)  to kernel version (2.6.32).
> The sensor is probed and accessed via I2C. Changed the code in-line
> with the latest I2C framework
> which uses new device driver binding model to make it work with new kernel.
> 
> But I see Transaction timeout errors on inserting the module. My module invokes
> 'i2c_smbus_write_block_data/i2c_smbus_read_block_data' to clear/set
> temperature format and
> that's when i see the below errors get triggered.
> 
> > insmod temp_sensor.ko

Why was this driver not submitted for inclusion into the kernel tree?
Or was it? Are you sure there is no compatible driver already in the
tree?

> [  211.804338] XXXX(temperature sensor) driver init start..
> [  211.815119] devfn: fb, vendor: 8086, device: 269b
> [  211.854127] temp_probe[bus details]: name: SMBus I801 adapter at
> 3000, id:0x0, algo: 0xffffffff81469fe0)
> [  211.884109] i801_smbus 0000:00:1f.3: start call for
> ffff88015b155400 ffff88015f94a580 at 4294879180
> [  211.895031] i801_smbus 0000:00:1f.3: Poll call for ffff88015b155400
> ffff88015f94a580 at 4294879191
> [  211.905023] i801_smbus 0000:00:1f.3: Poll call for ffff88015b155400
> ffff88015f94a580 at 4294879200
> [  211.915024] i801_smbus 0000:00:1f.3: Poll call for ffff88015b155400
> ffff88015f94a580 at 4294879211
> [  211.924016] i801_smbus 0000:00:1f.3: Poll call for ffff88015b155400
> ffff88015f94a580 at 4294879220
> [  211.933021] i801_smbus 0000:00:1f.3: Poll call for ffff88015b155400
> ffff88015f94a580 at 4294879229
> [  211.942018] i801_smbus 0000:00:1f.3: Poll call for ffff88015b155400
> ffff88015f94a580 at 4294879238
>                                                    .
>                                                    .
> [  211.951019] i801_smbus 0000:00:1f.3: Poll call for ffff88015b155400
> ffff88015f94a580 at 4294879247
> [  211.960018] i801_smbus 0000:00:1f.3: Poll call for ffff88015b155400
> ffff88015f94a580 at 4294879256
> [  211.969020] i801_smbus 0000:00:1f.3: Poll call for ffff88015b155400
> ffff88015f94a580 at 4294879265
> [  212.787881] i801_smbus 0000:00:1f.3: Transaction timeout
> [  212.793163] i801_smbus 0000:00:1f.3: Terminating the current operation
> [  212.800016] i801_smbus 0000:00:1f.3: Poll call for ffff88015b155400
> ffff88015f94a580 at 4294880096
> [  212.808880] i801_smbus 0000:00:1f.3: Failed terminating the transaction
> [  212.816016] i801_smbus 0000:00:1f.3: Poll call for ffff88015b155400
> ffff88015f94a580 at 4294880112
> [  212.824872] XXXX_CMD_STOP_POLLING smbus read fail(-110)!!
> 
> (enabled the debug messages in i2c-i801.c)

You did not just enable them, you added some of your own, or you aren't
using the original i2c-i801 driver from your kernel version.

> Is this driver issue or the bus problem on my Target board?

It is impossible to tell without seeing the temperature sensor driver
source code and the bus driver source code. It _looks_ like a bus
driver issue, but if the same code worked in kernel 2.6.21 there's no
reason why it would fail in kernel 2.6.32 (unless the hardware changed
too.)

You can try the standalone i2c-i801 driver from:
  http://khali.linux-fr.org/devel/misc/i2c-i801/
and see if it helps.

-- 
Jean Delvare
