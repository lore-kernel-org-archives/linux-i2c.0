From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: Add message transfer tracepoints for I2C and SMBUS
Date: Fri, 13 Dec 2013 16:05:36 +0000
Message-ID: <3708.1386950736@warthog.procyon.org.uk>
References: <20131213163349.4bc686c0@endymion.delvare> <20131213142627.4014.42860.stgit@warthog.procyon.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131213163349.4bc686c0-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> One significant difference between both implementations is that the old
> one logs before the actual transfer, while yours logs afterward. While I
> understand this allows you to log the result of the transfer, this also
> means you'll miss the log if the actual transaction locks the system
> (we've seen this before.) Something to think about...

I could split each into three messages:

	- Write request (has params & data buffer)
	- Read request (has params but no data buffer)
	- Read reply (has data buffer only)

It will make the transfer functions more complex, though, and will mean that,
for i2c, you won't get all the replies to the messages in a batch in with the
requests.  I can also label the messages with the index number.  Mostly I
suspect this won't be a problem.

David
