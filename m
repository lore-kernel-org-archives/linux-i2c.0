Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010031.outbound.protection.outlook.com [52.101.69.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B407402B99;
	Wed, 12 Aug 2026 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526432; cv=fail; b=lC0C9RiRcfjRYbnbxi17WTURhcz/LjjnaT91kZsjt44yBp+FRy4dvJZQR+E8/1e+0wRltoCLH2jNX04epTkmZmM4CFMi8+uffdV/W4VaqUJNB+grhIWxMtLCjX7VC9itv9BkzAK7cdUeY1seBI1Jpw0B7GPU6zmZxgqltoWCksc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526432; c=relaxed/simple;
	bh=gbhY2giD4W+5mEJp+Y22BWU2Lm82lhGKCfE63loNnnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vC8HGD85HSDS/ayfXb4c+74HVTBE51yVYd1Q06DD0LtReHWUEicS6H6f4RbKxERlo0FcmsPpsjosZN1rIt0iXOEoBna72IAKyyUu6fkdYPwNMuoAY+GsyQ74ZWswSmo4Ya6OZOmBUDBLqPwbvQh4zc116DeFPxaLpJPhIhx/V2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MS8Ae4ug; arc=fail smtp.client-ip=52.101.69.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MS8Ae4ug"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvAPEuA7ipRV9habtZ6j/WmW3qejou4wlKaehk+6pgJEGgM7qI4s43S1Rjqu1gH6vSfCqJfeM1/w0hUi6FYLkrwWHPnptz90Nme+5fh3Qk481+ZKw3tElFRPiEn3kTuRRuYHt/sMewLwUrqszBJfd6onLAbQV+HNrWyC0fv4ngYstXB70PKzQMXb2hsQSTglEpRM7RP+/GAORf713fPzh0L+IrqROw7Ldw51Ky8VuGBmeTsndni3AnaIponOdn56uOw8o1avx56KAr5Rtf+i8lZdT93cBj6lpVyM+4E8ew2FS09lFA0znDnTls4XJEtcOMAUA2gds6BijMZdxlWGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g/ZoYLzWMIbz86SHBpapBS7aDCVI1Z1+BvFw6sunQI=;
 b=GesEV6VoKEf7YWaY9uV7Z6N9OH2cmW5btkF7vb3JzlZfVp4ZUAV3O0eWn2wQDZkid0iOdRKRUqOsrlEZFOYKs8YudQcgWS+pf2NP9OzzWMeBefHIXUp9zr+6QE8l3ZZMkzTZdb+4PZzOxWwwSNtW3ZPCHlNk6GimBcuXEL29JaQ5tva5jA2tczuVMYXhCtsKCHzmK3jTsL0IJXwLDps9RTNMAqQEVVLm3I/hGhcC4XNCXhz/Ahd+SunfkM1nmcXRjP/0CksyoM6p2UV29kc1XTBeOZJDes9J8YPG0lq609ToKR+7aJndJjJ7raL9YsYO4c174Ix7fnS38lH6C2D97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g/ZoYLzWMIbz86SHBpapBS7aDCVI1Z1+BvFw6sunQI=;
 b=MS8Ae4ug1LHp7hStRatarhRDy5hQomIbiTMFBvMw3G9tuoDm2ebY5NtH9Wj7sIX28baqatOBPtUhUlKSUgqZ9xEOKSyJY80I0er1F7+vmGwBAqxi5bUb0xhvFpX0KKbcMn62GZSy7HUPp6ettrLC2UAYFJUgEeabfJa87J/9eETYVwKH9O8rLf2c+aCDKEgMmOgbVhErUmDYrT9+SclXtxZ5XFAUC4x8r48Seu07D4CytxroEkXuvihMW9OfvHugMN+LGddjZWmaQZ3gsPoB0SLODIPAGQwQGLrWIHl+h9vsc8fCZmOXJW0WQrur3GTQxzLETzy8Lx4ieREoDylB3w==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by DU4PR04MB10647.eurprd04.prod.outlook.com (2603:10a6:10:589::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 09:20:26 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 09:20:25 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>, "Carlos Song (OSS)"
	<carlos.song@oss.nxp.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Andi Shyti <andi.shyti@kernel.org>, Frank Li
	<frank.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] i2c: imx: add I2C_M_REV_DIR_ADDR and I2C_M_NOSTART
Thread-Topic: [PATCH] i2c: imx: add I2C_M_REV_DIR_ADDR and I2C_M_NOSTART
Thread-Index: AQHdJfRDYby9FhUcyEqAFsrecrVSM7aYpdlggAFKVQCAACqlcA==
Date: Wed, 12 Aug 2026 09:20:25 +0000
Message-ID:
 <AM0PR04MB680259939B7ED9AF5BA5957BE8DC2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References:
 <20260807-for-upstream-i2c-imx-lx2160-reverse-v1-1-f276ce8cb660@free.fr>
 <AM0PR04MB6802658862C4E2ED8628FFA8E8DD2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <anwI6qnsikPrd80W@L30177.local>
In-Reply-To: <anwI6qnsikPrd80W@L30177.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|DU4PR04MB10647:EE_
x-ms-office365-filtering-correlation-id: 47a58bd5-5a92-47aa-2341-08def852f1ad
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|19092799006|3023799007|6133799003|10067099003|56012099006|5023799004|11063799006|4143699003|22082099003|18002099003|38070700021|15866825006|41080700001;
x-microsoft-antispam-message-info:
 g9K2+cMId8LDfwuSYQJCV2wlb3RCJnSJsvDZmucjbmlYmfyVVv4lPsGpbjzCQCF550UV6nTGS1RZimaAu7N4qJ0xI57OCzzlC2axgq9rZgDjdvmoguvb7fEuaNxpwk7o6KH8D9yOzsTu2dAJbHgRScIJ9kvSFMUl7XaTPngG+1c5W1gmhTL/SdHSxIMSXp0CfC/0cwy8/PmiUnjL9UVhTTeiShX6+yZPdurr5YRsDrbDRpSgAI/Y292NroDRfnRaV6xCAmdjljfpp7H8Zi5qiFfBRUZ+WRu0Wjwq3fNaaDXSWLPlCe+bxRDs6M7c0wrD38Ig8Ft7vxlX+SGTCeXLE1kDflvmdD59TKhqKxH7IxBMG3SsSbrRJhli3VgtAVa3PtviZDyW2wLMfJ39SO9aW4iFqqTdAhlPEmTZU6EYbMo0w5b+aOx0HpM6koD+8Q1I2FrY4Tjp9E2cAw8xDPI1wdZ8AgAWMW1NS3A44zJoulGWYUrS1iGC3WpOWJrcbFCKx28wXAeDuv0BTggm/mFYieAFdkqtiC8a5QPeJgk/RLI1SxUTz0hx+D4YZyU+gwwD6HyO+Re+FeF92yXGF5qMoZ6ssYFRHQMopnTwnSEz62bzqkC7HRLgBRUxYgFH/odvDmonetcrAwQWhyNth/8hwXpK6oNsugrFmf1FAc3Ja15qJSVNXG3cn19iqdqRtC5NRB+SgNJVh9KPJD3cgSggv9xOOQtdF+UI5piXiwYDaBcRS/faRh9OqXBs75i7FycVePEFFPIwUJLjrFJOJu5vD/O25sk4xaqPnU/OQXXTbqM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(19092799006)(3023799007)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021)(15866825006)(41080700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HyV3Vs7mAJx0VibP78Ha3ddpzywsFww3dNkoZ50X5mNYcITwGVJ1z5HdsW1h?=
 =?us-ascii?Q?DYa4ed4YJX8Yfoom1VGjHWKP4rduzyGdLyqEmrD1tzZKUh+3hCOW7ICWl4Rn?=
 =?us-ascii?Q?qAhwWtHt7RFrdUX62z/bPWVrCV+s711pypZzyDB8Ld9FgQpQffDF4jjhmBc/?=
 =?us-ascii?Q?FLtUq7Xb3NGBH7o2DylXt4v1pyJgCzD30hv0Kxias0TtVFDDcp430ydYzcRR?=
 =?us-ascii?Q?akdkH0iziIYM53BxVDVbcGnApu+OlPTO2cMT2RN6xMcS5AOjsWBniGuekhT6?=
 =?us-ascii?Q?CO9neNfgP3Iq54quDyw3zgTWOeeQlEqRkf8qgWKXQD4dcKJMn0X6VQyMcmXj?=
 =?us-ascii?Q?r/6dqHsb3wXfF0izirVhCAkYkIFWuV4lhb02M4Ri+VKatQWVsQtJ7DLNqtcR?=
 =?us-ascii?Q?YXxdbkVy4PV37Tgr76lIDv2NkzclvmxYfA3gK8xFagtWrAAGlwOpxBrP7a8m?=
 =?us-ascii?Q?sVa8awbAYOJhazis7s2xJYcEjC15hyDwN3qYGndFH6DmYQLFx56ZycxAcYr0?=
 =?us-ascii?Q?1hg2uwlqD0Azo9HZW+JDZeI9JTGtg6dsvQZeK7YBJC8gtf/jVHfNXo0/DqRC?=
 =?us-ascii?Q?kGeLNX8iqo+6mwbMOnHltWGaPBpY6xfXS2NE3hxoLJH6Q8yN83pjYf9U+L1N?=
 =?us-ascii?Q?DD+STJ+POnrNkVCOlJtEVuXjDEbCj6F3GnIUiEVflbffOFmBZ1F1mIejNkwP?=
 =?us-ascii?Q?Ex6CNDcUqpbry6lCamhZnEc4GW2PDYfZJ6MsZRN64LIyE5sBfh06EFjXJrHI?=
 =?us-ascii?Q?OzP1nf/aRCTYHeHl/vVvSz4CpbmrrYCG2wm1g+EtVQ5Y6JPJXJP5w6pwAMCo?=
 =?us-ascii?Q?9c5zFeLs2ONlda1Pn7QcxPufzPQd8WFoWNJ8IPz/GSdm8MoAKM2UBiBcZJiK?=
 =?us-ascii?Q?gDd3a63LyN4xvCHLNAe0lwS2x31YUccZ8KQ3wUdZak9N0/sVsmsy1isdKyNd?=
 =?us-ascii?Q?Ch6Vd8bAdrYc3lZ4amR4kScP4FtwimwAS7pt4FV2diRF+P12K0eFAhH3LZd5?=
 =?us-ascii?Q?bTfrhf7QQW7vt2HMd7O1Oc3EgwN7YRJyUWwrV9dlkNZAAXmLyZ3GE1IB8//P?=
 =?us-ascii?Q?UtVm6uJh8ELu7ybbPoO8wZLP5jvF+mPVtOORMNknDbyRcbUd4OwT0DdONddI?=
 =?us-ascii?Q?z7EslD1JMnCkQLS4vAoCfOvCAc0K/DHxEhJuM8NiB/sGINGZVJ54r8IvvlX2?=
 =?us-ascii?Q?D3f5cpZcuMRZ7TV2EW4p3n5j+jVcfCKbahIQGwKe5veFfE0gC8vwomLWE3Kv?=
 =?us-ascii?Q?dtsgLbA5+2tU5jhpuNEHqE9fcQ4HFnfnnZHMTP0aGU81O1GX5YqrSG1Fo3k/?=
 =?us-ascii?Q?F1+kZbRb1cXHtxTWChl81aNbvJI9yqJI9ff3nOOi419INJeVCFfJe6S3Q4Dj?=
 =?us-ascii?Q?ad5s6Z7LvPPKtXdix05YWFqZ8Esw1pQ9o+aEUkks5tdsLHyt0EtgHQRo7rS1?=
 =?us-ascii?Q?GTXLLpirhsLDp9s/TmBfos/Kuv4YLZGa2RjGupJlqJxAgCIkQcpQ2/lokUm5?=
 =?us-ascii?Q?ytVS1Ub66wi2+IuI/agul2yrlxA8fYsh0jU3HUJ8AuuFj0dFcxhb4InDw/Kj?=
 =?us-ascii?Q?XcWKcZTJw79WQddkkYms7aUvkRAKwoEHjiDo8B1GHkAOGfKtOM6hpDj/o02x?=
 =?us-ascii?Q?meqIf1L2nJ/IIGatLVgPsbBUJVJJgh3ycqlq6zFY0evaVYLz8FYalHSyiAJC?=
 =?us-ascii?Q?iY8hPPByMp00SHGDcm06gZlqW/WT5jAioJIr62mllaMm2hSfO18AmpIxNipq?=
 =?us-ascii?Q?iKASCj9B/Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a58bd5-5a92-47aa-2341-08def852f1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 09:20:25.8681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0h10r1aFBcQYm81Y5IGGKz9AJ8TiY9ULU2vAjgAuYrZwu8eDhT+kQ8rJG5i4UNaMntZn+uJesTfnZN5WcnyCqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10647



> -----Original Message-----
> From: Vincent Jardin <vjardin@free.fr>
> Sent: Wednesday, August 12, 2026 1:47 PM
> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Andi Shyti <andi.shyti@kernel.org>; Frank Li
> <frank.li@nxp.com>; Sascha Hauer <s.hauer@pengutronix.de>; Fabio
> Estevam <festevam@gmail.com>; linux-i2c@vger.kernel.org;
> imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] i2c: imx: add I2C_M_REV_DIR_ADDR and
> I2C_M_NOSTART
>=20
> Hi Carlos,
>=20
> Thanks a lot for the review, and no problem for the delay.
>=20
> > This is a such rare i2c frame design in the Realtek RTL8366SE SMI read
> > frame, right?
>=20
> It is rare, but I have been inspired for I2C_M_REV_DIR_ADDR by the source=
 of
> two client drivers that use it.
>=20
> Note that I2C_M_NOSTART is not rare at all. It is what regmap uses for a =
real
> gather write. regmap_i2c_gather_write() opens with
>=20
>         if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_NOSTART))
>                 return -ENOTSUPP;
>=20
> FYI, some clients that need REV_DIR_ADDR and NOSTART,
>=20
>   drivers/input/joystick/as5011.c
>   drivers/video/fbdev/matrox/matroxfb_maven.c
>=20
> both build the identical 2-message pattern,
>=20
>   i2c_check_functionality(adapter,
>                                 I2C_FUNC_NOSTART |
>                                 I2C_FUNC_PROTOCOL_MANGLING)
>=20
> I do not have those devices, so I did not check it beside code readings.
>=20
> Some clients that need NOSTART alone,
>=20
>   drivers/base/regmap/regmap-i2c.c
>   drivers/infiniband/hw/hfi1/qsfp.c
>   drivers/gpu/drm/i915/display/dvo_ivch.c
>=20
> About the i2c masters, that use I2C_M_REV_DIR_ADDR in code,
>=20
>   drivers/i2c/algos/i2c-algo-bit.c
>   drivers/i2c/algos/i2c-algo-pcf.c
>   drivers/i2c/busses/i2c-s3c2410.c <- the model I did investigate
>   drivers/i2c/busses/i2c-tegra-bpmp.c
>   drivers/media/pci/cobalt/cobalt-i2c.c
>=20
> So a taxnonomy can be,
>=20
>   adapter            REV_DIR impl   MANGLING adv   NOSTART adv
> usable
>   i2c-algo-bit           yes            yes            yes
> yes
>   i2c-algo-pcf           yes            yes            no
> no
>   i2c-s3c2410            yes            yes            yes
> yes
>   i2c-tegra-bpmp         yes            yes            yes
> yes
>   cobalt-i2c             yes         (private adapter, not exposed)
>   i2c-brcmstb            no             yes            yes
> no
>   i2c-pxa                no             yes            yes
> no
>   i2c-tegra              no             yes         yes (cond)
> no
>   i2c-imx (this patch)   yes            yes            yes
> yes
>=20
> > Is Realtek RTL8366SE SMI driver upstream? Can I found the driver?
>=20
> Not yet, and I cannot point you at a tree today. It is Realtek's "Unmanag=
ed
> Switch" DSA driver, which is not public yet.
>=20
> What I can share is the message construction, which is the part you asked
> about and is not Realtek-specific.
>=20
>         static int as5011_i2c_read(struct i2c_client *client,
>                                    uint8_t aregaddr, signed char
> *value)
>         {
>                 uint8_t data[2] =3D { aregaddr };
>                 struct i2c_msg msg_set[2] =3D {
>                         {
>                                 .addr =3D client->addr,
>                                 .flags =3D I2C_M_REV_DIR_ADDR,
>                                 .len =3D 1,
>                                 .buf =3D (uint8_t *)data
>                         },
>                         {
>                                 .addr =3D client->addr,
>                                 .flags =3D I2C_M_RD |
> I2C_M_NOSTART,
>                                 .len =3D 1,
>                                 .buf =3D (uint8_t *)data
>                         }
>                 };
>                 int error;
>=20
>                 error =3D i2c_transfer(client->adapter, msg_set, 2);
>                 if (error < 0)
>                         return error;
>=20
>                 *value =3D data[0] & 0x80 ? -1 * (1 + ~data[0]) : data[0]=
;
>                 return 0;
>         }
>=20
> And the Realtek accessor, which is the same two messages with a 2-byte
> register and 2-byte data instead of 1 and 1:
>=20
>         u8 ra[2]   =3D { reg & 0xff, (reg >> 8) & 0xff };
>         u8 data[2] =3D { 0xff, 0xff };
>         struct i2c_msg msgs[2] =3D {
>                 {
>                         .addr  =3D client->addr,
>                         .flags =3D I2C_M_REV_DIR_ADDR,
>                         .len   =3D sizeof(ra),
>                         .buf   =3D ra,
>                 }, {
>                         .addr  =3D client->addr,
>                         .flags =3D I2C_M_RD | I2C_M_NOSTART,
>                         .len   =3D sizeof(data),
>                         .buf   =3D data,
>                 },
>         };
>=20
>         ret =3D i2c_transfer(client->adapter, msgs, 2);
>         if (ret !=3D 2)
>                 return ret < 0 ? ret : -EIO;
>=20
>         *val =3D data[0] | (data[1] << 8);
>=20
> msgs[0] is a write message carrying I2C_M_REV_DIR_ADDR, so the address
> byte goes out with the read bit set while the master keeps transmitting t=
he
> two register-address bytes. msgs[1] is the read half with I2C_M_NOSTART, =
so
> no repeated start is emitted and the controller simply turns the bus arou=
nd.
> Writes are an ordinary unflagged 4-byte write and need nothing from this
> patch.
>=20
> > ... Have you test this i2c-imx feature in your LS board with RTL8366SE?
>=20
> Yes, on an LX2160A board carrying four RTL8366SE-CG. Two are strapped to
> the chip's 2-wire "EEPROM SMI" mode and hang off hardware i2c-imx
> controllers; the other two are on MDIO, for both the same switch register=
s are
> reachable both ways and should answer the same values.
>=20
> First, the failure on an unpatched kernel, which is reproducible with not=
hing
> but i2ctools and is I think the clearest way to see the problem.
> These two commands are byte-identical:
>=20
>         # i2ctransfer -y -f -a 1 w2@0x7c 0x00 0x13 r4@0x7c
>         0xff 0xff 0x00 0x00
>         # i2ctransfer -y -f -a 1 r6@0x7c        # no preceding write at a=
ll
>         0xff 0xff 0x00 0x00 0x00 0x00
>=20
> Then, with this patch both chips answer correctly. For testing this patch=
, I did
> use the following that I have just pushed to help, for the record:
>=20
>         https://github.com/vjardin/smi-probe
>=20
>         # smi-probe -t i2c -b /dev/i2c-1 -a 0x7c id
>         chip_num    0x6980  CHIP_RTL8367E (inside RTL8366SE-CG)
>         chip_ver    0x0030
>         svlan_tpid  0x88a8  reset default, as expected
>=20
>         # smi-probe -t i2c -b /dev/i2c-1 -a 0x7c rd 0x1300
>         reg 0x1300 =3D 0x6980
>         # smi-probe -t i2c -b /dev/i2c-1 -a 0x7c rd 0x1202
>         reg 0x1202 =3D 0x88a8
>=20
>         # smi-probe -t i2c -b /dev/i2c-2 -a 0x5c rd 0x1202 # U19, IIC3
>         reg 0x1202 =3D 0x88a8
>         # smi-probe -t mdio -b 0x8b97000 -a 0x1a rd 0x1202 # MDIO
> control
>         reg 0x1202 =3D 0x88a8
>=20
> Then it binds as a DSA switch and enumerates its four user ports:
>=20
>         realtek-US-switch-dsa-i2c 2-005c: RTK DSA unit 0 (EEPROM SMI,
> addr 0x5c)
>=20
> I have many other i2c devices on this board, no regression.
>=20
> Thanks again for your review,
>   Vincent


Hi, Vincent

Thank you very much for such clear instructions. That helps lot to understa=
nd what happened.
Follow this, I also spend some time to learn and understand this case.

1. Why need I2C_M_REV_DIR_ADDR but not directly read?
The msg with I2C_M_REV_DIR_ADDR is a write msg in fact, it is a write messa=
ge, master write data and target ack,
only w bit is toggled to r bit.
Because the device don't follow the standard I2C spec, it need this special=
 frame to write:
[1] S + addr + r + [ACK] + data +[ACK] + data...
Yes, not wrong, a read bit on bus but it is a write msg for this device.

But the standard spec write msg is
[2] S + addr + w +[ACK] +data + [ACK] +data
So add this I2C_M_REV_DIR_ADDR flag to make this write msg w bit is changed=
 to r bit, msg [2] become msg [1] so the device worked.
Only change the r/w bit, other data flow keep write logic.

2. What I2C_M_NOSTART is doing?
It help skip the msg repeat start header, next msg start from data. If the =
first msg setting this flag, it should be unsupported(so you add a loop che=
ck to make sure the first msg without I2C_M_NOSTART flag).

3. The msg with I2C_M_NOSTART should keep the same direction with pre msg?
No, not need. For example, RTL8366SE frame:

(1){S Addr Rd [A] reg[7:0] [A] reg[15:8] [A]} (2){ [data[7:0]] A [data[15:8=
]] NA} P

For (1):
{S Addr Wr [A] reg[7:0] [A] reg[15:8] [A] is a write msg and "change the Wr=
 bit to Rd bit" by I2C_M_REV_DIR_ADDR.
So i2c bus signal is
{S Addr Rd [A] reg[7:0] [A] reg[15:8] [A]}

For (2):
{Rs Addr Rd [A] [data[7:0]] A [data[15:8]] NA} is a read msg and "skip the =
{Rs Addr Rd [A]}" by I2C_M_NOSTART.
So i2c bus signal is [data[7:0]] A [data[15:8]] NA.

This is a write msg then a read msg. So you add the I2C_M_NOSTART flag hand=
le in these 4 path: atomic read/irq read/atomic write/irq write.
Do I understand right?


About code, Could this part of the code be improved? Of course, that's a ma=
tter of personal preference.

@@ -1583,6 +1622,27 @@ static int i2c_imx_xfer_common(struct i2c_adapter *a=
dapter,
        struct imx_i2c_struct *i2c_imx =3D i2c_get_adapdata(adapter);
        int use_dma =3D 0;
=20
+       for (i =3D 0; i < num; i++) {
+               /*
+                * I2C_FUNC_PROTOCOL_MANGLING is advertised for
+                * I2C_M_REV_DIR_ADDR only; reject the flags it also covers=
 but
+                * that this driver does not implement, rather than silentl=
y
+                * transferring something the caller did not ask for.
+                */
+               if (msgs[i].flags & (I2C_M_IGNORE_NAK | I2C_M_NO_RD_ACK |
+                                    I2C_M_STOP))
+                       return -EOPNOTSUPP;
+
+               if (!(msgs[i].flags & I2C_M_NOSTART))
+                       continue;
+
+               /* Nothing to continue from, and a zero-length continuation
+                * would leave the controller with no byte to clock.
+                */
+               if (i =3D=3D 0 || msgs[i].len =3D=3D 0)
+                       return -EOPNOTSUPP;
+       }
+
        /* Start I2C transfer */
        result =3D i2c_imx_start(i2c_imx, atomic);
        if (result) {


I prefer this:
1. Do a single function for this check.
static int i2c_imx_check_msgs()
2. Add macro definition.
#define I2C_IMX_UNSUPPORTED_PROTOCOL_MANGLING_FLAGS \
	(I2C_M_IGNORE_NAK | I2C_M_NO_RD_ACK | I2C_M_STOP)
3. drop continue and use:
		/* NOSTART-specific sanity checks. */
		if (msgs[i].flags & I2C_M_NOSTART) {
			/*
			 * NOSTART continues an already open frame. The first
			 * message has nothing to continue from, and a
			 * zero-length continuation leaves the controller with
			 * no byte to clock.
			 */
			if (i =3D=3D 0 || msgs[i].len =3D=3D 0)
				return -EOPNOTSUPP;
		}

It is up to you. All in all, I think this patch is nice for me and thank yo=
u again for the improvements.

Carlos Song

