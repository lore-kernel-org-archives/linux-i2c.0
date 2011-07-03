From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: i2c-ocores timeout bug
Date: Sun, 03 Jul 2011 22:31:15 +0200
Message-ID: <87pqlr14z0.fsf@macbook.be.48ers.dk>
References: <BANLkTikEESnV9+hc=VFg=qFGOXeg4o0sOQ@mail.gmail.com>
	<20110616185209.08ef41ed@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110616185209.08ef41ed-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare's
	message of "Thu, 16 Jun 2011 18:52:09 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Andrew Worsley <amworsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

Hi,

 >> Basically the i2c-ocores xfer function, kicks off an interrupt driven
 >> array of i2c_msg transfers and waits 1second for it to complete and
 >> just
 >> returns -ETIMEDOUT if it times out. The interrupt driven transfer is
 >> *not* stopped on a time out and continues referencing the i2c_msg
 >> structure. In my
 >> case an i2c read the interrupt handler keeps adding bytes to the
 >> structure. Unfortunately after the time out the structure was released
 >> and it's length field was changed to a large number and the interrupt
 >> driver kept happily writing bytes way past the end of the original
 >> buffer until the kernel crashed or locked up!
 >> 
 >> Below is a fix that works for me in 2.6.32 which removes the i2c_msg
 >> buffer from the interrupt handler and changes the handler to check for
 >> it's removal.

There's been some changes to the ocores drivers since then (mainly
device tree support) - It would be good with a patch that can be applied
to head.

 >> 
 >> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
 >> index 8dee246..21e57a0 100644
 >> --- a/drivers/i2c/busses/i2c-ocores.c
 >> +++ b/drivers/i2c/busses/i2c-ocores.c
 >> @@ -137,6 +137,12 @@ static void ocores_process(struct ocores_i2c *i2c)
 >> wake_up(&i2c->wait);
 >> return;
 >> }
 >> +       if (msg == 0) {
 >> +       /* Caller has with drawn the request, buffer no longer available */
 >> +           i2c->state = STATE_ERROR;
 >> +           oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
 >> +           return;
 >> +       }

I would prefer to send a stop here. You don't know in what context this
will get called (spurious inteerupts?). I also don't like adding extra
meaning i2c->msg when we have a perfectly fine state variable.

How about you instead set state to STATE_ERROR in ocores_xfer on
timeouts, and then directly send the stop condition (so not in the
isr). Otherwise you don't have any guarantee that the next transfer
isn't setup by the time the interrupt fires.

 >> 
 >> /* error? */
 >> if (stat & OCI2C_STAT_ARBLOST) {
 >> @@ -223,8 +229,13 @@ static int ocores_xfer(struct i2c_adapter *adap,
 >> struct i2c_msg *msgs, int num)
 >> if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
 >> (i2c->state == STATE_DONE), HZ))
 >> return (i2c->state == STATE_DONE) ? num : -EIO;
 >> -       else
 >> +       else {
 >> +               printk(KERN_NOTICE

WARNING seems more suitable here.

 >> +               "ocores_xfer() i2c transfer to %d-%#x timed out\n",
 >> +                       i2c_adapter_id(adap), msgs->addr);
 >> +               i2c->msg = 0; /* remove the caller's request which
 >> will be re-used */
 >> return -ETIMEDOUT;
 >> +       }
 >> }

-- 
Bye, Peter Korsgaard
