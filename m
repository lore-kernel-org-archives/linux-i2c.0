From: "Amit Walambe" <amit.walambe-ymFC7zkAqBLaL3YF3Y4TSbVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH] fix i801_transaction() and ioctl return values
	for i2c-i801
Date: Tue, 17 Jun 2008 08:56:23 +0100
Message-ID: <20080617085623.30b61366@eurotech-ltd.co.uk>
References: <20080606124447.756f8262@eurotech-ltd.co.uk><20080608201828.18483a17@hyperion.delvare><20080609115656.27d37dc2@eurotech-ltd.co.uk><20080609152352.40f3b5eb@hyperion.delvare><loom.20080609T150250-626@post.gmane.org><20080614222635.15b41914@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080614222635.15b41914-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean!
Thanks a ton for your efforts! I will try my best to test these patches
and get back to you.
Thanks again.
- Amit

On Sat, 14 Jun 2008 22:26:35 +0200
"Jean Delvare" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Hi Amit,
> 
> Sorry for the late reply, I wanted to have some code to show before
> replying and it took longer to write than expected.
> 
> On Mon, 9 Jun 2008 15:27:50 +0000 (UTC), Amit Walambe wrote:
> > > I don't understand. You just said yourself that the problem didn't show
> > > on a 2.6.23 kernel, meaning that we somehow fixed the bug already, but
> > > still you want your patch to be applied?
> > My patch only waits till the busy bit clears. As you have said in your reply, it
> > adds unconditional delay of atleast 1 ms, but it avoided a few subsequent user
> > requests from failing.
> > I agree this happened on a very old kernel with vastly different behaviour, but
> > there is nothing in the current code to prevent it from happening. Still, I make
> > it your call if too cautious (but slow) patch is a good idea or not.
> > Please let me know if you think.
> 
> The slowdown caused by your patch is clearly not acceptable. It would
> be very easy to rewrite it to only delay as necessary. But the reason
> why I dislike your patch goes beyond this: I think it's broken by
> design. I can't see how it is different from simply changing the value
> of MAX_TIMEOUT from 100 to 200 as far as delay is concerned. And
> increasing MAX_TIMEOUT to 200 would have the added benefit that the
> first transaction would even succeed instead of failing (if the issue
> is that the transaction takes more time than the driver expects.)
> 
> Have you tried increasing MAX_TIMEOUT to 200 or even 500, to see if it
> would solve your problem?
> 
> > > For example, this patch:
> > >
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ca8b9e32a11a7cbfecbef00c8451a79fe1af392e
> > > seems pretty relevant to me, as it attempts to cleanly stop the
> > > controller on transaction timeout. It went into kernel 2.6.23.
> > This patch is useful to handle the failure that has occured (a new request fails
> > since controller is still busy with previous operation). But it doesn't avoid
> > this situation.
> 
> It is supposed to address exactly the problem you reported, by not
> leaving the controller in a busy state at the end of a "failing"
> transaction (where "failing" can mean "takes too long" too). Whether
> this actually works or not, is another story... I gave it a try today
> on an ICH5-based system, and the only error case I could test (SMBus
> block read with invalid size) was not recovered properly. The code
> looks good though, so maybe it's a hardware issue. I would really like
> to know if it works in your case.
> 
> > > I asked for the output of i2cdetect (i2cdetect 0 in your case), not
> > > i2cdetect -l. I wanted to have an idea what chips were present on the
> > > bus.
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00:          -- -- -- -- -- 08 -- -- -- -- -- -- -- 
> > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> > 20: 20 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> > 30: 30 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> > 40: -- -- -- -- 44 -- -- -- 48 -- -- -- -- -- -- -- 
> > 50: 50 -- -- -- 54 -- -- -- -- -- -- -- -- -- -- -- 
> > 60: -- -- -- -- -- -- -- -- -- 69 6a -- -- -- -- -- 
> > 70: -- -- -- -- -- -- -- --                         
> 
> I/O, EEPROM, thermal sensor, clock chips... lot of stuff on this bus!
> 
> > > One important thing to notice is that the driver is still doing
> > > something wrong in this area. If the host is found busy (bit 0 of the
> > > status register) the driver attempts to write 1 to that bit. Given that
> > > the bit in question is read-only, I'd say the chances that it works are
> > > thin... 
> > Ok, so the bit manipulation part is useless and wait part is only relevant.
> 
> Correct.
> 
> As you may have seen already, I've just sent the i2c-i801 patches I've
> been working on. The 4th one:
>   http://lists.lm-sensors.org/pipermail/i2c/2008-June/004070.html
> fixes the handling of the HOST_BUSY bit, amongst other error handling
> cleanups. It would be great if you could test it, although I understand
> that it might be difficult, or even impossible, if your customer has to
> stick to kernel 2.6.9. But one thing for sure, is that I won't take
> your patch, unless you test both kernel 2.6.25 and Linus' latest with
> my patches applied, and both keep failing in your situation.
> 


-- 
Amit Walambe
Design Engineer

Eurotech Ltd,
3 Clifton Court,
Cambridge CB1 7BN,
United Kingdom.

Tel: +44 (0)1223 403465 Direct
Tel: +44 (0)1223 411200 Switchboard
Fax: +44 (0)1223 410457
E-Mail: amit.walambe-ymFC7zkAqBLaL3YF3Y4TSbVCufUGDwFn@public.gmane.org
Web: http://www.eurotech-ltd.co.uk

Eurotech Ltd is a subsidiary of Eurotech S.p.A
VAT No. GB 314961067    Registered in England 1608562
Registered Office: 3 Clifton Court, Clifton Road, Cambridge CB1 7BN  UK

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
