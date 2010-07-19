From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH v2] gpio: sx150x: Add Semtech I2C sx150x gpio expander
 driver.
Date: Mon, 19 Jul 2010 16:50:38 -0700
Message-ID: <20100719165038.a308b019.akpm@linux-foundation.org>
References: <1278617834-14970-1-git-send-email-gbean@codeaurora.org>
	<20100719163142.16cab271.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100719163142.16cab271.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory Bean <gbean-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 19 Jul 2010 16:31:42 -0700
Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:

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
> 
> Meanwhile I'll do s/tristate/bool/.

Which of course didn't work because i2c is a module.


drivers/built-in.o: In function `sx150x_i2c_read':
sx150x.c:(.text+0x5362): undefined reference to `i2c_smbus_read_byte_data'
drivers/built-in.o: In function `sx150x_i2c_write':
sx150x.c:(.text+0x53e4): undefined reference to `i2c_smbus_write_byte_data'
drivers/built-in.o: In function `sx150x_init':
sx150x.c:(.init.text+0x418): undefined reference to `i2c_register_driver'
drivers/built-in.o: In function `sx150x_probe':
sx150x.c:(.devinit.text+0xda1): undefined reference to `i2c_smbus_write_word_data'
drivers/built-in.o: In function `sx150x_exit':
sx150x.c:(.exit.text+0x7c): undefined reference to `i2c_del_driver'
