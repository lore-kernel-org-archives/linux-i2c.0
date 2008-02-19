From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Complex I2C device
Date: Tue, 19 Feb 2008 15:23:48 +0100
Message-ID: <20080219152348.0cc481d5@hyperion.delvare>
References: <20080130144657.GA9444@enneenne.com>
	<Pine.LNX.4.64.0801302126150.6547@axis700.grange>
	<20080131091619.GI9444@enneenne.com>
	<20080219142133.2e022910@hyperion.delvare>
	<20080219141049.GD8190@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080219141049.GD8190-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 19 Feb 2008 15:10:49 +0100, Rodolfo Giometti wrote:
> On Tue, Feb 19, 2008 at 02:21:33PM +0100, Jean Delvare wrote:
> > =

> > Guennadi's solution (based on David Brownell's work) is actually pretty
> > generic as far as GPIOs are concerned. I like it.
> =

> If I well understand it I should use i2c_new_dummy() to simply create
> an handler for the alternate address.
> =

> > > =

> > > =

> > >                  +---------+
> > >            --+---+ Battery |
> > >              |   | Manager |
> > >              |   +---------+
> > >  Bus I2C ->> |
> > >              |
> > >              |
> > >              |   +---------+
> > >              +---+         |
> > >                  |  CHIP   |
> > >                  +---------+
> > > =

> > > A (complex) battery pack are managed by a "battery manager" and a
> > > custom chip connected by the I2C bus (my hardware designer _loves_ I2C
> > > bus :). Even these devices can be logically considered as only one
> > > (big) battery...
> > > =

> =

> In this situation into the driver of the =ABmain=BB device (the battery
> manager) I can use i2c_new_dummy() to get an handler to manage the
> other I2C chip. Is that right?

Yep, that's exactly the idea.

> It looks *really* good. :)

Credit go to David Brownell.

-- =

Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
