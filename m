From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 17:54:55 -0700
Message-ID: <20170802005455.GA16611@kroah.com>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <20170801014021.GA20004@kroah.com>
 <20170801124801.38bbc431@bbrezillon>
 <20170801175133.GA30520@kroah.com>
 <20170801233001.4b08834f@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170801233001.4b08834f@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@co>
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 01, 2017 at 11:30:01PM +0200, Boris Brezillon wrote:
> > > > No release type?  Oh that's bad bad bad and implies you have never
> > > > removed a device from your system as the kernel would have complained
> > > > loudly at you.  
> > > 
> > > You got me, never tried to remove a device :-). Note that these  
> > > ->release() hooks will just be dummy ones, because right now, device  
> > > resources are freed at bus destruction time.  
> > 
> > You better not have a "dummy" release hook, do that and as per the
> > kernel documentation, I get to make fun of you in public for doing that
> > :(
> 
> I'm not afraid of admitting I don't know everything, even the
> simplest things that you consider as basics for a kernel developer. You
> can make fun of me publicly if you want but that's not helping :-P.

No, I am referring to the Documentation/kobject.txt file, where it says:
	One important point cannot be overstated: every kobject must
	have a release() method, and the kobject must persist (in a
	consistent state) until that method is called. If these
	constraints are not met, the code is flawed.  Note that the
	kernel will warn you if you forget to provide a release()
	method.  Do not try to get rid of this warning by providing an
	"empty" release function; you will be mocked mercilessly by the
	kobject maintainer if you attempt this.

Sometimes I wonder why I even write documentation...

The point is, you have to release the memory the device structure "owns"
in the release callback, if not, then the model is not correct.  That's
all, please fix up your code to do so and I will be glad to review it
again.  I'm not trying to be rude here at all, but please, at the least,
read the documentation we have already first...

thanks,

greg k-h
