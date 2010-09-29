From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 05/24] i2c: change to new flag variable
Date: Wed, 29 Sep 2010 15:56:09 +0200
Message-ID: <20100929155609.00a70ee0@endymion.delvare>
References: <e0bdab5d2e8c52041c003de68ba774c3e706716c.1285355033.git.mfm@muteddisk.com>
	<9968d4260be8850200cc9c7dfe08addf611468b4.1285355033.git.mfm@muteddisk.com>
	<036514b5dd23c5af14303519d79d60d79adccbee.1285355033.git.mfm@muteddisk.com>
	<ffbd189ef2d414ea7c87ffe2b40fce87877dc014.1285355033.git.mfm@muteddisk.com>
	<b3e2061e1e6703f7b84c0484030e07de6000546a.1285355033.git.mfm@muteddisk.com>
	<20100925132611.03ef0882@endymion.delvare>
	<20100926021217.GC8191@haskell.muteddisk.com>
	<20100926092931.68980448@endymion.delvare>
	<20100926180726.GD8191@haskell.muteddisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100926180726.GD8191@haskell.muteddisk.com>
Sender: linux-kernel-owner@vger.kernel.org
To: matt mooney <mfm@muteddisk.com>
Cc: kernel-janitors@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 26 Sep 2010 11:07:26 -0700, matt mooney wrote:
> On 09:29 Sun 26 Sep     , Jean Delvare wrote:
> > On Sat, 25 Sep 2010 19:12:17 -0700, matt mooney wrote:
> > > Sam had implemented these newer style flag variables a while back as an
> > > eloquent way of handling conditional flags. A lot of newer (and some older)
> > > modules and subsystems were using them already, so to provide uniformity and for
> > > an eventual removal of the deprecated flags, I converted all remaining instances
> > > to the newer style. (IMHO, I think it flows better with the way the rest of the
> > > build system works.)
> > 
> > Fine with me. What's the planned merge path for this patch? Will you
> > push all the patches upstream yourself, or do you expect me to pick
> > this one?
> 
> I was hoping subsystem maintainers would pick them up, but a lot of the patches
> have been acked without being applied. My new plan is to have the unapplied ones
> go through the kbuild tree. So you can either pick it up or just ack it.

I've picked the patch, it's now in my i2c tree, scheduled for merge in 2.6.37.

-- 
Jean Delvare
