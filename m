From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Complex I2C device
Date: Tue, 19 Feb 2008 14:21:33 +0100
Message-ID: <20080219142133.2e022910@hyperion.delvare>
References: <20080130144657.GA9444@enneenne.com>
	<Pine.LNX.4.64.0801302126150.6547@axis700.grange>
	<20080131091619.GI9444@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080131091619.GI9444-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
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

Hi Rodolfo,

On Thu, 31 Jan 2008 10:16:19 +0100, Rodolfo Giometti wrote:
> On Wed, Jan 30, 2008 at 09:32:38PM +0100, Guennadi Liakhovetski wrote:
> > Hi Rodolfo,
> > =

> > On Wed, 30 Jan 2008, Rodolfo Giometti wrote:
> > =

> > > my custom board has a =ABcomplex=BB device... let me explain better: =
it's
> > > formed by a custom I2C device and an I/O extender PCA9539.
> > > =

> > > Ascii art:
> > > =

> > > =

> > >                 +---------+
> > >           --+---+         |
> > >             |   | PCA9539 |
> > >             |   +---------+
> > > Bus I2C ->> |      | | |
> > >             |      | | | <<--- GPIOs
> > >             |      | | |
> > >             |   +---------+
> > >             +---+         |
> > >                 |   CHIP  |
> > >                 +---------+  =

> > > =

> > > Some input GPIOs of CHIP are managed by the PCA9539. So fisically I
> > > have two devices but logically they are merged together into one.
> > > =

> > > I can send commands to CHIP by both I2C bus and the GPIOs, which in
> > > turn are controlled by the PCA9539.
> > > =

> > > Can you please suggest me the best way to manage this problem? My
> > > solution was to provide PCA9539's driver of some exported symbols and
> > > using them into the CHIP's driver. Is that right? Or, can I "call" (in
> > > any way) PCA9539 driver's methods from CHIP's driver?
> > =

> > First, you want to use gpiolib, which in -mm tree now lives under =

> > drivers/gpio and includes a driver for pca9539. With it the pca9539 dri=
ver =

> > registers a gpio controller with the system, and then your driver for t=
he =

> > other part can just request respective GPIOs as if they were normal CPU =

> > GPIOs or whatever else. And toggle them using the standard API. I will =

> > (hopefully tomorrow) post an example of exactly this to the =

> > video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org list. In my case this other chip is a CMOS =

> > camera.
> =

> Great, this would be a good solution for this scenario... but I'm
> looking something more "general". A related problem of mine is on
> another custom board which has the following:

Guennadi's solution (based on David Brownell's work) is actually pretty
generic as far as GPIOs are concerned. I like it.

> =

> =

>                  +---------+
>            --+---+ Battery |
>              |   | Manager |
>              |   +---------+
>  Bus I2C ->> |
>              |
>              |
>              |   +---------+
>              +---+         |
>                  |  CHIP   |
>                  +---------+
> =

> A (complex) battery pack are managed by a "battery manager" and a
> custom chip connected by the I2C bus (my hardware designer _loves_ I2C
> bus :). Even these devices can be logically considered as only one
> (big) battery...
> =

> Looking at I2C code, which uses the new style driver model, I see the
> function i2c_register_board_info() where we can specify the bus number
> and the devices list attached on that I2C bus, so I suppose we can add
> a function as:
> =

> 	struct i2c_client *i2c_find_client(int busnum, unsigned short addr);
> =

> which can return the i2c_client struct associated to the given bus
> number and i2c address.
> =

> This should resolve any possible problem related to every I2C
> "complex" device. Shouldn't it?

This would be doing things the wrong way around IMHO. Assuming that
there is no clean interface between both physical components of your
complex logical device, that would make a GPIO-like solution possible,
what you really have is a single device with 2 I2C addresses. We
support this already thanks to the i2c_new_dummy() function, so I see
no need for an additional interface.

-- =

Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
