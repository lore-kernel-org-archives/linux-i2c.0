From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Add message transfer tracepoints for SMBUS
Date: Thu, 06 Mar 2014 13:13:55 +0000
Message-ID: <19542.1394111635@warthog.procyon.org.uk>
References: <11165.1393507178@warthog.procyon.org.uk> <20140218205418.GH18768@katana> <20140109214954.25590.73057.stgit@warthog.procyon.org.uk> <20140109215002.25590.51609.stgit@warthog.procyon.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <11165.1393507178-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> > Can we have something like this for 'flags'?
> 
> There's a __print_flags() which should work.  One thing I'm concerned about
> there is how do we handle more flags being added - does that count as an ABI
> break if the printed format changes?
> 
> SMBus flags are basically the same as I2C flags, right?

Hmmm... __print_flags() seems to append a string if a flag is set, and doesn't
if it isn't set.  It places a separator between each string.  I would prefer
something that emits a single char per flag or a dash if it isn't present.
Are you okay with that?

David
