From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Wed, 10 Jun 2015 09:31:00 -0500
Message-ID: <CAL_JsqJSGnNfxNcchbFE+LEbymgCiZd=HwY3r5h1bnqo9sG3LQ@mail.gmail.com>
References: <1422083789-18905-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150422074019.GA1511@katana> <CAMAWPa-HMhJK9UzwfaMPe-MO=4mzjvC=nRwPX-pbab_fb3YZ9A@mail.gmail.com>
 <20150506183733.GA1513@katana> <A4E060DB-2799-4BF5-9CA6-DE53B7DF9A30@konsulko.com>
 <20150610054034.GB1573@katana> <CAL_Jsq+xTZy3QsdaXieR8LSVEJfSeehtcytZLOyt7ghTZ=Bcxw@mail.gmail.com>
 <20150610124949.GC1592@katana> <B9EA0BC3-56D8-4676-BEFC-734EC1FE6649@konsulko.com>
 <20150610140815.GA21540@katana> <041469A7-65F2-4C33-AD67-0B0CE4DEDD75@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <041469A7-65F2-4C33-AD67-0B0CE4DEDD75-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 10, 2015 at 9:10 AM, Pantelis Antoniou
<pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org> wrote:
> Hi Wolfram,
>
>> On Jun 10, 2015, at 17:08 , Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>>
>>>> IIRC it is the one which adds OF_POPULATED. If so, why is this not
>>>> scheduled for 4.1 as this bugfix depends on it?
>>>
>>> No idea. This is an obvious bugfix.
>>
>> Dunno if you did but mentioning after the commit message where you t=
hink
>> it should be applied is very helpful for maintainers.
>>
>>> I would like to, yes. It=E2=80=99s just the nature of the process w=
hen dealing with
>>> multiple kernel trees. I would be happy for someone to pick up and =
queue it
>>> for 4.1.
>>
>> That might be too late now... You could also have sent the patch to =
me
>> so that I could apply it via i2c with rob's ack. Next time...
>>
>
> No worries. I=E2=80=99ve waited a couple of years until these things =
got in, I can wait
> one more release cycle.

You should know this already, but in the future for cross subsystem
dependencies:
- send the whole series together
- Be clear if they are targeted for current rc and/or stable
- suggest who you think should merge them:
  - for fixes, whomever took the offending commit if it is the same
kernel cycle.
  - for dependencies, get ack's on the dependencies.

Rob
