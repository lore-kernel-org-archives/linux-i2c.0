From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2.6.24.3] 24xx Eeprom driver
Date: Mon, 17 Mar 2008 12:53:50 +0100
Message-ID: <20080317125350.253cd04a@hyperion.delvare>
References: <47DE2ECB.6050609@elpa.it> <20080317092154.GA6159@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080317092154.GA6159-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: "ing. Davide Rizzo" <davide-Rm2/HqoNtBE@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 17 Mar 2008 10:21:54 +0100, Wolfram Sang wrote:
> it was already discussed that writing to EEPROMs will not be included in
> the mainline kernel (it creates the possibility to destroy RAM modules).

Not sure if you refer to something I said, but that's not exactly what
I said (or if I did, it no longer applied). I am fine with a driver
that allows writing to EEPROMs as long long as it is a new-style I2C
driver. What I don't want is a driver that binds automatically to
anything at address 0x50-0x57 and lets people write to it, because
users would inevitably break their hardware from times to times.

> 
> Besides, your driver uses the old I2C-binding model and other soon
> to-be-removed stuff like .id's.
> 
> You might also consider using David Brownell's AT24 driver:
> 
> http://lists.lm-sensors.org/pipermail/i2c/2007-May/001208.html
> 
> (Side note to David: I already worked on adding platform_data, just need
> to test it in a quiet minute.)
> 
> To all: Surely a lot of people need an eeprom driver with write
> capabilities, especially in the embedded world. I think it would be a
> good idea to make David's driver more visible. This wheel was probably
> reinvented too many times already (we also had a custom driver in our
> company). EEPROMs can be nasty, so one central driver would also be very
> good to collect all the quirks.

I totally agree (even though I still don't get what's wrong with the
user-space approach that has been working for years, with i2c-dev and
eeprog). The only thing that prevented me from merging David Brownell's
at24 driver is the lack of review and the lack of time to do the review
myself. But I really would like to have this driver upstream as soon as
possible if many people want to use it.

> To make a start I would suggest the following:
> 
> Give the AT24 driver a repository (my company would provide this, if
> wanted/needed). Place a comment in mainline/eeprom.c (and maybe
> Kconfig?) that an advanced driver exists at this repository.
> 
> Opinions? Especially David?

I'd rather have David's driver reviewed and merged (possibly tagged
EXPERIMENTAL) in 2.6.26. That's the best visibility it can get.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
