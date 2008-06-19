From: "Eric Brower" <ebrower-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: multi-master lost-arbitration improvement
	for i2c-algo-pcf (take 2)
Date: Wed, 18 Jun 2008 17:59:00 -0700
Message-ID: <ec7cefb0806181759n56229fbdga0aaa0b6060a6c3f@mail.gmail.com>
References: <ec7cefb0806121410g154b546dx1cb2562898dba4b6@mail.gmail.com>
	<20080613090746.0008ed77@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080613090746.0008ed77-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Daniel Smolik <marvin-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 13, 2008 at 12:07 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Eric,
>
> Thanks for the updated patch.
>
> On Thu, 12 Jun 2008 14:10:03 -0700, Eric Brower wrote:
>> Attached is a revised patch to provide enhanced multi-master
>> arbitration support for i2c-algo-pcf.  The initial patch was
>> commented-on about 10 months ago, so I've included the prior mail
>> below for reference and interspersed my comments.  I am not a member
>> of this list, so please copy me directly on replies.  The attached
>> patch has been tested against a fairly recent Linus 2.6 GIT tree.
>>
>> Ref: http://lists.lm-sensors.org/pipermail/i2c/2007-August/001690.html
>>
>> Commit text:
>> Improve lost-arbitration handling of PCF8584.  This is necessary for
>> support of a currently out-of-kernel driver for Sun Microsystems E250
>> environmental management; perhaps others.
>> Signed-off-by: Eric Brower <ebrower at gmail.com>
>>
>> Daniel, please ACK if you are comfortable doing so.
>>
>> >> +static inline void handle_lab(struct i2c_algo_pcf_data *adap, const int *status)
>> >> +{
>> >> +  DEB2(printk(KERN_INFO
>> >> +          "i2c-algo-pcf.o: lost arbitration (CSR 0x%02x)\n",
>> >> +           *status));
>> >> +  /* Cleanup from LAB-- reset and enable ESO.
>> >> +   * This resets the PCF8584; since we've lost the bus, no
>> >> +   * further attempts should be made by callers to clean up
>> >> +   * (no i2c_stop() etc.)
>> >> +   */
>> >> +  set_pcf(adap, 1, I2C_PCF_PIN);
>> >> +  set_pcf(adap, 1, I2C_PCF_ESO);
>> >> +  /* We pause for a time period sufficient for any running
>> >> +   * I2C transaction to complete-- the arbitration logic won't
>> >> +   * work properly until the next START is seen.
>> >> +   * It is assumed the bus driver or client has set a proper value.
>> >> +   */
>> >> +  if (adap->lab_mdelay) {
>> >> +          mdelay(adap->lab_mdelay);
>> >> +  }
>> >
>> > Out of curiosity: on what basis will the value of lab_mdelay be chosen
>> > by the driver author? This seems to be pretty arbitrary, as you don't
>> > know what kind of transactions the other master is doing. The
>> > underlying question being: is it worth having a per-adapter parameter
>> > for this, as opposed to a hard-coded value?
>>
>> The driver (bus adapter) author shall select a value that is longer
>> than the longest start/stop bus transaction possible by either master.
>>  This is not entirely arbitrary, and can be determined by snooping the
>> i2c bus.  Unfortunately, for proper lost-arbitration functionality
>> with PCF8584 you must determine a sufficient value.  This is described
>> in the Philips/NXP AN96040 document:
>>
>> "Attention ! In both cases, the PCF8584 is not able to recognise that
>> there is still an ongoing
>> transmission. In order to prevent another arbitration problem the
>> controlling software should
>> wait for a time, longer than the longest message which can be sent
>> over the bus, before trying
>> to access the bus again."
>>
>> The parameter should be per-adapter, not hard-coded, for the above reason.
>>
>> Here's an example of a bus driver (i2c-envctrl) setting a desired value:
>>
>> static struct i2c_algo_pcf_data pcf_envctrl_data = {
>>         .setpcf     = pcf_envctrl_setbyte,
>>         .getpcf     = pcf_envctrl_getbyte,
>>         .getown     = pcf_envctrl_getown,
>>         .getclock   = pcf_envctrl_getclock,
>>         .waitforpin = pcf_envctrl_waitforpin,
>>         .udelay     = 10,
>>         .timeout    = 100,
>>         /*
>>          * This could be made dynamic based upon get_clock(), but
>>          * we know clock does not change within this implementation, so:
>>          * 10,000 uSec per bit (@100kHz) * 9 bits/byte * 3 trans
>
> FWIW, 100 kHz is 10 us per bit, not 10,000. But anyway, assuming 100
> kHz is dangerous (slaves can stretch the clock to slow it down) and
> most transactions take more than 3 bytes. And you're not counting the
> time taken by possible repeated start and stop signals. A more
> reasonable computation would be: 100 us * (9 bits/byte * 36 bytes + 2)
> = 32.6 ms. So a sane default for lab_mdelay would be 33.

Thanks for catching that; I'll update our out-of-kernel driver to be
less egregious on the timing.

>
>>          */
>>         .lab_mdelay = 270,
>>  };
>>
>>
>> >
>> > Also, it seems to me that you could sleep here. If you sleep a bit
>> > longer than expected, it shouldn't be a problem, right?
>>
>> Not a problem.  The pause is only intended to ensure at least
>> "lab_mdelay" msecs prior to the next attempt to use the bus.  This
>> gives the internal state machine of PCF8584 sufficient time to see a
>> stop or start sequence on the bus.
>
> You said "not a problem" but you did not change the code? It's still
> using mdelay rather than msleep. msleep would be more reasonable, you
> really have no reason to keep the CPU busy while waiting for the other
> master to complete his transaction. I'm doing this change.

I recall the reason.  On this implementation (Sun envctrltwo), i2c
components are used in interrupt context (environmental monitoring
interrupts are ack'ed by reading a PCF8574).  This is not really
within the design of the in-kernel I2C subsystem (due to use of
mutexes in i2c_transfer), but we've managed to wrap all accesses to
i2c with spinlocks-- ugly, but it lets us work.  I'm not sure if there
is any work going on to address this drawback, or if any other
consumer needs in_interrupt access as my driver does.  As an aside,
this out-of-kernel driver was done as a proof-of-concept to remove
existing drivers (prior to the i2c subsystem) that do their own I2C;
you decide which is worse. :)

My preference is to mdelay() here, so we don't exacerbate the issue of
sleeping code in the i2c subsystem.  A few bus drivers do this, but
that is fine-- the bus drivers understand the platform well enough to
know this is safe for them.  No (other) algo drivers do this.

If you object, perhaps we can implement a callback in i2c-algo-pcf
rather than an mdelay value.  A default value could msleep for some
arbitrary time period (as you have suggested), or can be reassigned to
mdelay().

Given the infrequency of lost arbitration, and the lack of any other
consumers of lab_mdelay in i2c-algo-pcf, I'm voting for mdelay rather
than a callback implementation.

>
>> > As a side question, shouldn't i2c-algo-pcf retry, rather than fail, on
>> > arbitration lost?
>>
>> It is not a safe assumption that a command (or series of commands) can
>> be re-tried after arbitration is lost.  A convenience function or
>> setting in the driver may be worthwhile for cases where the consumer
>> knows the action to be safe, but I would divorce such an enhancement
>> from this proposed patch.
>
> Agreed. In a recent discussion it was decided to return -EAGAIN on lost
> arbitration and let the caller decide what to do:
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-document-standard-fault-codes.patch
> So you could prepare and send a second patch doing that.

Yes, I'll do so-- thank you.

>
>> Thank you again for your consideration.  Apologies for the tardiness of a reply.
>
> Better late than never :) I'll apply the patch with the change
> mentioned above, thanks.
>
> --
> Jean Delvare
>



-- 
E

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
