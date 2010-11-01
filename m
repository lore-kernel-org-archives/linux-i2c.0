From: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/1] PN544 NFC driver.
Date: Mon, 01 Nov 2010 10:10:28 +0200
Message-ID: <1288599028.1603.56.camel@masi.mnp.nokia.com>
References: <1288333569-19979-1-git-send-email-matti.j.aaltonen@nokia.com>
	 <20101029143333.db43953b.akpm@linux-foundation.org>
Reply-To: matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101029143333.db43953b.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi.

On Fri, 2010-10-29 at 14:33 -0700, ext Andrew Morton wrote:
> On Fri, 29 Oct 2010 09:26:08 +0300
> "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > Hello.
> > 
> > And thanks to Andrew for the comments.
> > 
> > >> include/linux/pn544.h |   99 ++++++
> > > 
> > > Is drivers/misc/ the best place for this?
> > > 
> > > Don't be afraid to create a new drivers/nfc/ even if it has only one
> > > driver in it.  If someone later comes in and adds a new NFC driver then
> > > things will all fall into place.
> > 
> > OK. Now I've created directories drivers/nfc, include/linux/nfc and Documentation/nfc.
> 
> I beefed up the changelog a bit, telling people what "nfc" is.
> 
> We really should tell more people that we're adding a new subsystem. 
> Can you please resend the patchset, cc'ing linux-kernel?

OK...

> > >> +/* sysfs interface */
> > > 
> > > OK, this is more serious.
> > > 
> > > You're proposing a permanent addition to the kernel ABI.  This is the
> > > most important part of the driver because it is something we can never
> > > change.  This interface is the very first thing we'll want to
> > > understand and review, before we even look at the implementation.
> > > 
> > > And it isn't even described!  Not in the changelog, not in a
> > > documentation file, not even in code comments.
> > > 
> > > Please, provide a description of this proposed interface.  Sufficient
> > > for reviewers to understand it and for users to use it.  Pobably this
> > > will require some description of the hardware functions as well.
> > > 
> > > Please also consider updating Documentation/ABI/
> > 
> > I've added a documentation file. But I didn't make changes to the interface
> > yet.
> 
> So we can expect some updates?

Yes in the sense that I'm not yet sure what the community wants and so
making a big leap could just go in the wrong direction... 

> > > 
> > > And an ioctl interface as well!  An undocmented one.
> > > 
> > > ioctls are pretty unpopular for various reasons.  To a large extent,
> > > people have been using sysfs interfaces as a repalcement for ioctl()s.
> > > But this driver has both!
> > 
> > Some explanatory text written into the documentation file.
> 
> So, the sysfs interface is purely for running a device test?

Yes, and if the board data doesn't contain the test the sysfs interface
doesn't appear.

> And primary communication is via the /dev node, and that node supports
> an ioctl() which changes the meaning of reads and writes to that node?

There is the "normal" mode, which is practice is used something like 99%
of the time and there the special firmware upload mode.

> If so, that's a bit of a peculiar interface.  Perhaps there should have
> been two /dev nodes.  Certainly it would be most popular if the ioctl()
> interface were to simply disappear.

What would be the most popular choice?

> Please, do spell all of this out in some detail within the changelog
> when resending the code for wider review.  There are people out there
> (eg Greg, Alan) who are better at these things than I and we should
> provide them with all the details up-front without going through
> another question-and-answer session or expecting them to grovel through
> code to reverse-engineer the interfaces.

OK I'll try to do that, but I really thought the driver was simple and
the documentation clear enough...

> Another consideration here is that if we do expect more NFC devices and
> drivers for them, then we should aim for some standardisation of the
> interface, from day one.  Some discussion of this would also be helpful
> for reviewers.

I personally think we should aim for standardization.

> One other thing: these messages which flow between userspace and the
> device.  Are they documented or sufficiently well understood so that
> non-Nokia people can use this driver?

You can get the documentation from www.etsi.org as I said in the
document file.

> Because we had a driver come up a couple of weeks ago.  It was a
> simple, clean driver but all it did was to shuffle opaque data between
> userspace and the device, and the contents of that data was not
> publicly available.  I discussed the driver with Linus and he said "no".

Yes I remember, I am the contact person for that driver as well. And I
also though that these two drivers were very similar - except for the
message protocol: "simple and clean". 

Cheers,
Matti
