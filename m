From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Wed, 6 May 2015 21:39:31 +0300
Message-ID: <A4E060DB-2799-4BF5-9CA6-DE53B7DF9A30@konsulko.com>
References: <1422083789-18905-1-git-send-email-pantelis.antoniou@konsulko.com> <20150422074019.GA1511@katana> <CAMAWPa-HMhJK9UzwfaMPe-MO=4mzjvC=nRwPX-pbab_fb3YZ9A@mail.gmail.com> <20150506183733.GA1513@katana>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150506183733.GA1513@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

> On May 6, 2015, at 21:37 , Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>=20
> On Wed, May 06, 2015 at 10:51:07AM -0700, Kevin Hilman wrote:
>> On Wed, Apr 22, 2015 at 12:40 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> w=
rote:
>>> On Sat, Jan 24, 2015 at 09:16:29AM +0200, Pantelis Antoniou wrote:
>>>> Mark (and unmark) device nodes with the POPULATE flag as appropria=
te.
>>>> This is required to avoid multi probing when using I2C and device
>>>> overlays containing a mux.
>>>> This patch is also more careful with the release of the adapter de=
vice
>>>> which caused a deadlock with muxes, and does not break the build
>>>> on !OF since the node flag accessors are not defined then.
>>>>=20
>>>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>>>=20
>>> Now, that the dependency is upstream: applied to for-current, thank=
s!
>>=20
>> I'm not seeing this in linux-next, or in your for-current branch.
>>=20
>> Was this dropped or superseded by something else?
>=20
> I dropped it because it caused a build bug. So, we need another
> dependency in... I am not sure if this is already in.
>=20

=46WIW, I=E2=80=99ve posted the dependency patch already; it=E2=80=99s =
trivial as you recall.

Lets hope it gets picked so that this one can go in.

Regards

=E2=80=94 Pantelis
