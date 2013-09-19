From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] ARM: STi: Supply I2C configuration to STiH416 SoC
Date: Thu, 19 Sep 2013 16:32:37 +0100
Message-ID: <20130919153237.GA7071@lee--X1>
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-3-git-send-email-maxime.coquelin@st.com>
 <20130918120340.GF16984@lee--X1>
 <84625B87D65BCF478CC1E9C886A4C314DEF1BD9578@SAFEX1MAIL4.st.com>
 <5239A322.5010004@st.com>
 <84625B87D65BCF478CC1E9C886A4C314DEF1BD9579@SAFEX1MAIL4.st.com>
 <523AF548.30400@st.com>
 <84625B87D65BCF478CC1E9C886A4C314DEF1BD957D@SAFEX1MAIL4.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <84625B87D65BCF478CC1E9C886A4C314DEF1BD957D-+EwDPpWUVoSs+H57zxxw29BPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Cc: Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen GALLIMORE <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, Stuart MENEFY <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Gabriel FERNANDEZ <gabriel.fernandez-qxv4g6HH51o@public.gmane.org>, Olivier CLERGEAUD <olivier.clergeaud-lpHj6iFQ3dU@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> > Am not very comfortable with this idea.
> >
> > As there is no guarantee that the interrupt number/memory map and t=
he
> > i2c numbering will be same in future SOCs or other IPs.
> >
> > You might be already aware that the number of i2cs on each SOC are
> > different as example on STiH415 we have 10 SSCs and on STiH416 we h=
ave
> > 11 SSCs. So, At what point you decide that which devices/IPs should=
 be
> > in stih41x and which should in stih415/Stih416?
> Yes, I know there is one more SSC on STiH416.
>=20
> On one hand, this could add some confusion. But on the other hand,
> someone who will need to activate a SSP will know which one he has
> to activate.
>=20
> > Each i2c node will save around 5 lines if we common it up, but if t=
he
> > interrupt number or map changes this difference will be negligible.
> >
> > Common up at this level and mixing un-common ones in stih415.dtsi o=
r
> > stih416.dtsi will add confusion to readers as the information is sp=
lit
> > at multiple places.
> I agree it will be messy if one part of the node declared at one plac=
e,
> and the rest at another place.
> >
> > IMO the common up idea sounds good but reduces the readability and =
has
> > no effect on final dtb size.
>=20
> Fair enough. Lee, are you ok with keeping it as is?

To be honest I haven't taken a look at the layout of the dts[i] files
yet, so I can't really comment. Srini knows then better than anyone,
so if he says it doesn't make sense, then I'm happy to take his word
for it.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
