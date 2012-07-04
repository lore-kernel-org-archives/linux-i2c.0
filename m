From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Consolidate polling
Date: Wed, 4 Jul 2012 13:47:19 +0200
Message-ID: <20120704134719.36e3b9e1@endymion.delvare>
References: <20120703101927.63336e65@endymion.delvare>
	<CAGS+omDC7voaYU2w1zZjCBmXssPQVdp_7YOH+Lgvv5=XTU0fzg@mail.gmail.com>
	<20120703153959.0e760660@endymion.delvare>
	<CAGS+omAT0G=BBGRs9H91ah=oZnaY-MHbvbADGOKTES_FbCjLjA@mail.gmail.com>
	<20120704094910.7e077e2d@endymion.delvare>
	<CAGS+omBhKcJe7jUE8=mxp7Dh-eJP9bF1+dU9gze3UeyQUQpq-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omBhKcJe7jUE8=mxp7Dh-eJP9bF1+dU9gze3UeyQUQpq-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 4 Jul 2012 16:08:25 +0800, Daniel Kurtz wrote:
> On Wed, Jul 4, 2012 at 3:49 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > On Wed, 4 Jul 2012 14:12:26 +0800, Daniel Kurtz wrote:
> >> On Tue, Jul 3, 2012 at 9:39 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> >> > @@ -272,7 +272,7 @@ static int i801_wait_intr(struct i801_pr
> >>
> >> "i801_wait_intr()" isn't such a good name anymore.  I recommend
> >> i801_wait_xfer_status(), or i801_wait_host_idle().
> >
> > i801_wait_intr() isn't such a bad name IMHO, we are still ideally hoping
> > that INTR will be set, as this means the transaction will be
> > successful. The name has the advantage of being symmetric with
> > i801_wait_byte_done(), so it's clear which one of the status bits we
> > are expecting.
> >
> > "i801_wait_host_idle" would be a good name too, but the actual name
> > doesn't really matter anyway, as the next patch merges both functions
> > into a single one. I had written this patch before you posted your
> > proposed changes, but it can still be applied on top of these (with the
> > usual context adjustment.) Unless you really don't like it? If so,
> > please tell me why.
> >
> >> >                 dev_dbg(&priv->pci_dev->dev, "INTR Timeout!\n");
> >>
> >> "Timed out waiting for transaction to complete!\n"
> >
> > My next patch already changes this to:
> >
> >                 dev_err(&priv->pci_dev->dev,
> >                         "Timeout waiting for %02x! (%02x)\n", wait_set, status);
> >
> > My message is more generic because the function is now generic, but the
> > information provided is more or less the same. If you think wording can
> > be improved, just let me know.
> 
> I'm really not sure this function is that necessary.  The code seems
> more confusing now with the two waits combined into a single function.
>  Keeping them separate also means you don't have to do extra work like
> passing "wait_cleared = 0" and making sure not to clear BYTE_DONE in
> the BYTE_DONE case.

You have a point, and this is the reason why I originally wasn't sure
myself if I wanted to do it. But it also allows for further cleanups. I
have a patch moving the call to i801_wait into i801_check_post (which
allows gcc to inline i801_wait) and another one merging i801_wait into
i801_check_post (which saves some intermediate work.) Each step may
not be very appealing nor convincing individually, but if you stack all
three, the diffstat looks like:

 drivers/i2c/busses/i2c-i801.c |   86 ++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 56 deletions(-)

And the binary comparison shows 274 bytes saved on x86_64, which isn't
negligible.

That being said... The last two steps are unlikely to fit well with your
interrupt patches. So I will postpone these cleanup/optimization
patches of mine for the time being. I started working on this because
of the performance regression introduced by one of your patches. Now
that this is solved, I should resume to my original goal which was
to get all your patches reviewed, tested and in linux-next as quickly
as possible. We can always discuss the rest later.

Thanks again for your time, I'll now reorder and cleanup the current
patch series, retest, and then move on to the two interrupt patches.

-- 
Jean Delvare
