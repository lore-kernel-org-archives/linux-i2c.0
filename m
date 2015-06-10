From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: use enable on resume instead
 initialization
Date: Wed, 10 Jun 2015 10:07:22 +0300
Message-ID: <20150610070722.GM1478@lahna.fi.intel.com>
References: <1433785828-4100-1-git-send-email-lucas.de.marchi@gmail.com>
 <20150609085146.GD1478@lahna.fi.intel.com>
 <CAKi4VAJwD45VbWuCHegfkB-tbgvgza52-cgVNF4AxF8NCuYyRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKi4VAJwD45VbWuCHegfkB-tbgvgza52-cgVNF4AxF8NCuYyRQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas De Marchi <lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Fabio Mello <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 09, 2015 at 03:29:01PM -0300, Lucas De Marchi wrote:
> Hi Mika,
> 
> On Tue, Jun 9, 2015 at 5:51 AM, Mika Westerberg
> <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > On Mon, Jun 08, 2015 at 02:50:28PM -0300, lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> >> From: Fabio Mello <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >>
> >> According to documentation and tests, initialization is not
> >> necessary on module resume, since the controller keeps its state
> >> between disable/enable. Change the target address is also allowed.
> >>
> >> So, this patch replaces the initialization on module resume with a
> >> simple enable, and removes the (non required anymore) enables and
> >> disables.
> >>
> >> Signed-off-by: Fabio Mello <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >> Signed-off-by: Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >> ---
> >>
> >> These pictures explain a little more the consequence of letting the
> >> enable+disable in the code:
> >>
> >>       http://pub.politreco.com/paste/TEK0011-before.jpg
> >>       http://pub.politreco.com/paste/TEK0007-after.jpg
> >>
> >> The yellow line is a GPIO toggle in userspace to mark when we start and finish
> >> the i2c transactions.  The blue line is the SCL in that i2c bus. Take a look on
> >> the huge pauses we have between any 2 transactions.  These pauses are removed
> >> with this patch and we are able to read our sensor's values in 950usec rather
> >> than 5.24msec we had before.  We are testing this using a Minnowboard Max that
> >> has a designware i2c controller.
> >
> > Did you test this on any other platform than Intel Baytrail?
> 
> No. The only soc we have here with this controller is the Baytrail.

My concern is that this patch might break some non-Intel platform. It
would be nice if someone (Christian?) could try this out.
