From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 3/3] i2c: add support for i2c bus on Freescale
 CPM1/CPM2 controllers
Date: Mon, 19 May 2008 18:49:07 +0200
Message-ID: <20080519184907.651a4e48@hyperion.delvare>
References: <200805142314.m4ENEjPV026316@imap1.linux-foundation.org>
	<20080519155443.GA4279@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080519155443.GA4279-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, htoa-hi6Y0CQ0nG0@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, tmbinc-hi6Y0CQ0nG0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 19 May 2008 17:54:43 +0200, Wolfram Sang wrote:
> On Wed, May 14, 2008 at 04:14:45PM -0700, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org wrote:
> 
> Here is a more detailed review of this driver. After applying my fix, it
> worked fine on a MPC8260 + X24645 (EEPROM) + LM84 (Sensor) + RS5C372
> (RTC). I use this and the previous version for more than two weeks on a
> daily basis now.

Thanks for the review.

> > +	/* Set up the IIC parameters in the parameter ram. */
>
> Minor nit, in most cases within the driver I2C was preferred to IIC. Is
> there a preferred way, Jean?

"I2C" is preferred.

> > +	if (pmsg->flags & I2C_M_RD) {
> > +		dev_dbg(&adap->dev, "tx sc 0x%04x, rx sc 0x%04x\n",
> > +			in_be16(&tbdf->cbd_sc), in_be16(&rbdf->cbd_sc));
> > +
> > +		if (in_be16(&tbdf->cbd_sc) & BD_SC_NAK) {
> > +			dev_err(&adap->dev, "IIC read; No ack\n");
> > +			return -EIO;
> > +		}
> > +		if (in_be16(&rbdf->cbd_sc) & BD_SC_EMPTY) {
> > +			dev_err(&adap->dev,
> > +				"IIC read; complete but rbuf empty\n");
> > +			return -EREMOTEIO;
> > +		}
> > +		if (in_be16(&rbdf->cbd_sc) & BD_SC_OV) {
> > +			dev_err(&adap->dev, "IIC read; Overrun\n");
> > +			return -EREMOTEIO;
> > +		}
> > +		memcpy(pmsg->buf, rb, pmsg->len);
> > +	} else {
> > +		dev_dbg(&adap->dev, "tx sc %d 0x%04x\n", tx,
> > +			in_be16(&tbdf->cbd_sc));
> > +
> > +		if (in_be16(&tbdf->cbd_sc) & BD_SC_NAK) {
> > +			dev_err(&adap->dev, "IIC write; No ack\n");
> > +			return -EIO;
> > +		}
> > +		if (in_be16(&tbdf->cbd_sc) & BD_SC_UN) {
> > +			dev_err(&adap->dev, "IIC write; Underrun\n");
> > +			return -EIO;
> > +		}
> > +		if (in_be16(&tbdf->cbd_sc) & BD_SC_CL) {
> > +			dev_err(&adap->dev, "IIC write; Collision\n");
> > +			return -EIO;
> > +		}
> 
> The dev_err-statements are too strong, IMHO. For example, the
> at24-driver tries to write as fast as possible and may recieve a NACK,
> then it will wait a bit and retry. I wouldn't call this NACK an error
> then. I also wonder if it is worth a warning, as there is a timeout
> message later on, which will be printed as dev_dbg only. As other
> drivers I glimpsed at also don't write anything on NACK, maybe dev_dbg
> consistency would be preferable.
> 
> > +	}
> > +	return 0;
> > +}

I agree that dev_err() on nack is too strong, most drivers log it at
dev_dbg() level. However I fail to see the relation with timeout? A
nack isn't a timeout. A timeout would be very wrong and should be
reported with dev_err() I think.

Oh, BTW, nacks should be reported with -ENXIO according to:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-document-standard-fault-codes.patch
It might be worth checking that this new driver complies with these
freshly adopted error codes standard.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
