From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [RFC PATCH 3/3] i2c: mv64xxx: Document the newly introduced
 Armada XP A0 compatible
Date: Wed, 1 Jan 2014 16:45:52 -0500
Message-ID: <20140101214552.GB19878@titan.lakedaemon.net>
References: <1388508293-9141-1-git-send-email-gregory.clement@free-electrons.com>
 <1388508293-9141-4-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388508293-9141-4-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

[+ DT ml, Grant, Rob]

On Tue, Dec 31, 2013 at 05:44:53PM +0100, Gregory CLEMENT wrote:
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> index 82e8f6f17179..9410ed72ec45 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -5,7 +5,7 @@ Required properties :
>  
>   - reg             : Offset and length of the register set for the device
>   - compatible      : Should be "marvell,mv64xxx-i2c" or "allwinner,sun4i-i2c"
> -                     or "marvell,mv78230-i2c"
> +                     or "marvell,mv78230-i2c" or "marvell,mv78230-a0-i2c"

Once we nail down how we want to do this, Please add an explanation of
the differences between the compatibles.  eg 'offloading broken'.

thx,

Jason.

>   - interrupts      : The interrupt number
>  
>  Optional properties :
> -- 
> 1.8.1.2
> 
