From: Warner Losh <imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/8] ARM: at91: do not configure at91sam9g10 twi pio as
 open-drain
Date: Wed, 5 Sep 2012 22:57:36 -0600
Message-ID: <62436338-28EC-4781-ABD0-9B237BAFA6AE@bsdimp.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
 <1346404884-18451-5-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1346404884-18451-5-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.orgludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Aug 31, 2012, at 3:21 AM, <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:

> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> 
> As indicated in the datasheet, TWD and TWCK must not be programmed as
> open-drain.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
> arch/arm/mach-at91/at91sam9261_devices.c | 18 ++++++++++--------
> 1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
> index c94495d..405f603 100644
> --- a/arch/arm/mach-at91/at91sam9261_devices.c
> +++ b/arch/arm/mach-at91/at91sam9261_devices.c
> @@ -324,20 +324,22 @@ static struct platform_device at91sam9261_twi_device = {
> 
> void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
> {
> -	/* IP version is not the same on 9261 and g10 */
> +	/*
> +	 * IP version is not the same on 9261 and g10 and only 9261 one
> +	 * requires to configure PIO as open-drain.

"The IP version is not the same on the 9261 and g10.  Only the 9261
 requires PIO configured as open-drain."

would be a better way to say this.

> +	 */
> 	if (cpu_is_at91sam9g10()) {
> 		at91sam9261_twi_device.name = "at91sam9g10_i2c";
> +		at91_set_A_periph(AT91_PIN_PA7, 0);		/* TWD */
> +		at91_set_A_periph(AT91_PIN_PA8, 0);		/* TWCK */
> 	} else {
> 		at91sam9261_twi_device.name = "at91sam9261_i2c";
> +		at91_set_A_periph(AT91_PIN_PA7, 0);		/* TWD */
> +		at91_set_multi_drive(AT91_PIN_PA7, 1);
> +		at91_set_A_periph(AT91_PIN_PA8, 0);		/* TWCK */
> +		at91_set_multi_drive(AT91_PIN_PA8, 1);
> 	}
> 
> -	/* pins used for TWI interface */
> -	at91_set_A_periph(AT91_PIN_PA7, 0);		/* TWD */
> -	at91_set_multi_drive(AT91_PIN_PA7, 1);
> -
> -	at91_set_A_periph(AT91_PIN_PA8, 0);		/* TWCK */
> -	at91_set_multi_drive(AT91_PIN_PA8, 1);
> -

You could just move the two multi-drive lines up into the 9261 branch of the above if.  That would make it clearer that it is a workaround just for the 9261.

> 	i2c_register_board_info(0, devices, nr_devices);
> 	platform_device_register(&at91sam9261_twi_device);
> }
> -- 
> 1.7.11.3
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
