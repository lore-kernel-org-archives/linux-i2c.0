From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] [RFC] i2c: Don't wait for device release in i2c_del_adapter
Date: Wed, 14 Jan 2015 16:12:49 +0200
Message-ID: <C31FA639-70E2-49D0-9797-94A8E989F84F@konsulko.com>
References: <1421082050-10213-1-git-send-email-pantelis.antoniou@konsulko.com> <20150113152957.GL7660@katana> <20150114144938.4e3c3f52@endymion.delvare> <B2D57D11-FBC2-432A-90E8-90E4CF8F716C@konsulko.com> <54B677DE.6030204@gmx.de>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54B677DE.6030204-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

> On Jan 14, 2015, at 16:06 , Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org> wrote=
:
>=20
> Am 14.01.2015 um 14:54 schrieb Pantelis Antoniou:
>> Hi Jean,
>>=20
>>> On Jan 14, 2015, at 15:49 , Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:
> ...
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
>=20
> We do it day by day and it works perfectly with pca954x from 2.6.32 t=
o 3.14.27
> So if there are problems they must have been invented lately.

I had a report that someone had the same problem with overlays containi=
ng a pca mux,
let me see if I can find the person that sent it and get him to supply =
more info.

Kernel was at least 3.17, so=E2=80=A6

> --=20
> JM2C
> KR
> Michael
>=20

Regards

=E2=80=94 Pantelis
