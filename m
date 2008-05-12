From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Mon, 12 May 2008 09:25:33 -0700
Message-ID: <200805120925.33533.david-b@pacbell.net>
References: <200805012046.07885.david-b@pacbell.net>
	<200805111013.25440.david-b@pacbell.net>
	<20080512150512.1837e3e7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080512150512.1837e3e7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
> On Sun, 11 May 2008 10:13:25 -0700, David Brownell wrote:
> > On Saturday 10 May 2008, you wrote:
> > > > =A0
> > > > =A0static int ali1563_block_start(struct i2c_adapter * a)
> > > > @@ -170,7 +170,7 @@ static int ali1563_block_start(struct i2
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0data & HST_STS_BUSERR ? "=
No response or Bus Collision " : "",
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0data & HST_STS_DEVERR ? "=
Device Error " : "",
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0!(data & HST_STS_DONE) ? =
"Transaction Never Finished " : "");
> > > > -=A0=A0=A0=A0=A0return -1;
> > > > +=A0=A0=A0=A0=A0return -EIO;
> > > > =A0}
> > > =

> > > And same here. That's a little more work, admittedly.
> > =

> > Returning ENXIO for BUSERR/no-response doesn't follow your
> > heuristic of trusting the logspam-eliminators ... plus, it's
> > not clear that's not a different failure mode on that path.
> =

> Elsewhere in this driver there is:
> =

> 	/* device error - no response, ignore the autodetection case */
> 	if ((data & HST_STS_DEVERR) && (size !=3D HST_CNTL2_QUICK)) {
> 		dev_err(&a->dev, "Device error!\n");
> 	}
> =

> which makes it clear to me that HST_STS_DEVERR is what you get when no
> device acks a transaction. So returning -ENODEV would make sense.

In that case, yes.  That one is fixed.  (DEVERR and QUICK report
as ENXIO.)

But it looks like a case of bundling faults into one bit, ergo
my comment.  ONLY that case with QUICK is special cased per your
heuristic.  That other case isn't special cased... it could well
be exposing some *other* and more significant error.


> > NVidia seems to not have ALI 1563 specs on line (sigh) so
> > for now I'll just stick to your heuristic.
> =

> Not sure why nVidia would host ALi datasheets in the first place? Let
> alone the fact that nVidia is notoriously known to _not_ publish
> datasheets anyway :(

ALI renamed itself to ULI, and NVidia bought ULI.


> > I did make the "timeout" fault unique there, since that
> > fault was clearly distinguishable.
> =

> Agreed.
> =




_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
