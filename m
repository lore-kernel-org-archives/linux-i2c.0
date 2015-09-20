From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v4 0/8] i2c: Relax mandatory I2C ID table passing
Date: Sun, 20 Sep 2015 05:15:28 +0100
Message-ID: <20150920041528.GA3039@x1>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
 <55FAE058.7080504@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36703 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbbITEPg (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 20 Sep 2015 00:15:36 -0400
Received: by padhk3 with SMTP id hk3so85404946pad.3
        for <linux-i2c@vger.kernel.org>; Sat, 19 Sep 2015 21:15:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55FAE058.7080504@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Kieran Bingham <kieranbingham@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org

On Thu, 17 Sep 2015, Javier Martinez Canillas wrote:

> Hello,
>=20
> On 09/11/2015 01:55 PM, Kieran Bingham wrote:
> > Hi Wolfram,
> >=20
> > I have picked this patchset [0] up from Lee to rebase it, with an a=
im to
> > get this series moving again.
> >=20
> > This resend fixes up my SoB's as highlighted by Lee
> >=20
> > A couple of minor issues were resolved in the rebase. As it stood, =
Javier
> > proposed [1] to merge this series, and use a follow up series to ma=
ke sure
> > that all I2C drivers are using a MODLE_DEVICE_TABLE(of,...)
> >=20
> > I have prepared a Coccinelle patch to work through the bulk of the =
changes
> > required for the conversion, which will assist the transition proce=
ss.
> >=20
> > Once this patch set is accepted, I will commence converting the oth=
er
> > drivers, and submitting with a per subsystem breakdown or simliar t=
o
> > reduce traffic.
> >=20
> > [0] https://lkml.org/lkml/2014/8/28/283
> > [1] https://lkml.org/lkml/2014/9/12/496
> >=20
> > Lee's most recent cover-letter (from 12 months ago) follows:
> >=20
> > Hi Wolfram,
> >=20
> > Placing this firmly back on your plate.  I truly hope we don't miss
> > another merge-window.  This patch-set has the support of some prett=
y
> > senior kernel maintainers, so I hope acceptance shouldn't be too
> > difficult.
> >=20
> > As previously discussed I believe it should be okay for an I2C devi=
ce
> > driver _not_ supply an I2C ID table to match to.  The I2C subsystem
> > should be able to match via other means, such as via OF tables.  Th=
e
> > blocking factor during our previous conversation was to keep
> > registering via sysfs up and running.  This set does that.
> >=20
> > After thinking more deeply about the problem, it occurred to me tha=
t
> > any I2C device driver which uses the sysfs method and issues an
> > of_match_device() would also fail their probe().  Bolted on to this
> > set is a new, more generic way for these devices to match against
> > either of the I2C/OF tables.
> >=20
>=20
> I reviewed this series but wonder if we shouldn't take another approa=
ch.
>=20
> There are two reasons why a I2C device ID table is needed even when d=
evices
> are registered via OF:
>=20
> 1) Export the module aliases from the I2C device ID table so userspac=
e
>    can auto-load the correct module. This is because i2c_device_ueven=
t
>    always reports a MODALIAS of the form i2c:<client->name>.
>=20
> 2) Match the I2C client with a I2C device ID so a struct i2c_device_i=
d
>    is passed to the I2C driver probe() function.
>=20
> As Kieran mentioned I proposed a transition path to fix 1) and posted
> these patches: https://lkml.org/lkml/2015/7/30/519
>=20
> While this series are fixing 2) by changing the matching logic and ad=
ding
> a second probe callback for drivers that don't need to get a i2c_devi=
ce_id.
>=20
> Now, the problem I see with this approach is that drivers will likely=
 want
> to get the struct of_device_id .data field since that is the reason w=
hy
> the I2C core pass a pointer to the struct i2c_device_id in the first =
place.
> So drivers could get the .driver_data field and take decisions depend=
ing on
> which device was registered / matched.
>=20
> If the parameter is removed from probe, it means that drivers will ha=
ve to
> to open code to get it. This is the same issue that exist with OF tod=
ay, if
> a driver needs the .data field from the of_device_id table, is has to=
 do:
>=20
> struct of_device_id *match of_match_node(of_match_table, i2c->dev.of_=
node);
>=20
> to get the match->data. And a similar helper will be needed to get th=
e
> struct i2c_device_id since the core won't do it anymore.
>=20
> So what I propose is to change the probe callback signature instead t=
o have
> a const void *data as the second parameter and the core can either lo=
okup
> from the I2C device ID table or the OF device ID table depending on w=
hich
> mechanism was used to register the I2C device.
>=20
> That way legacy drivers will only need a I2C device ID table and DT d=
rivers
> will only need a OF device ID table and drivers won't need to open co=
de the
> matching logic to get the data stored in the tables.
>=20
> Drivers that support both legacy platform and OF based registration, =
will
> have both tables and the I2C core will lookup the data from the right=
 table.
>=20
> An alternative is to keep this series but have a generic function tha=
t gets
> a pointer to a struct i2c_client as parameter and returns the data fr=
om the
> correct table so drivers that don't need that information won't get i=
t at
> probe time but drivers that need it, can get it easily assisted by th=
e core.

You mean like i2c_match_id()? ;)

This patch already takes care of this issue.  Please see:

  i2c: Export i2c_match_id() for direct use by device drivers

Drivers will know if they either only supply an I2C or OF table, so
they will know which call to use in order to obtain their
=2Edriver_data|.data. attributes.  We can generify the call if you thin=
k
that makes things easier, but I don't see a need for it ATM.

> Both options are similar, the question is if the I2C core should matc=
h and
> lookup the entry from the correct table on probe or let drivers do it=
 later.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
