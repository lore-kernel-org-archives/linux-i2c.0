From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC PATCH 3/8] Add PCA9536 4 bit I2C GPIO extender
	support to the pca9539 GPIO driver
Date: Thu, 31 Jan 2008 03:46:16 -0800
Message-ID: <200801310346.16424.david-b@pacbell.net>
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

> > > > This should IMO list the '38 (8-bit) and '37 (4-bit) parts too.
> > > > Same register layout as the '36 (4-bit). =A0Otherwise the "x" seems
> > > > misleading...
> > > =

> > > Ok, I don't want to look through all datasheets ATM, so, I'll just tr=
ust =

> > > you, ok?
> > =

> > OK by me. =A0The NXP website makes them easy enough to find, but
> > it's another one of those sites that tries to be too clever by
> > overusing JavaScript.
> =

> I'm actually adding 9534 (8-bit) and 9535 (16-bit) too atm, if you don't =

> mind:-)

Do they have the same register interfaces?  I looked at them a long
time ago, and don't recall.  If they have the same interface, then
more power to you!



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
