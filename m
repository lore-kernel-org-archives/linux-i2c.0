From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 4/6] ARM: at91/dt: sama5d3: add i2c gpio pinctrl
Date: Sat, 4 Jan 2020 22:39:48 +0000
Message-ID: <e22772f8-9e6d-002d-98d7-414136a32439@axentia.se>
References: <20200103094821.13185-1-codrin.ciubotariu@microchip.com>
 <20200103094821.13185-5-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20200103094821.13185-5-codrin.ciubotariu@microchip.com>
Content-Language: en-US
Content-ID: <FF949416C25CEE4A9F9A12B8347FB46E@eurprd02.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Codrin.Ciubotariu@microchip.com" <Codrin.Ciubotariu@microchip.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "kamel.bouhara@bootlin.com" <kamel.bouhara@bootlin.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>
List-Id: linux-i2c@vger.kernel.org

On 2020-01-03 10:49, Codrin.Ciubotariu@microchip.com wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add the i2c gpio pinctrls to support the i2c bus recovery
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
> 
> Changes in v2:
>  - none;
> 
>  arch/arm/boot/dts/sama5d3.dtsi | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 

*snip*

> @@ -639,6 +648,12 @@
>  							<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA30 periph A TWD0 pin, conflicts with URXD1, ISI_VSYNC */
>  							 AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA31 periph A TWCK0 pin, conflicts with UTXD1, ISI_HSYNC */
>  					};
> +
> +					pinctrl_i2c0_gpio: i2c0-gpio {
> +						atmel,pins =
> +							<AT91_PIOA 30 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP
> +							 AT91_PIOA 31 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
> +					};

I'm curious, but why are pull-ups suddenly needed just because the pins are
used for GPIO recovery? Why are pull-ups not needed when the pins are used
by the I2C peripheral device(s)?

Given figure 27-2 "I/O Line Control Logic" in my SAMA5D3 datasheet, I see
no difference as to how and why the pull-ups are applied depending on what
the current function of the pin is. So, if the I2C bus works w/o pulls, bus
recovery using GPIO must also work w/o pulls.

I.e. the device tree requires you to have external pull-ups on the I2C bus
anyway, so why bother with internal pull-ups for the recovery case?

Changing pull-up settings just for recovery feels like something that will
inevitably create hard to debug surprises at the least opportune time...

Or am I missing something?

(I'm focusing on SAMA5D3 since that is what I happen to work with,
 but the same question appears to apply for SAMA5D2 and SAMA5D4...)

Cheers,
Peter
