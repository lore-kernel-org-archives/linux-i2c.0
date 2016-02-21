From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 7/9] iio: imu: inv_mpu6050: Fix alignment with open
 parenthesis
Date: Sun, 21 Feb 2016 12:59:44 -0800
Message-ID: <1456088384.31061.2.camel@perches.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
	 <1455810794-3188-8-git-send-email-daniel.baluta@intel.com>
	 <56CA2101.8050805@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56CA2101.8050805-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ggao-ktqnL0SqcGIj5TC/SZClsA@public.gmane.org, adi.reus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org, mwelling-EkmVulN54Sk@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 2016-02-21 at 20:41 +0000, Jonathan Cameron wrote:
> On 18/02/16 15:53, Daniel Baluta wrote:
> > This makes code consistent around inv_mpu6050 driver and
> > fixes the following checkpatch.pl warning:
> > CHECK: Alignment should match open parenthesis
> >=20
> > Note that there were few cases were it was not possible to
> > fix this due to making the line too long, but we can live with that=
=2E
> >=20
> > Signed-off-by: Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Applied
[]
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/i=
io/imu/inv_mpu6050/inv_mpu_core.c
[]
> > @@ -217,11 +217,10 @@ static int inv_mpu6050_sensor_show(struct inv=
_mpu6050_state=A0=A0*st, int reg,
> > =A0	return IIO_VAL_INT;
> > =A0}
> > =A0
> > -static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
> > -			=A0=A0=A0=A0=A0=A0struct iio_chan_spec const *chan,
> > -			=A0=A0=A0=A0=A0=A0int *val,
> > -			=A0=A0=A0=A0=A0=A0int *val2,
> > -			=A0=A0=A0=A0=A0=A0long mask) {
> > +static int
> > +inv_mpu6050_read_raw(struct iio_dev *indio_dev,
> > +		=A0=A0=A0=A0=A0struct iio_chan_spec const *chan,
> > +		=A0=A0=A0=A0=A0int *val, int *val2, long mask) {

Ideally, you'd also convert this form to use
the open brace on a new line like:

static int
inv_mpu6050_read_raw(struct iio_dev *indio_dev,
		=A0=A0=A0=A0=A0struct iio_chan_spec const *chan,
		=A0=A0=A0=A0=A0int *val, int *val2, long mask)
{
