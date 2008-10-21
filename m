From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] pci: use pci_ioremap_bar() in drivers/i2c
Date: Tue, 21 Oct 2008 10:49:00 +0200
Message-ID: <20081021104900.5e338301@hyperion.delvare>
References: <20081020215751.17cdfe46@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081020215751.17cdfe46-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Arjen,

On Mon, 20 Oct 2008 21:57:51 -0700, Arjan van de Ven wrote:
> From 2642176b21b402e7f1ea7697ad2659d0e7e59f6e Mon Sep 17 00:00:00 2001
> From: Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Date: Sun, 28 Sep 2008 16:13:48 -0700
> Subject: [PATCH] pci: use pci_ioremap_bar() in drivers/i2c
> 
> Use the newly introduced pci_ioremap_bar() function in drivers/i2c.
> pci_ioremap_bar() just takes a pci device and a bar number, with the goal
> of making it really hard to get wrong, while also having a central place
> to stick sanity checks.
> 
> CC: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
> Signed-off-by: Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-hydra.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hydra.c
> index 1098f21..648aa7b 100644
> --- a/drivers/i2c/busses/i2c-hydra.c
> +++ b/drivers/i2c/busses/i2c-hydra.c
> @@ -123,7 +123,7 @@ static int __devinit hydra_probe(struct pci_dev *dev,
>  				hydra_adap.name))
>  		return -EBUSY;
>  
> -	hydra_bit_data.data = ioremap(base, pci_resource_len(dev, 0));
> +	hydra_bit_data.data = pci_ioremap_bar(dev, 0);
>  	if (hydra_bit_data.data == NULL) {
>  		release_mem_region(base+offsetof(struct Hydra, CachePD), 4);
>  		return -ENODEV;

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
