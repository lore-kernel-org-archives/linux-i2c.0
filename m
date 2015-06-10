From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Wed, 10 Jun 2015 09:18:07 -0500
Message-ID: <CAL_JsqJPzXi9zWfLktoCoEdTUWjiQsVSEGqab=+FiQBUuFzymw@mail.gmail.com>
References: <1422083789-18905-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150422074019.GA1511@katana> <CAMAWPa-HMhJK9UzwfaMPe-MO=4mzjvC=nRwPX-pbab_fb3YZ9A@mail.gmail.com>
 <20150506183733.GA1513@katana> <A4E060DB-2799-4BF5-9CA6-DE53B7DF9A30@konsulko.com>
 <20150610054034.GB1573@katana> <CAL_Jsq+xTZy3QsdaXieR8LSVEJfSeehtcytZLOyt7ghTZ=Bcxw@mail.gmail.com>
 <20150610124949.GC1592@katana> <B9EA0BC3-56D8-4676-BEFC-734EC1FE6649@konsulko.com>
 <20150610140815.GA21540@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150610140815.GA21540@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 10, 2015 at 9:08 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote=
:
>> > IIRC it is the one which adds OF_POPULATED. If so, why is this not
>> > scheduled for 4.1 as this bugfix depends on it?
>>
>> No idea. This is an obvious bugfix.
>
> Dunno if you did but mentioning after the commit message where you th=
ink
> it should be applied is very helpful for maintainers.

+1

>> I would like to, yes. It=E2=80=99s just the nature of the process wh=
en dealing with
>> multiple kernel trees. I would be happy for someone to pick up and q=
ueue it
>> for 4.1.
>
> That might be too late now... You could also have sent the patch to m=
e
> so that I could apply it via i2c with rob's ack. Next time...

That is exactly what I suggested on Jan 26 and Wolfram asked to resend
with my ack. Pantelis sent it on Apr 24 (w/o my ack) and I applied it
on May 29. Wolfram acked it, so I assumed you were not picking it up.
It sat there for over a month, so it must not have been critical to
apply for 4.1.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
