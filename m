From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v8 3/6] i2c: designware: MASTER mode as separated driver
Date: Thu, 20 Apr 2017 15:49:01 +0300
Message-ID: <3963c4b3-0ca7-8a97-825c-09dde3472554@linux.intel.com>
References: <cover.1492014220.git.lolivei@synopsys.com>
 <f4ffddb9cb8206d299700d9de89b11246757e8c0.1492014220.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f4ffddb9cb8206d299700d9de89b11246757e8c0.1492014220.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 04/12/2017 07:47 PM, Luis Oliveira wrote:
> - The functions related to I2C master mode of operation were transformed
>   in a single driver.
> - Common definitions were moved to i2c-designware-core.h
> - The i2c-designware-core is now only a library file, the functions
>   associated are in a source file called i2c-designware-common and
>   are used by both i2c-designware-master and i2c-designware-slave.
> - To decrease noise in namespace common i2c_dw_*() functions are
>   now using ops to keep them private.
> - Designware PCI driver had to be changed to match the previous ops
>   functions implementation.
>
> Almost all of the "core" source is now part of the "master" source. The
> difference is the functions used by both modes and they are in the
> "common" source file.
>
> Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> Acked-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> v7-v8
> - removed "@dynamic_tar_update_enabled" comment
>
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-designware-common.c         | 274 +++++++++++++++
>  drivers/i2c/busses/i2c-designware-core.h           | 145 +++++++-
>  ...c-designware-core.c => i2c-designware-master.c} | 367 +--------------------
>  drivers/i2c/busses/i2c-designware-pcidrv.c         |   8 +-
>  drivers/i2c/busses/i2c-designware-platdrv.c        |   6 +-
>  6 files changed, 432 insertions(+), 369 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-designware-common.c
>  rename drivers/i2c/busses/{i2c-designware-core.c => i2c-designware-master.c} (65%)
>
Acked-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
