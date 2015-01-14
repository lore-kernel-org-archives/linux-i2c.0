From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] [RFC] i2c: Don't wait for device release in i2c_del_adapter
Date: Wed, 14 Jan 2015 19:24:22 +0200
Message-ID: <6680B42A-76E8-40CF-9574-ECD00B40AE98@konsulko.com>
References: <1421082050-10213-1-git-send-email-pantelis.antoniou@konsulko.com> <20150113152957.GL7660@katana> <20150114144938.4e3c3f52@endymion.delvare> <B2D57D11-FBC2-432A-90E8-90E4CF8F716C@konsulko.com> <20150114161525.49c54acc@endymion.delvare> <20150114162442.GB18578@roeck-us.net> <20150114181426.3a39791b@endymion.delvare>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150114181426.3a39791b-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

> On Jan 14, 2015, at 19:14 , Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:
>=20
> Hi Guenter,
>=20
> On Wed, 14 Jan 2015 08:24:43 -0800, Guenter Roeck wrote:
>> On Wed, Jan 14, 2015 at 04:15:25PM +0100, Jean Delvare wrote:
>>> I did that. On my system the i2c-i801 driver instantiates an
>>> i2c-mux-gpio device. Unloading the i2c-i801 driver removes that dev=
ice
>>> and it works fine. Note however that I am not able to unload module
>>> i2c-i801 immediately, I have to unload module i2c-mux-gpio first, a=
s
>>> the latter holds a reference to the former. This is because
>>> i2c-mux-gpio calls i2c_get_adapter() on the parent I2C bus segment =
at
>>> probing time.
>>>=20
>>> I see that i2c-mux-pinctrl does the same, but i2c-mux-pca954x and
>>> i2c-mux-pca9541 do not. This might be an issue. I doubt this is rel=
ated
>>> to your problem though, as these are module references and not devi=
ce
>>> references.
>>=20
>> Should we add get/put functions to those drivers ?
>=20
> I'm not sure. If you unload a driver which instantiated a pca9540-lik=
e
> device, without unloading i2c-mux-pca954x first, does something bad
> happen?
>=20

I=E2=80=99m not sure this got anything to do with module reference. The=
 problem
lies at the device model=E2=80=99s reference counts.

I=E2=80=99ll try to dig around tomorrow and see what the real device re=
ference counts
are, but my hunch goes like this:

MUX
+=E2=80=94- ADAPTER
    +=E2=80=94 DEV.

Mux remove method is called, i2c_del_mux_adapter is called on all the c=
hannels
of the mux, calling in turn i2c_del_adapter which hangs on completion o=
f the
dev_released.

The call to device_unregister never calls the device_type callback (i2c=
_adapter_dev_release)
because the reference count is not 1 at that point, someone else is hav=
ing another
reference.

I guess we could use Greg=E2=80=99s ideas on the matter.

> --=20
> Jean Delvare
> SUSE L3 Support

Regards

=E2=80=94 Pantelis
