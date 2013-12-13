From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] i2c: Add message transfer tracepoints for I2C and SMBUS
Date: Fri, 13 Dec 2013 10:48:06 -0500
Message-ID: <20131213104806.4fb56012@gandalf.local.home>
References: <20131213142627.4014.42860.stgit@warthog.procyon.org.uk>
	<20131213163349.4bc686c0@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131213163349.4bc686c0-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 13 Dec 2013 16:33:49 +0100
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Hi David,
> 
> Please note that I am no longer maintaining the i2c subsystem so you
> should have sent this to Wolfram, not me.
> 
> On Fri, 13 Dec 2013 14:26:27 +0000, David Howells wrote:
> > Add tracepoints into the I2C and SMBUS message transfer functions to retrieve
> > the message sent or received.  The following config options must be turned on
> > to make use of the facility:
> > 
> > 	CONFIG_FTRACE
> > 	CONFIG_ENABLE_DEFAULT_TRACERS
> > 
> > The I2C tracepoint can be enabled thusly:
> > 
> > 	echo 1 >/sys/kernel/debug/tracing/events/i2c/i2c_transfer/enable
> > 
> > and will dump messages that can be viewed in /sys/kernel/debug/tracing/trace
> > that look like:
> > 
> >         ... i2c_transfer: i2c-5 f=00 a=44 l=6 ret=1 [021433000000]
> > 
> > formatted as:
> > 
> > 	i2c-<adapter-nr>
> > 	f=<flags>
> > 	a=<addr>
> > 	l=<datalen>
> > 	ret=<result>
> > 	[<data>]
> > 
> > (Bit 0 of the flags is set if this was a read and clear if it was a write).
> 
> Wouldn't the traces be more readable if the direction was written
> explicitly as R or W?

We can easily do that by adding in the TP_printk()

	".. (%s) ..", ..., __entry->flags & 1 ? "R" : "W", ...

> 
> > 
> > 
> > The SMBUS tracepoint can be enabled thusly:
> > 
> > 	echo 1 >/sys/kernel/debug/tracing/events/i2c/smbus_transfer/enable
> > 
> > and will dump messages that can be viewed in /sys/kernel/debug/tracing/trace
> > that look like:
> > 
> > 	... smbus_transfer: i2c-0 f=00 a=51 r=1 c=0 p=2 res=0 [80ff0100000000000000800c693d0088ffffb83aee3b0088ffff0100000000000000]
> > 
> > formatted as:
> > 
> > 	i2c-<adapter-nr>
> > 	f=<flags>
> > 	a=<addr>
> > 	r=<read_write>
> 
> Here too I would consider R and W as more readable than r=1 and r=0.

Same thing can be done here.

> 
> > 	c=<command>
> > 	p=<protocol>
> 
> Would it be possible to print this as a string rather than a number?
> The protocol numbers are completely arbitrary, so the reader would have
> to open i2c.h each time to figure out what is what.

That can be done in the TP_printk() with:

	".. %s ..", ..,
	__print_symbolic(__entry->protocol,
		{ I2C_SMBUS_QUICK	,	"QUICK"	},
		{ I2C_SMBUS_BYTE	,	"BYTE"	},
		{ I2C_SMBUS_BYTE_DATA	,	"BYTE_DATA" },
		[...]
		{ I2C_SMBUS_I2C_BLOCK_DATA,	"I2C_BLOCK_DATA"}), ...


> 
> > 	res=<result>
> > 	[<data-block>]
> > 
> > 
> > In both cases, the adapters to be traced can be selected by something like:
> > 
> > 	echo adapter_nr==1 >/sys/kernel/debug/tracing/events/i2c/{i2c,smbus}_transfer/filter
> 
> I have no objection to the feature, but it should be noted that
> i2c-core already offers something similar (albeit less flexible) for
> I2C level transfers:
> 
> #ifdef DEBUG
> 		for (ret = 0; ret < num; ret++) {
> 			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, "
> 				"len=%d%s\n", ret, (msgs[ret].flags & I2C_M_RD)
> 				? 'R' : 'W', msgs[ret].addr, msgs[ret].len,
> 				(msgs[ret].flags & I2C_M_RECV_LEN) ? "+" : "");
> 		}
> #endif
> 
> If your code goes in, I suppose the code above should be removed to
> avoid redundancy.
> 
> One significant difference between both implementations is that the old
> one logs before the actual transfer, while yours logs afterward. While I
> understand this allows you to log the result of the transfer, this also
> means you'll miss the log if the actual transaction locks the system
> (we've seen this before.) Something to think about...
> 

Note, as this is being added to the trace system, one can use function
tracing to see if this is causing the crash. Yeah, you wont be able to
see what the transfer packet was, but you can use kprobes to help there
too.

-- Steve
