From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-piix4: Add support for AMD ML and CZ SMBus
 changes
Date: Thu, 23 Jan 2014 13:27:40 +0100
Message-ID: <20140123132740.122c0f8a@endymion.delvare>
References: <1390428346-2235-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390428346-2235-1-git-send-email-shane.huang-5C7GfCeVMHo@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carl Peng <carl.peng-5C7GfCeVMHo@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Shane, hi Wolfram,

On Wed, 22 Jan 2014 14:05:46 -0800, Shane Huang wrote:
> The locations of SMBus register base address and enablement bit are changed
> from AMD ML, which need this patch to be supported.
> 
> Signed-off-by: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
> ---
>  Documentation/i2c/busses/i2c-piix4 |    2 +-
>  drivers/i2c/busses/Kconfig         |    1 +
>  drivers/i2c/busses/i2c-piix4.c     |   28 +++++++++++++++++++++++-----
>  3 files changed, 25 insertions(+), 6 deletions(-)

Overall it looks good.

Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Wolfram, I think this is a candidate for stable kernel branches. It
should apply fine down to 3.12.

Shane, I still have one additional question:

> (...)
> @@ -258,13 +267,22 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
>  	smba_en_hi = inb_p(smba_idx + 1);
>  	release_region(smba_idx, 2);
>  
> -	if ((smba_en_lo & 1) == 0) {
> +	if (!smb_en) {
> +		smb_en_status = smba_en_lo & 0x10;
> +		piix4_smba = smba_en_hi << 8;
> +		if (aux)
> +			piix4_smba |= 0x20;
> +	} (...)

As the mask used for smb_en_status doesn't depend on the value of
"aux", this implies that on the Hudson-2, a single bit controls if both
SMBus controllers are enabled. It's not possible to enable one and
disable the other. Is it correct, or is it an overlook?

BTW it would be really great if we could have access to the
documentation for these new AMD chipsets. I looked for both Hudson and
FCH at http://developer.amd.com/ but these searches returned nothing. I
could help better if I had access to the documentation / datasheets.

-- 
Jean Delvare
