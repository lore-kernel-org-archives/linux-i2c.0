From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 5/5] i2c: octeon,thunderx: Limit register access retries
Date: Thu, 22 Sep 2016 18:40:18 +0200
Message-ID: <20160922164018.GA2993@hardcore>
References: <cover.1474439371.git.jglauber@cavium.com>
 <a52c3157fd27c939185163d2df23e39174cabc60.1474439371.git.jglauber@cavium.com>
 <20160921210335.GG1513@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160921210335.GG1513@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, "Bazhenov, Dmitry" <dmitry.bazhenov@auriga.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 21, 2016 at 11:03:35PM +0200, Wolfram Sang wrote:
> On Wed, Sep 21, 2016 at 08:51:06AM +0200, Jan Glauber wrote:
> > Do not infinitely retry register readq and writeq operations
> > in order to not lock up the CPU in case the TWSI gets stuck.
> > 
> > Return -EIO in case of a failed data read. For all other
> > cases just return so subsequent operations will fail
> > and trigger the recovery.
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> 
> I didn't really check, but have you considered using
> readq_poll_timeout() from iopoll.h?
> 

Indeed, readq_poll_timeout() fits quite well here. It will lose some cycles
on mips but I'm not convinced that matters with i2c.

That would be the first user of readq_poll_timeout() in the kernel :)

--Jan
