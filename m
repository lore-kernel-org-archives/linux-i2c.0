From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 04/16] i2c: eg20t: remove unnecessary OOM messages
Date: Wed, 7 May 2014 09:20:29 +0200
Message-ID: <20140507092029.0b4293a2@endymion.delvare>
References: <018301cf69aa$cb7987d0$626c9770$%han@samsung.com>
	<018801cf69ab$70a79a30$51f6ce90$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <018801cf69ab$70a79a30$51f6ce90$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Tomoya MORINAGA' <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 07 May 2014 13:18:46 +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message.
> 
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-eg20t.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
> index ff775ac..a44ea13 100644
> --- a/drivers/i2c/busses/i2c-eg20t.c
> +++ b/drivers/i2c/busses/i2c-eg20t.c
> @@ -751,10 +751,8 @@ static int pch_i2c_probe(struct pci_dev *pdev,
>  	pch_pci_dbg(pdev, "Entered.\n");
>  
>  	adap_info = kzalloc((sizeof(struct adapter_info)), GFP_KERNEL);
> -	if (adap_info == NULL) {
> -		pch_pci_err(pdev, "Memory allocation FAILED\n");
> +	if (adap_info == NULL)
>  		return -ENOMEM;
> -	}
>  
>  	ret = pci_enable_device(pdev);
>  	if (ret) {

Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>

-- 
Jean Delvare
SUSE L3 Support
