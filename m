From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Patch v3] i2c: Multiplexed I2C bus core support
Date: Tue, 20 Jul 2010 21:27:29 +0200
Message-ID: <20100720212729.4d81048b@hyperion.delvare>
References: <4C36E6E2.1070307@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C36E6E2.1070307-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Fri, 09 Jul 2010 11:07:46 +0200, Michael Lawnick wrote:
> Add multiplexed bus core support. I2C multiplexer and switches
> like pca954x get instantiated as new adapters per port.
> 
> Signed-off-by: Michael Lawnick <demx1175@wbit01lx.(none)>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> Based on kernel 2.6.35.rc2 +
> [PATCH] i2c: Move adapter locking helpers to i2c-core
> by Jean Delware <20100615140218.07090c90-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
> <http://article.gmane.org/gmane.linux.drivers.i2c/6226/match=i2c+move+adapter+locking+helpers+i2c+core>
> 
>  drivers/i2c/Kconfig         |   11 +++
>  drivers/i2c/Makefile        |    1 +
>  drivers/i2c/i2c-core.c      |   80 +++++++++++++++++----
>  drivers/i2c/i2c-dev.c       |   44 +++++++++++-
>  drivers/i2c/i2c-mux.c       |  165 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c-mux.h     |   46 ++++++++++++
>  include/linux/i2c.h         |    8 ++
>  7 files changed, 341 insertions(+), 14 deletions(-)
>  create mode 100755 drivers/i2c/i2c-mux.c
>  create mode 100755 include/linux/i2c-mux.h

Patch applied, with two changes:
* Reverted changes to i2c_sysfs_new_device(), i2c_sysfs_delete_device()
and i2c_del_adapter() - no longer needed after I added a dedicated
mutex for userspace client lists.
* Removed locking in i2c_check_addr_busy() and i2cdev_check_addr(). It
was insufficient anyway, I'll think of something better and add it
later.

Rodoflo, I've added your Acked-by, I hope this is fine.

Resulting patch can be seen here:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-multiplexing-core-support.patch

Thanks again for your contribution and patience :)

-- 
Jean Delvare
