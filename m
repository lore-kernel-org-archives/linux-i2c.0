From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/6] drivers/i2c: Update i2c_trace_msg static key to modern api
Date: Tue, 03 Apr 2018 15:00:27 +0100
Message-ID: <13518.1522764027@warthog.procyon.org.uk>
References: <20180403132032.bseezddmd6rrka6g@ninjato> <20180326210929.5244-1-dave@stgolabs.net> <20180326210929.5244-2-dave@stgolabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180403132032.bseezddmd6rrka6g@ninjato>
Content-ID: <13517.1522764027.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: dhowells@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> wrote:

> > No changes in refcount semantics -- key init is false; replace
> > 
> > static_key_slow_inc|dec   with   static_branch_inc|dec
> > static_key_false          with   static_branch_unlikely
> > 
> > Added a '_key' suffix to i2c_trace_msg, for better self
> > documentation.
> > 
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-i2c@vger.kernel.org
> > Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Reviewed-by: David Howells <dhowells@redhat.com>
