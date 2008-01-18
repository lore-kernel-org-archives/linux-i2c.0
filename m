From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-au1550: properly terminate zero-byte
	transfers
Date: Fri, 18 Jan 2008 08:33:35 +0100
Message-ID: <20080118083335.28fd387c@hyperion.delvare>
References: <20080114084652.GA15392@roarinelk.homelinux.net>
	<20080117165230.711e87bf@hyperion.delvare>
	<20080117163733.GA13110@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080117163733.GA13110-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, cd-8pe3aW1LYQvVtiohHAVwjA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Manuel,

On Thu, 17 Jan 2008 17:37:33 +0100, Manuel Lauss wrote:
> On Thu, Jan 17, 2008 at 04:52:30PM +0100, Jean Delvare wrote:
> > Hi Manuel,
> > 
> > This approach looks much nicer than your previous proposal. I like it.
> > Applied, thanks!
> 
> Thank you, however there's still the problem with unterminated bus xfers
> after receiving a NAK. I've only seen them with a PCA9539 if one's trying
> to access a non-existant register.  However it can't be solved to everyones
> satisfaction I'm afraid...
> (see http://mlau.at/files/i2c-au1550-stopfix-1-behav_2.png )

Indeed. As I understand it, the hardware simply offers no clean
solution to this problem, as you have to ask for the stop condition
before you send an address or data byte. As you can't foresee
transaction failures, you just can't ask for the stop condition before
the failure (or simply nack) happens. Which means that you either don't
send a stop condition at all (what the driver does now) or you send an
extra byte before the stop condition (slightly better but still not
perfect.) Or maybe you have to read the datasheet in details to find
out how to do the right thing, some chips can be very tricky in this
respect.

Anyway, I will take whatever patch you think will improve the situation
on this platform.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
