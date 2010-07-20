From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH v2] gpio: sx150x: Add Semtech I2C sx150x gpio expander
 driver.
Date: Tue, 20 Jul 2010 10:21:35 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1007201019300.8107@localhost.localdomain>
References: <1278617834-14970-1-git-send-email-gbean@codeaurora.org> <20100719163142.16cab271.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100719163142.16cab271.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Gregory Bean <gbean-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Mon, 19 Jul 2010, Andrew Morton wrote:

> On Thu,  8 Jul 2010 12:37:14 -0700
> Gregory Bean <gbean-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> 
> > Add support for Semtech SX150-series I2C GPIO expanders.
> 
> It doesn't work when compiled as a module:
> 
> ERROR: "irq_to_desc" [drivers/gpio/sx150x.ko] undefined!
> ERROR: "handle_edge_irq" [drivers/gpio/sx150x.ko] undefined!
> ERROR: "set_irq_chip_and_handler" [drivers/gpio/sx150x.ko] undefined!
> ERROR: "set_irq_noprobe" [drivers/gpio/sx150x.ko] undefined!
> 
> I think there's a reason why some of those things aren't exported to
> modules.  Perhaps Thomas can remind us?

There was no requirement to do so, it came up with those I2C irq
controllers lately. I don't have a strong feeling, but if we can avoid
the export I'd feel more comfortable.

Thanks,

	tglx
