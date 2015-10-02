From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v4 0/8] i2c: Relax mandatory I2C ID table passing
Date: Fri, 2 Oct 2015 10:35:12 +0100
Message-ID: <20151002093512.GB23213@x1>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
 <55FAE058.7080504@osg.samsung.com>
 <20150920041528.GA3039@x1>
 <5603A881.2010300@osg.samsung.com>
 <20150924165807.GA27197@x1>
 <20151001205035.GB7514@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35329 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbbJBJfQ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Oct 2015 05:35:16 -0400
Received: by wicge5 with SMTP id ge5so24861310wic.0
        for <linux-i2c@vger.kernel.org>; Fri, 02 Oct 2015 02:35:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151001205035.GB7514@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Kieran Bingham <kieranbingham@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org

On Thu, 01 Oct 2015, Wolfram Sang wrote:

>=20
> > > Yes but that is not true for drivers that support both OF and leg=
acy board
> > > files. For those drivers, there will be a lot of boiler plate cod=
e duplicated
> > > that would look something like:
> > >=20
> > >      unsigned long data;
> > >      struct of_device_id *match;
> > >      struct i2c_devicd_id *id;
> > >=20
> > >      if (i2c->dev.of_node) {
> > >             match =3D i2c_of_match_device(of_match_table, i2c);
> > > 	    if (!match)
> > > 	           return -EINVAL;
> > >=20
> > >             data =3D (unsigned long)match->data;
> > >      } else {
> > >             id =3D i2c_match_id(id_table, i2c);
> > > 	    if (!id)
> > > 	           return -EINVAL;
> > >=20
> > >             data =3D id->driver_data;
> > >      }
>=20
> I said this before: It is not only the additional code, I think it is
> quite unelegant to to do the matching again which has already been do=
ne.
> (and DT boottime has already increased, partly due to the excessive
> string matching). Also, I wouldn't like to see an I2C specific soluti=
on;
> this problem exists for other subsystems, too.
>=20
> > I'm fine with a new API for this stuff.  I'm even happy to go ahead
> > and code it up, but it's important to note that this is work which
> > should be based on this set and not a blocker for this set to be
> > accepted.
>=20
> Is that a promise? :)

Yes.

> > The correct approach is the former.  One of the aims of this set wa=
s
> > to bring the I2C .probe() call-back more into line with the majorit=
y
> > of the other .probe() calls in the kernel i.e. with only a single
> > parameter.  I'm really not a fan of passing some random void pointe=
r
>=20
> Yes, I like this about this series.
>=20
> > in.  Using a look-up call to fetch ACPI/OF/I2C/etc data is the curr=
ent
> > norm and is a very viable option.
>=20
> It is the status quo, but that doesn't make it better IMO.
>=20
> > Wolfram, please (finally :D) take this set.
>=20
> I tend to give in ;)

Great.  Although, I don't see a "applied, thanks". :)

Please just take it, so we can breathe a sigh of relief and move on to
the next stage. :D

> Maybe we can talk in Dublin a bit about a possible
> next step after this series?

I'm happy to chat, although I'm afraid I won't be in Dublin this
time.  Kieran will be though, so feel free to so some lobby loitering
and I'll discuss with him when he returns.  Failing that we can
hook-up on Gtalk or IRC etc.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
