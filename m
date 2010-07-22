From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [Patch v3] i2c: Multiplexed I2C bus core support
Date: Thu, 22 Jul 2010 08:42:43 +0200
Message-ID: <20100722064243.GB9753@enneenne.com>
References: <4C36E6E2.1070307@gmx.de>
 <20100720212729.4d81048b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100720212729.4d81048b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 20, 2010 at 09:27:29PM +0200, Jean Delvare wrote:
> Hi Michael,
> 
> Patch applied, with two changes:
> * Reverted changes to i2c_sysfs_new_device(), i2c_sysfs_delete_device()
> and i2c_del_adapter() - no longer needed after I added a dedicated
> mutex for userspace client lists.
> * Removed locking in i2c_check_addr_busy() and i2cdev_check_addr(). It
> was insufficient anyway, I'll think of something better and add it
> later.

Great! :)

> Rodoflo, I've added your Acked-by, I hope this is fine.

It's ok for me.

> Resulting patch can be seen here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-multiplexing-core-support.patch
> 
> Thanks again for your contribution and patience :)

Michael, maybe you wish updating the linux-i2c wiki page regarding
this issue?

   https://i2c.wiki.kernel.org/index.php/I2C_bus_multiplexing

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
