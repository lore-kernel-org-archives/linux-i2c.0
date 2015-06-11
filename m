From: Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: use enable on resume instead
 initialization
Date: Thu, 11 Jun 2015 11:48:51 -0300
Message-ID: <20150611144851.GA2407@vader.bz.intel.com>
References: <1433785828-4100-1-git-send-email-lucas.de.marchi@gmail.com>
 <20150609085146.GD1478@lahna.fi.intel.com>
 <CAKi4VAJwD45VbWuCHegfkB-tbgvgza52-cgVNF4AxF8NCuYyRQ@mail.gmail.com>
 <20150610070722.GM1478@lahna.fi.intel.com>
 <OF847FFF39.1FF5F96A-ONC1257E60.00506AFD-C1257E60.0052A8CE@alitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <OF847FFF39.1FF5F96A-ONC1257E60.00506AFD-C1257E60.0052A8CE-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Fabio Mello <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lucas De Marchi <lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 06/10, christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org wrote:
> Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote on 10.06.2015 
> 09:07:22:
> > My concern is that this patch might break some non-Intel platform. It
> > would be nice if someone (Christian?) could try this out.
> 
> Ouch, this one brings back painful memories. Take a look at patch 
> 38d7fadef4973bb94e36897fcb6bb6a12fdd10c9 (
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=38d7fadef4973bb94e36897fcb6bb6a12fdd10c9
> ) for the context.
> 
> In brief:
> - Before patch 38d7fade, the driver disabled the hardware after successful 
> transfers. I do not know the reason for this and I cannot judge whether 
> this is necessary or not. I thus decided not to modify this behaviour in 
> patch 38d7fade.
> 
> - After patch 38d7fade, the driver disabled the dw controller after all 
> transfers, in particular in the case of unsuccessful transfers. This 
> modification was necessary because of a race condition triggered by an i2c 
> slave device which interrupted transfers in the middle. In this case, the 
> dw controller (at least our version) seems to send spurious interrupts 
> later if it is not disabled. The interrupt handler is not designed to be 
> called on already aborted transfers, however, which leads to undesirable 
> behaviour if the interrupt occurs at the wrong moment (system hangs in irq 
> loop).

Yeah. So before we had:

 - sucessful transfer
   -> disable the adapter after complete
 - timeout transfer
   -> disable the adapter after complete

And your patch added the disable in case there wasn't a timeout but
dev->msg_err was set.


> I will try to dig out the test setup we used to validate the patch at the 
> time but given the fact that this was two years ago this might take a 
> little while. In the meantime, do you have any means to stress test the 
> case of unexpected events on the bus (client aborts transfer, timeout 
> etc.)? An alternative might be to only disable the controller in the case 
> of errors and leave it active after successful transfers. We should 
> understand why the controller was disabled after successful transfers in 

It seems pretty rad to disable the controller after each transfer.  It
may be due to previous revisions of the hw but may well be because of
"it was the simplest way to do it" at the time.  Disabling the
controller after each transfer even if successful. For unsuccessful
transfers we may want to disable it if there's a hw bug, but it would be
good to check this indeed.


> the first place, however. Maybe some quirk with older versions of the 
> hardware? Mika, do you have any memories about this?

I'm not sure if it's a hw bug or if it's just an oversight from previous
versions of this driver.  So adding a quirk with correct versions will
be difficult IMO.  We've been only testing this with well behaved
slaves.  Do you have any idea how to test the bad guys?  Maybe
connecting a slave with a long wire to introduce errors?


-- 
Lucas De Marchi
