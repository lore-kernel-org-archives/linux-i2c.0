From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3] New-style I2C and SMBus EEPROM driver (with
 device_ids)
Date: Wed, 11 Jun 2008 21:41:35 +0200
Message-ID: <20080611214135.090ea690@hyperion.delvare>
References: <20080605193103.GA13062@pengutronix.de>
	<200806101402.44392.david-b@pacbell.net>
	<20080611090256.30031c79@hyperion.delvare>
	<200806111025.08951.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200806111025.08951.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Wed, 11 Jun 2008 10:25:08 -0700, David Brownell wrote:
> On Wednesday 11 June 2008, Jean Delvare wrote:
> > But then you wouldn't include arbitrary example platform data 
> > structures either, contrary to what your original proposal did.
> 
> Which version of "original" do you mean?  :)

I was thinking of
http://lists.lm-sensors.org/pipermail/i2c/2008-April/003307.html
but now I realize that it had already changes from Wolfram, so I was
confused, sorry.

> The idea you refer to was a simplification:  the driver wouldn't
> need to maintain lots of chip tables *plus* provide a per-chip
> override mechanism.  There'd be only platform_data, in all cases.

Such devices can never be created from user-space then (or maybe using
configfs? I really need to look into that). The nice thing about i2c
device names is that it makes devices easy to instantiate.

> The easy way would be to reference a predefined struct, which
> could easily be cloned and modified to address pagesize and
> write protection issues.  (Also the various EEPROMs that were
> not listed in the current tables.)

That's what I would like to avoid. I think that providing predefined
structures is dangerous. You have to look at two places to know what
you have exactly. If platform data is provided then I would like all of
it to be spelled out explicitly by the caller. Otherwise I expect some
confusion.

> The switch to use i2c_device_id seems to throw a monkey wrench
> in that plan.  Though I suppose it doesn't need to, except for
> the powerpc model whereby *only* client->name is available to
> distinguish parts, and platform_data is in the "not mentioned
> in polite society" category.  ;)

The switch to i2c_device_id has little to do here. We already had i2c
device names acting as sub-types. All it did was moving the name string
comparison from individual drivers to i2c-core.

> > I think 
> > that our decision whether to have default definitions in the driver,
> > depends on the answer to this question (and you'll know better than me.)
> 
> I don't quite follow your decision tree there.  Elaborate please?

My point is: if EEPROM parts can be swapped easily and manufacturers
do that, then platform code has to play it safe and always use the
smallest possible page size. That is, do exactly what plan on doing with
i2c_device_id entries. So it makes sense to have these entries
(platform code will use them.)

OTOH, if EEPROM parts are usually not swappable and the platform code
authors really knows what is there, then they will want to optimize the
platform data to use the best possible page size, meaning that the
i2c_device_id entries will, in general, not be used, and thus might not
be worth even defining.

An alternative approach would be to make all i2c_device_id entries
read-only EEPROMs (so the page size no longer matters) and anyone who
wants write access has to provide custom platform data.

As I wrote above, I never had to deal with writable EEPROMs myself, so
I'm really not the right person to make the decision. Leaving it up to
you and Wolfram.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
