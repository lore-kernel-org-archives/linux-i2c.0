From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [patch 3/3] i2c: add support for i2c bus on
	Freescale	CPM1/CPM2 controllers
Date: Sun, 1 Jun 2008 23:24:28 +0100
Message-ID: <20080601222428.GC6226@fluff.org.uk>
References: <200805142314.m4ENEjPV026316@imap1.linux-foundation.org>
	<20080519155443.GA4279@pengutronix.de>
	<20080519184907.651a4e48@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080519184907.651a4e48-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, htoa-hi6Y0CQ0nG0@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, tmbinc-hi6Y0CQ0nG0@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, May 19, 2008 at 06:49:07PM +0200, Jean Delvare wrote:
> Hi Wolfram,
> 
> > The dev_err-statements are too strong, IMHO. For example, the
> > at24-driver tries to write as fast as possible and may recieve a NACK,
> > then it will wait a bit and retry. I wouldn't call this NACK an error
> > then. I also wonder if it is worth a warning, as there is a timeout
> > message later on, which will be printed as dev_dbg only. As other
> > drivers I glimpsed at also don't write anything on NACK, maybe dev_dbg
> > consistency would be preferable.

dev_err() for a number of i2c bus errors are too strong, think about
the case where a system is having i2cprobe run on it (you will get a
lot of errors). It isn't as if the error is lost downstream anyway.

> > > +	return 0;
> > > +}
> 
> I agree that dev_err() on nack is too strong, most drivers log it at
> dev_dbg() level. However I fail to see the relation with timeout? A
> nack isn't a timeout. A timeout would be very wrong and should be
> reported with dev_err() I think.
> 
> Oh, BTW, nacks should be reported with -ENXIO according to:
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-document-standard-fault-codes.patch
> It might be worth checking that this new driver complies with these
> freshly adopted error codes standard.

Hmm, where ECONREFUSED or EPIPE (if NAK in already selected device)
entertained?


-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
