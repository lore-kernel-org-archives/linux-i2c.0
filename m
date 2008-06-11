From: "Amit Walambe" <amit.walambe-ymFC7zkAqBLaL3YF3Y4TSbVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH] fix i801_transaction() and ioctl return values
	for i2c-i801
Date: Wed, 11 Jun 2008 09:15:55 +0100
Message-ID: <20080611091555.276b8429@eurotech-ltd.co.uk>
References: <20080606124447.756f8262@eurotech-ltd.co.uk>
	<20080608201828.18483a17@hyperion.delvare>
	<20080609115656.27d37dc2@eurotech-ltd.co.uk>
	<20080609152352.40f3b5eb@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080609152352.40f3b5eb-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 9 Jun 2008 15:23:52 +0200
"Jean Delvare" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Hi Amit,
Hi Jean!
The gmane website or my company's emailing system is acting up. I am
receiving emails very late and my postings are not showing up.
So, I am resending my reply.
 
> I don't understand. You just said yourself that the problem didn't show
> on a 2.6.23 kernel, meaning that we somehow fixed the bug already, but
> still you want your patch to be applied?
The problem not appearing on newer kernels can be a function of
different latency behaviour. There is no code in the driver to handle
the situation. Current driver will return failure for a new request if
it finds host controller busy with previous one; which is not
acceptable in our case. Hence a patch to simply wait till the
operation completes.

I think this discussion basically boils down to whether the driver
should complete the current operation or just start it and return,
hoping to have it finished before the next request arrives. 

> For example, this patch:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ca8b9e32a11a7cbfecbef00c8451a79fe1af392e
> seems pretty relevant to me, as it attempts to cleanly stop the
> controller on transaction timeout. It went into kernel 2.6.23.
This patch handles the case when actual command fails (by aborting the
command). What if, as in our case, resetting of status bits takes long?

Why such a simple operation is taking long is something I don't know (but 
I am sure no other operation is being carried out).

> i2cset supports this functionality since October 2004.
I didn't look into it. Apologies!

> I asked for the output of i2cdetect (i2cdetect 0 in your case), not
> i2cdetect -l. I wanted to have an idea what chips were present on the
> bus.
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: 20 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: 30 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- 44 -- -- -- 48 -- -- -- -- -- -- -- 
50: 50 -- -- -- 54 -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- 69 6a -- -- -- -- -- 
70: -- -- -- -- -- -- -- --                         

> Please note that "resetting" is not really the correct term for what
I used "resetting the status bits" somewhere else in the message.
Shouldn't have used 'reset' interchangeably.

> As written above, I think your problem is already fixed in 2.6.23 so no
> patch is needed. I wouldn't want your patch as is anyway, as it adds a
> sleep unconditionally, making the driver twice as slow as the original
> code.
ok. I am not insisting it goes mainline. I understand your concerns. Please 
suggest if you can think of a better way to handle this condition.

> One thing that might still be worth investigating is why some
> transactions do not complete in the first place.
> 
> This might be related to the fact that the timeout loop was written
> with HZ=100 in mind and is broken by design. It timeouts in count (100,
> where all but one drivers have 500), not time. Depending on various
> parameters (amongst which the value of HZ), the actual time it waits
> for is very different. At HZ=100 it was typically 2 seconds, but at
> HZ=1000 it would be 200 ms, which isn't that much. Although at 16 kHz,
> a 32-byte I2C block read transaction would take 20 ms if I count
> correctly, so it still fits.
I will investigate more on the line of the above suggestions. Thanks! Any 
pointers for the first one (as to why resetting the status bits is taking
this long) would be more than welcome.

Thanks a lot for the help!
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
