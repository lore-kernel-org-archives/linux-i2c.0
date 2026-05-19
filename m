Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010004.outbound.protection.outlook.com [52.101.69.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431EC233956
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186572; cv=fail; b=DMuQMnfK2eI7YbRWrGYz25YufwkTKcaBd30BayOnOV6+dfyx7AFQsYA6uIpcBANK3lK1CMdd4a6VyyPXW/1yUt3kz5K1Bk1lbxzWNAkip6ZxO2U6VP3eFV8PobvI/Yl4InQBKYtxe9fR0RQGcwRGzxj5UYEhpmHbNd32yHAQnIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186572; c=relaxed/simple;
	bh=063L4fGo6e7EDlHRm79dr8amqOoUmIQYQ8kDGyWVugY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MroE5wNeIW4cbYxAYbKkOSWUG5a6AXhfQnrys0lxz9Y2AJd1zbgVRflo/YutW+h2kik5KHV8HU7gwyYhtiwJWln99tyv0TQpxQxv7+PUMtg4RJl4VaBxugb35uiB/q7oC5kPebPuDwGeQN0uRfI3SBNk41zufKZhQq+T6o+M1b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RAVQwlWR; arc=fail smtp.client-ip=52.101.69.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RAVQwlWR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUlVA6tNoYmDOqr7D4ymkm8q47YvBaNjtxQnos6oUD3J5DyRQ6RjUSzewD3mjaT+pPVtC5YC6q2M0c1mWDSEJhl/y+xC3XIBMKKgq8rlAl9AwtdmDh0MBtlUDnKz/A9unfBYUL0joSWYBSVfBJA+d84/hvn+6WAwvWk7vq+C7XHHlrXAyNrcdkvfjS6k9iqTYa5uXLNCTcq/fVzHCLJxo9iIXKNLwPnM6Lkl025CfN20F6g46LByjLh8NBq6mZT4h12rjymvesLLQPS9B7rtSIKTXJjvjfceD9OybakJyl/HRQon9F2+lICVSGzT4MxoVs7lD2AWyLmCp4iDpvXXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am7jvwkbY6jyqfuriP3RFgX+2K8jxunc+OAC35XrW/Q=;
 b=WHz3W1/nJs34C72OXZGwubQVpA0/pIbEZvdsxHmTp+AFedqumFoe6IdP2bFXhkTC4RlxP9DAWUN639dlKCw11LaD0ypjhozbdbdL1rtiSDfIzmaWonZ4gxRmT2t5UheGVzlC6dUJzfAraDxaFveT9/NW/WQI45jO7ovY8zykorGvi7v3yj2ZGokbZpoIcDmFkPfQ1PyyCH52mx/OzbVhh1yNXS22sWAV0vSTK7wVutlgFTVVERJMiOc00bhnJA0v4qwLI12Wsz5BMznJE/wlYK3+1BJJlZa1/djZ+EqQhy9wsAPCOa3gwmBtEWiJ9vdkcjspNRl722NtuczcI32TOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am7jvwkbY6jyqfuriP3RFgX+2K8jxunc+OAC35XrW/Q=;
 b=RAVQwlWRPD8XfLlsvSfP6W8J+K8EQJs6Bz+WvnwBhS99uk4S7CYDQzPMzQDu1nUBSA2skaVQebgcNi+R6nDWKzvAF88EpjnN16pHd8wNHIMgNvpKTc1MF+Irs9dsr6ZrySqE5sCUHFQuxj117yGXQoXL+QPuhPnTXjwDprwdo5U86VaSnomVBfVyMkN4es9Lonklp/EOz0rQvCnA2r3an98ArVxKpRDb6qIbU+yODM95WBk6Pd7ATCLDw4JFUEvFb4EGhg/lBm/CsdrNH+49WNKn+3KaNrtNmn8B+o31rBolfJe24HNmbfY5EKix7zULEWkYbXj9cuqe6e8PxldZFQ==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by FRWPR04MB11175.eurprd04.prod.outlook.com (2603:10a6:d10:171::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 10:29:23 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 10:29:23 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Dan Scally <dan.scally@ideasonboard.com>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Andi Shyti <andi.shyti@kernel.org>,
	Frank Li <frank.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, Gao Pan <b54642@freescale.com>, Fugang Duan
	<B38611@freescale.com>, Wolfram Sang <wsa@kernel.org>, Oleksij Rempel
	<o.rempel@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: RE: [PATCH v2 1/2] i2c: imx: Don't recover bus when arbitration lost
Thread-Topic: [PATCH v2 1/2] i2c: imx: Don't recover bus when arbitration lost
Thread-Index: AQHc53pc4k+85GXPs0Ks28dbDeCpbw==
Date: Tue, 19 May 2026 10:29:23 +0000
Message-ID:
 <AM0PR04MB680225F01902AD7990E4B6E5E8002@AM0PR04MB6802.eurprd04.prod.outlook.com>
References: <20260424-i2c-imx-fixes-v2-0-34fb9504aaeb@ideasonboard.com>
 <20260424-i2c-imx-fixes-v2-1-34fb9504aaeb@ideasonboard.com>
 <aa1a6931-1a98-4f72-b8fc-ae05df28f931@ideasonboard.com>
In-Reply-To: <aa1a6931-1a98-4f72-b8fc-ae05df28f931@ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|FRWPR04MB11175:EE_
x-ms-office365-filtering-correlation-id: 404e936e-0011-4ec6-b88c-08deb5917ea9
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|7416014|38070700021|22082099003|56012099003|11063799006|18002099003|4143699003;
x-microsoft-antispam-message-info:
 0gQc0pwAyERDFDtr+gDgZnOhwCUl+j3psV1wLLAgj7nsWu0jdQK8tiLGxbQrToasVhJXEk2A+rGtIPO2cvF83vg6LEGA++uk8U03GNYA/9i8RbRFZgiuLa+r6qkXrRp0BZe9fwzTI+t1eBeGIZpK9AXjbku75M3YWISZ+in6VPyW/79bHI+kfvh+LGFcQelE2JY9Vsi6/r5AtYEQ8WlOCnsbDgOIzlw+ktcVMMVAecQi2VIrdbT5lN57me0gWYmx4Wan+RdXCefheDUGqvYHjiyYlsdyk09I58rzSG4+s1DuUmcRVyye1t4kAx0KRhXsuUWDlwVyOCcJCnmldkk3vYxurUzcdoonFUFY0eX1tF+a+1ZybhvvzBqTmj0bWd2lFNZ4J+cmdMqLlNxXDbQzRGLLYpq11VQwiXfEl0Rm4mCS3A+aCAfx+XUiOgJwpZoKq8XHpamamUtLF9db54ph9IOScElmIFZ1/gsjUw1UwL7QmXJpDBZGpMI1bv0Y1WWSnDssh0Jx0SyjzaLfjeI+tZdOGRxnxfQXt/mBCTrY4nIf+jJHhi5Cot7fDU+9j8Ywk7EWndLiKgPG5z416P5HpNbBiQxJ0TSd5+9On2JEX3J1t/HP9Td0KKgUGBadyvOl1ZDRK3vLJWtCz0vpIXtv6n5od0/bsW56fzqRJywRsj3ipAmbIAC9qPIYkCf6GM6/7nCi6suT//2C7Owl8MCJuRKVavtwp2TRNCd6LWIGrrZyITWA7/0HFx/5qCZ9LAdx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(7416014)(38070700021)(22082099003)(56012099003)(11063799006)(18002099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?deVZ6Oq+ht7owonsMPpvoWe8g97YWANEQWYOz8wO9a6p6YqzUW0ZsjSvzPsF?=
 =?us-ascii?Q?7uRi8vVPYsVductmmRMUI/CSG28wqERR5HggIAknuGpT2CXT3Bb6W7/RZ3/c?=
 =?us-ascii?Q?03kNydHqTKedrp0ddQGYu5qs9R7RYlgJrdyS5ie0VjPnY0p12dWvnSe6r3Rm?=
 =?us-ascii?Q?fMi93EvVAEB+UyOpyB6D8mt14rddDCwb8VX+ThPpGPVm0jqlJBTbo75L52IQ?=
 =?us-ascii?Q?LpJTcmpoECz3BKP+rv6nWcf1zfA9R6zUhrmDcvweJEKiXrhjMug2O5e7mdrB?=
 =?us-ascii?Q?Yy5F3WwEyCCMydvlN4Nv654JMjZUCY+JxmkrDXO0mroZag7pbStXvrVVsTgq?=
 =?us-ascii?Q?4g9djE2SZWFjd01n0LKPbSyCtW5E+D/YprsYaL4OeE+0S52MSGb3h3TP10Dm?=
 =?us-ascii?Q?Z+GfcOpsy06/bJCPOcZVx16knlRYzxwVGF6ZDKzrcz/PkefkfW9kLCzEsQEn?=
 =?us-ascii?Q?TRp7gReE14oJh3wD6SsSPuB006AIHeijKHUmSNMJAhZMcZMuczU3KwE23uw/?=
 =?us-ascii?Q?RllQWj8eK148UvFyK7KM+BrXf16E7+Cbl03JNYemsA1R0acSLLy1t+wcRaNi?=
 =?us-ascii?Q?Al4qwPBWWTvPpejh5PCOKV5peBc+05giogjsh9rpVAdKaVh6yhMXF7AefGpq?=
 =?us-ascii?Q?tzD5VXtjOpLYBrs+OcgP7EASA1dFasdtZDKCqO4VTi4XMI4PiJwOB999l4ye?=
 =?us-ascii?Q?1gNPZmc61/1QG0lCasWGptfhvfqG+H8VS7emcviaE0YMEFs+IhQHiy8Eqi37?=
 =?us-ascii?Q?Pe6zMbmqhdSfJ0g+uaKlkTFtY2fLN9LfHcvw7Rqy53WCEcuZyIVLs3P+SzgE?=
 =?us-ascii?Q?QaZ47MZZBcr5p3FTRyneuXTP/nracBy6fWRnkStXJC4659zM69bFBDx97LDD?=
 =?us-ascii?Q?fuBCgkjT7jPqaACezX+/r4Y/DwplyfWP7axBkiHu+wTLR5k+9m8ObJqs6OkV?=
 =?us-ascii?Q?3Lt0svhvpDKxqL/zopiHy2tDEVm+tMAMcqwP8oD3lBCkc4hsOID+78n3C+kl?=
 =?us-ascii?Q?xhqHLE8Vg1ya2A6QXLjbAD+KLgkyZ7anFRizI1pYWxs7Xzy+Wq2wYlkM6u5n?=
 =?us-ascii?Q?DDvLkIpxjFEw6kVQshrJWrdhGF8ovX/GBoIopXlTd6zk4dddUgu1SL2+Ff5W?=
 =?us-ascii?Q?Ks4M+5+qVPN4FsHLfUK5rP6x9LloEzobf0TpwbK3gLVebGDFl27/bQ/gjMDk?=
 =?us-ascii?Q?ligOeu6TjQh1Y0n06+Bm3blVhRX15X7TR39IqXY/oGOpKx5/PDjuaNiH/s0B?=
 =?us-ascii?Q?LwmCJ9PFxuDskAzfCfOmdXlZatglTqGNahNcEjb74HtSkeNB3zP+JsoQXzV5?=
 =?us-ascii?Q?Nn2ZjyYV50I+S0sRxOvKbW6Wt2NtvGfb+Z7iw8p+uyJzX+kJDBXWsTE1mN++?=
 =?us-ascii?Q?56z6FhfAO0P1l8YXYsnZ2NqbFXhqMpJwoS3j5Wo77y7hER5uMcJk+1xHgNFI?=
 =?us-ascii?Q?k95bB2Z40IQ0U5V5fzJaEQN5AwgRnZBiMxD6BQKLahNMF4RRoltzgHJByklS?=
 =?us-ascii?Q?spWU6bQCsMbsXX6gvT13TUwZahLZCPE/PP2ZrUeLsUUYPYmiaTPQ322id04y?=
 =?us-ascii?Q?1IhMCXSSc0t4eAiKaOq230BX6PXeQj6S/fLiXXEMGVIKuovOdNlO5ZhqInoT?=
 =?us-ascii?Q?JHOw80XBAFtC7s2T+nF6DGdvnVHu+hrq9VzjjFv7JceVS3dw6KsSxWGYYicU?=
 =?us-ascii?Q?pmUriEsVfWax/K0IdhMOQvZdVtK+LpYMFQXvnz0yG59d/Av/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404e936e-0011-4ec6-b88c-08deb5917ea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 10:29:23.2813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vmW7CcSNkafIEtECm/fizEYTvEe+win/1Ppz+ZMxA2XdiqIsUDQJKL+bAcLyEamG/B5I5dX765NuL0nSYRjeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11175



> -----Original Message-----
> From: Dan Scally <dan.scally@ideasonboard.com>
> Sent: Tuesday, May 19, 2026 4:42 PM
> To: Oleksij Rempel <o.rempel@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>
> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; Andi Shyti <andi.shyti@kernel.org>;=
 Frank
> Li <frank.li@nxp.com>; Sascha Hauer <s.hauer@pengutronix.de>; Fabio
> Estevam <festevam@gmail.com>; Gao Pan <b54642@freescale.com>; Fugang
> Duan <B38611@freescale.com>; Wolfram Sang <wsa@kernel.org>
> Subject: Re: [PATCH v2 1/2] i2c: imx: Don't recover bus when arbitration =
lost
>=20
> [You don't often get email from dan.scally@ideasonboard.com. Learn why th=
is is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Hello Oleksij / all
>=20
> On 24/04/2026 13:36, Daniel Scally wrote:
> > In i2c_imx_xfer_common(), the driver attempts bus recovery whenever
> > i2c_imx_start() fails. One of the failure modes for i2c_imx_start() is
> > an arbitration-lost signal which results when a second I2C master on
> > the bus tries to control the bus simultaneously, which is a normal and
> > expected behaviour.
> >
> > Bus recovery is not the right response for this case. Add a check for
> > the -EAGAIN return code to avoid running the bus recovery.
> >
> > Fixes: 1c4b6c3bcf30d ("i2c: imx: implement bus recovery")
> > Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
> > ---
>=20
> I raised this patch after we had issues with one of the i2c controllers o=
n imx8mp.
> In that case, the bus had multiple masters that were causing the SoC's i2=
c
> controller to lose arbitration. The result was that the framework attempt=
ed to
> run i2c_generic_scl_recovery() and regularly hit the "SCL is stuck low, e=
xit
> recovery" message [1] because the bus was busy rather than stuck.
>=20
> I'm now experiencing a different issue with the imx8mp in which a differe=
nt
> controller - which isn't on a multiple-masters bus - starts transacting f=
ine early in
> boot, but then seems to get stuck - any attempt to start a transaction by=
 either
> a driver or i2ctransfer results in the IAL bit in I2C_I2SR being set and =
so the
> driver reports that it's lost arbitration [2]. In this case, the bus reco=
very is
> needed to fix the problem, and so this commit hurts things rather than he=
lps
> them. This problem isn't consistent - I get it on maybe 10% of boots.
>=20
Hi Dan,

This is the RM shows:

Arbitration lost. Set by hardware in the following circumstances (IAL must =
be cleared by software by
writing a "0" to it at the start of the interrupt service routine):
* I2Cn_SDA input samples low when the master drives high during an address =
or data-transmit cycle.
* I2Cn_SDA input samples low when the master drives high during the acknowl=
edge bit of a datareceive
cycle.
For the above two cases, the bit is set at the falling edge of the ninth I2=
Cn_SCL clock during the ACK
cycle.
* A Start cycle is attempted when the bus is busy.
* A Repeated Start cycle is requested in Slave mode.
* A Stop condition is detected when the master did not request it.
NOTE: Software cannot set the bit.
0 No arbitration lost.
1 Arbitration is lost.

From my understanding:
The IAL (Arbitration Lost) bit is set not only when true arbitration is los=
t, but also in several other conditions:

- SDA is sampled low when the master drives it high (during address/data or=
 ACK phase)
- A START is attempted while the bus is busy
- A STOP condition is detected unexpectedly
- A repeated START occurs in slave mode

So in practice, IAL can be asserted not only by real arbitration loss, but =
also when the controller detects abnormal bus conditions.

Since your system is single-master, this is unlikely to be a true arbitrati=
on scenario. Instead, it is more likely caused by signal integrity or timin=
g-related issues, such as:
- weak pull-up / slow rising edges
- noise or glitches on SDA
- timing violations from the slave device
- others

As a workaround, you can enable the 'single-master' property to disable arb=
itration checks in single-master systems, for example:

&i2c1 {
    clock-frequency =3D <400000>;
    pinctrl-names =3D "default", "gpio";
    pinctrl-0 =3D <&pinctrl_i2c1>;
    pinctrl-1 =3D <&pinctrl_i2c1_gpio>;
    scl-gpios =3D <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
    sda-gpios =3D <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
    single-master;
    status =3D "okay";
};

Hope it will help some.

Carlos
