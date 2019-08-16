From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH V2 06/13] clk: bcm2835: Mark PLLD_PER as CRITICAL
Date: Fri, 16 Aug 2019 10:39:33 -0700
Message-ID: <20190816173934.60509205F4@mail.kernel.org>
References: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
 <1565713248-4906-7-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565713248-4906-7-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Scott Branden <sbranden@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Quoting Stefan Wahren (2019-08-13 09:20:41)
> The VPU firmware assume that the PLLD_PER isn't modified by the ARM core.
> Otherwise this could cause firmware lookups. So mark the clock as critical
> to avoid this.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/clk/bcm/clk-bcm2835.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index fdf672a..b62052e 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -1785,7 +1785,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>                 .load_mask = CM_PLLD_LOADPER,
>                 .hold_mask = CM_PLLD_HOLDPER,
>                 .fixed_divider = 1,
> -               .flags = CLK_SET_RATE_PARENT),
> +               .flags = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),

Please add a comment in the code to the effect that is in the commit
text so we don't have to dig through commits to figure out why this
special CLK_IS_CRITICAL flag is here.

>         [BCM2835_PLLD_DSI0]     = REGISTER_PLL_DIV(
>                 SOC_ALL,
>                 .name = "plld_dsi0",
