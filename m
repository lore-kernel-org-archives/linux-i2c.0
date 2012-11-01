From: Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v3 3/5] i2c: i2c-mpc: make I2C bus speed configurable
Date: Thu, 1 Nov 2012 19:19:56 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B708169179@039-SN2MPN1-023.039d.mgd.msft.net>
References: <20090407082052.477328750@denx.de>
	<20090407082231.500525932@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090407082231.500525932-ynQEQJNshbs@public.gmane.org>
Content-Language: en-US
Content-ID: <50FA6A8705C7564CA61CFB7BB2912590-725oAoX4OcF2GV6JINhBVAC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfgang,

I know it's been 3 1/2 years since you wrote this code, but I think I
found a bug.

On Tue, Apr 7, 2009 at 3:20 AM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wrote:
> This patch makes the I2C bus speed configurable by using the I2C node
> property "clock-frequency". If the property is not defined, the old
> fixed clock settings will be used for backward comptibility.
>
> The generic I2C clock properties, especially the CPU-specific source
> clock pre-scaler are defined via the OF match table:
>
>   static const struct of_device_id mpc_i2c_of_match[] = {
>         ...
>         {.compatible = "fsl,mpc8543-i2c",
>          .data = &(struct fsl_i2c_match_data) {
>                         .setclock = mpc_i2c_setclock_8xxx,
>                         .prescaler = 2,
>                 },
>         },
>
> The "data" field defines the relevant I2C setclock function and the
> relevant pre-scaler for the I2C source clock frequency.
>
> It uses arch-specific tables and functions to determine resonable
> Freqency Divider Register (fdr) values for MPC83xx, MPC85xx, MPC86xx,
> MPC5200 and MPC5200B.
>
> The i2c->flags field and the corresponding FSL_I2C_DEV_* definitions
> have been removed as they are obsolete.
>
> Signed-off-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>

...

> +u32 mpc_i2c_get_sec_cfg_8xxx(void)
> +{
> +       struct device_node *node = NULL;
> +       u32 __iomem *reg;
> +       u32 val = 0;
> +
> +       node = of_find_node_by_name(NULL, "global-utilities");
> +       if (node) {
> +               const u32 *prop = of_get_property(node, "reg", NULL);
> +               if (prop) {
> +                       /*
> +                        * Map and check POR Device Status Register 2
> +                        * (PORDEVSR2) at 0xE0014
> +                        */
> +                       reg = ioremap(get_immrbase() + *prop + 0x14, 0x4);
> +                       if (!reg)
> +                               printk(KERN_ERR
> +                                      "Error: couldn't map PORDEVSR2\n");
> +                       else
> +                               val = in_be32(reg) & 0x00000080; /* sec-cfg */

I'm looking at the MPC8544 reference manual, and PORDEVSR2[SEC_CFG] is
in position 26, which means that this line should be "& 0x20", not "&
0x80".

Can you check this for me and let me know if I'm right?

> +                       iounmap(reg);
> +               }
> +       }
> +       if (node)
> +               of_node_put(node);
> +
> +       return val;
> +}

-- 
Timur Tabi
Linux kernel developer at Freescale
