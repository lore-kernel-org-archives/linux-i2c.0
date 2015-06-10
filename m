From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Wed, 10 Jun 2015 07:42:59 -0500
Message-ID: <CAL_Jsq+xTZy3QsdaXieR8LSVEJfSeehtcytZLOyt7ghTZ=Bcxw@mail.gmail.com>
References: <1422083789-18905-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150422074019.GA1511@katana> <CAMAWPa-HMhJK9UzwfaMPe-MO=4mzjvC=nRwPX-pbab_fb3YZ9A@mail.gmail.com>
 <20150506183733.GA1513@katana> <A4E060DB-2799-4BF5-9CA6-DE53B7DF9A30@konsulko.com>
 <20150610054034.GB1573@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150610054034.GB1573@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 10, 2015 at 12:40 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrot=
e:
>
>> >>>> Mark (and unmark) device nodes with the POPULATE flag as approp=
riate.
>> >>>> This is required to avoid multi probing when using I2C and devi=
ce
>> >>>> overlays containing a mux.
>> >>>> This patch is also more careful with the release of the adapter=
 device
>> >>>> which caused a deadlock with muxes, and does not break the buil=
d
>> >>>> on !OF since the node flag accessors are not defined then.
>> >>>>
>> >>>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/HQFizaE/u3fw@public.gmane.org=
m>
>> >>>
>> >>> Now, that the dependency is upstream: applied to for-current, th=
anks!
>> >>
>> >> I'm not seeing this in linux-next, or in your for-current branch.
>> >>
>> >> Was this dropped or superseded by something else?
>> >
>> > I dropped it because it caused a build bug. So, we need another
>> > dependency in... I am not sure if this is already in.
>> >
>>
>> FWIW, I=E2=80=99ve posted the dependency patch already; it=E2=80=99s=
 trivial as you recall.
>>
>> Lets hope it gets picked so that this one can go in.
>
> Is that in now?

You mean "of: Move OF flags to be visible even when !CONFIG_OF"? If
so, it is queued up for 4.2 in my tree.

Rob
