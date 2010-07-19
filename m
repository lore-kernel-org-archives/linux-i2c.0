From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH v2] gpio: sx150x: Add Semtech I2C sx150x gpio expander
 driver.
Date: Mon, 19 Jul 2010 16:31:42 -0700
Message-ID: <20100719163142.16cab271.akpm@linux-foundation.org>
References: <1278617834-14970-1-git-send-email-gbean@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278617834-14970-1-git-send-email-gbean-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory Bean <gbean-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu,  8 Jul 2010 12:37:14 -0700
Gregory Bean <gbean-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:

> Add support for Semtech SX150-series I2C GPIO expanders.

It doesn't work when compiled as a module:

ERROR: "irq_to_desc" [drivers/gpio/sx150x.ko] undefined!
ERROR: "handle_edge_irq" [drivers/gpio/sx150x.ko] undefined!
ERROR: "set_irq_chip_and_handler" [drivers/gpio/sx150x.ko] undefined!
ERROR: "set_irq_noprobe" [drivers/gpio/sx150x.ko] undefined!

I think there's a reason why some of those things aren't exported to
modules.  Perhaps Thomas can remind us?

Meanwhile I'll do s/tristate/bool/.
