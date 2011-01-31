From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] [ARM] tegra: Add i2c support
Date: Mon, 31 Jan 2011 14:48:50 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310C8E2E6@HQMAIL01.nvidia.com>
References: <1283466103-20889-1-git-send-email-ccross@android.com>
 <AANLkTimYURYGix-0Xk3wdf1A-XEAJbBXR_JDn1BFw_uq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimYURYGix-0Xk3wdf1A-XEAJbBXR_JDn1BFw_uq-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWOunwaRDDq4rA@public.gmane.org
Cc: "mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org" <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "gadiyar-l0cyMroinI0@public.gmane.org" <gadiyar-l0cyMroinI0@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Colin Cross wrote at Tuesday, December 21, 2010 5:12 PM:
>=20
> On Thu, Sep 2, 2010 at 3:21 PM, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org> wrot=
e:
> > Signed-off-by: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> > ---
> > =A0drivers/i2c/busses/Kconfig =A0 =A0 | =A0 =A07 +
> > =A0drivers/i2c/busses/Makefile =A0 =A0| =A0 =A01 +
> > =A0drivers/i2c/busses/i2c-tegra.c | =A0665 ++++++++++++++++++++++++=
++++++++++++++++
> > =A0include/linux/i2c-tegra.h =A0 =A0 =A0| =A0 25 ++
> > =A04 files changed, 698 insertions(+), 0 deletions(-)
> > =A0create mode 100644 drivers/i2c/busses/i2c-tegra.c
> > =A0create mode 100644 include/linux/i2c-tegra.h
> >
> Ben, this didn't make it into 2.6.37?  Can it go into next-i2c?

I didn't see any response to this request, at least not in the linux-te=
gra
archives.

--=20
nvpublic
