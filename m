From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCHv2] i2c: rcar: add DMA support
Date: Thu, 19 May 2016 10:01:07 +0200
Message-ID: <20160519080107.GM29375@bigcity.dyn.berto.se>
References: <1463228228-32560-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <6110679.RmWR1Poicp@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6110679.RmWR1Poicp@wuerfel>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Arnd,

Thanks for your feedback.

On 2016-05-18 15:23:07 +0200, Arnd Bergmann wrote:
> On Saturday 14 May 2016 14:17:08 Niklas S=F6derlund wrote:
> > +       chan =3D dma_request_slave_channel_reason(dev, chan_name);
> > +       if (IS_ERR(chan)) {
> > +               ret =3D PTR_ERR(chan);
> > +               dev_dbg(dev, "request_channel failed for %s (%d)\n"=
,
> > +                       chan_name, ret);
> > +               return chan;
> > +       }
> >=20
>=20
> I think you should now use dma_request_chan() for new drivers.

Will fix and resend.

>=20
> 	Arnd

--=20
Regards,
Niklas S=F6derlund
