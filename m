From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] i2c: Add message transfer tracepoints for I2C
Date: Thu, 27 Feb 2014 13:07:24 +0000
Message-ID: <10892.1393506444@warthog.procyon.org.uk>
References: <20140218203346.GG18768@katana> <20140109214954.25590.73057.stgit@warthog.procyon.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140218203346.GG18768@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: dhowells@redhat.com, wolfram@the-dreams.de, khali@linux-fr.org, linux-i2c@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> wrote:

> 'flags' are u16 and the whole range is needed -> %04x

Done.  Note that %02x does not preclude more digits, but I guess it's better
to have things line up.

> for the address simply %03x should do.

Done.

> And for the buffer: %*phN is difficult to read IMO. What about %*ph? Or
> %*phD at least?

My problem with that is that it increases the length of the output by 50% and
there's a hard limit on how much output we may produce.

David
