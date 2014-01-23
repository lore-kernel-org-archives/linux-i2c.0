From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-piix4: Use different message for AMD Auxiliary
 SMBus Controller
Date: Thu, 23 Jan 2014 13:43:38 +0100
Message-ID: <20140123134338.0ea83d94@endymion.delvare>
References: <1390428412-2269-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390428412-2269-1-git-send-email-shane.huang-5C7GfCeVMHo@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carl Peng <carl.peng-5C7GfCeVMHo@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 22 Jan 2014 14:06:52 -0800, Shane Huang wrote:
> Same messages for AMD main and auxiliary SMBus controllers lead to confusion,
> this patch is to remove confusion and keep consistent with non-AMD products.
> 
> Signed-off-by: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-piix4.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index f71b4d3..d82b8ab 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -295,7 +295,8 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
>  	/* Aux SMBus does not support IRQ information */
>  	if (aux) {
>  		dev_info(&PIIX4_dev->dev,
> -			 "SMBus Host Controller at 0x%x\n", piix4_smba);
> +			 "Auxiliary SMBus Host Controller at 0x%x\n",
> +			 piix4_smba);
>  		return piix4_smba;
>  	}
>  

I like it very much, as it makes all these messages consistent across
devices. And this allows string re-use for a small gain in size.

Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Wolfram, please apply.

-- 
Jean Delvare
