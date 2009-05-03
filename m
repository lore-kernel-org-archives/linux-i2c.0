From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/6] i2c: Get rid of the legacy binding model
Date: Sun, 3 May 2009 09:25:06 +0200
Message-ID: <20090503092506.70e37de9@hyperion.delvare>
References: <20090502113856.39940f1e@hyperion.delvare>
	<20090502114020.41c38247@hyperion.delvare>
	<200905021203.43974.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200905021203.43974.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 2 May 2009 12:03:43 -0700, David Brownell wrote:
> On Saturday 02 May 2009, Jean Delvare wrote:
> > @@ -100,9 +100,8 @@ extern s32 i2c_smbus_write_i2c_block_dat
> > =A0 * @class: What kind of i2c device we instantiate (for detect)
> > =A0 * @attach_adapter: Callback for bus addition (for legacy driver=
s)
> > =A0 * @detach_adapter: Callback for bus removal (for legacy drivers=
)
>=20
> Remnants of the legacy model still remain ...

Depends on what exactly you call "the legacy model". As long as the
lifetime of the devices is those of the standard model, I don't much
care much about the rest.

At this point there are still a few drivers using attach_adapter, so we
can't get rid of it: 9 macintosh drivers, and i2c-dev. The fix for the
macintosh drivers would be to convert the powermac to fixed bus
numbers. This is probably not very difficult, but I'd rather let
powerpc people take care of that.

=46or i2c-dev, I just don't know. We could merge it into i2c-core. Or w=
e
could split the notification mechanism out of i2c_driver. Or maybe we
can leverage the driver core notification mechanism and get rid of
ours.

Either way this is probably not the highest priority change at this
point in time. I'd rather work on the sysfs replacement for
I2C_CLIENT_INSMOD* macros, the multiplexing support and the conversion
of i2c-adapter to bus devices first.

> > - * @detach_client: Callback for device removal (for legacy drivers=
)
> > - * @probe: Callback for device binding (new-style drivers)
> > - * @remove: Callback for device unbinding (new-style drivers)
> > + * @probe: Callback for device binding
> > + * @remove: Callback for device unbinding
> > =A0 * @shutdown: Callback for device shutdown
> > =A0 * @suspend: Callback for device suspend
> > =A0 * @resume: Callback for device resume

--=20
Jean Delvare
