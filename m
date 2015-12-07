From: Gao Pandy <gaopan@freescale.com>
Subject: RE: [Patch V1] i2c: imx: init bus recovery info before adding i2c
 adapter
Date: Mon, 7 Dec 2015 02:45:13 +0000
Message-ID: <CY1PR0301MB0858B65C8F06804400B791F4CF090@CY1PR0301MB0858.namprd03.prod.outlook.com>
References: <1449221594-29603-1-git-send-email-b54642@freescale.com>
 <20151205190736.GD1597@katana>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_CY1PR0301MB0858B65C8F06804400B791F4CF090CY1PR0301MB0858_"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0130.outbound.protection.outlook.com ([65.55.169.130]:58039
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754998AbbLGCpY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 6 Dec 2015 21:45:24 -0500
In-Reply-To: <20151205190736.GD1597@katana>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Li Frank <Frank.Li@freescale.com>, Duan Andy <fugang.duan@freescale.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>

--_002_CY1PR0301MB0858B65C8F06804400B791F4CF090CY1PR0301MB0858_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,=20

	Sorry for it.=20
=09
	I have sent out an i2c runtime patch which was acked by Uwe Kleine. I thou=
ght it would be accepted, so I sent out this one based on that one.=20


Best Regards
Gao Pan =20

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: Sunday, December 06, 2015 3:08 AM
> To: Gao Pan-B54642
> Cc: u.kleine-koenig@pengutronix.de; linux-i2c@vger.kernel.org; Li Frank-B=
20596;
> Duan Fugang-B38611; kernel@pengutronix.de
> Subject: Re: [Patch V1] i2c: imx: init bus recovery info before adding i2=
c
> adapter
>=20
> On Fri, Dec 04, 2015 at 05:33:14PM +0800, Gao Pan wrote:
> > During driver probe, i2c_imx_init_recovery_info() must come before
> > i2c_add_numbered_adapter(), because the get/set_scl() functions are
> > assigned in i2c_register_adapter() under the conditon that bus
> > recover_info are initialized. Otherwise, get/set_scl() function
> > pointers never get assigned.
> >
> > In such case, when i2c_generic_gpio_recovery() is used for bus
> > recovery, there will be kernel crash because bri->set_scl is NULL.
> >
> > The solution to this bug is moving i2c_imx_init_recovery_info() before
> > i2c_register_adapter().
> >
> > Signed-off-by: Gao Pan <b54642@freescale.com>
> > Signed-off-by: Fugang Duan <B38611@freescale.com>
>=20
> Makes sense, but I can't apply this one. What is it based on?


--_002_CY1PR0301MB0858B65C8F06804400B791F4CF090CY1PR0301MB0858_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Mon, 07 Dec 2015 02:45:09 GMT";
	modification-date="Mon, 07 Dec 2015 02:45:09 GMT"

Received: from BY1PR0301MB0855.namprd03.prod.outlook.com (10.160.193.149) by
 DM2PR0301MB0863.namprd03.prod.outlook.com (10.160.215.149) with Microsoft
 SMTP Server (TLS) id 15.1.331.20 via Mailbox Transport; Mon, 30 Nov 2015
 08:06:39 +0000
Received: from BLUPR03CA008.namprd03.prod.outlook.com (10.255.124.25) by
 BY1PR0301MB0855.namprd03.prod.outlook.com (10.160.193.149) with Microsoft
 SMTP Server (TLS) id 15.1.331.20; Mon, 30 Nov 2015 08:06:37 +0000
Received: from BY2FFO11OLC005.protection.gbl (10.255.124.4) by
 BLUPR03CA008.outlook.office365.com (10.255.124.25) with Microsoft SMTP Server
 (TLS) id 15.1.331.20 via Frontend Transport; Mon, 30 Nov 2015 08:06:36 +0000
Received: from metis.ext.pengutronix.de (92.198.50.35) by
 BY2FFO11OLC005.mail.protection.outlook.com (10.1.14.145) with Microsoft SMTP
 Server (TLS) id 15.1.331.11 via Frontend Transport; Mon, 30 Nov 2015 08:06:34
 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] ident=Debian-exim)
	by metis.ext.pengutronix.de with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1a3JTj-0001Um-Tw; Mon, 30 Nov 2015 09:06:31 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.84)
	(envelope-from <ukl@pengutronix.de>)
	id 1a3JTi-00059o-Qt; Mon, 30 Nov 2015 09:06:30 +0100
From: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Gao Pandy <gaopan@freescale.com>
CC: "wsa@the-dreams.de" <wsa@the-dreams.de>, Li Frank
	<Frank.Li@freescale.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, Duan Andy
	<fugang.duan@freescale.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>
Subject: Re: [Patch V9] i2c: imx: add runtime pm support to improve the
 performance
Thread-Topic: [Patch V9] i2c: imx: add runtime pm support to improve the
 performance
Thread-Index: AQHRD7tqeq2V6i7sA0aeuOgo6ktGtp6LIKGQgCkCDJCAAEnlAA==
Date: Mon, 30 Nov 2015 08:06:30 +0000
Message-ID: <20151130080630.GG10431@pengutronix.de>
References: <1445842521-26222-1-git-send-email-b54642@freescale.com>
 <DM2PR0301MB08630A714625556EE4D3F773CF000@DM2PR0301MB0863.namprd03.prod.outlook.com>
In-Reply-To: <DM2PR0301MB08630A714625556EE4D3F773CF000@DM2PR0301MB0863.namprd03.prod.outlook.com>
Content-Language: en-US
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-AuthSource: BY2FFO11OLC005.protection.gbl
X-MS-Has-Attach: 
X-MS-Exchange-Organization-Network-Message-Id: 37bd55a3-5783-4b9a-ce4c-08d2f95d2a50
X-MS-TNEF-Correlator: 
received-spf: None (protection.outlook.com: pengutronix.de does not designate
 permitted sender hosts)
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <98953856E73E934AAA25489062B34446@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

Hello,

On Mon, Nov 30, 2015 at 03:42:15AM +0000, Gao Pandy wrote:
> Ping...

The things I pointed out were fixed. I didn't test it, but the patch
looks reasonable. I'd say it's ready to cook in next until the merge
window opens next time.

If you want to interpret this as an Ack, feel free to do this.

Best regards
Uwe

--
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            =
|
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--_002_CY1PR0301MB0858B65C8F06804400B791F4CF090CY1PR0301MB0858_--
