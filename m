From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: dln2: simplify return flow for dln2_i2c_enable
Date: Mon, 17 Nov 2014 17:12:03 +0200
Message-ID: <CAE1zot+9-JMjKWST4VDifrjau=kXoxWB=GOHx06h8szwMwiCwg@mail.gmail.com>
References: <1415708457-18798-1-git-send-email-octavian.purdila@intel.com>
	<1415708457-18798-3-git-send-email-octavian.purdila@intel.com>
	<20141113162315.GC1275@katana>
	<20141117145651.GR24004@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141117145651.GR24004@x1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 17, 2014 at 4:56 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> On Thu, 13 Nov 2014, Wolfram Sang wrote:
>
> > On Tue, Nov 11, 2014 at 02:20:57PM +0200, Octavian Purdila wrote:
> > > This fixes the following kbuild test robot warning:
> > >
> > > >> drivers/i2c/busses/i2c-dln2.c:70:1-4: WARNING: end returns can be simplified if negative or 0 value
> > >
> > > Reported-by: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > Reported-by: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
> > >
> > > Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >
> > Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> >
> > Lee, I think it is easiest if you simply add it to the branch you have
> > for this driver. OK?
>
> Octavian indicated that he needs to send a v2 of the second patch.  I
> assume he will add your Ack to this patch when he does with a note
> saying that it needs to be added to the I2C IB.
>

Hi Lee,

Yes, I will to that, and add a couple more fixes from Dan Carpenter, a
little bit later tonight.
