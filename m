From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: Get rid of the legacy binding model
Date: Sat, 2 May 2009 11:16:54 -0700
Message-ID: <200905021116.54865.david-b@pacbell.net>
References: <20090502113856.39940f1e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090502113856.39940f1e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday 02 May 2009, Jean Delvare wrote:
> 1* In i2c_device_uevent() there is the following piece of code:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0/* by definition, legacy drivers can't hotplu=
g */
> =A0=A0=A0=A0=A0=A0=A0=A0if (dev->driver)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
>=20
> David, I presume this can go away?

Legacy drivers are going away, so ... yes.  :)


> 2* Core locking should be checked. I am not completely sure what
> core_lock was supposed to protect, nor what it should protect now. I
> think it should protect at least i2c_adapter_idr, driver->detect()
> calls (which may add a device to the driver->clients list) and
> driver->attach_adapter() calls (for the same reason), although for th=
e
> latter two, a per-driver lock may be more appropriate.

Protecting the IDR seems right to me.  I'd have to look at the
post-patches code to say more ... but for now I'll just say that
locking driver->*() calls seems less desirable than just making
sure the updates to clients_list are protected.  You should work
to minimize lock scope, so in general *drop* locks before calling
out from one module to another.  (Lots of nastiness comes from
the other module making calls that involve more locking...)


> At the moment, we also hold the lock for all of i2c_register_adapter(=
),
> i2c_del_adapter() and i2c_del_driver(), but not i2c_register_driver()=
,
> which seems a little inconsistent. David, do you know if we need to
> serialize the calls to device_register() and device_unregister(), or =
if
> the driver core takes care of this for us?

Driver core locking should eventually suffice for everything except
data structures directly managed by the I2C framework.

- Dave
