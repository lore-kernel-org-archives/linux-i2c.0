From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] MAINTAINERS: remove me as maintainer for I2C host drivers
Date: Tue, 10 Apr 2018 17:40:52 +0200
Message-ID: <68529743-2df6-f07f-b3db-720e09b765c3@axentia.se>
References: <20180410141125.4477-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180410141125.4477-1-wsa@the-dreams.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
List-Id: linux-i2c@vger.kernel.org

On 2018-04-10 16:11, Wolfram Sang wrote:
> The number of I2C host controller drivers keeps increasing, and although
> I had some success acquiring specific driver maintainers, my bandwidth
> is by far not enough to act as a fallback for the rest of the drivers.
> To reflect this status-quo in MAINTAINERS, add a seperate entry for I2C
> host drivers, let the I2C list (= community) be the contact point, and
> mark this section as "Odd fixes".
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> 
> Joe: my tests worked fine with the file patterns; yet I'd appreciate if you
> had time to double check them. Thanks!
> 
>  MAINTAINERS | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6d296bdce328..2f7ccdcf76f7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6580,15 +6580,23 @@ W:	https://i2c.wiki.kernel.org/
>  Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/i2c/
> +F:	Documentation/devicetree/bindings/i2c/i2c.txt
>  F:	Documentation/i2c/
> -F:	drivers/i2c/
> -F:	drivers/i2c/*/
> +F:	drivers/i2c/*
>  F:	include/linux/i2c.h
>  F:	include/linux/i2c-*.h
>  F:	include/uapi/linux/i2c.h
>  F:	include/uapi/linux/i2c-*.h

Hmm, I think you are ducking out from the i2c-mux-pinctrl driver as well.
Was that the intent?

> +I2C SUBSYSTEM DRIVERS
> +L:	linux-i2c@vger.kernel.org
> +W:	https://i2c.wiki.kernel.org/
> +Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
> +S:	Odd Fixes
> +F:	Documentation/devicetree/bindings/i2c/
> +F:	drivers/i2c/*/
> +

And this includes all the other muxes, i.e. those that are "mine". Maybe
not a problem, but what do I know?

Cheers,
Peter

>  I2C-TAOS-EVM DRIVER
>  M:	Jean Delvare <jdelvare@suse.com>
>  L:	linux-i2c@vger.kernel.org
> 
