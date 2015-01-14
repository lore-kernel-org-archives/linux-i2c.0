From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] [RFC] i2c: Don't wait for device release in i2c_del_adapter
Date: Wed, 14 Jan 2015 16:18:56 +0200
Message-ID: <AEACDB0B-BF24-422E-89E3-45B232E6E261@konsulko.com>
References: <1421082050-10213-1-git-send-email-pantelis.antoniou@konsulko.com> <20150113152957.GL7660@katana> <20150114144938.4e3c3f52@endymion.delvare> <B2D57D11-FBC2-432A-90E8-90E4CF8F716C@konsulko.com> <54B679DC.40303@roeck-us.net>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54B679DC.40303-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

> On Jan 14, 2015, at 16:14 , Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
>=20
> On 01/14/2015 05:54 AM, Pantelis Antoniou wrote:
>=20
>>> That being said, nobody complained about this in 11 years, so I wou=
ld
>>> be surprised if it was plain wrong. I'd rather question the test co=
de.
>>> Where is it?
>>>=20
>>=20
>> No-one has apparently tested removing an i2c mux device on a running=
 system
>> before.
>>=20
> Hi Pantelis,
>=20
> We didn't see the problem with 3.14. That was with an earlier version=
 of the
> overlay patchset, though.
>=20

There have been changes to the overlay patchset since then true, but I =
don=E2=80=99t see
how that would trigger a deadlock in i2c. The completion wait just seem=
s bogus to me.

> Guenter
>=20

Regards

=E2=80=94 Pantelis
