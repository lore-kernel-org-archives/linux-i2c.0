From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: i2c: introduce i2c helper i2c_find_client_by_name()
Date: Fri, 12 Jul 2013 13:35:51 +0200
Message-ID: <4066449.W80oPjbVFF@avalon>
References: <20130606183346.GA13259@bingao-desk1.fm.intel.com> <20130712110047.GA3135@katana> <CAHp75Ve8oLeT=-_t96i_ctcmnM4kEPHD0cBjBroJTnYxwczBmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75Ve8oLeT=-_t96i_ctcmnM4kEPHD0cBjBroJTnYxwczBmw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Gao <bin.gao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

On Friday 12 July 2013 14:29:16 Andy Shevchenko wrote:
> On Fri, Jul 12, 2013 at 2:00 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> >> Briefly looking into ACPI tables we have and mechanisms that we can
> >> use in ACPI case, I doubt we may apply all the ideas, probably some of
> >> them, though I didn't get yet where to read about in details. What I
> >> could say now is that the patch provided by Bin Gao is definitely no
> >> go.
> > 
> > Laurent explained to me what V4L did and now does. It used to be the way
> > tha V4L drivers did register I2C slaves according to platform_data. Now,
> > with DT the slaves get instanciated earlier, so they now use notifiers
> > to know when the slaves are in place. Something like this should
> > probably be done here, too, instead of unregistering and re-registering.
> 
> Yes, seems right way to go.
> I think ACPI case can use V4L2 async API somehow, though it has its
> own event model.
> I'll talk to Sakari Ailus to sync.

Do you have any pointer to the relevant parts of the ACPI specification ?

-- 
Regards,

Laurent Pinchart
