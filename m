From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [RESEND PATCH v3 2/2] i2c: change id to let i2c-at91 work
Date: Tue, 16 Oct 2012 00:13:38 -0700
Message-ID: <20121016071338.GE5172@kroah.com>
References: <1350364668-21280-1-git-send-email-voice.shen@atmel.com>
 <1350364668-21280-2-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1350364668-21280-2-git-send-email-voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 16, 2012 at 01:17:48PM +0800, Bo Shen wrote:
> From: voice <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> 
> The i2c core driver will turn the platform device ID to busnum
> When using platfrom device ID as -1, it means dynamically assigned
> the busnum. When writing code, we need to make sure the busnum,
> and call i2c_register_board_info(int busnum, ...) to register device
> if using -1, we do not know the value of busnum
> 
> In order to solve this issue, set the platform device ID as a fix number
> Here using 0 to match the busnum used in i2c_regsiter_board_info()
> 
> Signed-off-by: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
> Resend
>   Cc linux kernel stable mailing list
> ---
>  arch/arm/mach-at91/at91rm9200.c          |    2 +-
>  arch/arm/mach-at91/at91rm9200_devices.c  |    2 +-
>  arch/arm/mach-at91/at91sam9260.c         |    4 ++--
>  arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
>  arch/arm/mach-at91/at91sam9261.c         |    4 ++--
>  arch/arm/mach-at91/at91sam9261_devices.c |    2 +-
>  arch/arm/mach-at91/at91sam9263.c         |    2 +-
>  arch/arm/mach-at91/at91sam9263_devices.c |    2 +-
>  arch/arm/mach-at91/at91sam9rl_devices.c  |    2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
