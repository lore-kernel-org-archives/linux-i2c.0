From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Convert to DEFINE_PCI_DEVICE_TABLE
Date: Mon, 02 Jan 2012 07:44:52 -0800
Message-ID: <4F01D0F4.2070301@gmail.com>
References: <1324956897.9775.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1324956897.9775.2.camel@phoenix>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>, Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 12/26/2011 07:34 PM, Axel Lin wrote:
> Convert static struct pci_device_id *[] to static DEFINE_PCI_DEVICE_TABLE
> tables.
>
> Signed-off-by: Axel Lin<axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Rudolf Marek<r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
> Cc: Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Ben Dooks<ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Cc: Olof Johansson<olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> Cc: "Mark M. Hoffman"<mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
> Cc: Dirk Brandewie<dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Tomoya MORINAGA<tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
> Cc: Wolfram Sang<w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Feng Tang<feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Sebastian Andrzej Siewior<bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
> This patch is against linux-next tree.
> Axel
>
>   drivers/i2c/busses/i2c-ali1563.c           |    2 +-
>   drivers/i2c/busses/i2c-ali15x3.c           |    2 +-
>   drivers/i2c/busses/i2c-amd756.c            |    2 +-
>   drivers/i2c/busses/i2c-amd8111.c           |    2 +-
>   drivers/i2c/busses/i2c-designware-pcidrv.c |    2 +-
>   drivers/i2c/busses/i2c-eg20t.c             |    2 +-
>   drivers/i2c/busses/i2c-hydra.c             |    2 +-
>   drivers/i2c/busses/i2c-i801.c              |    2 +-
>   drivers/i2c/busses/i2c-intel-mid.c         |    2 +-
>   drivers/i2c/busses/i2c-nforce2.c           |    2 +-
>   drivers/i2c/busses/i2c-pasemi.c            |    2 +-
>   drivers/i2c/busses/i2c-piix4.c             |    2 +-
>   drivers/i2c/busses/i2c-pxa-pci.c           |    2 +-
>   drivers/i2c/busses/i2c-sis5595.c           |    2 +-
>   drivers/i2c/busses/i2c-sis630.c            |    2 +-
>   drivers/i2c/busses/i2c-sis96x.c            |    2 +-
>   drivers/i2c/busses/i2c-via.c               |    2 +-
>   drivers/i2c/busses/i2c-viapro.c            |    2 +-
>   drivers/i2c/busses/scx200_acb.c            |    2 +-
>   19 files changed, 19 insertions(+), 19 deletions(-)
>

> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index 9e89e73..37f4211 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -349,7 +349,7 @@ static void __devexit i2c_dw_pci_remove(struct pci_dev *pdev)
>   /* work with hotplug and coldplug */
>   MODULE_ALIAS("i2c_designware-pci");
>
> -DEFINE_PCI_DEVICE_TABLE(i2_designware_pci_ids) = {
> +static DEFINE_PCI_DEVICE_TABLE(i2_designware_pci_ids) = {
>   	/* Moorestown */
>   	{ PCI_VDEVICE(INTEL, 0x0802), moorestown_0 },
>   	{ PCI_VDEVICE(INTEL, 0x0803), moorestown_1 },
Acked-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
