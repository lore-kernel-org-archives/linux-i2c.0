From: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/8] i2c mux cleanup and locking update
Date: Wed, 6 Jan 2016 14:23:02 +0100
Message-ID: <CAKv63uvvdjmQj3J73UJZFLJ=U0c+Z=dmknm3UH=3MvYU0oqNNg@mail.gmail.com>
References: <1452009438-27347-1-git-send-email-peda@lysator.liu.se> <20160105184819.GA1743@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160105184819.GA1743@katana>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>Olli Salonen <ol>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram and Peter,
I will give my opinion about the path chosen although it should be
taken lightly.

I can see that hardware guys missed the software guys again on the
development path, but since this happens more often than not, I would
say it seems OK to have support for this as long as it does not make
more complex (longer) standard i2c transfers. I would support to have
additional mutex before mux as that will make less chance that someone
forgets to lock mutex before mux and proposed solution seems valid.

Regards,
Crt

On 5 January 2016 at 19:48, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> Peter,
>
>> PS. needs a bunch of testing, I do not have access to all the involved hw
>
> First of all, thanks for diving into this topic and the huge effort you
> apparently have put into it.
>
> It is obviously a quite intrusive series, so it needs careful review.
> TBH, I can't really tell when I have the bandwidth to do that, so I hope
> other people will step up. And yes, it needs serious testing.
>
> To all: Although I appreciate any review support, I'd think the first
> thing to be done should be a very high level review - is this series
> worth the huge update? Is the path chosen proper? Stuff like this. I'd
> appreciate Acks or Revs for that. Stuff like fixing checkpatch warnings
> and other minor stuff should come later.
>
> Thanks,
>
>    Wolfram
>
