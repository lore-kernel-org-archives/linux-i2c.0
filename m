From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Add support for the S-35390A RTC chip.
Date: Tue, 8 Jan 2008 14:01:24 +0100
Message-ID: <20080108140124.5ad4c46b@hyperion.delvare>
References: <1199573894-9189-1-git-send-email-byron.bbradley@gmail.com>
	<200801061425.38412.david-b@pacbell.net>
	<20080108130712.50613b02@hyperion.delvare>
	<200801080439.28135.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801080439.28135.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 8 Jan 2008 04:39:27 -0800, David Brownell wrote:
> On Tuesday 08 January 2008, Jean Delvare wrote:
> > =

> > > In fact it's common practice to adopt subsystem-specific conventions
> > > about what a given errno value indicates. =A0Otherwise, almost every
> > > fault observed would map to a small handful ... making them useless
> > > for fault recovery logic, and at best problematic in terms of any
> > > diagnostic utility.
> > =

> > A common practice to use random error codes
> =

> Hey, *I* didn't say "random error codes".
> =

> =

> > just to make sure they are =

> > unique? I don't think so, no. Resource not available is EBUSY, not
> > ENOCSI, period. Please fix your driver.
> =

> Actually, "address in use" is EADDRINUSE.  I made that change.
> =

> (Another reason to use oddball errno values is as a placeholder
> until a more appropriate one is found.)

OK, EADDRINUSE is equally fine with me.

-- =

Jean Delvare
