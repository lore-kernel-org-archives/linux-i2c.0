From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2.6.26.5] rtc-ds1307 : SMBus compatibility
Date: Sat, 11 Oct 2008 21:50:20 -0700
Message-ID: <200810112150.21370.david-b@pacbell.net>
References: <C1C62166118DFA4A8BBA01A2411F0D170E9BE59E27@PRI-MBX-101.dom1.vinci-energies.net>
	<20081010133344.653431af@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081010133344.653431af-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, BARRE Sebastien <sbarre-6lXSvc0s5hDQT0dZR+AlfA@public.gmane.org>
Cc: frederic Rodo <f.rodo-6YL8BHNr0ZqHdZQakrT3ElaPQRlvutdw@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday 10 October 2008, Jean Delvare wrote:
> Unfortunately your e-mail client replaced all tabs with spaces in the
> patch, so I can't apply it, which makes reviewing it much harder.
> Here's a first pass anyway, but please fix that and resend the patch in
> such a format that I (and other developers) can apply it.

... and test it.

At a quick glance, this looks like a sane conversion ... unlike the last
one proposed, which I had to NAK since it broke driver functionality by
trying to replace block transfers with non-equivalent byte-at-a-time ones.
(Clock updates between bytes, boom!)


> Note that while this patch deals with I2C, it affects an RTC driver so
> you should send it to the RTC subsystem maintainer (Alessandro, Cc'd)
> and mailing list. You might also want to get the last developers who
> touched the rtc-ds1307 driver to test your patch. I've Cc'd them as
> well.

Right.  As a rule, use GIT history to see who's maintaining code
when there's no MAINTAINERS entry.

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
