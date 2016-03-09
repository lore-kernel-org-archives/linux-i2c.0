From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v4 0/8] i2c: Relax mandatory I2C ID table passing
Date: Wed, 9 Mar 2016 12:30:33 +0700
Message-ID: <20160309053033.GM13692@x1>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
 <20151009211636.GA1481@katana>
 <CAB3z_RrOKvQW5GiTEP2zqMaQ=EtpsqHB1GmUm-+D+12NM=USOg@mail.gmail.com>
 <20160308042221.GD13692@x1>
 <CAB3z_RpyRr5T4W2iLJfA8xiZLuiMgAN=-EN=xgv2RDTNMmOdzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36502 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbcCIFas (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 9 Mar 2016 00:30:48 -0500
Received: by mail-pf0-f181.google.com with SMTP id u190so1557246pfb.3
        for <linux-i2c@vger.kernel.org>; Tue, 08 Mar 2016 21:30:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAB3z_RpyRr5T4W2iLJfA8xiZLuiMgAN=-EN=xgv2RDTNMmOdzg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieranbingham@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On Tue, 08 Mar 2016, Kieran Bingham wrote:

> On 8 Mar 2016 11:22, "Lee Jones" <lee.jones@linaro.org> wrote:
> >
> > On Mon, 12 Oct 2015, Kieran Bingham wrote:
> >
> > > Hi Wolfram,
> > >
> > > On 9 October 2015 at 22:16, Wolfram Sang <wsa@the-dreams.de> wrot=
e:
> > > >
> > > > As said to Kieran personally in Dublin, I want a verification t=
hat all
> > > > binding methods still work, especially runtime instantiation fo=
r
> drivers
> > > > without i2c_device_ids.
> > >
> > > Ok, I should be able to find some time to look at that this week.
> > >
> > > >  Also, for the last patch, a verification should
> > > > be done if the drivers i2c_device_id hasn't been used meanwhile=
=2E
> > >
> > > I'll see what I can do ...
> > >
> > > > I'd also like to see 'probe_new' instead of 'probe2' for the ne=
w
> function
> > > > name. That should be it.
> > >
> > > Ok, obviously this is only a temporary naming so I don't mind eit=
her
> way,
> > > I'll do a rename for the next version
> > >
> > > I've also just found a compile failure to fix up on !CONFIG_OF, t=
his
> > > can make its way into the respin.
> >
> > I still don't see this upstream.  What's the latest status?
>=20
> Needs correct testing:
> "verification that all binding methods still work, especially runtime
> instantiation for drivers without i2c_device_ids."
>=20
> Actually I rebased this set last week.  I was going to try and see if=
 I can
> test in qemu. Just need to work out how to load DT fragments at runti=
me.

Sounds like an over-the-top solution.  Can't you just modprobe some mod=
ules?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
