From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Add message transfer tracepoints for SMBUS
Date: Thu, 27 Feb 2014 13:19:38 +0000
Message-ID: <11165.1393507178@warthog.procyon.org.uk>
References: <20140218205418.GH18768@katana> <20140109214954.25590.73057.stgit@warthog.procyon.org.uk> <20140109215002.25590.51609.stgit@warthog.procyon.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140218205418.GH18768@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:

> Although SMBus has no 10-bit addresses, we probably should also use %03x
> there for consistency reasons?

Done.

> Also, the I2C tracing has first 'f' then 'a', that should be consistent,
> too.

Flags first or address first?  Do you have a preference (for both)?

> 'flags' should be %04x again

Done.

> and I'd prefer %*ph (or %*phD) for the buffer.

Again, I'm not so certain.

> Can we have something like this for 'flags'?

There's a __print_flags() which should work.  One thing I'm concerned about
there is how do we handle more flags being added - does that count as an ABI
break if the printed format changes?

SMBus flags are basically the same as I2C flags, right?

David
