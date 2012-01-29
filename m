From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] (RESEND #2)  i2c: prevent spurious interrupt
Date: Sun, 29 Jan 2012 23:29:34 +0000
Message-ID: <20120129232934.GD8441@trinity.fluff.org>
References: <20120126161319.22798.6071.stgit@bob.linux.org.uk> <20120127092607.09ed312a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120127092607.09ed312a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 27, 2012 at 09:26:07AM +0100, Jean Delvare wrote:
> Hi Alan,
> 
> On Thu, 26 Jan 2012 16:13:34 +0000, Alan Cox wrote:
> > From: Kristen Carlson Accardi <kristen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > Don't call i2c_enable on resume because it causes a spurious
> > interrupt.
> > 
> > Signed-off-by:  Kristen Carlson Accardi <kristen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> > 
> >  drivers/i2c/busses/i2c-designware-pcidrv.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> Please come up with a decent subject line for this patch. Currently it
> sounds very generic so Ben will never look at it, assuming I will take
> care of it. But it is actually driver-specific, and that's a driver Ben

I agreee, the subject needs to be more specific to the driver it is
modifying. I would accept i2c-dw or i2c-designware as the start of
the subject.

Jean, thanks for clairfying ownership,

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
