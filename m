From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 1/3] MFD: introduce lpc_sch for Intel SCH LPC bridge
Date: Tue, 23 Feb 2010 10:41:42 +0100
Message-ID: <20100223094141.GC3550@sortiz.org>
References: <4B73DAEE.5080400@compulab.co.il>
 <4B73DB4B.40501@compulab.co.il>
 <4B7D7C13.20703@compulab.co.il>
 <4B7D7CD0.7080202@oracle.com>
 <4B7D807D.9060105@compulab.co.il>
 <20100223092636.42b083f0@hyperion.delvare>
 <4B839F27.2040003@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B839F27.2040003-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Denis Turischev <denis-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Denis,

On Tue, Feb 23, 2010 at 11:25:59AM +0200, Denis Turischev wrote:
> Hi Samuel,
> Regarding renaming of sch* to isch* do you want incremental patch, or fresh version?
> 
I'll fix that myself, no worries.

Cheers,
Samuel.


> Denis
> 
> Jean Delvare wrote:
> >>+static struct mfd_cell lpc_sch_cells[] = {
> >>+	{
> >>+		.name = "isch_smbus",
> >>+		.num_resources = 1,
> >>+		.resources = &smbus_sch_resource,
> >>+	},
> >>+	{
> >>+		.name = "sch_gpio",
> >>+		.num_resources = 1,
> >>+		.resources = &gpio_sch_resource,
> >>+	},
> >>+};
> >
> >These names are nicely inconsistent. What about "isch_gpio"?
> >
> 
> >>+obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
> >
> >I don't like this name either. There is another vendor (SMSC) shipping
> >LPC devices with "SCH" in their names, so there is room for confusion.
> >"isch" makes it clearer that we are talking about the Intel ones.
> >
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
