From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 09/15] drivers/mfd: Enable Device Tree support for the
 db8500-prcmu
Date: Wed, 9 May 2012 16:30:51 +0200
Message-ID: <20120509143051.GG1794@sortiz-mobl>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-10-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336155805-18554-10-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Lee,

On Fri, May 04, 2012 at 07:23:19PM +0100, Lee Jones wrote:
> This patch will enable probing to occur during a Device Tree enabled
> boot. The IRQ base is expected to be located in and will be fetched
> from the DT itself. We also prevent any of the db8500 regulators
> from being registered here, as they will be enabled via DT instead.
> 
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/mfd/db8500-prcmu.c |   29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
