Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8811684BE;
	Wed, 21 Jan 2026 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977791; cv=fail; b=QdaQa+/Zndoav+25Dr2dbST3pvAGZs820GS1M8gjUJvPIVdJmG755EwWzoeqech9nt+jVwzosi4c56+lJJVn3SD1zZMEtG8CxczPrTJvFIcfHJuqF/LeOr6iYv83nvzwWVg7fSWTn7+zGJiqhSsYaiiMOCRMQCdvlvzTjrjvmgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977791; c=relaxed/simple;
	bh=2Ep+2ZJ409PvTllxGsgFba/Df943BKmEHy5BmUb3Cxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dq+XBExANPq0yKF6Dqapp56c1rMCDhdK0l0PXMVBs0MI/Oz5x23GPzga0qeOROrhzY/JvBAl/pWUGZmCVyOJLURh+UBVBJobECREVirou8XA/e2Vdwl3sCsbNcb2U4mM5rD2fumjF5/SgNdgQndmiSOiCOcTzcmNB4jJweXrhOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y+7eZC2O; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y+7eZC2O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKrXVZKhPRUNQy96NoSms6ALBTvPdyw7yrgBl/OQ56PbwdKW/LnJhwVPVrbUphD1GKb/Er4QBD2HBLtmo2tyMdNj2+YnllQxvvDofLiODyH6J+nvEtS9IAEG1addV2PDZsHGY/dXHS5e6X/CO6+oBb8ONKseUfdnGqACuKCCRp3dOgl72Xr35W7NrYxp4OLCOgWDZP4362/MaBg/COjhvcT9OVORQvxXYmhoPqKsX1QX2bgUhQNUWSoyliarY8OHyvGkFsa+3YF4SWYIB1XgM+mkMuRtVXkecIl1ZvhJQ1RR/um+DlRwWlv6eAF+oCKUqVXQCmZ3iTMQC54H9daw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z21h9A42Pflamw5K/Cfu/pmF3+JtiJG0wDs428wPsvk=;
 b=LHESt+Yr6Kf+otSbMmyEysou5SzeZQIPnkNW3cFCnSao+rS8Ee6DJXZhEU39weM221Ds54hHAlcch0lknu47UUoFC3ynPmiGuxMuu5t0uwLN8oaODhy6AyCmMsERbrF61mG4ah8fO7Y31I4qwEaiRDTSXj1TxpWWyVQoHRQDb+Ud2kN9jMPhpB10EIiA6JWNgdqEowFKus7YtIft1l2Fu1bNB5+CxCCtSOWiF4Veo6TWOdeDSDOjzIEayZ4F9pz1Urmp/slz3+ECND46vsXYEAAm51ny0ZSwQ5VWx5JFZvG3B6eg1X6qRvcOLFcUr+S7vn8I2+0i39Fq8a2XrVTmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z21h9A42Pflamw5K/Cfu/pmF3+JtiJG0wDs428wPsvk=;
 b=Y+7eZC2OYXLe0pSgPBWgc8NqsWz1HTxwrvMaHoJYigWHCwuLKe1FXVx7ZUyush1Q0j6EEJAudJts3bRHrQ2ZtVoeeyFPJ+9UecDD4iNjVxEHc8NPhm12piVeLUu/2eMw0LY85Ql1sN1J8nQ5kLIQoyjXSYzX9gkg/37CYZmAcEumEaylFS2bPw4X5gV0JG6tUNFnqu/j+yfhP/o9t1fyWlSYAjAYHQK4AqRxlHr7c3rhjH3xl3Jt5jgQxEtjo0Gmu2AJ1bbFaxp/IeDOs5baWzWIxuMd8ecu/IpJvPhq134tYggUR9p6YWg6ipiN9rrtz+FDu/1ay0W+ZX/5PbxwKQ==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by AS8PR04MB8277.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 06:43:05 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1%3]) with mapi id 15.20.9520.009; Wed, 21 Jan 2026
 06:43:05 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: Frank Li <frank.li@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "vz@mleia.com" <vz@mleia.com>,
	"wsa@kernel.org" <wsa@kernel.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] i2c: imx-lpi2c: support smbus block read feature
Thread-Topic: [PATCH v2] i2c: imx-lpi2c: support smbus block read feature
Thread-Index: AQHciqD4iZGxTCOuFEu77Xns39YlRrVcLPaA
Date: Wed, 21 Jan 2026 06:43:05 +0000
Message-ID:
 <VI2PR04MB11147F5B660417134E6F9F9CAE896A@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251121110100.1909603-1-carlos.song@nxp.com>
 <aW9jUs2-kiVIxTfn@zenone.zhora.eu>
 <VI2PR04MB111476EC2286A529FE09F774AE896A@VI2PR04MB11147.eurprd04.prod.outlook.com>
In-Reply-To:
 <VI2PR04MB111476EC2286A529FE09F774AE896A@VI2PR04MB11147.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|AS8PR04MB8277:EE_
x-ms-office365-filtering-correlation-id: 346d80af-7eed-45f9-f8ae-08de58b85512
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GyShQkEqBYgm5zTW2XZ6EPcLLio5D0nVeDhqNgjyUV4JwnfMOJ+TYVJw32mR?=
 =?us-ascii?Q?Mm7xFTRvstd5vj4N2H/VFZggDYCCtPxa6QQEE92tzGUcz0Vqagoqu1UAf2GK?=
 =?us-ascii?Q?FX2lbT04NBrITzXbbkZhDtbQR0vc9mKm9TZigjqDqQ8V3WGJBLzNRsNqhwQA?=
 =?us-ascii?Q?q81HotbP3V+z+sqhBfZHH8zhCuDyNFnV+rkIue/gnGVoMW+tP2vrTVGlTZoP?=
 =?us-ascii?Q?Z2sHT/PlTL/tpeMBBvu9l9vIoKLQVlZ2+77DpxTK/HqIeBuh0BYF6nJclM7b?=
 =?us-ascii?Q?oy18SXEh5rgPvtG9yZPPALzmbPlAoY9V67DzCkcdUQgjdS1+xK5CtZSQSny6?=
 =?us-ascii?Q?Nh0/LJ0QtpsXFIXa+/tNPlzTsgCArPV8iAmwXhm2H9URlRx77x87TAvcEm7J?=
 =?us-ascii?Q?9j7e6GVjqWHx15RdN7rM0Y7PcJt+2mt3DWEVCejOhFfVPL7yilHusyf7XlPp?=
 =?us-ascii?Q?55gAPMV/WhY3LkT6dTOFpHNaaKpknq3IUkO4wWqPT85sHdgD0b6xQkpp/GA3?=
 =?us-ascii?Q?GcLLZ2GvL5S015IbwltY32MNKCbRI2n2a7z8/bYFOuBvRpIy22QrG0BV2KPm?=
 =?us-ascii?Q?t3DcVjQpzvnO+JlZNsAcg884CZTpQHVrPL3bvRz4aCGWgkzZfgIHOeleI65M?=
 =?us-ascii?Q?MgmQA/GwJCLJEfhNccrGegLo53ypUuAspP7Os96toTRq12rXEXV/8Ym3H5cY?=
 =?us-ascii?Q?d7AZFRpb5uFE/uGrTXyc5D09FV+z1sYD7JPCprebdc9JAQxvb1li73pOK3GT?=
 =?us-ascii?Q?TR/N1mxH91Mpw0t+zXs4rbLBt0ilHu+O3sc70gLRkrWWjRJtz4PnoMpOGCd3?=
 =?us-ascii?Q?gKUqUUgYSYlTP+Qy2t9KUWQ63m9AQqDnmw3bxAyEfWPiM1HZIL5GKl/RUGaA?=
 =?us-ascii?Q?ZzjrUEiomr7jXCUNs2vF6+dFgmEIsCUz9rbOhJgGJoXFW1S/AQ/nw3J5plys?=
 =?us-ascii?Q?uO2Mu5bIpSA+gND+3K5D4oJM5ow0JlxwV68gII07E9URB0cyglCKHUMOs0dV?=
 =?us-ascii?Q?TLtlrdbCHGyWNor8/T2Lz2fT153cwhcY8m1daqeLC3M53APT3XaMfLvXV/Ik?=
 =?us-ascii?Q?98ZfORqOJsEXB6qFWVP3BMnc+JM0uwNdFmP5SQncjEL7wL1lRbdRimuO8FRo?=
 =?us-ascii?Q?jWfq93OItuNxgmJ71y47L12KKGlXKX+08jD2k4fusuS5/gfbpr+/clmiQTro?=
 =?us-ascii?Q?QLbv7MbDHbDDHOvHDQ3jFGQX1eY2qADQMq4Q7QY0kvwqHjv5wHodpGtqfoOo?=
 =?us-ascii?Q?0DNDm4z0rDClG/qfu0LSW95cKWPx7yylaptlvBPw5kKVKYhkH9xSs/EFbOWM?=
 =?us-ascii?Q?3Yql4Vwu6YOPYGeUMY1FtKGD4LHmG33gB946o6leAilHLjO91xWgMeVECB2j?=
 =?us-ascii?Q?2TybajdivJgclyga2P7Z/4Nqn4gH22bE5ZdHQBoFK4eZPtGV05RccrhgHl2t?=
 =?us-ascii?Q?yTHl2Zj1BZl3CyApke5t+sDUMDtgKpkhfquRYJ65ygeSdaBzpfyTx6XkylIc?=
 =?us-ascii?Q?v/4HTFnhZfMNKcnUspSfpQ/vIf/Xgvgmg2zfEdosbngrEp6QBM0lgew1D0jB?=
 =?us-ascii?Q?9+I1A08nEnSOTP8dcT5KPqoU6TLE9ypZIeUZsd2gwEJWQOUsK/w0Oguxt1Fa?=
 =?us-ascii?Q?ozN+N3iUeb7pkW4GcvzInGs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f4yG2kiLzQK0whqkgAohsxZvl1vv2BixBqX99rAhvaKUoRxhx7Pn/GCUG1kd?=
 =?us-ascii?Q?tVUU0dsu/Wt6uiF12oU+J4yZS1/kMgID/2ZmitoFjYLVtuQ1EG1kJETPXrWj?=
 =?us-ascii?Q?VgYsON9Aw/EDHsqofeCwNbGmHfdP2oLm1lt2tOsXUwRV78/GBPr8hS0anV8h?=
 =?us-ascii?Q?SmNoYP8quV+h8+4ZaiFZ1XkK8LQjQUtqm6zRQ7rrWkxBRtsehIljkLxUzJnJ?=
 =?us-ascii?Q?eg2Uqztw5cIbPzk8GgFTprH7yGCiIs7eNCaegWpNla1D7e4D/ITulB/aiIfH?=
 =?us-ascii?Q?npnn7uCqfrDRd6MCQePi6qmEpAzg42fMRv0n1AAJdsaz1hGz58kbzw8kgPvx?=
 =?us-ascii?Q?BlbxjltwrbTujzccIFtYoqY5JrdJKGOzgtGjR6kt/4Z0ktPXJCtuqfBcYCRT?=
 =?us-ascii?Q?Gp+Ry79GOjs+SwAojt9jnrOjJUPgDNu88uQiE9R0ku3LN9nGPg+U6i7OdbdS?=
 =?us-ascii?Q?gfwSIlLNLaPIWMTqKozzFdXu99eFIhZk35x4bYOL15B/kUUoHlFMft/aU8zi?=
 =?us-ascii?Q?EAfjBE7Yl9n09sB2cUTT2rNrAVz32G56XrJR96LwmmpWAQjQEKxXyssD2h9w?=
 =?us-ascii?Q?4flaD77Txv++oIeF2qxlgQf72Q1f43UNJ9nsUYjpuGvj+rZpjMSIKmZgmkbd?=
 =?us-ascii?Q?hBv2DjyYjGAlmruDD0DnqIqLBRFw0kge+MLgBOodAWv7ZtsWcIYZ4fXFyWgq?=
 =?us-ascii?Q?fLhNSw22EYcoh0NZHoTn/hZ9G10XzuzHvi94zwZGTA6utSU4t+cHLdfunaov?=
 =?us-ascii?Q?18qfgvcO7zdZbjQvTu8i/poFttZHdvHCw2JMskh7GZgPDwGvfNyb9xg8euut?=
 =?us-ascii?Q?qpWwzST9YFQW/nx50nDo9eFCAVuTR0/LmZDLwzGnNTRUnZajqvFvwBpRfM1h?=
 =?us-ascii?Q?myRarAgj+aEldYwp5+tcvPjtHm4pyUBXGPA6AocG7ZmbYmU8Bur130280M0M?=
 =?us-ascii?Q?1JN/pT+pDenigCVDPTh62MJvQB5XNl9UrDUuRbUWSf+ICtq4R2V6l0wnh1lr?=
 =?us-ascii?Q?nmja2lxJA5RtUxyI0c1qgAIcHhcOIDowEI04T75WoyqS4yuiPio4BjRx6+W8?=
 =?us-ascii?Q?lyholmxVXwpofLXQL9gmRtBSsW6t2Y2urHUcJaNEOG4btWvDAUk8hrADkiN7?=
 =?us-ascii?Q?Caj9HCUqHwOjD8lznATrdcT6TQaNP4Z1mQwLA1oHpvGZ4yS31t7iOQGxlkO+?=
 =?us-ascii?Q?IEA6ShiLptCVK91+tjhsUWCLCU7gHHaXwTXguVm+HhNCthntecqr0cmy9gEv?=
 =?us-ascii?Q?7G9vn0PEd7RjT6VhcZvOQ7WFnFa4jQp4NM3lKKCX0U/usd3fzxhxtBy2qvp6?=
 =?us-ascii?Q?YuKhVmqNLXn76BZGsl5papsuKnmDZwYkdrO62qZsO8DlMGquKlwYl0NxrGIj?=
 =?us-ascii?Q?emSP44yM9HQzURZWV07NBt6wBIV5AGZXlMcIFlNpCFIqesTlotQQw6a09kM/?=
 =?us-ascii?Q?aKNAchYC3mkqGgJMBkg1aHZf3KuqjY9is59hb5mk7k5ArNyl6Pqq5co23B2R?=
 =?us-ascii?Q?ghlW6g9BouUixJcp84827C17RpKXi5dnCxXWehC6ZALsMprhEoTjdXk7clFa?=
 =?us-ascii?Q?iO9F0KlSGnNEyG90ylBzglf3cunJY09cKX5Je3Qruu4jTilwxTQ/8wJySSEt?=
 =?us-ascii?Q?+IJvqYtaxTS7LgWlHdsfwKQYcxcEXlnZaHjB2Gxd6pt6u8JlIYdhrUCfrTFg?=
 =?us-ascii?Q?5E/ulcKmNTgCth2/iy+rM2TbAsUGf5b6aUZNjiqPTU1bm51U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346d80af-7eed-45f9-f8ae-08de58b85512
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 06:43:05.7175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4eH1VraYHqbnCRi+y1247DLw89YByBYJ2YKVNQLVgAHdyF/zCZOWzoS5shksFUSI+XRtIu4M0/41MZa3c3bzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

Sorry.. Will fix at V3. This is V2 version..

> -----Original Message-----
> From: Carlos Song
> Sent: Wednesday, January 21, 2026 2:41 PM
> To: Andi Shyti <andi.shyti@kernel.org>
> Cc: Frank Li <frank.li@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; vz@mleia.com; wsa@kernel.org;
> linux-i2c@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] i2c: imx-lpi2c: support smbus block read feature
>=20
>=20
>=20
> > -----Original Message-----
> > From: Andi Shyti <andi.shyti@kernel.org>
> > Sent: Tuesday, January 20, 2026 7:31 PM
> > To: Carlos Song <carlos.song@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; vz@mleia.com; wsa@kernel.org;
> > linux-i2c@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: [EXT] Re: [PATCH v2] i2c: imx-lpi2c: support smbus block read
> > feature
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message using t=
he
> 'Report this email'
> > button
> >
> >
> > Hi Carlos,
> >
> > On Fri, Nov 21, 2025 at 07:01:00PM +0800, Carlos Song wrote:
> > > The LPI2C controller automatically sends a NACK after the last byte
> > > of a receive command unless the next command in MTDR is also a
> > > receive
> > command.
> > > If MTDR is empty when a receive completes, NACK is transmitted by def=
ault.
> > >
> > > To comply with SMBus block read, start with a 2-byte read:
> > > - The first byte is the block length. Once received, update MTDR
> > >   immediately to keep MTDR non-empty.
> > > - Issue a new receive command for the remaining data before the secon=
d
> > >   byte arrives ensuring continuous ACK instead of NACK.
> >
> > What is the real fix you are addressing here? Can you be a bit more
> descriptive?
> >
> > > Fixes: a55fa9d0e42e ("i2c: imx-lpi2c: add low power i2c bus driver")
> >
> > Is this tag really needed?
> >
> Hi, Andi
>=20
> From previous code logic, looks like driver want to support this feature =
but when
> I use i2ctool to test, it totally doesn't work. So I make patch to suppor=
t this
> feature really. Sorry for my misleading commit log. As you suggested, I s=
hould
> add more explanation about "what I'm fixing". I can fix this in V2.
>=20
> > > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> >
> > ...
> >
> > >  #define MRDR_RXEMPTY BIT(14)
> > >  #define MDER_TDDE    BIT(0)
> > >  #define MDER_RDDE    BIT(1)
> > > +#define MSR_RDF_ASSERT(x) FIELD_GET(MSR_RDF, (x))
> >
> > This name sounds more as an imperative action, do you mean something
> > like MSR_RDF_ASSERTED(x)?
> >
> Yes I will fix this in V2.
>=20
> > >  #define SCR_SEN              BIT(0)
> > >  #define SCR_RST              BIT(1)
> >
> > ...
> >
> > > +static unsigned int lpi2c_SMBus_block_read_single_byte(struct
> > > +lpi2c_imx_struct *lpi2c_imx) {
> > > +     unsigned int val, data;
> > > +     int ret;
> > > +
> > > +     ret =3D readl_poll_timeout(lpi2c_imx->base + LPI2C_MSR, val,
> > > +                              MSR_RDF_ASSERT(val), 1, 1000);
> >
> > What is the value of val here?
> >
> It is the value of LPI2C_MSR which CPU read out. We only care about RDF b=
it, in
> order to ensure real-time, I have to poll this register and once RDF asse=
rted,
> move on immediately.
>=20
> > > +     if (ret) {
> > > +             dev_err(&lpi2c_imx->adapter.dev, "SMBus read count
> > timeout %d\n", ret);
> > > +             return ret;
> >
> > This is an unsigned function and you are trying to return a negative nu=
mber.
> >
>=20
> I will fix this in V2.
> > Can we also add a comment saying that readl_poll_timeout() fails only
> > if it times out?
> >
> Yes, you are right, I will add this comment before the readl_poll_timeout=
 line.
>=20
> > > +     }
> > > +
> >
> > ...
> >
> > > +             /* Read the first byte as block len */
> > > +             block_len =3D
> lpi2c_SMBus_block_read_single_byte(lpi2c_imx);
> > > +             if (block_len < 0) {
> >
> > both block_len and lpi2c_SMBus_block_read_single_byte() are unsigned,
> > but you are comparing for negative value.
> >
> I will fix this in V2. Looks I need to split this function to make the re=
turn value
> type aligned.
>=20
> > > +                     dev_err(&lpi2c_imx->adapter.dev, "SMBus read
> > data length timeout\n");
> > > +                     return;
> > > +             }
> > > +
> >
> > ...
> >
> > > +             if (block_len =3D=3D 1) {
> > > +                     ret =3D
> > lpi2c_SMBus_block_read_single_byte(lpi2c_imx);
> > > +                     if (ret < 0)
> > > +                             dev_err(&lpi2c_imx->adapter.dev,
> > > + "SMBus
> > read data timeout\n");
> > > +                     return;
> >
> > do we need to increment msglen here?
> >
>=20
> lpi2c_imx->msglen is not needed to update here. It is only for RX bytes c=
ount in
> IRQ.
> But, msgs-> len really need to be updated.
>=20
> > > +             }
> > > +
> > > +             /* Block read other length data need to update command
> > > + again*/
> >
> > Please fix the commenting style here.
> >
> Will fix at V2.
>=20
> Thank you very much for all your suggestions!
> > > +             writel((RECV_DATA << 8) | (block_len - 2),
> > > + lpi2c_imx->base +
> > LPI2C_MTDR);
> > > +             lpi2c_imx->msglen +=3D block_len;
> > > +     }
> >
> > Thanks,
> > Andi
