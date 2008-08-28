From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Fwd: [PATCH 2/3] I2C: at24: add kernel interface for
	reading/writing EEPROM
Date: Thu, 28 Aug 2008 14:19:47 -0700
Message-ID: <200808281419.47519.david-b@pacbell.net>
References: <200808251941.54964.david-b@pacbell.net>
	<200808270019.12987.david-b@pacbell.net>
	<9e4733910808270640h2e5fb88fn46548d3630b7f45d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910808270640h2e5fb88fn46548d3630b7f45d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 27 August 2008, Jon Smirl wrote:
> On 8/27/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > On Tuesday 26 August 2008, Trent Piepho wrote:
> >  > Lots of tv cards have eeproms with configuration information.  They =
use an
> >  > I2C driver called tveeprom that exports this:
> >  >
> >  > int tveeprom_read(struct i2c_client *c, unsigned char *eedata, int l=
en)
> >
> >
> > That presumes the driver somehow has access to that I2C client.
> =

> How about using bus_find_device? PowerPC uses it to locate the i2c
> device using pointers in the device tree.

Still making too many assumptions for my taste ... like using
I2C, and in this case also OF.  What I want is an approach that
can work with all the drivers with EEPROM and NVRAM support
that I've happenened on so far:

	drivers/i2c/chips/at24.c
	drivers/spi/chips/at25.c
	drivers/rtc/rtc-cmos.c
	drivers/rtc/rtc-ds1305.c
	drivers/rtc/rtc-ds1307.c
	drivers/rtc/rtc-ds1511.c
	drivers/rtc/rtc-ds1553.c
	drivers/rtc/rtc-ds1742.c
	drivers/rtc/rtc-m48t59.c
	drivers/rtc/rtc-stk17ta8.c

All those could easily export a (renamed) "struct at24_iface *" so
their persistent (and updatable) memory could be exported to kernel
code using the very same (simple) interface.

Discussion about how to use a different interface than what's shown
in the $SUBJECT patch seems to want to promote (a) each of those ten
drivers having a *different* interface exposed by EXPORT_SYMBOL(),
or else don't support in-kernel access at all, and (b) a bunch of
extra glue code to support it, like the OF-specific bits you showed
below and then going to the code that knows to use those bits to
get which device, and how to ask those devices for their data.

Moreover, IMO the basic question is still whether there is a good
reason not to build on the $SUBJECT patch.  (So far:  no.)

Sure it *could* be done differently -- especially if think (a) is
good but being able to reuse interfaces is bad -- but it's like
spending so much time choosing what color to paint the bikeshed
that the bikeshed itself never gets built...

- Dave

p.s. The only nontrivial technical issue I have with $PATCH is that
     "struct at24_iface" needs to cope better with "rmmod at24".
     An optional teardown(...) call would suffice.


> +static int of_dev_node_match(struct device *dev, void *data)
> +{
> + =A0 =A0 =A0 =A0return dev->archdata.of_node =3D=3D data;
> +}
> +
> +struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct device *dev;
> +=A0=A0=A0=A0=A0=A0=A0
> +=A0=A0=A0=A0=A0=A0=A0dev =3D bus_find_device(&i2c_bus_type, NULL, node,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 of_dev_node_match);
> +=A0=A0=A0=A0=A0=A0=A0if (!dev)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return NULL;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> +=A0=A0=A0=A0=A0=A0=A0return to_i2c_client(dev);
> +}
> +EXPORT_SYMBOL(of_find_i2c_device_by_node);
> +


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
