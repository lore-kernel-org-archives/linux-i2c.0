From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v7 3/6] i2c: designware: MASTER mode as separated driver
Date: Wed, 22 Mar 2017 16:38:42 +0200
Message-ID: <92bee7a2-4320-cff7-ef18-9770d6fe12fe@linux.intel.com>
References: <cover.1490007620.git.lolivei@synopsys.com>
 <c224fa537fc1daf9f3256ce7c8da12f73f7035a7.1490007620.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c224fa537fc1daf9f3256ce7c8da12f73f7035a7.1490007620.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 03/20/17 13:10, Luis Oliveira wrote:
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
> v6-v7
> - Moved kernel doc comments from patch 4/6 to this patch. @Jarkko
> - Fix Designware I2C PCI driver error when looking for previous extern
>   functions.
>
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-designware-common.c         | 274 +++++++++++++++
>  drivers/i2c/busses/i2c-designware-core.h           | 146 +++++++-
>  ...c-designware-core.c => i2c-designware-master.c} | 367 +--------------------
>  drivers/i2c/busses/i2c-designware-pcidrv.c         |   8 +-
>  drivers/i2c/busses/i2c-designware-platdrv.c        |   6 +-
>  6 files changed, 433 insertions(+), 369 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-designware-common.c
>  rename drivers/i2c/busses/{i2c-designware-core.c => i2c-designware-master.c} (64%)
>
Acked-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
