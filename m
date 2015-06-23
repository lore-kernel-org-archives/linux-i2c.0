From: christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org
Subject: Re: [PATCH] i2c: designware: use enable on resume instead initialization
Date: Tue, 23 Jun 2015 18:45:10 +0200
Message-ID: <OFB47A681B.5488F019-ONC1257E6D.005A6CD2-C1257E6D.005BD52F@alitech.com>
References: <1433785828-4100-1-git-send-email-lucas.de.marchi@gmail.com> <20150609085146.GD1478@lahna.fi.intel.com> <CAKi4VAJwD45VbWuCHegfkB-tbgvgza52-cgVNF4AxF8NCuYyRQ@mail.gmail.com> <20150610070722.GM1478@lahna.fi.intel.com> <OF847FFF39.1FF5F96A-ONC1257E60.00506AFD-C1257E60.0052A8CE@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <OF847FFF39.1FF5F96A-ONC1257E60.00506AFD-C1257E60.0052A8CE@LocalDomain>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org
Cc: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Fabio Mello <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

Christian Ruppert/ALi_GVA/ALi wrote on 10.06.2015 17:05:16:
> Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote on 10.06.
> 2015 09:07:22:
> > On Tue, Jun 09, 2015 at 03:29:01PM -0300, Lucas De Marchi wrote:
> > > Hi Mika,
> > > 
> > > On Tue, Jun 9, 2015 at 5:51 AM, Mika Westerberg
> > > <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > > > On Mon, Jun 08, 2015 at 02:50:28PM -0300, 
> lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > > >> From: Fabio Mello <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > >>
> > > >> According to documentation and tests, initialization is not
> > > >> necessary on module resume, since the controller keeps its state
> > > >> between disable/enable. Change the target address is also 
allowed.
> > > >>
> > > >> So, this patch replaces the initialization on module resume with 
a
> > > >> simple enable, and removes the (non required anymore) enables and
> > > >> disables.
> > > >>
> > > >> Signed-off-by: Fabio Mello <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > >> Signed-off-by: Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > >> ---
> > > >>
> > > >> These pictures explain a little more the consequence of letting 
the
> > > >> enable+disable in the code:
> > > >>
> > > >>       http://pub.politreco.com/paste/TEK0011-before.jpg
> > > >>       http://pub.politreco.com/paste/TEK0007-after.jpg
> > > >>
> > > >> The yellow line is a GPIO toggle in userspace to mark when we 
> > start and finish
> > > >> the i2c transactions.  The blue line is the SCL in that i2c 
> > bus. Take a look on
> > > >> the huge pauses we have between any 2 transactions.  These 
> > pauses are removed
> > > >> with this patch and we are able to read our sensor's values in 
> > 950usec rather
> > > >> than 5.24msec we had before.  We are testing this using a 
> > Minnowboard Max that
> > > >> has a designware i2c controller.
> > > >
> > > > Did you test this on any other platform than Intel Baytrail?
> > > 
> > > No. The only soc we have here with this controller is the Baytrail.
> > 
> > My concern is that this patch might break some non-Intel platform. It
> > would be nice if someone (Christian?) could try this out.
> 
> Ouch, this one brings back painful memories. Take a look at patch 
> 38d7fadef4973bb94e36897fcb6bb6a12fdd10c9 (https://git.kernel.org/
> cgit/linux/kernel/git/torvalds/linux.git/commit/?
> id=38d7fadef4973bb94e36897fcb6bb6a12fdd10c9) for the context.
> 
> In brief:
> - Before patch 38d7fade, the driver disabled the hardware after 
> successful transfers. I do not know the reason for this and I cannot
> judge whether this is necessary or not. I thus decided not to modify
> this behaviour in patch 38d7fade.
> 
> - After patch 38d7fade, the driver disabled the dw controller after 
> all transfers, in particular in the case of unsuccessful transfers. 
> This modification was necessary because of a race condition 
> triggered by an i2c slave device which interrupted transfers in the 
> middle. In this case, the dw controller (at least our version) seems
> to send spurious interrupts later if it is not disabled. The 
> interrupt handler is not designed to be called on already aborted 
> transfers, however, which leads to undesirable behaviour if the 
> interrupt occurs at the wrong moment (system hangs in irq loop).
> 
> I will try to dig out the test setup we used to validate the patch 
> at the time but given the fact that this was two years ago this 
> might take a little while. In the meantime, do you have any means to
> stress test the case of unexpected events on the bus (client aborts 
> transfer, timeout etc.)? An alternative might be to only disable the
> controller in the case of errors and leave it active after 
> successful transfers. We should understand why the controller was 
> disabled after successful transfers in the first place, however. 
> Maybe some quirk with older versions of the hardware? Mika, do you 
> have any memories about this?

As promised I tried to dig out the test setup we used to validate patch 
38d7fade at the time but without success. (I half expected that after such 
a long time...)

So I said to myself, let's give the patch a try nevertheless and see if it 
works in our system at least in the nominal case (no i2c bus errors).

The result is not very encouraging: Out of five (identical) designware i2c 
controllers we have on my test SOC, the first one initialises properly but 
the second one gets stuck in the famous irq loop right away when the 
module is enabled in i2c_dw_init. The system never gets around to try 
initialising the remaining three controllers due to the irq loop. I didn't 
have the time to investigate the details yet but I suspect this is 
triggered by some nastily behaved device on the bus. For example, some of 
our external devices are notorious for keeping i2c  lines tied to zero 
before being properly powered on/reset/initialised by their respective 
drivers (which in turn depend on the i2c master to be initialised first, 
obviously). I'll grab an oscilloscope and dump the waves to confirm this 
suspicion on the occasion.
However, similar situations might occur in multi-master setups (which we 
don't have). I suspect the driver/hardware to also end up in the irq loop 
after loosing arbitration with this patch. Has anybody the means to test 
this in a multi-master system?

Greetings,
  Christian
