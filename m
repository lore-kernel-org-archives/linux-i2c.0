From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Problem with unstable i2c communication with i810 bus
 driver
Date: Tue, 20 May 2008 20:37:15 +0200
Message-ID: <20080520203715.68c502f3@hyperion.delvare>
References: <48321FD9.2010007@gmx.de>
	<20080520091807.071f1032@hyperion.delvare>
	<4832C0C8.2090401@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <4832C0C8.2090401-Mmb7MZpHnFY@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wilken Haase <Hibbelharry-Mmb7MZpHnFY@public.gmane.org>
Cc: i2c list <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wilken,

On Tue, 20 May 2008 14:15:04 +0200, Wilken Haase wrote:
> Badly I don't know of anymore devices connected to this bus.

You could probe the bus using i2cdetect. Just testing if i2cdetect works
will be a good test already.

> I do have the datasheets and read them multiple times just to be sure.
> The data sheet talks of needed delays.

What does it say exactly?

> I tried experimenting with udelay values at the right file and did slow
> the bus down, both values up to 150.

Note: values above 50 are not compatible with SMBus.

> But while dumping the chip slowed noticeably
> down i still got some bogus values back. Think that's maybe not the
> right idea.
> On another sidenote: I own another settopbox which is partly similar and
> also uses a fs454 scan konverter, but controlled by an intel i830 chipset.
> The fs454 is accessible without any problems there with the stock kernel
> driver. I really don't think the bus is multi mastered. Maybe this is a
> termination problem.

If the other system works OK with basically the same type of hardware,
then I indeed suspect a hardware defect on the failing box. Maybe try
to find out someone else with exactly the same box which is failing for
you, and see if it also fails for him/her?

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
