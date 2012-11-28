From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 14/16] i2c-ali1563: remove __dev* attributes
Date: Wed, 28 Nov 2012 13:31:53 +0100
Message-ID: <20121128133153.700e84a8@endymion.delvare>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
	<1354049993-12718-15-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-15-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Bill,

On Tue, 27 Nov 2012 15:59:51 -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option.  As result the __dev*
> markings will be going away.
> 
> Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
> and __devexit.
> 
> Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
> Cc: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-ali1563.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
> index e02d9f8..5b17c9f 100644
> --- a/drivers/i2c/busses/i2c-ali1563.c
> +++ b/drivers/i2c/busses/i2c-ali1563.c
> @@ -326,7 +326,7 @@ static u32 ali1563_func(struct i2c_adapter * a)
>  }
>  
>  
> -static int __devinit ali1563_setup(struct pci_dev * dev)
> +static int ali1563_setup(struct pci_dev * dev)

While you're here, it would be great if you could fix the checkpatch
errors on the lines you touch:

ERROR: "foo * bar" should be "foo *bar"
#91: FILE: drivers/i2c/busses/i2c-ali1563.c:329:
+static int ali1563_setup(struct pci_dev * dev)

and same twice below. Thanks.

>  {
>  	u16 ctrl;
>  
> @@ -390,7 +390,7 @@ static struct i2c_adapter ali1563_adapter = {
>  	.algo	= &ali1563_algorithm,
>  };
>  
> -static int __devinit ali1563_probe(struct pci_dev * dev,
> +static int ali1563_probe(struct pci_dev * dev,
>  				const struct pci_device_id * id_table)
>  {
>  	int error;
> @@ -411,7 +411,7 @@ exit:
>  	return error;
>  }
>  
> -static void __devexit ali1563_remove(struct pci_dev * dev)
> +static void ali1563_remove(struct pci_dev * dev)
>  {
>  	i2c_del_adapter(&ali1563_adapter);
>  	ali1563_shutdown(dev);
> @@ -428,7 +428,7 @@ static struct pci_driver ali1563_pci_driver = {
>   	.name		= "ali1563_smbus",
>  	.id_table	= ali1563_id_table,
>   	.probe		= ali1563_probe,
> -	.remove		= __devexit_p(ali1563_remove),
> +	.remove		= ali1563_remove,
>  };
>  
>  module_pci_driver(ali1563_pci_driver);


-- 
Jean Delvare
