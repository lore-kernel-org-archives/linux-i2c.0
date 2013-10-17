From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/4] i2c: busses: i2c-st: Add ST I2C controller
Date: Thu, 17 Oct 2013 16:53:08 +0100
Message-ID: <20131017155308.GQ19112@lee--X1>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>
 <1381754813-4679-2-git-send-email-maxime.coquelin@st.com>
 <20131016151419.GA14104@ns203013.ovh.net>
 <525F915D.9020501@st.com>
 <525FAEED.7030207@st.com>
 <20131017141957.GE14104@ns203013.ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131017141957.GE14104@ns203013.ovh.net>
Sender: linux-doc-owner@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: srinivas kandagatla <srinivas.kandagatla@st.com>, Maxime COQUELIN <maxime.coquelin@st.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Stuart MENEFY <stuart.menefy@st.com>, Stephen GALLIMORE <stephen.gallimore@st.com>, Gabriel FERNANDEZ <gabriel.fernandez@st.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, 17 Oct 2013, Jean-Christophe PLAGNIOL-VILLARD wrote:

> On 10:33 Thu 17 Oct     , srinivas kandagatla wrote:
> > On 17/10/13 08:27, Maxime COQUELIN wrote:
> > > ...
> > >>> >> +
> > >>> >> +static struct of_device_id st_i2c_match[] =3D {
> > >>> >> +     { .compatible =3D "st,comms-ssc-i2c", },
> > >> > the rules is to put the first soc that use the ip in the compa=
tible
> > >> > as st,sti7100-scc-i2c
> > > Ok. There are no plans to upstream the SH4 platforms, it will onl=
y=20
> > > remains in stlinux.com.
> > > Maybe I can set the first ARM platform (STiH415)?
> > > That would give st,stih415-ssc-i2c.
> > NAK, for st,stih415-ssc-i2c naming.
> >=20
> > IMO, this makes sense when the same IP integration done on differen=
t SOC
> > changes slightly/very differently.
> >=20
> > But in this case the "comms" IP remains unchanged across all the SO=
Cs.
> >=20
> > I would still prefer "st,comms-ssc-i2c", allowing a single device d=
river
> > to match against several SoCs. ST "comms" IP it is integrated acros=
s all
> > the STi series of SoCs, so we don't want to add new entry in compat=
ible
> > for every new SOC.
>=20
> you never need this you always the first SoC that's all
>=20
> see other bindings on at91 as example sorry NACK

I'm guessing that using the first SoC is an I2C'isum.

Guys, if you don't want to be too specific, just make it as generic as
possible whilest still using the SoC as a POR: st,stih41x-ssc-i2c will
do for now, as it covers all current bases.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
