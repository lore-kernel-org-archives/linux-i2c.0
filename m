From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH 2/3] Convert PowerPC MPC i2c to of_platform_driver
	from	platform_driver
Date: Mon, 28 Jan 2008 10:12:06 -0600
Message-ID: <20080128161206.GB19873@lixom.net>
References: <20080128144202.8410.14647.stgit@terra.home>
	<20080128144206.8410.2505.stgit@terra.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080128144206.8410.2505.stgit-+J+k29bDNxlBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Nice to see this one, I've been waiting for it. :)

On Mon, Jan 28, 2008 at 09:42:07AM -0500, Jon Smirl wrote:

> diff --git a/drivers/i2c/busses/powerpc-common.c b/drivers/i2c/busses/powerpc-common.c
> new file mode 100644
> index 0000000..51b039f
> --- /dev/null
> +++ b/drivers/i2c/busses/powerpc-common.c

This is really broader than powerpc. devtree-common.c would be a more
suitable name.

> @@ -0,0 +1,81 @@
> +/*
> + * powerpc-common.c - routines common to device tree parsing for all
> + *                    powerpc based i2c hosts
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + * (C) Copyright 2008 Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/of_platform.h>
> +
> +#include "powerpc-common.h"
> +
> +#ifdef CONFIG_PPC_MERGE
> +
> +void of_register_i2c_devices(struct i2c_adapter *adap, struct device_node *adap_node)
> +{
> +	void *result;
> +	struct device_node *node = NULL;
> +
> +	while ((node = of_get_next_child(adap_node, node))) {
> +		struct i2c_board_info info;
> +		const u32 *addr;
> +		const char *compatible;
> +		int len;
> +
> +		compatible = of_get_property(node, "compatible", NULL);
> +		if (!compatible) {
> +			printk(KERN_ERR "i2c-mpc.c: missing compatible attribute\n");
> +			continue;
> +		}
> +
> +		addr = of_get_property(node, "reg", &len);
> +		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
> +			printk(KERN_ERR "i2c-mpc.c: missing reg attribute for %s\n", compatible);

This is no longer i2c-mpc. Same for the other comments in this function.


-Olof

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
