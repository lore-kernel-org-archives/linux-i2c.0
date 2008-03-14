From: "Andrew Dyer" <amdyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] I2C driver for IMX
Date: Fri, 14 Mar 2008 05:00:46 -0500
Message-ID: <c166aa9f0803140300n75f6790enee3f28bdebeba945@mail.gmail.com>
References: <frbjjv$ndk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <frbjjv$ndk$1@ger.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Thu, Mar 13, 2008 at 11:07 AM, Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Almost written from scratch - only small piece of code leaved from old
>  driver, witch never was originally in vanilla kernel.
>  SMB is NOT supported currently.
>  Tested on the MXLADS v2.0 board with i2c client driver (driver for
>  NT7651 LCD controller). All works fine, stable.

needs a signed-off-by line and --- separator

>
> diff -uprN -X linux-2.6.24.3-vanilla/Documentation/dontdiff linux-2.6.24.3-vanilla/drivers/i2c/busses/i2c-imx.c linux-2.6.24.3/drivers/i2c/busses/i2c-imx.c
>  --- linux-2.6.24.3-vanilla/drivers/i2c/busses/i2c-imx.c 1970-01-01 03:00:00.000000000 +0300
>  +++ linux-2.6.24.3/drivers/i2c/busses/i2c-imx.c 2008-03-13 17:50:52.000000000 +0200
>  +/* These defines are missed in imx-regs.h */
>  +#define IMX_I2C_IADR   (0x00)  /* i2c slave address */
>  +#define IMX_I2C_IFDR           (0x04)  /* i2c frequency divider */
>  +#define IMX_I2C_I2CR           (0x08)  /* i2c control */
>  +#define IMX_I2C_I2SR    (0x0C) /* i2c status */
>  +#define IMX_I2C_I2DR    (0x10) /* i2c transfer data */

why put the defines in here if all the other register defines are in imx-regs.h?

>  +/* bits in IMX_I2C_I2SR register */
>  +#define I2SR_RXAK      0x01
>  +#define I2SR_IIF       0x02
>  +#define I2SR_SRW       0x04
>  +#define I2SR_IAL       0x10
>  +#define I2SR_IBB       0x20
>  +#define I2SR_IAAS      0x40
>  +#define I2SR_ICF       0x80
>  +
>  +/* bits in IMX_I2C_I2CR register */
>  +#define I2CR_RSTA      0x04
>  +#define I2CR_TXAK      0x08
>  +#define I2CR_MTX       0x10
>  +#define I2CR_MSTA      0x20
>  +#define I2CR_IIEN      0x40
>  +#define I2CR_IEN       0x80

ditto above for the bit definitions

>  +static struct i2c_imx_clk_div_pair i2c_imx_clk_div_tbl[64] = { /* FIXME */
...
>  +};

anything with FIXME in comments probably should be addressed :-)

probably don't need the array size specifier

a reference to the datasheet page this table comes from would good
(table 26-5 in the rev. 4 version of the ref. manual)

a note should mention the code depends on the entries being sorted
with the dividers in order

structure can be marked as __init now as it no longer can be
referenced at any time other than startup


>  +    #ifdef CONFIG_I2C_DEBUG_BUS
>  +        printk("I2C: <i2c_imx_bus_busy>\n");
>  +    #endif

dev_debug() would be a lot easier to read than this mess of #ifdefs

>  +static int i2c_imx_set_clk      (struct imx_i2c_struct *i2c_imx, unsigned int rate) {

function only gets called at init time, so add __init

>  +       unsigned int hclk, sysclk;
>  +       unsigned int desired_div;
>  +       int i;
>  +
>  +    #ifdef CONFIG_I2C_DEBUG_BUS
>  +        printk("I2C: <i2c_imx_set_clk>\n");
>  +    #endif
>  +
>  +       sysclk = imx_get_system_clk ();
>  +       hclk = imx_get_hclk();
>  +       desired_div = (hclk << 1) / rate;
>  +    #ifdef CONFIG_I2C_DEBUG_BUS
>  +        printk("I2C: <i2c_imx_set_clk> SYSCLK=%d, HCLK=%d, DIV=%d\n", sysclk, hclk, desired_div);
>  +    #endif

printing desired_div here gives the wrong result - it's 2x what it should be.

>  +       if (desired_div & 0x01)
>  +               desired_div++;
>  +       desired_div >>= 1;

Should be printed here after rounding.

>  +       if (desired_div < 22)
>  +               desired_div = 22;
>  +       if (desired_div > 3840)
>  +               return -EINVAL;
>  +       for (i=0; i<64; i++) {
>  +               if (i2c_imx_clk_div_tbl[i].divider >= desired_div)
>  +                       break;
>  +       }

should get rid of magic constants 64, 22, and 3840 - 64 is # entries
in the table, 22 is smallest divisor and 3840 is largest divisor
allowed by h/w.


>  +static int i2c_imx_xfer         (struct i2c_adapter *adapter, struct i2c_msg *msgs, int num) {
>  +
>  +       int i, temp;
>  +       int err = 0;
>  +       struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
>  +
>  +       #ifdef CONFIG_I2C_DEBUG_BUS
>  +        printk("I2C: <i2c_imx_xfer>\n");
>  +       #endif
>  +
>  +       // chech or i2c bus is not busy

c++ comment and misspelling

>  +       err = i2c_imx_bus_busy(i2c_imx);
>  +       if (err)
>  +               goto fail0;
>  +
>  +    // Enable i2c
>  +    i2c_imx_enable(i2c_imx);
>  +
>  +    /* Start I2C transfer */
>  +    i2c_imx_start (i2c_imx);
>  +
>  +    #ifdef CONFIG_I2C_DEBUG_BUS
>  +        temp = readb (i2c_imx->base + IMX_I2C_I2CR);
>  +        printk("I2C: <i2c_imx_xfer> CONTROL: IEN=%d, IIEN=%d, MSTA=%d, MTX=%d, TXAK=%d, RSTA=%d\n",
>  +            (temp&I2CR_IEN?1:0),(temp&I2CR_IIEN?1:0),(temp&I2CR_MSTA?1:0),(temp&I2CR_MTX?1:0),
>  +            (temp&I2CR_TXAK?1:0),(temp&I2CR_RSTA?1:0));
>  +        temp = readb (i2c_imx->base + IMX_I2C_I2SR);
>  +        printk("I2C: <i2c_imx_xfer> STATUS: ICF=%d, IAAS=%d, IBB=%d, IAL=%d, SRW=%d, IIF=%d, RXAK=%d\n",
>  +            (temp&I2SR_ICF?1:0),(temp&I2SR_IAAS?1:0),(temp&I2SR_IBB?1:0),(temp&I2SR_IAL?1:0),
>  +            (temp&I2SR_SRW?1:0),(temp&I2SR_IIF?1:0),(temp&I2SR_RXAK?1:0));
>  +    #endif
>  +
>  +       // read/write data
>  +       for (i=0; i<num; i++) {
>  +
>  +               if (i) {
>  +            #ifdef CONFIG_I2C_DEBUG_BUS
>  +                printk("I2C: <i2c_imx_read> repeated start\n");
>  +            #endif
>  +            temp = readb(i2c_imx->base + IMX_I2C_I2CR);
>  +            temp |= I2CR_RSTA;
>  +            writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>  +               }
>  +               #ifdef CONFIG_I2C_DEBUG_BUS
>  +            printk("I2C: <i2c_imx_xfer> transfer message: %d\n", i);
>  +        #endif
>  +               /* write/read data */
>  +               if (!(msgs[i].flags & I2C_M_RD))
>  +                       err = i2c_imx_write (i2c_imx, &msgs[i]);
>  +               else
>  +            err = i2c_imx_read  (i2c_imx, &msgs[i]);
>  +       }
>  +
>  +fail0:
>  +       /* Stop bus */
>  +       i2c_imx_stop (i2c_imx);
>  +       /* disable i2c bus */
>  +       i2c_imx_disable (i2c_imx);
>  +    #ifdef CONFIG_I2C_DEBUG_BUS
>  +        printk("I2C: <i2c_imx_xfer> exit with: %s: %d\n", (err < 0)?"error":"succes msg", (err < 0)?err:num);

misspelling - success

>  +    #endif
>  +       return (err < 0) ? err : num;
>  +}
>  +
>  +static u32 i2c_imx_func         (struct i2c_adapter *adapter) {
>  +       return I2C_FUNC_I2C;
>  +}
>  +
>  +static int __init i2c_imx_probe (struct platform_device *pdev) {
>  +
>  +    struct imx_i2c_struct *i2c_imx;
>  +    struct resource *res;
>  +    void   __iomem     *base;
>  +    int irq;
>  +       int res_size;
>  +       int ret;
>  +
>  +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  +       irq = platform_get_irq(pdev, 0);
>  +       if (!res) {
>  +        printk("I2C: can't get device resources!\n");

should probably use dev_err macro for these error messages

>  +        return -ENODEV;
>  +       }
>  +       if (irq < 0) {
>  +        printk("I2C: can't get irq number!\n");
>  +        return -ENODEV;
>  +       }
>  +
>  +       res_size = (res->end) - (res->start) + 1;
>  +       if (!request_mem_region(res->start, res_size, res->name)) {
>  +               printk("I2C: can't allocate %d bytes at %d address!\n", res_size, res->start);
>  +               return -ENOMEM;
>  +       }
>  +
>  +       base = ioremap (res->start, res_size);
>  +       if (!base) {
>  +           printk("I2C: ioremap failed!\n");
>  +               ret = -EIO;
>  +               goto fail0;
>  +       }
>  +
>  +       i2c_imx = kzalloc(sizeof(struct imx_i2c_struct), GFP_KERNEL);
>  +       if (!i2c_imx) {
>  +               printk("I2C: can't allocate inteface!\n");
>  +               ret = -ENOMEM;
>  +               goto fail1;
>  +       }
>  +
>  +    // Setup i2c_imx driver structure

c++ comment

>  +
>  +       printk("I2C: %s: IMX I2C adapter registered\n", i2c_imx->adapter.dev.bus_id);
>  +       return 0;   // Return OK */

mixed c++ and normal comment?

>  --- linux-2.6.24.3-vanilla/drivers/i2c/busses/Kconfig   2008-01-25 00:58:37.000000000 +0200
>  +++ linux-2.6.24.3/drivers/i2c/busses/Kconfig   2008-03-13 17:29:43.000000000 +0200
>  @@ -249,6 +249,16 @@ config I2C_IBM_IIC
>           This driver can also be built as a module.  If so, the module
>           will be called i2c-ibm_iic.
>
>  +config I2C_IMX
>  +       tristate "IMX I2C interface"
>  +       depends on ARCH_IMX
>  +       help
>  +         Say Y here if you want to use the IIC bus controller on
>  +         the Freescale IMX processors.

it's i.MX - I think this will only work with i.MX1, i.MXL, and i.MXS.
I think the i.MX21, 21S, 27, and 31 are a bit different.

-- 
Hardware, n.:
 The parts of a computer system that can be kicked.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
