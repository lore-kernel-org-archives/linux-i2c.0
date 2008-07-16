From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping,
	otherwise kernel will oops
Date: Wed, 16 Jul 2008 16:20:20 -0600
Message-ID: <fa686aa40807161520rfaf056elcd2116b70371d95d@mail.gmail.com>
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
	<20080711182323.GB15321@secretlab.ca>
	<20080712080004.GA16739@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080712080004.GA16739-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jul 12, 2008 at 2:00 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Fri, Jul 11, 2008 at 12:23:23PM -0600, Grant Likely wrote:
>> On Fri, Jul 11, 2008 at 09:48:59PM +0400, Anton Vorontsov wrote:
>> > Firstly kernel warns at set_irq_chip, and then dies completely:
>> >
>> > Trying to install chip for IRQ-1
>> >
>> > diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
>> > index b2ccdcb..95a24de 100644
>> > --- a/drivers/of/of_i2c.c
>> > +++ b/drivers/of/of_i2c.c
>> > @@ -93,10 +93,8 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>> >             if (info.irq == NO_IRQ)
>> >                     info.irq = -1;
>>
>> What is the reason that info.irq is set to -1 in the first place?  This
>> looks like another bug to me.  Does something in the i2c layer depend on
>> the -1 value?
>>
>
> You already acked a fix to this :) I wasn't sure if my patch would
> make it on its own, as Jon Smirl was also working on fixes to of_i2c.c
> and he seemed to pick up this issue, too.

Ugh, I have trouble remembering what I've done from one day to the next.  :-/

After looking at it again, I'm inclined to prefer the NO_IRQ fix.
There is a smaller user base of of_i2c and so it will have a much
smaller impact if it breaks stuff.  It also has the added advantage of
encouraging people to actually fix the drivers that assume -1.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
