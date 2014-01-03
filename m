From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
Date: Fri, 3 Jan 2014 19:48:00 +0100
Message-ID: <20140103194800.2d3ca026@skate>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
	<1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1388743185-24822-2-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Gregory CLEMENT,

On Fri,  3 Jan 2014 10:59:44 +0100, Gregory CLEMENT wrote:
> +static int __init mvebu_soc_id_init(void)
> +{
> +	struct device_node *np;
> +	int ret = 0;
> +
> +	np = of_find_matching_node(NULL, mvebu_pcie_of_match_table);
> +	if (np) {

Change this to:

	if (!np)
		return 0;

so that you avoid indenting the entire function code inside the if
{ ... } block.

> +		void __iomem *pci_base;
> +		struct clk *clk;
> +		/*
> +		 * ID and revision are available from any port, so we
> +		 * just pick the first one
> +		 */
> +		struct device_node *child = of_get_next_child(np, NULL);

Maybe check that child is not NULL here?

> +
> +		clk = of_clk_get_by_name(child, NULL);
> +		if (IS_ERR(clk)) {
> +			pr_err("%s: cannot get clock\n", __func__);

I think you should rather do:

#define pr_fmt(fmt) "mvebu-soc-id: " fmt

at the beginning of your C file and get rid of the "%s" for the
__func__.

> +		/* SoC ID */
> +		soc_dev_id = __raw_readl(pci_base + PCIE_DEV_ID_OFF) >> 16;
> +
> +		/* SoC revision */
> +		soc_rev = __raw_readl(pci_base + PCIE_DEV_REV_OFF)
> +			& SOC_REV_MASK;

Use readl() for both of these reads. __raw_readl() will not work
properly when the system is booted big-endian.

> +	return ret;
> +}
> +arch_initcall(mvebu_soc_id_init);

> +#ifdef CONFIG_ARCH_MVEBU
> +int mvebu_get_soc_id(u32 *dev, u32 *rev);
> +#else
> +int mvebu_get_soc_id(u32 *dev, u32 *rev)

Missing "static inline". Without these, if this header file is included
more than once, you will have two times the same symbol defined.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
