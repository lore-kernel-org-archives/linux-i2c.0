From: Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>
Subject: RE: [PATCH] i2c: designware: Add support for 16bit register access
Date: Wed, 14 Mar 2012 16:51:42 +0800
Message-ID: <D5ECB3C7A6F99444980976A8C6D896384FA2BA269D@EAPEX1MAIL1.st.com>
References: <1331654061-5322-1-git-send-email-sr@denx.de>
	<D5ECB3C7A6F99444980976A8C6D896384FA2BA250F@EAPEX1MAIL1.st.com>
	<201203140858.00472.sr@denx.de>
	<D5ECB3C7A6F99444980976A8C6D896384FA2BA2675@EAPEX1MAIL1.st.com>
 <20120314094346.3d6e167f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120314094346.3d6e167f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, spear-devel <spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> -----Original Message-----
> From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]
> Sent: Wednesday, March 14, 2012 2:14 PM
> To: Bhupesh SHARMA
> Cc: Stefan Roese; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; spear-devel; ben-
> linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> Subject: Re: [PATCH] i2c: designware: Add support for 16bit register
> access
> 
> On Wed, 14 Mar 2012 16:19:22 +0800, Bhupesh SHARMA wrote:
> > > -----Original Message-----
> > > From: Stefan Roese [mailto:sr-ynQEQJNshbs@public.gmane.org]
> > > Sent: Wednesday, March 14, 2012 1:28 PM
> > > To: Bhupesh SHARMA
> > > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; spear-devel; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> > > Subject: Re: [PATCH] i2c: designware: Add support for 16bit
> register
> > > access
> > >
> > > On Wednesday 14 March 2012 04:29:23 Bhupesh SHARMA wrote:
> > > > > -----Original Message-----
> > > > > From: Stefan Roese [mailto:sr-ynQEQJNshbs@public.gmane.org]
> > > > > Sent: Tuesday, March 13, 2012 9:24 PM
> > > > > To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > > Cc: spear-devel; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> > > > > Subject: [PATCH] i2c: designware: Add support for 16bit
> register access
> > > > > (...)
> > > > > @@ -258,6 +270,12 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
> > > > >
> > > > >  		reg = DW_IC_COMP_TYPE_VALUE;
> > > > >
> > > > >  	}
> > > > >
> > > > > +	/* Configure register access mode 16bit */
> > > > > +	if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
> > > > > +		dev->access_16bit = 1;
> > > >
> > > > Can we use a suitable macro for 0x0000ffff?
> > >
> > > Hmmm. Wouldn't that make it more complex? 0x0000ffff is easy to
> > > understand. A
> > > marco would "hide" this value. I would prefer to keep the value.
> >
> > Using a macro doesn't make things 'more complex', but more readable.
> > Magic numbers must be avoided at all cost. A better
> > named MACRO is always better (for anyone else reading the code)
> > than a magic number like 0x0000ffff.
> 
> I beg to disagree. Quite strongly, even.
> 
> For one thing, "at all cost" never holds in the real world. You always
> have to make compromises.
> 
> For another, it only makes sense to define constants for values that
> have a specific meaning. For example bits in a bit vector, or bit
> masks. Here this is clearly not the case, so I fully agree with Stefan
> that a define would make the code _less_ readable.

Well you can have your opinion, let's wait for the 
maintainer's words..

> > > > > (...)
> > > > > diff --git a/drivers/i2c/busses/i2c-designware-core.h
> > > > > b/drivers/i2c/busses/i2c-designware-core.h
> > > > > index 02d1a2d..f5af101 100644
> > > > > --- a/drivers/i2c/busses/i2c-designware-core.h
> > > > > +++ b/drivers/i2c/busses/i2c-designware-core.h
> > > > > @@ -83,6 +83,7 @@ struct dw_i2c_dev {
> > > > >
> > > > >  	u32			abort_source;
> > > > >  	int			irq;
> > > > >  	int			swab;
> > > > >
> > > > > +	int			access_16bit;
> > > >
> > > > ...
> > > > int?? Probably we are better off with making this as bool.
> > >
> > > I'm not a big fan of bool's. But I have no strong preference here.
> My
> > > reasoning here was consistency. As we already have "int swab" for a
> > > similar
> > > issue.
> >
> > If we have not done it earlier, doesn't mean that we repeat the same
> > mistake again. There is no reason to take access_16bit as an int when
> a bool
> > will suffice.
> >
> > This wastes storage and on some platforms (which have real crunch of
> memory),
> > such saving is critical.
> >
> > > So basically, I would prefer to not make the changes you suggested.
> But
> > > in the
> > > end its the decision of the maintainer(s).
> > >
> >
> > Linux is a collaborative world and patches can be reviewed by
> > literally anyone :)
> 
> Likewise, everyone can send patches to address issues that bother them.
> Want these ints turned into bools? Stop yelling at Stefan, and do it
> yourself. If it is so critical, no doubt you'll find reviewers to ack
> your patch and maintainers to apply it. And you'll even get the fame.

You missed the point completely..

We have done a thing in 'X' way but later we realize that 'Y'
is a better way of doing it and when we bring out something new
we still use the 'X' way and claim that it was always done that way
doesn't make sense. It's better to use 'Y' way for everything new
and gradually shift older stuff too..

> > I am sure the maintainer(s) will find my comments worth adding in
> your patch..
> 
> I'm not in charge of this specific driver, so I can't speak for the
> maintainer. And you shouldn't either...
> 

Yes of-course.
Let's wait for the maintainer(s) words.

Regards,
Bhupesh
