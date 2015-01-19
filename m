From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Py-smbus for Python 3
Date: Mon, 19 Jan 2015 13:24:30 +0100
Message-ID: <20150119132430.7fcba08e@endymion.delvare>
References: <1421658501.2937.2@smtp.inria.fr>
	<1879153388.1899869.1421658735412.JavaMail.zimbra@inria.fr>
	<20150119092420.GA998@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150119092420.GA998@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Michael Mercier <michael.mercier-MZpvjPyXg2s@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

On Mon, 19 Jan 2015 10:24:20 +0100, Wolfram Sang wrote:
> On Mon, Jan 19, 2015 at 10:12:15AM +0100, Michael Mercier wrote:
> > Hi,
> > 
> > I am working on a project that use the py-smbus module. The problem is 
> > I am using python 3.x and the py-smbus library is not compatible with 
> > this version.
> > 
> > I found a lot of hack to do so, like:
> > http://www.raspberrypi.org/forums/viewtopic.php?f=32&t=22348
> > http://procrastinative.ninja/2014/07/21/smbus-for-python34-on-raspberry/
> > http://comments.gmane.org/gmane.linux.drivers.i2c/11290
> > http://www.spinics.net/lists/linux-i2c/msg08427.html
> > 
> > I eventually manage to make it work but this code only working with 
> > python 3.
> > 
> > I like distribute it but I do not know where. Is there someone that can 
> > merge this upstream properly (with python2 compatibility)?
> > 
> > I can also put it on github to make it available so any interested people could improve it?
> > 
> > What do you think?
> 
> Adding Jean to the list, he is the current maintainer of i2c-tools.

Indeed there have been many people doing the same, unfortunately nobody
ever posted a patch which would preserve compatibility with python 2. I
don't know a thing about python but I can't imagine that this is not
possible.

Unfortunately, as long as nobody contributes a patch which makes
py-smbus work for both python version 2 and version 3, I can't apply
it. I don't think it makes sense to break compatibility with one
version to make the other one work.

-- 
Jean Delvare
SUSE L3 Support
