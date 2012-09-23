From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: busses: i2c-ocores: Fix documentation filename
Date: Sun, 23 Sep 2012 10:36:46 -0500
Message-ID: <505F2C8E.9080607@gmail.com>
References: <20120923133012.GA22830@linux-3ix0.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120923133012.GA22830-ks9ITDofB9nuAK1a81qwxQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Maxin B. John" <maxin.john-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, "Jean Delvare (PC drivers,core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09/23/2012 08:30 AM, Maxin B. John wrote:
> Fixes the wrong filename.
> 
> Signed-off-by: Maxin B. John <maxin.john-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

Acked-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>

> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index bffd550..e39c122 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -11,7 +11,7 @@
>  
>  /*
>   * This driver can be used from the device tree, see
> - *     Documentation/devicetree/bindings/i2c/ocore-i2c.txt
> + *     Documentation/devicetree/bindings/i2c/i2c-ocores.txt
>   */
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> 
