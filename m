From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: i801: Do not add ICH_RES_IO_SMI if PMC device is
 not present
Date: Tue, 25 Feb 2020 06:21:16 -0800
Message-ID: <2dec872e-26fb-eefc-5606-cfb1bf55d02e@roeck-us.net>
References: <20200225123802.88984-1-mika.westerberg@linux.intel.com>
 <20200225123802.88984-4-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200225123802.88984-4-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Martin Volf <martin.volf.42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2/25/20 4:38 AM, Mika Westerberg wrote:
> Martin noticed that nct6775 driver does not load properly on his system
> in v5.4+ kernels. The issue was bisected to commit b84398d6d7f9 ("i2c:
> i801: Use iTCO version 6 in Cannon Lake PCH and beyond") but it is
> likely not the culprit because the faulty code has been in the driver
> already since commit 9424693035a5 ("i2c: i801: Create iTCO device on
> newer Intel PCHs"). So more likely some commit that added PCI IDs of
> recent chipsets made the driver to create the iTCO_wdt device on Martins
> system.
> 
> The issue was debugged to be PCI configuration access to the PMC device
> that is not present. This returns all 1's when read and this caused the
> iTCO_wdt driver to accidentally request resourses used by nct6775.
> 
> Fix this by checking that the PMC device is there and only then populate
> the iTCO_wdt ICH_RES_IO_SMI resource. Since the resource is now optional
> the iTCO_wdt driver should continue to work on recent systems without it.
> 
> Link: https://lore.kernel.org/linux-hwmon/CAM1AHpQ4196tyD=HhBu-2donSsuogabkfP03v1YF26Q7_BgvgA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/
> Fixes: 9424693035a5 ("i2c: i801: Create iTCO device on newer Intel PCHs")
> Reported-by: Martin Volf <martin.volf.42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-i801.c | 45 +++++++++++++++++++++--------------
>   1 file changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index ca4f096fef74..7fa58375bd4b 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1519,7 +1519,7 @@ static DEFINE_SPINLOCK(p2sb_spinlock);
>   
>   static struct platform_device *
>   i801_add_tco_spt(struct i801_priv *priv, struct pci_dev *pci_dev,
> -		 struct resource *tco_res)
> +		 struct resource *tco_res, size_t nres)
>   {
>   	struct resource *res;
>   	unsigned int devfn;
> @@ -1563,7 +1563,7 @@ i801_add_tco_spt(struct i801_priv *priv, struct pci_dev *pci_dev,
>   	res->flags = IORESOURCE_MEM;
>   
>   	return platform_device_register_resndata(&pci_dev->dev, "iTCO_wdt", -1,
> -					tco_res, 3, &spt_tco_platform_data,
> +					tco_res, nres + 1, &spt_tco_platform_data,

Does this work as intended ? It still adds ICH_RES_MEM_OFF at index 2,
but if there is no SMI resource it will only pass two sets of resources
to the wdt driver, one of which (the SMI resource) would be empty,
ie have start == NULL and size == 0.

Guenter
