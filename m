From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH][RESEND] i2c-i801: Add basic interrupt support
Date: Sat, 16 Aug 2008 20:33:47 +0200
Message-ID: <20080816203347.0af81c5b@hyperion.delvare>
References: <48A33E77.7060502@gmail.com>
	<20080816155856.2e0bcf4c@hyperion.delvare>
	<48A6FECC.8020801@gmail.com>
	<20080816185013.30fcf4ee@hyperion.delvare>
	<20080816194147.7c0a11dc@hyperion.delvare> <48A715FE.80802@hhs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48A715FE.80802-fbo2DhPpy/Q@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Hans de Goede <j.w.r.degoede-fbo2DhPpy/Q@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Hans,

On Sat, 16 Aug 2008 20:01:34 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > On Sat, 16 Aug 2008 18:50:13 +0200, Jean Delvare wrote:
> >> On Sat, 16 Aug 2008 18:22:36 +0200, Ivo Manca wrote:
> >>> Great and thanks. Am really curious about the stability of this code :)
> >> I'm hitting the first problems, with SMBus block transactions. They
> >> fail on my ICH3 with use_irq=1. That's strange because these
> >> transactions shouldn't make use of interrupts on the ICH3, but I still
> >> see the IRQ handler being called 3 times, and then the transaction
> >> times out. I'm debugging this now.
> > 
> > OK, I see what's going on. On this laptop, IRQ 9 is used by many
> > things, not just SMBus. So the interrupt handler keeps being called even
> > without SMBus activity or with polled-based SMBus activity. That's what
> > happens during SMBus block transactions: the interrupt handler is
> > called but not for us. However the interrupt handler thinks it is
> > called by us and clears the status register value. This causes the
> > polled-based loop to wait forever: by the time it looks for the status
> > register value, it has been cleared.
> > 
> > So we need to change the code in either of three ways:
> > * Drop support for byte-by-byte block transactions.
> > * Inhibit the interrupt handler during polled-based block transactions.
> > * Convert the byteb-by-byte block transaction code to use interrupts
> >   instead of polling.
> > The latter would be cleaner, but that's also more work.
> > 
> 
> Erm, is this testing with or without your merging of the status flags defines? 
> Maybe that is causing this?

This is indeed with my merging of the status flag defines. But the
problem would happen regardless: the interrupt handler resets all the
status flags if any flag of I801_HST_STS_MASK_ALL, not just
I801_HST_STS_MASK_NORM, is set.

You might argue that the interrupt handler could be modified to only
reset the flags it knows about, i.e. I801_HST_STS_MASK_NORM. This is
probably correct, but even then, it doesn't feel safe to have an
interrupt handler triggered while poll-based code operated on the same
register values.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
