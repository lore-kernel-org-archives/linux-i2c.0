From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] [RFC] i2c: Don't wait for device release in
 i2c_del_adapter
Date: Wed, 14 Jan 2015 12:41:22 -0800
Message-ID: <20150114204122.GA31119@kroah.com>
References: <1421082050-10213-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150113152957.GL7660@katana>
 <20150114144938.4e3c3f52@endymion.delvare>
 <B2D57D11-FBC2-432A-90E8-90E4CF8F716C@konsulko.com>
 <20150114161525.49c54acc@endymion.delvare>
 <20150114162442.GB18578@roeck-us.net>
 <20150114181426.3a39791b@endymion.delvare>
 <6680B42A-76E8-40CF-9574-ECD00B40AE98@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6680B42A-76E8-40CF-9574-ECD00B40AE98-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 14, 2015 at 07:24:22PM +0200, Pantelis Antoniou wrote:
> I=E2=80=99ll try to dig around tomorrow and see what the real device =
reference counts
> are, but my hunch goes like this:
>=20
> MUX
> +=E2=80=94- ADAPTER
>     +=E2=80=94 DEV.
>=20
> Mux remove method is called, i2c_del_mux_adapter is called on all the=
 channels
> of the mux, calling in turn i2c_del_adapter which hangs on completion=
 of the
> dev_released.
>=20
> The call to device_unregister never calls the device_type callback (i=
2c_adapter_dev_release)
> because the reference count is not 1 at that point, someone else is h=
aving another
> reference.

Who has that reference?  It's not sysfs, right?  Or is it?  How is the
remove method being called, is that coming from a sysfs file?

Having that call "wait" for the other release call to happen is really
old, as Jean points out, from 2003.  We have "fixed" sysfs since then t=
o
detach the files from the devices easier, we used to have some nasy
reference count issues in that area.  Perhaps this isn't needed anymore=
,
I don't remember the i2c core code at all, that was a long time ago.

thanks,

greg k-h
