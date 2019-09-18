From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Date: Wed, 18 Sep 2019 21:07:48 +0200
Message-ID: <20190918190748.GA2014907@kroah.com>
References: <20190918170952.GT2596@sirena.co.uk>
 <20190918185257.GC1933777@kroah.com>
 <CAHk-=whreYmsU_AQtzDS5gd3yamYJ72gBo+YekYSyJLPQ1Qo-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=whreYmsU_AQtzDS5gd3yamYJ72gBo+YekYSyJLPQ1Qo-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 18, 2019 at 12:03:17PM -0700, Linus Torvalds wrote:
> On Wed, Sep 18, 2019 at 11:53 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Sep 18, 2019 at 06:09:52PM +0100, Mark Brown wrote:
> > >
> > > After merging the driver-core tree, today's linux-next build
> > > for arm64 allmodconfig failed like this:
> >
> > Wait, I thought Linus said this fixup was now resolved.  What went
> > wrong?
> 
> I think this is purely a linux-next build failure.
> 
> I do full allmodconfig builds between each merge I do, and what
> happened is that as part of the LED merge, I removed the
> no-longer-used 'i2c_acpi_find_match_adapter()' to resolve that build
> warning.
> 
> Then linux-next presumably merged my tree with the driver-core tree,
> and that re-instated the use of i2c_acpi_find_match_adapter() - which
> was now gone.
> 
> But when *I* merged the driver-core tree, I did the merge fixup
> correctly to actually re-instate not only the use, but also re-instate
> the removed function that now had a use again.
> 
> > Linus, should I submit a fix for this?
> 
> My tree should be fine, and I really think this is just a temporary
> linux-next effect from the above. I think linux-next only handled the
> actual syntactic conflicts, not the semantic conflict of "function had
> been removed to avoid build error from previous merge, and needed to
> be brought back"
> 
> Knock wood.

I looked at your merge of the driver core tree, and see that the
"missing" function is now back.

And I did a test build here and all works for me, so I think this is ok,
thanks for the fixup.

greg k-h
