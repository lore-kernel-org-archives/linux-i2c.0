From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC V2 00/12] i2c: describe adapter quirks in a generic way
Date: Thu, 05 Mar 2015 15:27:05 +0200
Message-ID: <1425562025.5705.24.camel@mm-sol.com>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424880126-15047-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Wed, 2015-02-25 at 17:01 +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> 
> Here is the second version of the patch series to describe i2c adapter quirks
> in a generic way. For the motivation, please read description of patch 1. This
> is still RFC because I would like to do some more tests on my own, but I need
> to write a tool for that. However, I'd really like to have the driver authors
> to have a look already. Actual testing is very much appreciated. Thanks to the
> Mediatek guys for rebasing their new driver to this framework. That helps, too!
> 
> The branch is also here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirks
> 
> Thanks,
> 
>    Wolfram
> 
> Major changes since V1:
> 
> * more fine-grained options to describe modes with combined messages.
>   This should also cover the Mediatek HW now as well as all other
>   permutations I can think of.
> 
> * the core code and at91 driver had to be refactored to reflect the
>   above change
> 
> * added the bcm-iproc driver which came to mainline recently
> 
> Wolfram Sang (12):
>   i2c: add quirk structure to describe adapter flaws
>   i2c: add quirk checks to core
>   i2c: at91: make use of the new infrastructure for quirks
>   i2c: opal: make use of the new infrastructure for quirks
>   i2c: qup: make use of the new infrastructure for quirks
> 

For QUP driver. 

Reviewed-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Tested-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>

Thanks,
Ivan
