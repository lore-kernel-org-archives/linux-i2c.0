From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.27-rc7] i2c: guard against oopses from bad
	init sequences
Date: Wed, 24 Sep 2008 08:55:52 -0700
Message-ID: <200809240855.53043.david-b@pacbell.net>
References: <200809231138.19583.david-b@pacbell.net>
	<20080924115527.315d2968@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080924115527.315d2968-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Wednesday 24 September 2008, Jean Delvare wrote:
> Hi David,
> 
> On Tue, 23 Sep 2008 11:38:19 -0700, David Brownell wrote:
> > From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> > 
> > Guard I2C against oopsing because of init sequence problems...
> > 
> > Alternatively have postcore_initcall(i2c_init), which may
> > be better ... the initcall levels are pretty limited, and
> > in these cases the "subsystem" of interest builds on I2C
> > and needs to work before device_initcall.  Having I2C use
> > subsys_initcall kind of forces things into fs_initcall.
> > 
> > I'd encourage the anti-oopsing paranoia in any case, even
> > if i2c switches to postcore_initcall (or earlier).
> 
> I'm confused. If i2c_register_adapter() is called before i2c_init(),
> your patch prevents an oops, but things will still not work, right?

And it warns about exactly where the problem came from,
because of the WARN_ON.  That addresses a long-standing
debuggability problem which has afflicted these issues.


> So 
> this doesn't seem to add much value. In any case we need to fix the
> init sequence, so let's just do that.

I'll send in a separate patch switching the driver model init
to a postcore_initcall() -- it's not arch-specific and there
seems no reason to have it earlier.

Semi-related:  that module init/exit code is at a wierd place,
in the middle of that file ... vs the conventional location at
the end.  OK to change that?  In the same patch, or separate?

- Dave


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
