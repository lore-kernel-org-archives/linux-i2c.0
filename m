From: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
Date: Sun, 5 Jan 2014 10:27:56 -0700
Message-ID: <20140105172756.GA11280@obsidianresearch.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
 <201401051525.52459.arnd@arndb.de>
 <20140105154023.GA2048@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140105154023.GA2048-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Jan 05, 2014 at 04:40:23PM +0100, Andrew Lunn wrote:
> > > +static int __init mvebu_soc_id_init(void)
> > > +{
> > > +	struct device_node *np;
> > > +	int ret = 0;
> > > +
> > > +	np = of_find_matching_node(NULL, mvebu_pcie_of_match_table);
> > > +	if (np) {
> > > +		void __iomem *pci_base;
> > > +		struct clk *clk;
> > > +		/*
> > > +		 * ID and revision are available from any port, so we
> > > +		 * just pick the first one
> > > +		 */
> > > +		struct device_node *child = of_get_next_child(np, NULL);
> > 
> > I guess all this will fail if for some reason the PCIe node is not
> > present on machines that don't use PCIe.
> 
> Hi Arnd
> 
> That would be rather odd. These nodes are in the top level SoC dtsi
> file. When they are not used, they have status = "disabled" and are in
> the dtb blob with this state.

Hang on, you can't safely read from a disabled PCI node, it could have been
powered down by the bootloader..

Jason
