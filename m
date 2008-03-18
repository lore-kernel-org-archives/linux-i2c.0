From: "Andrew Dyer" <amdyer@gmail.com>
Subject: Re: [PATCH V2] I2C driver for IMX
Date: Tue, 18 Mar 2008 13:03:30 -0500
Message-ID: <c166aa9f0803181103k1986b5c1teedc63eb36f6a56a@mail.gmail.com>
References: <fre0op$akp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <fre0op$akp$1@ger.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Darius <augulis.darius@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 14, 2008 at 9:04 AM, Darius <augulis.darius@gmail.com> wrote:

> diff -uprN -X linux-2.6.24.3-vanilla/Documentation/dontdiff linux-2.6.24.3-vanilla/drivers/i2c/busses/i2c-imx.c linux-2.6.24.3/drivers/i2c/busses/i2c-imx.c
>  --- linux-2.6.24.3-vanilla/drivers/i2c/busses/i2c-imx.c 1970-01-01 03:00:00.000000000 +0300
>  +++ linux-2.6.24.3/drivers/i2c/busses/i2c-imx.c 2008-03-14 15:44:47.000000000 +0200

+/* Macros */
+#define print_err(f,x...)      printk(KERN_ERR f, ##x)
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define print_dbg(f,x...)      printk(KERN_DEBUG f, ##x)
+#else
+#define print_dbg(f,x...)      ((void)0)
+#endif

why not use standard kernel macros dev_err() and dev_dbg()?

...stuff deleted...

>  +static int i2c_imx_bus_busy (struct imx_i2c_struct *i2c_imx) {
>  +
>  +       unsigned int i = 0;
>  +
>  +       print_dbg("I2C: <i2c_imx_bus_busy>\n");
>  +
>  +       /* wait for bus not busy */
>  +       for (i=0; i<I2C_IMX_TIME_BUSY; i++) {
>  +               if (!(readb(i2c_imx->base + IMX_I2C_I2SR) & (I2SR_IBB | I2SR_IAL)))
>  +                       return 0;
>  +               udelay(1);
>  +       }
>  +       print_dbg("I2C: <i2c_imx_bus_busy> I2C bus is busy!\n");
>  +       return -I2C_IMX_ERR_BUSY;
>  +}

This function is a little problematic - for the case where there is
I2C traffic but are no other bus masters, it usually takes a few
cycles before the bus comes ready, so for throughput you don't want to
go back through the scheduler, but it's probably not a good idea to
busy-wait on a multi-master bus where some other i2c transaction might
take a long time.  Maybe this could be modified to a two-stage scheme,
where the first wait could use udelay() for a few cycles, and then
switch to msleep()

Also I2C_IMX_TIME_* are not really times, they're loop counts - poor
naming on my part :-(

>  +
>  +static int i2c_imx_trx_complete (struct imx_i2c_struct *i2c_imx) {
>  +
>  +       int result;
>  +
>  +       print_dbg("I2C: <i2c_imx_trx_complete>\n");
>  +       result = wait_event_interruptible_timeout(i2c_imx->queue,
>  +               (i2c_imx->i2csr & I2SR_IIF), 5 * HZ);

hardcoded 5 sec. constant here

>  +
>  +       if (unlikely(result < 0)) {
>  +               print_dbg("I2C: <i2c_imx_trx_complete> result < 0!\n");
>  +               return result;
>  +       }
>  +       else if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
>  +               print_dbg("I2C: <i2c_imx_trx_complete> Timeout!\n");
>  +               return -I2C_IMX_ERR_TX_TIMEOUT;
>  +       }
>  +       print_dbg("I2C: <i2c_imx_trx_complete> TRX complete!\n");
>  +       i2c_imx->i2csr = 0;
>  +       return 0;
>  +}

...stuff deleted...

>  +static void i2c_imx_enable (struct imx_i2c_struct *i2c_imx) {
>  +
>  +       print_dbg("I2C: <i2c_imx_enable>\n");
>  +       writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>  +}
>  +
>  +static void i2c_imx_disable (struct imx_i2c_struct *i2c_imx) {
>  +
>  +       print_dbg("I2C: <i2c_imx_disable>\n");
>  +
>  +       /* setup chip registers to defaults */
>  +       writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>  +       writeb(0, i2c_imx->base + IMX_I2C_I2SR);
>  +}

this looks wrong - you're setting the enable bit in the disable function

>  +
>  +static void i2c_imx_start (struct imx_i2c_struct *i2c_imx) {
>  +
>  +       unsigned int temp = 0;
>  +
>  +       print_dbg("I2C: <i2c_imx_start>\n");
>  +       temp = readb ( i2c_imx->base + IMX_I2C_I2CR);
>  +       temp |= I2CR_MSTA;
>  +       writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>  +       temp |= (I2CR_IIEN | I2CR_MTX | I2CR_TXAK);
>  +       writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>  +
>  +       temp = readb (i2c_imx->base + IMX_I2C_I2CR);
>  +       print_dbg("I2C: <i2c_imx_start> CONTROL: IEN=%d, IIEN=%d, MSTA=%d, MTX=%d, TXAK=%d, RSTA=%d\n",
>  +               (temp&I2CR_IEN?1:0),(temp&I2CR_IIEN?1:0),(temp&I2CR_MSTA?1:0),(temp&I2CR_MTX?1:0),
>  +               (temp&I2CR_TXAK?1:0),(temp&I2CR_RSTA?1:0));
>  +       temp = readb (i2c_imx->base + IMX_I2C_I2SR);
>  +       print_dbg("I2C: <i2c_imx_start> STATUS: ICF=%d, IAAS=%d, IBB=%d, IAL=%d, SRW=%d, IIF=%d, RXAK=%d\n",
>  +               (temp&I2SR_ICF?1:0),(temp&I2SR_IAAS?1:0),(temp&I2SR_IBB?1:0),(temp&I2SR_IAL?1:0),
>  +               (temp&I2SR_SRW?1:0),(temp&I2SR_IIF?1:0),(temp&I2SR_RXAK?1:0));

I would wrap these register debug statements in macros since they
appear a few more times, and add a space after commas or some newlines
to make this a bit easier to parse.

>  +}
>  +
>  +static void i2c_imx_stop (struct imx_i2c_struct *i2c_imx) {
>  +
>  +       unsigned int temp = 0;
>  +
>  +       print_dbg("I2C: <i2c_imx_stop>\n");
>  +       temp = readb ( i2c_imx->base + IMX_I2C_I2CR);
>  +       temp &= ~I2CR_MSTA;
>  +       writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>  +       temp = readb (i2c_imx->base + IMX_I2C_I2CR);
>  +       print_dbg("I2C: <i2c_imx_stop> CONTROL: IEN=%d, IIEN=%d, MSTA=%d, MTX=%d, TXAK=%d, RSTA=%d\n",
>  +               (temp&I2CR_IEN?1:0),(temp&I2CR_IIEN?1:0),(temp&I2CR_MSTA?1:0),(temp&I2CR_MTX?1:0),
>  +               (temp&I2CR_TXAK?1:0),(temp&I2CR_RSTA?1:0));
>  +       temp = readb (i2c_imx->base + IMX_I2C_I2SR);
>  +       print_dbg("I2C: <i2c_imx_stop> STATUS: ICF=%d, IAAS=%d, IBB=%d, IAL=%d, SRW=%d, IIF=%d, RXAK=%d\n",
>  +               (temp&I2SR_ICF?1:0),(temp&I2SR_IAAS?1:0),(temp&I2SR_IBB?1:0),(temp&I2SR_IAL?1:0),
>  +               (temp&I2SR_SRW?1:0),(temp&I2SR_IIF?1:0),(temp&I2SR_RXAK?1:0));
>  +}
>  +
>  +static int __init i2c_imx_set_clk (struct imx_i2c_struct *i2c_imx, unsigned int rate) {
>  +
>  +       unsigned int hclk, sysclk;
>  +       unsigned int desired_div;
>  +       int i;
>  +
>  +       print_dbg("I2C: <i2c_imx_set_clk>\n");
>  +       sysclk = imx_get_system_clk ();
>  +       hclk = imx_get_hclk();
>  +       desired_div = hclk / rate;
>  +       if (desired_div & 0x01)
>  +               desired_div++;
>  +       if (desired_div < 22)
>  +               desired_div = 22;
>  +       if (desired_div > 3840)
>  +               desired_div = 3840;

still have the magic constant numbers in here...

>  +       for (i=0; i<50; i++) {
>  +               if (i2c_imx_clk_divider[i][0] >= desired_div)
>  +                       break;



-- 
Hardware, n.:
 The parts of a computer system that can be kicked.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
