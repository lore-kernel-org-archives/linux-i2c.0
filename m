From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v3 1/1] i2c: taos-evm: replace simple_strtoul by
 kstrtou8
Date: Sat, 21 Nov 2015 21:10:06 +0100
Message-ID: <20151121211006.6c69a818@endymion.delvare>
References: <1447851356-6248-1-git-send-email-clabbe.montjoie@gmail.com>
	<1447851356-6248-2-git-send-email-clabbe.montjoie@gmail.com>
	<CAHp75Vepu9=DjsV2JdR2pRMQw+0GJTJktudg44GnCgbms0B7mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52672 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbbKUUKK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 21 Nov 2015 15:10:10 -0500
In-Reply-To: <CAHp75Vepu9=DjsV2JdR2pRMQw+0GJTJktudg44GnCgbms0B7mw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Andy,

On Wed, 18 Nov 2015 18:26:25 +0200, Andy Shevchenko wrote:
> On Wed, Nov 18, 2015 at 2:55 PM, LABBE Corentin
> <clabbe.montjoie@gmail.com> wrote:
> > The simple_strtoul function is marked as obsolete.
> > This patch replace it by kstrtou8.
> >
>=20
> Only one concern. simple_strto* goes through the string until it has
> an invalid character or \0. In your case kstrtou8 will fail the
> transfer. So, is there possible cases when HW returns such data?

It's not supposed to happen.

> And just a style nitpicks below.
>=20
> >                 if (p[0] =3D=3D 'x') {
> > -                       data->byte =3D simple_strtol(p + 1, NULL, 1=
6);
> > +                       /*
> > +                        * voluntarily dropping error code of kstrt=
ou8 since all
>=20
> -> Voluntarily=E2=80=A6
>=20
> > +                        * error code that it could return are inva=
lid according
> > +                        * to Documentation/i2c/fault-codes
>=20
> -> =E2=80=A6codes.
>=20
> > +                        */
> > +                       if (kstrtou8(p + 1, 16, &data->byte))
> > +                               return -EPROTO;
>=20


--=20
Jean Delvare
SUSE L3 Support
