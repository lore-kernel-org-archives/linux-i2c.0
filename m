From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH] i2c: rcar: add DMA support
Date: Sat, 14 May 2016 14:12:02 +0200
Message-ID: <20160514121202.GJ3256@bigcity.dyn.berto.se>
References: <1462365503-8451-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160512213127.GA1860@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160512213127.GA1860@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Thanks for your feedback.

On 2016-05-12 23:31:27 +0200, Wolfram Sang wrote:
> Hi Niklas,
>=20
> thanks for the submission. I was finally able to test this change.
>=20
> On Wed, May 04, 2016 at 02:38:23PM +0200, Niklas S=F6derlund wrote:
> > Make it possible to transfer i2c message buffers via DMA.
> > Start/Stop/Sending_Slave_Address and some data is still handled usi=
ng
> > the old state machine, it is sending the bulk of the data that is d=
one
> > via DMA.
> >=20
> > The first byte of a transmission and the last two bytes of receptio=
n are
> > sent/received using PIO. This is needed for the HW to have access t=
o the
> > first byte before DMA transmit and to be able to set the STOP condi=
tion
> > for DMA reception.
> >=20
> > Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnate=
ch.se>
>=20
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> I did regression tests on my Salvator-X trying to trigger previously
> known issues. Nothing bad happened. This could be expected since STAR=
T
> and STOP is done in PIO mode, but one never knows :) Also did verify
> that DMA is triggered for bigger transfers.
>=20
> Did you have time to re-measure the threshold? Also, did you try boot=
ing

I did not re-measure the threshold, I'm not sure how to do that in a=20
good correct way. I reasoned that I modeled my implementation on the=20
sh_mobile-driver and there are roughly the same amount code in the DMA=20
code path so I used the same threshold.

> without DMA and on Gen2? We had a bit of hazzle with !DMA with the
> sh_mobile-driver. Boot test and basic i2cdetect will suffice.

I tested in on Koelsch, but I don't have the schematics for the board s=
o=20
I could not hookup to an external i2c bus and look at it. But i2cdetect=
=20
is working.

>=20
> Patch looks good, only minor nits:
>=20
> > +	/* Do not use DMA for messages shorter then 8 bytes */
> > +	if (msg->len < 8)
> > +		return;
> > +
> > +	if (IS_ERR(chan))
> > +		return;
>=20
> Make this one if (a || b)?

=46ill fix.

>=20
> > @@ -516,6 +738,7 @@ static int rcar_i2c_master_xfer(struct i2c_adap=
ter *adap,
> >  out:
> >  	pm_runtime_put(dev);
> > =20
> > +
>=20
> Unrelated change ;)

=46ill fix.

>=20
> Thanks,
>=20
>    Wolfram
>=20

--=20
Regards,
Niklas S=F6derlund
