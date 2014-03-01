From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/2] i2c: Add message transfer tracepoints for SMBUS
Date: Sat, 01 Mar 2014 07:48:27 +0000
Message-ID: <24554.1393660107@warthog.procyon.org.uk>
References: <20140228212134.GC2517@katana> <20140218205418.GH18768@katana> <20140109214954.25590.73057.stgit@warthog.procyon.org.uk> <20140109215002.25590.51609.stgit@warthog.procyon.org.uk> <11165.1393507178@warthog.procyon.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140228212134.GC2517@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: dhowells@redhat.com, wolfram@the-dreams.de, khali@linux-fr.org, linux-i2c@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> wrote:

> > > Can we have something like this for 'flags'?
> > 
> > There's a __print_flags() which should work.  One thing I'm concerned about
> > there is how do we handle more flags being added - does that count as an ABI
> > break if the printed format changes?
> 
> Not sure, I mean, this is debug output, no?

Apparently, the raw messages are ABI, but the text dump (which is what we're
talking out) is not.  So doing this should be okay.

David
