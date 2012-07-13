From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 4/4] i2c: i2c-ocores: support for 16bit and 32bit IO
Date: Fri, 13 Jul 2012 19:18:35 +0530
Message-ID: <CAM=Q2csMBP7YHgmMob0Npaxo70Quo3-76TNhQawE972zfiLiHA@mail.gmail.com>
References: <1342187065-1651-1-git-send-email-jayachandranc@netlogicmicro.com>
	<1342187065-1651-5-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1342187065-1651-5-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Jul 13, 2012 at 7:14 PM, Jayachandran C
<jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org> wrote:
> From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>
> Some architectures supports only 16-bit or 32-bit read/write access to
> their IO space. Add a 'reg-io-width' platform and OF parameter which
> specifies the IO width to support these platforms.
>
> reg-io-width can be specified as 1, 2 or 4, and has a default value
> of 1 if it is unspecified.
>
> Signed-off-by: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
> ---
>  .../devicetree/bindings/i2c/i2c-ocores.txt         |    2 ++
>  drivers/i2c/busses/i2c-ocores.c                    |   21 ++++++++++++++++++--
>  include/linux/i2c-ocores.h                         |    1 +
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> index 1c9334b..c15781f 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> @@ -10,6 +10,7 @@ Required properties:
>
>  Optional properties:
>  - reg-shift       : device register offsets are shifted by this value
> +- reg-io-width    : io register width in bytes (1, 2 or 4)
>  - regstep         : deprecated, use reg-shift above
>
>  Example:
> @@ -23,6 +24,7 @@ Example:
>                 clock-frequency = <20000000>;
>
>                 reg-shift = <0>;        /* 8 bit registers */
> +               reg-io-width = <1>;     /* 8 bit read/write */
>
>                 dummy@60 {
>                         compatible = "dummy";
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index 721ead9..de3b119 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -30,6 +30,7 @@
>  struct ocores_i2c {
>         void __iomem *base;
>         u32 reg_shift;
> +       u32 reg_io_width;
>         wait_queue_head_t wait;
>         struct i2c_adapter adap;
>         struct i2c_msg *msg;
> @@ -72,12 +73,22 @@ struct ocores_i2c {
>
>  static inline void oc_setreg(struct ocores_i2c *i2c, int reg, u8 value)
>  {
> -       iowrite8(value, i2c->base + (reg << i2c->reg_shift));
> +       if (i2c->reg_io_width == 4)
> +               iowrite32(value, i2c->base + (reg << i2c->reg_shift));
> +       else if (i2c->reg_io_width == 2)
> +               iowrite16(value, i2c->base + (reg << i2c->reg_shift));
> +       else
> +               iowrite8(value, i2c->base + (reg << i2c->reg_shift));
>  }
>
>  static inline u8 oc_getreg(struct ocores_i2c *i2c, int reg)

Should the return type be changed.
Now that it is returning more that than 8 bits.

Did I miss something?

>  {
> -       return ioread8(i2c->base + (reg << i2c->reg_shift));
> +       if (i2c->reg_io_width == 4)
> +               return ioread32(i2c->base + (reg << i2c->reg_shift));
> +       else if (i2c->reg_io_width == 2)
> +               return ioread16(i2c->base + (reg << i2c->reg_shift));
> +       else
> +               return ioread8(i2c->base + (reg << i2c->reg_shift));
>  }
>
