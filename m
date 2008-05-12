From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Mon, 12 May 2008 18:54:39 +0200
Message-ID: <20080512185439.1a9cf3c1@hyperion.delvare>
References: <200805012046.07885.david-b@pacbell.net>
	<200805111013.25440.david-b@pacbell.net>
	<20080512150512.1837e3e7@hyperion.delvare>
	<200805120925.33533.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805120925.33533.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Mon, 12 May 2008 09:25:33 -0700, David Brownell wrote:
> On Monday 12 May 2008, Jean Delvare wrote:
> > Elsewhere in this driver there is:
> > 
> > 	/* device error - no response, ignore the autodetection case */
> > 	if ((data & HST_STS_DEVERR) && (size != HST_CNTL2_QUICK)) {
> > 		dev_err(&a->dev, "Device error!\n");
> > 	}
> > 
> > which makes it clear to me that HST_STS_DEVERR is what you get when no
> > device acks a transaction. So returning -ENODEV would make sense.
> 
> In that case, yes.  That one is fixed.  (DEVERR and QUICK report
> as ENXIO.)
> 
> But it looks like a case of bundling faults into one bit, ergo
> my comment.  ONLY that case with QUICK is special cased per your
> heuristic.  That other case isn't special cased... it could well
> be exposing some *other* and more significant error.

Just to make sure it's clear: the Quick command case isn't special as
far as the returned error value is concerned. If nobody acks a Quick
command, that's still -ENXIO.

What is special about the Quick command is that we don't want to log the
error in this case, because it's used for detection purposes so it
happens frequently and it isn't something the user should worry about.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
