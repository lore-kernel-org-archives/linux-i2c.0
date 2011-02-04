From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 02/10] i2c-designware: split of i2c-designware.c into core
 and bus specific parts
Date: Fri, 04 Feb 2011 13:23:09 +0900
Message-ID: <4D4B7F2D.1090303@renesas.com>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com>
 <1296699608-13227-3-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1296699608-13227-3-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2/3/2011 11:20 AM, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>  drivers/i2c/busses/Kconfig                  |   15 +-
>  drivers/i2c/busses/Makefile                 |    5 +-
>  drivers/i2c/busses/i2c-designware-core.c    |  563 +++++++++++++++++
>  drivers/i2c/busses/i2c-designware-core.h    |  194 ++++++
>  drivers/i2c/busses/i2c-designware-pcidrv.c  |  199 ++++++
>  drivers/i2c/busses/i2c-designware-platdrv.c |  199 ++++++
>  drivers/i2c/busses/i2c-designware.c         |  884 ---------------------------
>  7 files changed, 1171 insertions(+), 888 deletions(-)

Git rename detection (git config diff.renames true) would be helpful.

> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -33,7 +33,10 @@ obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
>  obj-$(CONFIG_I2C_BLACKFIN_TWI)	+= i2c-bfin-twi.o
>  obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
>  obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
> -obj-$(CONFIG_I2C_DESIGNWARE)	+= i2c-designware.o
> +obj-$(CONFIG_I2C_DESIGNWARE_PLATFORM)	+= i2c-designware-platform.o
> +i2c-designware-platform-objs := i2c-designware-platdrv.o i2c-designware-core.o
> +obj-$(CONFIG_I2C_DESIGNWARE_PCI)	+= i2c-designware-pci.o
> +i2c-designware-pci-objs := i2c-designware-pcidrv.o i2c-designware-core.o
>  obj-$(CONFIG_I2C_GPIO)		+= i2c-gpio.o
>  obj-$(CONFIG_I2C_HIGHLANDER)	+= i2c-highlander.o
>  obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o

Much better than previous ones, I'm ok with this.

> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> new file mode 100644
> index 0000000..a0d1ea3
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-designware-core.c

> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
> new file mode 100644
> index 0000000..4e37031
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-designware-core.h

> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> new file mode 100644
> index 0000000..9d10ae8
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c

> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> new file mode 100644
> index 0000000..9d10ae8
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c

> diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
> deleted file mode 100644
> index cd03f5e..0000000
> --- a/drivers/i2c/busses/i2c-designware.c
> +++ /dev/null

Will take git diff with rename detection, and check diffs later.
-- 
Shinya Kuribayashi
Renesas Electronics
