From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH V5] I2C bus driver for IMX
Date: Fri, 16 May 2008 11:31:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0805161003320.23876@shell4.speakeasy.net>
References: <g0c44d$2ji$1@ger.gmane.org> <20080514213214.GB16881@fluff.org.uk>
	<g0hbge$qm2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <g0hbge$qm2$1@ger.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 15 May 2008, Darius wrote:
> All Ben comments accepted, coding style fixed, checked with checkpatch.pl.
> Only 5 warnings about line over 80 characters.
> Tested on MXLADS V2.0 board with 2.6.26-rc1 kernel.
>

+static int __initdata i2c_imx_clk_divider [50] [2] = {

This should be unsigned.  Maybe u16 to save space?

+	dev_dbg(&i2c_imx->adapter.dev, "<i2c_imx_bus_busy>\n");

You could write dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);

The same with all the other places you have the function name.  Makes it
easier if you rename a function or move code around.  Also lets you do some
sort of macro:
#define dprintk(dev, fmt, args...) dev_dbg(dev, "<%s> " fmt, __func__, ## args)
 or
#define dprintk(fmt, args...) dev_dbg(&i2c_imx->adapter.dev, "<%s> " fmt, __func__, ## args)

A lot people won't like the hidden variable use of the latter, though there
is a lot of code that does this for debug printing.

+	 * This delay caused by [an] i.MXL hardware bug.
+	 * If no (or to short) delay, no "STOP" bit will be generated.

"too short"

+static int __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx, unsigned int rate)
+{
+
+	unsigned int hclk, sysclk;

if CONFIG_I2C_DEBUG_BUS isn't defined, then sysclk won't be used in this
function.  Better to stick the imx_get_system_clk() call inside the
ifdef'ed code.

+	unsigned int desired_div;
+	int i;
+
+	sysclk = imx_get_system_clk();
+	hclk = imx_get_hclk();
+	desired_div = hclk / rate;

You probably want to round up, instead of down, in this calculation.
Like this:

        desired_div = (hclk + rate - 1) / rate;

Rounding downs means you'll get a higher clock than requested, which is
usually worse than a lower clock.

+	if (desired_div & 0x01)
+		desired_div++;

Why is this code necessary?  I see that all the supported dividers are
even, but it makes no difference to your code that finds the actual divider
if desired_div is even or odd.

+	if (desired_div < 22)
+		desired_div = 22;
+	if (desired_div > 3840)
+		desired_div = 3840;
+	for (i = 0; i < ARRAY_SIZE(i2c_imx_clk_divider); i++) {
+		if (i2c_imx_clk_divider[i][0] >= desired_div)
+			break;
+	}

Since you know the lowest and highest dividers are at the ends of the
table, you can avoid duplicating them.

	if (desired_div >
	    i2c_imx_clk_divider[ARRAY_SIZE(i2c_imx_clk_divider)-1][0]) {
		i = ARRAY_SIZE(i2c_imx_clk_divider) - 1;
		...print warning that clock will be too fast...
	} else if (desired_div < i2c_imx_clk_divider[0][0]) {
		/* print warning that clock will be too slow? */
		i = 0;
	} else
		for (i = 0; i2c_imx_clk_divider[i][0] < desired_div; i++) ;

+
+	/*
+	 * There dummy delay is calculated.
+	 * It should be about one I2C clock period long.
+	 * This delay is used in I2C bus disable function
+	 * to fix chip hardware bug.
+	 */
+
+	disable_delay = (1000000 / (hclk / i2c_imx_clk_divider[i][0])) + 1;

This is a more accurate way to calculate one clock period in us.

	disable_delay = (500000U * i2c_imx_clk_divider[i][0] + hclk/2 - 1) /
		        (hclk/2);

+static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
+{
+	struct imx_i2c_struct *i2c_imx = dev_id;
+	unsigned int temp;
+
+	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+	dev_dbg(&i2c_imx->adapter.dev,
+		"<i2c_imx_isr> CONTROL: IEN=%d, IIEN=%d, "
+		"MSTA=%d, MTX=%d, TXAK=%d, RSTA=%d\n",
+		(temp&I2CR_IEN ? 1 : 0), (temp&I2CR_IIEN ? 1 : 0),
+		(temp&I2CR_MSTA ? 1 : 0), (temp&I2CR_MTX ? 1 : 0),
+		(temp&I2CR_TXAK ? 1 : 0), (temp&I2CR_RSTA ? 1 : 0));
+	temp = readb(i2c_imx->base + IMX_I2C_I2SR);
+	dev_dbg(&i2c_imx->adapter.dev,
+		"<i2c_imx_isr> STATUS: ICF=%d, IAAS=%d, IBB=%d, "
+		"IAL=%d, SRW=%d, IIF=%d, RXAK=%d\n",
+		(temp&I2SR_ICF ? 1 : 0), (temp&I2SR_IAAS ? 1 : 0),
+		(temp&I2SR_IBB ? 1 : 0), (temp&I2SR_IAL ? 1 : 0),
+		(temp&I2SR_SRW ? 1 : 0), (temp&I2SR_IIF ? 1 : 0),
+		(temp&I2SR_RXAK ? 1 : 0));

If one doesn't have DEBUG defined, then don't the two above readb()s end up
being pointless?  Or is it necessary to read them even if the result is
never used?

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
