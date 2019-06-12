From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v2] i2c: i2c-stm32f7: fix the get_irq error cases
Date: Wed, 12 Jun 2019 14:29:58 +0200
Message-ID: <6fe9c4cc-d7ed-aad8-b8f8-240a4888aaa8@st.com>
References: <1558020594-1498-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1558020594-1498-1-git-send-email-fabrice.gasnier@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wsa@the-dreams.de, pierre-yves.mordret@st.com
Cc: alexandre.torgue@st.com, marc.w.gonzalez@free.fr, linux-kernel@vger.kernel.org, fabien.dessenne@st.com, linux-i2c@vger.kernel.org, mcoquelin.stm32@gmail.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 5/16/19 5:29 PM, Fabrice Gasnier wrote:
> During probe, return the "get_irq" error value instead of -EINVAL which
> allows the driver to be deferred probed if needed.
> Fix also the case where of_irq_get() returns a negative value.
> Note :
> On failure of_irq_get() returns 0 or a negative value while
> platform_get_irq() returns a negative value.
> 
> Fixes: aeb068c57214 ("i2c: i2c-stm32f7: add driver")
> 
> Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - Also check for irq == 0 that means "does not exist" as pointed out by
>   Marc

Hi Wolfram, all,

Gentle ping on this patch

Best Regards,
Fabrice

> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index 4284fc9..d7d7dd7 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -25,7 +25,6 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pinctrl/consumer.h>
> @@ -1812,15 +1811,14 @@ static struct i2c_algorithm stm32f7_i2c_algo = {
>  
>  static int stm32f7_i2c_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np = pdev->dev.of_node;
>  	struct stm32f7_i2c_dev *i2c_dev;
>  	const struct stm32f7_i2c_setup *setup;
>  	struct resource *res;
> -	u32 irq_error, irq_event, clk_rate, rise_time, fall_time;
> +	u32 clk_rate, rise_time, fall_time;
>  	struct i2c_adapter *adap;
>  	struct reset_control *rst;
>  	dma_addr_t phy_addr;
> -	int ret;
> +	int irq_error, irq_event, ret;
>  
>  	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
>  	if (!i2c_dev)
> @@ -1832,16 +1830,20 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>  		return PTR_ERR(i2c_dev->base);
>  	phy_addr = (dma_addr_t)res->start;
>  
> -	irq_event = irq_of_parse_and_map(np, 0);
> -	if (!irq_event) {
> -		dev_err(&pdev->dev, "IRQ event missing or invalid\n");
> -		return -EINVAL;
> +	irq_event = platform_get_irq(pdev, 0);
> +	if (irq_event <= 0) {
> +		if (irq_event != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to get IRQ event: %d\n",
> +				irq_event);
> +		return irq_event ? irq_event : -ENODEV;
>  	}
>  
> -	irq_error = irq_of_parse_and_map(np, 1);
> -	if (!irq_error) {
> -		dev_err(&pdev->dev, "IRQ error missing or invalid\n");
> -		return -EINVAL;
> +	irq_error = platform_get_irq(pdev, 1);
> +	if (irq_error <= 0) {
> +		if (irq_error != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to get IRQ error: %d\n",
> +				irq_error);
> +		return irq_error ? irq_error : -ENODEV;
>  	}
>  
>  	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
> 
