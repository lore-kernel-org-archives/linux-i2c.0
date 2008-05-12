From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Mon, 12 May 2008 10:08:52 -0700
Message-ID: <200805121008.52834.david-b@pacbell.net>
References: <200805012046.07885.david-b@pacbell.net>
	<200805120925.33533.david-b@pacbell.net>
	<20080512185439.1a9cf3c1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080512185439.1a9cf3c1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Monday 12 May 2008, Jean Delvare wrote:
> =

> > But it looks like a case of bundling faults into one bit, ergo
> > my comment. =A0ONLY that case with QUICK is special cased per your
> > heuristic. =A0That other case isn't special cased... it could well
> > be exposing some *other* and more significant error.
> =

> Just to make sure it's clear: the Quick command case isn't special as
> far as the returned error value is concerned. If nobody acks a Quick
> command, that's still -ENXIO.
> =

> What is special about the Quick command is that we don't want to log the
> error in this case, because it's used for detection purposes so it
> happens frequently and it isn't something the user should worry about.

Close...

The desired out come is that whenever the first address doesn't
get ACKed, we report ENXIO.  Arguably the same should be true of
the address byte after all repeated START bits too ... but then
we run into other error reporting problems.

Logging is orthogonal.  We don't want to log probing errors, as
a rule, and Quick is (for our purposes) basically about probing.

Then there's also the "what does this hardware bit mean" issue.
In this case, absent hardware docs, we're guessing in all cases
except for the QUICK case.  With only a few bits to report all
faults, it's clear there's some degree of fault bundling.  Ergo
my caution:  I didn't restructure all fault paths in that driver
to treat that one bit as if it only means "no address ACK", only
the one where it's clear that was how the driver interpreted it.

- Dave
 =


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
