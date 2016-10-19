From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 4/4] i2c: digicolor: Fix module autoload
Date: Wed, 19 Oct 2016 08:05:28 +0300
Message-ID: <20161019050528.ahtibbag7n6gksic@tarshish>
References: <1476824508-4679-1-git-send-email-javier@osg.samsung.com>
 <1476824508-4679-5-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:52023 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbcJSFFf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 19 Oct 2016 01:05:35 -0400
Content-Disposition: inline
In-Reply-To: <1476824508-4679-5-git-send-email-javier@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org

Hi Javier Martinez Canillas,

On Tue, Oct 18, 2016 at 06:01:48PM -0300, Javier Martinez Canillas wrote:
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> Before this patch:
> 
> $ modinfo drivers/i2c/busses/i2c-digicolor.ko | grep alias
> $
> 
> After this patch:
> 
> $ modinfo drivers/i2c/busses/i2c-digicolor.ko | grep alias
> alias:          of:N*T*Ccnxt,cx92755-i2cC*
> alias:          of:N*T*Ccnxt,cx92755-i2c
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

>  drivers/i2c/busses/i2c-digicolor.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-digicolor.c b/drivers/i2c/busses/i2c-digicolor.c
> index 9604024e0eb0..49f2084f7bb5 100644
> --- a/drivers/i2c/busses/i2c-digicolor.c
> +++ b/drivers/i2c/busses/i2c-digicolor.c
> @@ -368,6 +368,7 @@ static const struct of_device_id dc_i2c_match[] = {
>  	{ .compatible = "cnxt,cx92755-i2c" },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, dc_i2c_match);
>  
>  static struct platform_driver dc_i2c_driver = {
>  	.probe   = dc_i2c_probe,

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
