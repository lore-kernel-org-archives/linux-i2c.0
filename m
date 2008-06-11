From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v3] New-style I2C and SMBus EEPROM driver (with
	device_ids)
Date: Wed, 11 Jun 2008 10:25:08 -0700
Message-ID: <200806111025.08951.david-b@pacbell.net>
References: <20080605193103.GA13062@pengutronix.de>
	<200806101402.44392.david-b@pacbell.net>
	<20080611090256.30031c79@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080611090256.30031c79-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 11 June 2008, Jean Delvare wrote:
> Having only dealt with read-only EEPROMs so far, I wasn't aware that
> different incarnations of otherwise compatible EEPROMs could have
> different page sizes. This is indeed a problem.

In terms of getting the best bulk write performance, yes;
it's easily worth a factor of two or four.  I don't think
that will matter on all systems though.


> If you think that this 
> makes default types useless, then I am fine not having such default
> types (meaning that platform data would be mandatory, except for SPD
> EEPROMs.) 

By "default types" presumably you mean what I meant when I said
"least common denominator" settings?  Well, no -- not useless.

But it does ensure that some systems will want to provide more
specific settings.  The read-only flag has the same issue:  some
systems won't want to make it too easy for end-users to clobber
calibrations recorded during manufacturing.


> But then you wouldn't include arbitrary example platform data 
> structures either, contrary to what your original proposal did.

Which version of "original" do you mean?  :)

The idea you refer to was a simplification:  the driver wouldn't
need to maintain lots of chip tables *plus* provide a per-chip
override mechanism.  There'd be only platform_data, in all cases.

The easy way would be to reference a predefined struct, which
could easily be cloned and modified to address pagesize and
write protection issues.  (Also the various EEPROMs that were
not listed in the current tables.)

The switch to use i2c_device_id seems to throw a monkey wrench
in that plan.  Though I suppose it doesn't need to, except for
the powerpc model whereby *only* client->name is available to
distinguish parts, and platform_data is in the "not mentioned
in polite society" category.  ;)

 
> That being said... If almost compatible EEPROMs can be used in a 
> hardware design, differing only by the write page size, can the
> platform code author, in practice, really assume a page size greater
> than the minimum? That would assume the same specific incarnation of the
> EEPROM is always used. Is is common to have such a certainty?

In my observation, yes.  I don't happen to have observed anyone
swapping one vendor's part for another vendor's, even in newer
board revisions.  A bill-of-materials rarely changes much.

But that's more of a manufacturing issue than a software issue,
and I can easily *imagine* boards that are handled differently.

Some boards are designed to allow certain part substitutions,
and in theory that could be done for EEPROMs as well as flash
or RAM.  Or for discretes (resistors, capacitors, inductors,
diodes, FETs, etc).  Such capabilities should be designed in,
so a platform code author would know what the options are.


> I think 
> that our decision whether to have default definitions in the driver,
> depends on the answer to this question (and you'll know better than me.)

I don't quite follow your decision tree there.  Elaborate please?

- Dave



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
