From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: Add message transfer tracepoints for I2C and SMBUS
Date: Fri, 13 Dec 2013 17:04:14 +0000
Message-ID: <22364.1386954254@warthog.procyon.org.uk>
References: <20131213104806.4fb56012@gandalf.local.home> <20131213142627.4014.42860.stgit@warthog.procyon.org.uk> <20131213163349.4bc686c0@endymion.delvare>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131213104806.4fb56012-f9ZlEuEWxVcJvu8Pb33WZ0EMvNT87kid@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org> wrote:

> > Would it be possible to print this as a string rather than a number?
> > The protocol numbers are completely arbitrary, so the reader would have
> > to open i2c.h each time to figure out what is what.
> 
> That can be done in the TP_printk() with:
> 
> 	".. %s ..", ..,
> 	__print_symbolic(__entry->protocol,
> 		{ I2C_SMBUS_QUICK	,	"QUICK"	},
> 		{ I2C_SMBUS_BYTE	,	"BYTE"	},
> 		{ I2C_SMBUS_BYTE_DATA	,	"BYTE_DATA" },
> 		[...]
> 		{ I2C_SMBUS_I2C_BLOCK_DATA,	"I2C_BLOCK_DATA"}), ...

What happens if the number isn't in the table?

David
