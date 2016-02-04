From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] Adding Intel Lewisburg support for iTCO
Date: Fri, 5 Feb 2016 01:07:57 +0200
Message-ID: <CAHp75VeuLzpqPm-vDeeMHJ1HgcBFVQknM7qpy3o10-nHjr5RsA@mail.gmail.com>
References: <1454625447-27563-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454625447-27563-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: jdelvare@suse.com, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 5, 2016 at 12:37 AM, Alexandra Yates
<alexandra.yates@linux.intel.com> wrote:
> Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog
> resources have been moved to reside under the i801 SMBus host
> controller whereas previously they were under the LPC device.
>
> This patch adds Intel lewisburg SMBus support for iTCO device.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index f62d697..27fa0cb 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1271,6 +1271,8 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>         switch (dev->device) {
>         case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS:
>         case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS:
> +       case PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS:
> +       case PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS:
>         case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
>                 priv->features |= FEATURE_I2C_BLOCK_READ;
>                 priv->features |= FEATURE_IRQ;
> --
> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
