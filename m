From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/03] i2c-i801: Add basic interrupt support
Date: Sun, 10 Aug 2008 22:08:03 +0200
Message-ID: <489F4AA3.3070101@gmail.com>
References: <488762A0.8030409@gmail.com>
	<20080810190522.76a61673@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080810190522.76a61673-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Hans de Goede <j.w.r.degoede-fbo2DhPpy/Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hey Jean,

Jean Delvare wrote:
> Ah, really great! Thanks for working on this :)
>
> Is there any inherent difficulty to get interrupts to work with HW PEC?
> And with I2C block transactions? Or did you just not get around to
> doing it?
>   
To be honoust: I don't know a thing about HW PEC and was not able to 
test it anyway. Therefor, I decided not to touch this part yet. I did 
try to add support for interrupts with I2C block transactions. This 
however caused various nasty problems.

That made me first want to test and implement basic interrupt support 
before going there again. When I know for sure the basics work correctly 
and stable (and when I know for sure I haven't made very stupid coding 
mistakes), I'll try again to add support for block transactions :).
> Yeah, Mark has been traveling a lot in time lately. Unfortunately this
> also means that we can't watch this archived post yet, it'll be a few
> more months before it shows up! ;)
>
> (Seriously, archives.andrew.net.au is the old list archive and
> apparently it has been discontinued, please use lists.lm-sensors.org
> instead.)
>   
Ugh, you _can't_ time travel yourself? ";p

(I used archives.andrew.net.au because that was the first hit on 
google... Anyway, here is the correct link: 
http://lists.lm-sensors.org/pipermail/lm-sensors/2004-November/009588.html )
> I've just given it a quick try on my old ICH3-M-based laptop and it
> seems to work fine there. The speed improvement compared to the polling
> code is very impressive.
>
> I'm going to do more tests on 2 other machines (with ICH5 and ICH7
> respectively) and will report when I'm done. A patch review will also
> follow.
>   
Thanks! Glad to hear I didn't kill your laptop :).
> The i2c-i801 driver has changed a lot since then. Any chance you could
> respin the patches against 2.6.27-rc2?
>   
Sure, I'll try to respin it as soon as possible. Hopefully, that will be 
tomorrow.
> Thanks,
>   
Ivo

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
