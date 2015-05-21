From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6/6] MAINTAINERS: maintain parport
Date: Wed, 20 May 2015 23:09:41 -0700
Message-ID: <20150521060941.GA30864@kroah.com>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1432135622-8288-7-git-send-email-sudipm.mukherjee@gmail.com>
 <CAFLxGvyw+UhHrdbiXCkKefirjiOum2+cNY26zDe2AzAi0hx0ng@mail.gmail.com>
 <20150521055118.GC8344@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20150521055118.GC8344@1wt.eu>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Willy Tarreau <w@1wt.eu>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Richard Weinberger <richard.weinberger@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Jean Delvare <jdelvare@suse.de>, Willy Tarreau <willy@meta-x.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Tim Waugh <tim@cyberelk.net>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, May 21, 2015 at 07:51:18AM +0200, Willy Tarreau wrote:
> On Wed, May 20, 2015 at 05:46:44PM +0200, Richard Weinberger wrote:
> > On Wed, May 20, 2015 at 5:27 PM, Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > > Lets give the parport subsystem a proper name and start
> > > maintaining the files.
> > 
> > Excuse me, but usually someone takes over the maintainer role after
> > proving that he
> > cares for a sub system for a certain period of time.
> > Or did I miss something?
> 
> Sudip has been volunteering for fixing this code which is marked
> as "orphan". So whatever his experience and care in this area,
> it will be better for the driver to have a maintainer than none.
> 
> Good luck Sudip, as drivers which have become orphans are probably
> the ones that deserve the least love :-)

I agree.  I've been "baby-sitting" this subsystem for a long time now.
If Sudip wants to take it on, and based on his recent patches it looks
like he does, I'm all for him to be the maintainer of it.  So this patch
in the series is fine with me, I'll apply it when the rest of this
series gets merged.

thanks,

greg k-h
