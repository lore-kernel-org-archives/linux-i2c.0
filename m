From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa.c recover from false start
Date: Tue, 24 Jun 2008 18:03:07 +0200
Message-ID: <20080624180307.6de9d47d@hyperion.delvare>
References: <36A8B4824CA88E478F1A25136D0597610112DD04@mail.ad.skymv.com>
	<20080619134237.3b7dff53@hyperion.delvare>
	<36A8B4824CA88E478F1A25136D0597610112DEAE@mail.ad.skymv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <36A8B4824CA88E478F1A25136D0597610112DEAE-RKsfjrak5bi0VCHWTNMfawC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Chuck Kamas <ckamas-mizZ2TCXIxVBDgjK7y7TUQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Chuck,

On Thu, 19 Jun 2008 09:02:49 -0700, Chuck Kamas wrote:
> I have to disagree with you on the hardware issue.  The i2c bus must be
> able to recover from any and all issues.

Definitely not. To go to an extreme example, you're not going to recover
from a nuclear attach aimed at your PXA system ;) More seriously, we
only want to make our drivers robust to problems which can reasonably
happen. Otherwise the code would be slow and unmaintainable.

>                                           The fact that a hot plug is
> how I discovered this issue does not mean that that is the only why for
> the PXA to get locked up.  I can think of a few more: ESD, RFI, bus
> glitch...

My time to disagree. You should protect your system from physical
interferences at the hardware level. Compensating poor hardware design
with software workarounds is a bad practice.

You mentioned the device hot-plug as the reason why you wanted this
patch to be applied, I didn't. Now you mention other reasons why this
patch should still be applied, but I suspect you haven't experienced
any of these.

>         You are correct that the patch should look for another master
> talking on the bus before resetting itself. If another master is using
> the bus we have a few scenarios.  1) He is talking to us and we are a
> slave, in which case we would not time out because our slave process
> would be taking care of business. 2) He is talking to another.  In this
> case we can reset our engine/HW without fear of upsetting that traffic.
> I believe your concern is that resetting our engine/HW will interfere
> with the traffic.  If this is true we have another problem to contend
> with.

I am not familiar with the PXA hardware, so I don't know what really
happens when you reset the engine. I can imagine though that you lose
the notion that the bus is busy, as this is typically done by detecting
start and stop conditions on the bus. So I presume you could start a new
transaction while the bus is already in use. No good.

>     3) There is no one talking on the bus and our HW is in a bad
> state.  This is the case I am trying to cover.

But by doing so, I suspect that you're breaking case 2) which is
legitimate and more likely to happen. That's the reason why I don't
want to apply your patch.

> As to the time out issue, we should use the smbus' specification as our
> guide.

Not all I2C devices comply with the SMBus specification, so you have to
be careful if you go that route. I'm not too sure what you had in mind
anyway.

If something really needs to be done, please discuss this with someone
familiar with the i2c-pxa driver, and come up with a proper patch
explaining what it does, why, and why it is correct.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
