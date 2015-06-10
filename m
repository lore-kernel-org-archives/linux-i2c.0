From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Wed, 10 Jun 2015 16:51:27 +0300
Message-ID: <B9EA0BC3-56D8-4676-BEFC-734EC1FE6649@konsulko.com>
References: <1422083789-18905-1-git-send-email-pantelis.antoniou@konsulko.com> <20150422074019.GA1511@katana> <CAMAWPa-HMhJK9UzwfaMPe-MO=4mzjvC=nRwPX-pbab_fb3YZ9A@mail.gmail.com> <20150506183733.GA1513@katana> <A4E060DB-2799-4BF5-9CA6-DE53B7DF9A30@konsulko.com> <20150610054034.GB1573@katana> <CAL_Jsq+xTZy3QsdaXieR8LSVEJfSeehtcytZLOyt7ghTZ=Bcxw@mail.gmail.com> <20150610124949.GC1592@katana>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150610124949.GC1592@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

> On Jun 10, 2015, at 15:49 , Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>=20
> On Wed, Jun 10, 2015 at 07:42:59AM -0500, Rob Herring wrote:
>> On Wed, Jun 10, 2015 at 12:40 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> w=
rote:
>>>=20
>>>>>>>> Mark (and unmark) device nodes with the POPULATE flag as appro=
priate.
>>>>>>>> This is required to avoid multi probing when using I2C and dev=
ice
>>>>>>>> overlays containing a mux.
>>>>>>>> This patch is also more careful with the release of the adapte=
r device
>>>>>>>> which caused a deadlock with muxes, and does not break the bui=
ld
>>>>>>>> on !OF since the node flag accessors are not defined then.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.c=
om>
>>>>>>>=20
>>>>>>> Now, that the dependency is upstream: applied to for-current, t=
hanks!
>>>>>>=20
>>>>>> I'm not seeing this in linux-next, or in your for-current branch=
=2E
>>>>>>=20
>>>>>> Was this dropped or superseded by something else?
>>>>>=20
>>>>> I dropped it because it caused a build bug. So, we need another
>>>>> dependency in... I am not sure if this is already in.
>>>>>=20
>>>>=20
>>>> FWIW, I=E2=80=99ve posted the dependency patch already; it=E2=80=99=
s trivial as you recall.
>>>>=20
>>>> Lets hope it gets picked so that this one can go in.
>>>=20
>>> Is that in now?
>>=20
>> You mean "of: Move OF flags to be visible even when !CONFIG_OF"? If
>> so, it is queued up for 4.2 in my tree.
>=20
> Sorry, I lost track of all the fixes needed for this one. I also can'=
t
> recall being CCed to them. Pity.
>=20
> IIRC it is the one which adds OF_POPULATED. If so, why is this not
> scheduled for 4.1 as this bugfix depends on it?
>=20

No idea. This is an obvious bugfix.

> Pantelis, thanks for all the work yet I must say I am seriously confu=
sed
> with the handling of this patch. I thought you wanted the original I2=
C
> fix applied asap?

I would like to, yes. It=E2=80=99s just the nature of the process when =
dealing with
multiple kernel trees. I would be happy for someone to pick up and queu=
e it
for 4.1.

Regards

=E2=80=94 Pantelis
