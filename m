From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 1/9] i2c: xiic: Do not continue in case of errors in Rx
Date: Wed, 17 Jun 2015 12:38:47 +0000
Message-ID: <4EED9C67BE3EF440A606099F8E34C52862BB72@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1434381480-3042-1-git-send-email-shubhraj@xilinx.com>
 <20150617114159.GA4604@schokonusskuchen.bad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150617114159.GA4604-oo5tB6JMkjKRinMKxDlMNPwbnWRJjS81@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Wolfram Sang [mailto:wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org]
> Sent: Wednesday, June 17, 2015 5:12 PM
> To: Shubhrajyoti Datta
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Shubhrajyoti Datta
> Subject: Re: [PATCH 1/9] i2c: xiic: Do not continue in case of errors in Rx
>
> Hi,
>
> On Mon, Jun 15, 2015 at 08:47:52PM +0530, Shubhrajyoti Datta wrote:
> > Handle error cases in the Rx path
> >
> > Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>
> Your patch descriptions need improvement. They describe what you do, but
> this can be seen in the patch as well. What you need to describe is WHY you
> need this change.

In case  the slave nacks the transaction in the middle of the transfer The driver continues.

> What was wrong before,

The usual expectation is that in case of error / nack the transaction is halted.

>what is better now.

There are 2 things my series does

1 . The interrupts were disabled in the start of the transfer and re-enabled again.
So if there are any error interrupts this will not be handled.

2. Secondly during the isr also the interrupts were disabled.
So if there is any nack in between that may not be respected.

3. I felt in case of all  errors we should
Call xiic_wakeup(i2c, STATE_ERROR); -> wake_up(&i2c->wait)
And come out of wait.


I made the patches speculatively after reading a bug report that says nacks are not
Respected in the middle of a transfer.

However do not have a peripheral that will nack in the middle of a transfer.
Could not test it in that sense.

> Because this driver is long in use, we must be very careful about regressions
> and every change needs a good reason.

I agree.

>
> So, please rework your patch descriptions.



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
