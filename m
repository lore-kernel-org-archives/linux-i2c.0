From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] [RFC] i2c: Don't wait for device release in
 i2c_del_adapter
Date: Wed, 14 Jan 2015 08:19:44 -0800
Message-ID: <20150114161944.GA18578@roeck-us.net>
References: <1421082050-10213-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150113152957.GL7660@katana>
 <20150114144938.4e3c3f52@endymion.delvare>
 <B2D57D11-FBC2-432A-90E8-90E4CF8F716C@konsulko.com>
 <54B679DC.40303@roeck-us.net>
 <AEACDB0B-BF24-422E-89E3-45B232E6E261@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AEACDB0B-BF24-422E-89E3-45B232E6E261-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 14, 2015 at 04:18:56PM +0200, Pantelis Antoniou wrote:
> Hi Guenter,
>=20
> > On Jan 14, 2015, at 16:14 , Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrot=
e:
> >=20
> > On 01/14/2015 05:54 AM, Pantelis Antoniou wrote:
> >=20
> >>> That being said, nobody complained about this in 11 years, so I w=
ould
> >>> be surprised if it was plain wrong. I'd rather question the test =
code.
> >>> Where is it?
> >>>=20
> >>=20
> >> No-one has apparently tested removing an i2c mux device on a runni=
ng system
> >> before.
> >>=20
> > Hi Pantelis,
> >=20
> > We didn't see the problem with 3.14. That was with an earlier versi=
on of the
> > overlay patchset, though.
> >=20
>=20
> There have been changes to the overlay patchset since then true, but =
I don=E2=80=99t see
> how that would trigger a deadlock in i2c. The completion wait just se=
ems bogus to me.
>=20

Maybe the problem is triggered by a change in the infrastructure.

Guenter
