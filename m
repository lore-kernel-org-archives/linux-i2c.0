From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 01/11] drivers/i2c/busses/i2c-nforce2.c: Remove
 unnecessary casts of pci_get_drvdata
Date: Mon, 15 Nov 2010 22:06:55 +0100
Message-ID: <20101115220655.3c2600f6@endymion.delvare>
References: <cover.1289851770.git.joe@perches.com>
	<8202cea15da761f594353ae6906e1414b1f1f152.1289851770.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8202cea15da761f594353ae6906e1414b1f1f152.1289851770.git.joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 15 Nov 2010 12:13:52 -0800, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-nforce2.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
> index a605a50..ff1e127 100644
> --- a/drivers/i2c/busses/i2c-nforce2.c
> +++ b/drivers/i2c/busses/i2c-nforce2.c
> @@ -432,7 +432,7 @@ static int __devinit nforce2_probe(struct pci_dev *dev, const struct pci_device_
>  
>  static void __devexit nforce2_remove(struct pci_dev *dev)
>  {
> -	struct nforce2_smbus *smbuses = (void*) pci_get_drvdata(dev);
> +	struct nforce2_smbus *smbuses = pci_get_drvdata(dev);
>  
>  	nforce2_set_reference(NULL);
>  	if (smbuses[0].base) {

Applied, thanks.

-- 
Jean Delvare
