From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 1/2] i2c: octeon: Fix register access
Date: Fri, 11 Nov 2016 08:00:25 +0100
Message-ID: <20161111070025.GB15806@hardcore>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161108071337.GA4601@hardcore>
 <20161110201731.GE1585@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20161110201731.GE1585@katana>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Paul Burton <paul.burton@imgtec.com>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 10, 2016 at 09:17:31PM +0100, Wolfram Sang wrote:
> On Tue, Nov 08, 2016 at 08:13:37AM +0100, Jan Glauber wrote:
> > On Mon, Nov 07, 2016 at 08:09:20PM +0000, Paul Burton wrote:
> > > Commit 70121f7f3725 ("i2c: octeon: thunderx: Limit register access
> > > retries") attempted to replace potentially infinite loops with ones
> > > which will time out using readq_poll_timeout, but in doing so it
> > > inverted the condition for exiting this loop.
> > > 
> > > Tested on a Rhino Labs UTM-8 with Octeon CN7130.
> > > 
> > > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > > Cc: Jan Glauber <jglauber@cavium.com>
> > > Cc: David Daney <david.daney@cavium.com>
> > > Cc: Wolfram Sang <wsa@the-dreams.de>
> > > Cc: linux-i2c@vger.kernel.org
> > > 
> > > ---
> > 
> > Acked-by: Jan Glauber <jglauber@cavium.com>
> > 
> > Thanks for spotting this. I think this should go into stable too for
> > 4.8, so adding Cc: stable@vger.kernel.org.
> 
> Shall I still apply this one? Seems to me that 70121f7f3725 is still
> under discussion of being reverted?
> 

70121f7 needs to be reverted, but it looks like i2c devices are still
not working on Octeon after that. We are still debugging the issue,
so I would suggest to wait for some more days.

--Jan
