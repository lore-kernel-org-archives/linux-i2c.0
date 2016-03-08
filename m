From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v4 0/8] i2c: Relax mandatory I2C ID table passing
Date: Tue, 8 Mar 2016 11:22:21 +0700
Message-ID: <20160308042221.GD13692@x1>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
 <20151009211636.GA1481@katana>
 <CAB3z_RrOKvQW5GiTEP2zqMaQ=EtpsqHB1GmUm-+D+12NM=USOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34902 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbcCHEW2 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Mar 2016 23:22:28 -0500
Received: by mail-pf0-f179.google.com with SMTP id x188so3699169pfb.2
        for <linux-i2c@vger.kernel.org>; Mon, 07 Mar 2016 20:22:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAB3z_RrOKvQW5GiTEP2zqMaQ=EtpsqHB1GmUm-+D+12NM=USOg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieranbingham@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>

On Mon, 12 Oct 2015, Kieran Bingham wrote:

> Hi Wolfram,
>=20
> On 9 October 2015 at 22:16, Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> > As said to Kieran personally in Dublin, I want a verification that =
all
> > binding methods still work, especially runtime instantiation for dr=
ivers
> > without i2c_device_ids.
>=20
> Ok, I should be able to find some time to look at that this week.
>=20
> >  Also, for the last patch, a verification should
> > be done if the drivers i2c_device_id hasn't been used meanwhile.
>=20
> I'll see what I can do ...
>=20
> > I'd also like to see 'probe_new' instead of 'probe2' for the new fu=
nction
> > name. That should be it.
>=20
> Ok, obviously this is only a temporary naming so I don't mind either =
way,
> I'll do a rename for the next version
>=20
> I've also just found a compile failure to fix up on !CONFIG_OF, this
> can make its way into the respin.

I still don't see this upstream.  What's the latest status?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
