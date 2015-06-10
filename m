From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Wed, 10 Jun 2015 17:10:13 +0300
Message-ID: <041469A7-65F2-4C33-AD67-0B0CE4DEDD75@konsulko.com>
References: <1422083789-18905-1-git-send-email-pantelis.antoniou@konsulko.com> <20150422074019.GA1511@katana> <CAMAWPa-HMhJK9UzwfaMPe-MO=4mzjvC=nRwPX-pbab_fb3YZ9A@mail.gmail.com> <20150506183733.GA1513@katana> <A4E060DB-2799-4BF5-9CA6-DE53B7DF9A30@konsulko.com> <20150610054034.GB1573@katana> <CAL_Jsq+xTZy3QsdaXieR8LSVEJfSeehtcytZLOyt7ghTZ=Bcxw@mail.gmail.com> <20150610124949.GC1592@katana> <B9EA0BC3-56D8-4676-BEFC-734EC1FE6649@konsulko.com> <20150610140815.GA21540@katana>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150610140815.GA21540@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

> On Jun 10, 2015, at 17:08 , Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>=20
>>> IIRC it is the one which adds OF_POPULATED. If so, why is this not
>>> scheduled for 4.1 as this bugfix depends on it?
>>=20
>> No idea. This is an obvious bugfix.
>=20
> Dunno if you did but mentioning after the commit message where you th=
ink
> it should be applied is very helpful for maintainers.
>=20
>> I would like to, yes. It=E2=80=99s just the nature of the process wh=
en dealing with
>> multiple kernel trees. I would be happy for someone to pick up and q=
ueue it
>> for 4.1.
>=20
> That might be too late now... You could also have sent the patch to m=
e
> so that I could apply it via i2c with rob's ack. Next time...
>=20

No worries. I=E2=80=99ve waited a couple of years until these things go=
t in, I can wait
one more release cycle.

Regards

=E2=80=94 Pantelis

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
