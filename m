From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Add message transfer tracepoints for I2C
Date: Sat, 01 Mar 2014 07:54:13 +0000
Message-ID: <24692.1393660453@warthog.procyon.org.uk>
References: <20140228211758.GB2517@katana> <20140218203346.GG18768@katana> <20140109214954.25590.73057.stgit@warthog.procyon.org.uk> <10892.1393506444@warthog.procyon.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140228211758.GB2517@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:

> > > And for the buffer: %*phN is difficult to read IMO. What about %*ph? Or
> > > %*phD at least?
> > 
> > My problem with that is that it increases the length of the output by 50%
> > and there's a hard limit on how much output we may produce.
> 
> Is it PAGE_SIZE? How is this handled when the buffer is so big that the
> limit will be reached anyhow? Note that it is really uncommon to
> transfer kilobytes in one go via i2c. Usually, big transfers are split
> up into smaller fragments, say 128-256 byte. So, for readability, I'd
> still favour %*ph.

I was thinking that limited the size of the output field to 64 bytes.  But
reading vsprintf.c again, it appears it's actually the size of the binary blob
that it's converting to hex that's limited to 64 bytes.

I would prefer shorter lines - 128 bytes of hex still isn't entirely readable,
even with separators interpolated, but I'll add this.

David
