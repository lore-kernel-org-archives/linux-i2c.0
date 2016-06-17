From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v1 1/1] i2c-i801: make it depend on CONFIG_X86
Date: Fri, 17 Jun 2016 20:59:36 +0200
Message-ID: <20160617205936.74d3c6cd@endymion>
References: <1465996923-76230-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<20160616114915.0446f3a3@endymion>
	<1466155895.30123.153.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41693 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097AbcFQS7k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Jun 2016 14:59:40 -0400
In-Reply-To: <1466155895.30123.153.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Fri, 17 Jun 2016 12:31:35 +0300, Andy Shevchenko wrote:
> On Thu, 2016-06-16 at 11:49 +0200, Jean Delvare wrote:
> > Hi Andy,
> >=20
> > On Wed, 15 Jun 2016 16:22:03 +0300, Andy Shevchenko wrote:
> > > The IP seems not used outside of x86 world, so, make it depend on
> > > CONFIG_X86.
> >=20
> > I've seen the ICH10 used on at least one IA64 system (Supermicro I8=
QBH
> > mainboard.) So, nack, sorry. However I'd be OK with:
> >=20
> > 	depends on X86 || IA64 || COMPILE_TEST
>=20
> I don't like this. (...)

May I ask why?

> Anyway it's good to know that module is used
> somewhere else. Thanks.
>=20
> >=20
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com=
>
> > > ---
> > > =C2=A0drivers/i2c/busses/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0| 4 ++--
> > > =C2=A0drivers/i2c/busses/i2c-i801.c | 4 ++--
> > > =C2=A02 files changed, 4 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kcon=
fig
> > > index f167021..78609ad 100644
> > > --- a/drivers/i2c/busses/Kconfig
> > > +++ b/drivers/i2c/busses/Kconfig
> > > @@ -89,8 +89,8 @@ config I2C_HIX5HD2
> > > =C2=A0
> > > =C2=A0config I2C_I801
> > > =C2=A0	tristate "Intel 82801 (ICH/PCH)"
> > > -	depends on PCI
> > > -	select CHECK_SIGNATURE if X86 && DMI
> > > +	depends on X86 && PCI
> > > +	select CHECK_SIGNATURE if DMI
> > > =C2=A0	help
> > > =C2=A0	=C2=A0=C2=A0If you say yes to this option, support will be=
 included
> > > for the Intel 801 family of mainboard I2C interfaces.=C2=A0=C2=A0=
Specifically,
> > > the following diff --git a/drivers/i2c/busses/i2c-i801.c
> > > b/drivers/i2c/busses/i2c-i801.c index b436963..9dcc417 100644
> > > --- a/drivers/i2c/busses/i2c-i801.c
> > > +++ b/drivers/i2c/busses/i2c-i801.c
> > > @@ -902,7 +902,7 @@ static const struct pci_device_id i801_ids[] =
=3D {
> > > =C2=A0
> > > =C2=A0MODULE_DEVICE_TABLE(pci, i801_ids);
> > > =C2=A0
> > > -#if defined CONFIG_X86 && defined CONFIG_DMI
> > > +#ifdef CONFIG_DMI
> > > =C2=A0static unsigned char apanel_addr;
> > > =C2=A0
> > > =C2=A0/* Scan the system ROM for the signature "FJKEYINF" */
> > > @@ -1020,7 +1020,7 @@ static void i801_probe_optional_slaves(stru=
ct
> > > i801_priv *priv) #else
> > > =C2=A0static void __init input_apanel_init(void) {}
> > > =C2=A0static void i801_probe_optional_slaves(struct i801_priv *pr=
iv) {}
> > > -#endif	/* CONFIG_X86 && CONFIG_DMI */
> > > +#endif	/* CONFIG_DMI */
> > > =C2=A0
> > > =C2=A0#if (defined CONFIG_I2C_MUX_GPIO || defined
> > > CONFIG_I2C_MUX_GPIO_MODULE) && \ defined CONFIG_DMI
