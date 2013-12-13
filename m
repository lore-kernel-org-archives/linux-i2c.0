From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] i2c: Add message transfer tracepoints for I2C and SMBUS
Date: Fri, 13 Dec 2013 12:39:02 -0500
Message-ID: <20131213123902.06fe9c85@gandalf.local.home>
References: <20131213104806.4fb56012@gandalf.local.home>
	<20131213142627.4014.42860.stgit@warthog.procyon.org.uk>
	<20131213163349.4bc686c0@endymion.delvare>
	<22364.1386954254@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <22364.1386954254-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 13 Dec 2013 17:04:14 +0000
David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org> wrote:
> 
> > > Would it be possible to print this as a string rather than a number?
> > > The protocol numbers are completely arbitrary, so the reader would have
> > > to open i2c.h each time to figure out what is what.
> > 
> > That can be done in the TP_printk() with:
> > 
> > 	".. %s ..", ..,
> > 	__print_symbolic(__entry->protocol,
> > 		{ I2C_SMBUS_QUICK	,	"QUICK"	},
> > 		{ I2C_SMBUS_BYTE	,	"BYTE"	},
> > 		{ I2C_SMBUS_BYTE_DATA	,	"BYTE_DATA" },
> > 		[...]
> > 		{ I2C_SMBUS_I2C_BLOCK_DATA,	"I2C_BLOCK_DATA"}), ...
> 
> What happens if the number isn't in the table?

It simply prints the hex value. See trace_output.c:

const char *
ftrace_print_symbols_seq(struct trace_seq *p, unsigned long val,
			 const struct trace_print_flags *symbol_array)
{
	int i;
	const char *ret = p->buffer + p->len;

	for (i = 0;  symbol_array[i].name; i++) {

		if (val != symbol_array[i].mask)
			continue;

		trace_seq_puts(p, symbol_array[i].name);
		break;
	}

	if (ret == (const char *)(p->buffer + p->len))
		trace_seq_printf(p, "0x%lx", val);
		
	trace_seq_putc(p, 0);

	return ret;
}

-- Steve
