From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH V2 05/13] clk: bcm2835: Add BCM2711_CLOCK_EMMC2 support
Date: Fri, 13 Sep 2019 03:20:24 +0200
Message-ID: <097c31de-4b11-92a8-af22-c34d6317359c@gmx.net>
References: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
 <1565713248-4906-6-git-send-email-wahrenst@gmx.net>
 <d89bbc4b-b6bc-0d4e-86d1-6be11876ce00@gmail.com> <87o8zp1h4u.fsf@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87o8zp1h4u.fsf@anholt.net>
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
To: Eric Anholt <eric@anholt.net>, Matthias Brugger <matthias.bgg@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Am 12.09.19 um 20:52 schrieb Eric Anholt:
> Matthias Brugger <matthias.bgg@gmail.com> writes:
>
>> On 13/08/2019 18:20, Stefan Wahren wrote:
>>> The new BCM2711 supports an additional clock for the emmc2 block.
>>> So add a new compatible and register this clock only for BCM2711.
>>>
>>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>>> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
>>> Acked-by: Eric Anholt <eric@anholt.net>
>>> ---
>>>  drivers/clk/bcm/clk-bcm2835.c | 20 +++++++++++++++++++-
>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
>>> index 21cd952..fdf672a 100644
>>> --- a/drivers/clk/bcm/clk-bcm2835.c
>>> +++ b/drivers/clk/bcm/clk-bcm2835.c
>>> @@ -114,6 +114,8 @@
>>>  #define CM_AVEODIV		0x1bc
>>>  #define CM_EMMCCTL		0x1c0
>>>  #define CM_EMMCDIV		0x1c4
>>> +#define CM_EMMC2CTL		0x1d0
>>> +#define CM_EMMC2DIV		0x1d4
>>>
>>>  /* General bits for the CM_*CTL regs */
>>>  # define CM_ENABLE			BIT(4)
>>> @@ -290,7 +292,8 @@
>>>  #define BCM2835_MAX_FB_RATE	1750000000u
>>>
>>>  #define SOC_BCM2835		BIT(0)
>>> -#define SOC_ALL			(SOC_BCM2835)
>>> +#define SOC_BCM2711		BIT(1)
>>> +#define SOC_ALL			(SOC_BCM2835 | SOC_BCM2711)
>>>
>>>  /*
>>>   * Names of clocks used within the driver that need to be replaced
>>> @@ -2003,6 +2006,16 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>>>  		.frac_bits = 8,
>>>  		.tcnt_mux = 39),
>>>
>>> +	/* EMMC2 clock (only available for BCM2711) */
>>> +	[BCM2711_CLOCK_EMMC2]	= REGISTER_PER_CLK(
>>> +		SOC_BCM2711,
>>> +		.name = "emmc2",
>>> +		.ctl_reg = CM_EMMC2CTL,
>>> +		.div_reg = CM_EMMC2DIV,
>>> +		.int_bits = 4,
>>> +		.frac_bits = 8,
>>> +		.tcnt_mux = 42),
>>> +
>>>  	/* General purpose (GPIO) clocks */
>>>  	[BCM2835_CLOCK_GP0]	= REGISTER_PER_CLK(
>>>  		SOC_ALL,
>>> @@ -2238,8 +2251,13 @@ static const struct cprman_plat_data cprman_bcm2835_plat_data = {
>>>  	.soc = SOC_BCM2835,
>>>  };
>>>
>>> +static const struct cprman_plat_data cprman_bcm2711_plat_data = {
>>> +	.soc = SOC_BCM2711,
>>> +};
>>> +
>>>  static const struct of_device_id bcm2835_clk_of_match[] = {
>>>  	{ .compatible = "brcm,bcm2835-cprman", .data = &cprman_bcm2835_plat_data },
>>> +	{ .compatible = "brcm,bcm2711-cprman", .data = &cprman_bcm2711_plat_data },
>> Because the RPi4 FW uses bcm2838-cprman as compatible, we will need to add this
>> here as well.
> Upstream has not committed to backwards compat with Pi's firmware.  That
> makes the ABI requirement we get held to for upstream's DT absurd, but
> that's the state of things.

We also learned from past, that's not possible to keep things downstream
compatible. As soon as a binding is not accepted, this wont work
anymore. A lot of the downstream stuff is hacky.

For example yesterday, i learned that the thermal node is broken
(register is part of ring oscillator block). So do we really want to be
compatible with a hack? I would say: No
