From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [patch v5] i2c: mux: mellanox: add driver
Date: Thu, 10 Nov 2016 13:04:52 +0000
Message-ID: <AM5PR0501MB2097FAAAEDC706D335FA0A85A2B80@AM5PR0501MB2097.eurprd05.prod.outlook.com>
References: <1473799071-12830-1-git-send-email-vadimp@mellanox.com>
 <c530714e-b61e-8a38-a054-9d335f0e8a71@axentia.se>
 <AM5PR0501MB2097C2A4BA889C44549A0E9FA2A30@AM5PR0501MB2097.eurprd05.prod.outlook.com>
 <b7cf55af-1354-0e0d-b960-877a6223b357@axentia.se>
 <AM5PR0501MB2097404BB1877921F0F6C8F5A2B80@AM5PR0501MB2097.eurprd05.prod.outlook.com>
 <9850b1e2-40e9-d56f-570a-39edeee0b67e@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9850b1e2-40e9-d56f-570a-39edeee0b67e@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Peter Rosin [mailto:peda@axentia.se]
> Sent: Thursday, November 10, 2016 3:02 PM
> To: Vadim Pasternak <vadimp@mellanox.com>; wsa@the-dreams.de
> Cc: linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org; jiri@resnull=
i.us;
> Michael Shych <michaelsh@mellanox.com>
> Subject: Re: [patch v5] i2c: mux: mellanox: add driver
>=20
> On 2016-11-10 13:56, Vadim Pasternak wrote:
> >
> >
> >> -----Original Message-----
> >> From: Peter Rosin [mailto:peda@axentia.se]
> >> Sent: Thursday, November 10, 2016 1:13 PM
> >> To: Vadim Pasternak <vadimp@mellanox.com>; wsa@the-dreams.de
> >> Cc: linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> jiri@resnulli.us; Michael Shych <michaelsh@mellanox.com>
> >> Subject: Re: [patch v5] i2c: mux: mellanox: add driver
> >>
> >> [resend to all, got the wrong button, sorry]
> >>
> >> On 2016-11-10 11:42, Peter Rosin wrote:
> >>> On 2016-11-03 06:20, Vadim Pasternak wrote:
> >>>> Hi,
> >>>>
> >>>> I see that this patch has not been picked-up yet for i2c-next.
> >>>> Is it possible it was missed from some reason?
> >>>
> >>> Yes, apparently, really sorry about that!
> >>>
> >>> I'll put it in a branch and make a pull request for Wolfram (but
> >>> that is a bit new for me, we'll see how it goes).
> >>
> >> But now that I looked again, I noticed that the source is dual
> >> licensed and yet your MODULE_LICENSE tag says only "GPL v2". I.e. the
> >> same issue your i2c master driver had that Vladimir Zapolskiy noticed.
> >>
> >> Please fix this, and it might be a good idea to take a look in your
> >> other drivers as well in case you have further problems in this depart=
ment...
> >
> > Hi Peter,
> >
> > Thank you for reply.
> > I'll re-submit it from the current i2c next branch.
> > Since I'll fix the license, I guess I should issue it as "patch v6". Ri=
ght?
>=20
> Sounds right, yes.

OK, will do it.
And I'll fix the comment according to your last recommendation.

Cheers,
Vadim.
>=20
> Cheers,
> Peter
