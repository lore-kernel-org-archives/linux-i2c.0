From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c: remove deprecated callbacks
Date: Thu, 1 Sep 2011 15:01:05 +0200
Message-ID: <20110901150105.31111b67@endymion.delvare>
References: <1314852027-9523-1-git-send-email-xiyou.wangcong@gmail.com>
	<20110901105226.0d8dd8b2@endymion.delvare>
	<CAM_iQpVGO6Jfcdy4wWN7O-ZpTha2SbfK6xeaf8g9DRGuh=xcbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAM_iQpVGO6Jfcdy4wWN7O-ZpTha2SbfK6xeaf8g9DRGuh=xcbg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: =?ISO-8859-1?B?QW3pcmljbw==?= Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Randy Dunlap <rdunlap@xenotime.net>, Ben Dooks <ben-linux@fluff.org>, linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 1 Sep 2011 17:12:00 +0800, Am=E9rico Wang wrote:
> On Thu, Sep 1, 2011 at 4:52 PM, Jean Delvare <khali@linux-fr.org> wro=
te:
> > Furthermore, you didn't even check if the deprecated callbacks were
> > still in use. It turns out that there are 9 drivers still using one=
 of
> > them (6 macintosh drivers and 3 sound drivers) so plain removing it
> > will cause build breakages. We obviously don't want to do that, so =
I am
> > not going to apply your patch (nor mine) for now.
>=20
> Hmm, sorry that I didn't know this, maybe we can defer the removal
> of these callbacks?

We have to, obviously. And given that this is 50% of the patch, there's
little point in applying the rest now.

> > (...)
> > If you want to help, then instead of sending a patch which I alread=
y
> > have and virtually everybody could have written, please get the
> > remaining 3 drivers converted to the current i2c binding model:
> > =A0sound/ppc/keywest.c
> > =A0sound/aoa/codecs/onyx.c
> > =A0sound/aoa/codecs/tas.c
>=20
> Sure, if I can... so how do we convert them? Any examples?

If it was trivial, someone would have done it already... I converted
most drivers a couple years ago, but the remaining ones only run on
systems I don't have and converting them properly would take intimate
knowledge of the systems in question and preferably actual hardware for
testing.

You can read the possible replacements for the current deprecated
implementations:
  Documentation/i2c/instantiating-devices

At the moment I am essentially waiting to see when Ben is headed, as
hopefully the sound drivers can follow the same path. If you want to
help Ben with code review or testing (if you can) this would be great.

--=20
Jean Delvare
