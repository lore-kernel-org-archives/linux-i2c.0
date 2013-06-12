From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv4 3/9] ARM: orion: pass the i2c registers
 definition through the platform data
Date: Wed, 12 Jun 2013 10:39:34 +0200
Message-ID: <8677826.XZJHdNSNK7@flatron>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com> <1371024438-16631-4-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCCYVXM26EFRBSPH4CGQKGQE6JJHVYA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1371024438-16631-4-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post?hl=en-GB>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-GB>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi?hl=en-GB>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Maxime,

On Wednesday 12 of June 2013 10:07:12 Maxime Ripard wrote:
> Convert the existing platform data users of the MV64XXX i2c driver to
> pass the registers offset structure along with the platform data.

I'm not really convinced that platform data is the right way to pass such 
data.

IMHO driver/match data were supposed to contain variant-specific 
parameters, which the driver would receive based on matching platform 
device name (in non-DT case) or compatible string (in DT case).

Best regards,
Tomasz

> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm/plat-orion/common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
> index c019b7a..c166fc9 100644
> --- a/arch/arm/plat-orion/common.c
> +++ b/arch/arm/plat-orion/common.c
> @@ -509,6 +509,7 @@ void __init orion_ge00_switch_init(struct
> dsa_platform_data *d, int irq)
> ***********************************************************************
> *****/ static struct mv64xxx_i2c_pdata orion_i2c_pdata = {
>  	.freq_n		= 3,
> +	.regs		= &mv64xxx_i2c_regs_mv64xxx,
>  	.timeout	= 1000, /* Default timeout of 1 second */
>  };
> 
> @@ -524,6 +525,7 @@ static struct platform_device orion_i2c = {
> 
>  static struct mv64xxx_i2c_pdata orion_i2c_1_pdata = {
>  	.freq_n		= 3,
> +	.regs		= &mv64xxx_i2c_regs_mv64xxx,
>  	.timeout	= 1000, /* Default timeout of 1 second */
>  };
