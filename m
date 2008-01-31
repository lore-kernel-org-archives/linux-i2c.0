From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC PATCH 3/8] Add PCA9536 4 bit I2C GPIO extender
	support to the pca9539 GPIO driver
Date: Thu, 31 Jan 2008 03:49:41 -0800
Message-ID: <200801310349.41945.david-b@pacbell.net>
References: <Pine.LNX.4.64.0801231646090.4932@axis700.grange>
	<200801310248.41076.david-b@pacbell.net>
	<Pine.LNX.4.64.0801311204280.6494@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0801311204280.6494-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
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
To: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 31 January 2008, Guennadi Liakhovetski wrote:
> =

> > > So, actually, using my descriptor array is nearer to what it eventual=
ly =

> > > should become, I think. Under 2.6.26 you'd also, probably, just have =
a =

> > > "struct i2c_device_id *" member in your pca953x_chip.
> > =

> > Well, I was also pointing out that all you need is the number of GPIOs;
> > no need to save any ID struct at all. =A0These chips are VERY similar.
> =

> Ok, agreed, let's remove it then. For now I just use an array of structs =

> similar to i2c_device_id only to avoid a long sequence of strcmp calls in =

> probe() and compare the name in a loop. Is this alright?

Sure; it's your call on most such details, I just wanted clean patches.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
