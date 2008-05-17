From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.26-rc1] i2c_use_client() defends against NULL
Date: Sat, 17 May 2008 11:53:04 -0700
Message-ID: <200805171153.04995.david-b@pacbell.net>
References: <200805041306.21074.david-b@pacbell.net>
	<200805170657.56833.david-b@pacbell.net>
	<Pine.LNX.4.58.0805171048070.4196@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0805171048070.4196-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
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
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Saturday 17 May 2008, Trent Piepho wrote:
> > > Passing NULL to the current functions would just crash, it wouldn't
> > > morph anything.
> >
> > That's only if you assume an MMU set up to cause oopsing on reference
> > to the first and last pages of memory. =A0Not the best of assumptions...
> =

> Maybe BUG_ON(!client) would be better? =A0It seems more likely to catch
> a programming error.

BUG_ON() is almost always the wrong answer though ... it's only
appropriate when there's no way for the system to continue.

And in fact, here it's *not* a bug...

Passing NULL around is more often OK than not.  Example, it's
expected that passing it to a "free this object" routine will
work, saving callers a NULL check.  Similarly, refcount calls.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
