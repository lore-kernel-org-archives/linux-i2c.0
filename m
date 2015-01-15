From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] [RFC] i2c: Don't wait for device release in i2c_del_adapter
Date: Thu, 15 Jan 2015 18:25:22 +0200
Message-ID: <E91AA1C8-64EE-4111-94BD-B8F05071D507@konsulko.com>
References: <1421082050-10213-1-git-send-email-pantelis.antoniou@konsulko.com> <20150113152957.GL7660@katana> <20150114144938.4e3c3f52@endymion.delvare> <B2D57D11-FBC2-432A-90E8-90E4CF8F716C@konsulko.com> <20150114161525.49c54acc@endymion.delvare> <20150114162442.GB18578@roeck-us.net> <20150114181426.3a39791b@endymion.delvare> <6680B42A-76E8-40CF-9574-ECD00B40AE98@konsulko.com> <20150114204122.GA31119@kroah.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150114204122.GA31119-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Greg,

> On Jan 14, 2015, at 22:41 , Greg Kroah-Hartman <gregkh@linuxfoundatio=
n.org> wrote:
>=20
> On Wed, Jan 14, 2015 at 07:24:22PM +0200, Pantelis Antoniou wrote:
>> I=E2=80=99ll try to dig around tomorrow and see what the real device=
 reference counts
>> are, but my hunch goes like this:
>>=20
>> MUX
>> +=E2=80=94- ADAPTER
>>    +=E2=80=94 DEV.
>>=20
>> Mux remove method is called, i2c_del_mux_adapter is called on all th=
e channels
>> of the mux, calling in turn i2c_del_adapter which hangs on completio=
n of the
>> dev_released.
>>=20
>> The call to device_unregister never calls the device_type callback (=
i2c_adapter_dev_release)
>> because the reference count is not 1 at that point, someone else is =
having another
>> reference.
>=20

=46irst of all, my head hurts. Tracking device references ain=E2=80=99t=
 easy. Is there some kind
of debugging method you=E2=80=99d recommend for this?

> Who has that reference?  It's not sysfs, right?  Or is it?  How is th=
e
> remove method being called, is that coming from a sysfs file?
>=20

No, it=E2=80=99s not sysfs. Sysfs is not used at all.

The remove method of the mux gets called and on it=E2=80=99s remove met=
hod i2c_del_mux_adapter is called,
which in turn calls i2c_del_adapter() which hangs.

Anyway, finally figured out what the problem was, a reference was held,=
 and not released properly in
the i2c notifier pathc.

I=E2=80=99ll send out an updated patch later today.

> Having that call "wait" for the other release call to happen is reall=
y
> old, as Jean points out, from 2003.  We have "fixed" sysfs since then=
 to
> detach the files from the devices easier, we used to have some nasy
> reference count issues in that area.  Perhaps this isn't needed anymo=
re,


It=E2=80=99s awfully easy to get a hang with this blocking wait. Turns =
a memory leak into a hard hang.

> I don't remember the i2c core code at all, that was a long time ago.
>=20

Bummer.

> thanks,
>=20
> greg k-h

Regards

=E2=80=94 Pantelis
