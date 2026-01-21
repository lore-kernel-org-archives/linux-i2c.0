Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78BB3803E5;
	Wed, 21 Jan 2026 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977696; cv=fail; b=CAhpH4LCputiwnXXD4cLfhsxvaID6iMRhb39bIlTCm5iT+VreDRaA2H3T1iltbVOjVDh7JTtTzupEXMtguBnUt0z2wanW6gvQV0UJIfiZqIRpeLAPNLawYPiuKlphR/l6tE9Ypf/OakIXoswGKcFbyEb9lqRs6R6kLwkMm6h99Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977696; c=relaxed/simple;
	bh=ld8Bp1Ck4JzBUAI1wFYujQ56cDHS5rMp6thYt5z+xAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eQlcBMp8aiXVK9HeCzoYpxpt1JhGOB4/WldZAT0oB8k272I/wfCcbrhwsbvDZ8UbFvDbG2MFTRePUzzIYyCHuF1pyL7Lj6CX5HdiXqTbWynMztPpwTq6WanVTj+JwRTnW1to746uiV03Ni+mDAWIm8TIsRAVDYJGKbFuYJKKgaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TlMBWnse; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TlMBWnse"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/DURdSvCAZLU9YPRVnKLy+cFgbrEGUyvkgMYQ6WM4+4RNjJpSjWWBU80QImLpfz7bdV7UMXcGIMnhr6wZPVN/3iNIWXcwuc2tc1AIWgW/AKXJccyHJ9qklDyjvMwuCdOCTRzPwuxmXI7Rg1/OOmFt2Oh9BCOWt8ARGtc97UiBbustWq38rHZyU7VF7QkCSqkULaqwIjeTv7JIVSqg2dimZlloHZxpCZ3pTBiZXdwqsoOI0zBg/tOe9///MaWmDvojP0I2/lR8IUeZJEkuTiNGCAFL7whHpsZcW2xbV1i3Ar5hLyxuStGoD0/rSST164UOai2aVv1+Cvwe+4nRbCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EABSjqIJINrHj1xJgryAruuG40DfvPffrgy7AB5Vs2Q=;
 b=v110ahg58VDFq0Qjy5/pKhyo8EPBduy7vdUpA3js5c4ttnHXUyhRnLe65uBy7JIbtij2XoT0cQBD62S5X5L3aAe0MkvAZoS2n/PZKCSR77n3jFJYN4PRye5qPTYctR2wZZwSn+iIKZb0gNVdO7+OXAnLh9NDaqqjehbhQ5O1lvS4v0RDshQ3dZ8RPrwrWviSEow7vY6J2YVYHBYI0qR0eADl0mnQv/NwGUwyRH62Gzu6pPcWEjXw946FqSlByho8rNDrCVm+jDIFk6gSzYzCHbBr5WLp17vyZuOcWUYVxEie87NlYzFseVVf4fB4MzHyTsQktasNtddo98MHPMPaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EABSjqIJINrHj1xJgryAruuG40DfvPffrgy7AB5Vs2Q=;
 b=TlMBWnsedfbZ+asUArCWHMG8o22LEfAU9/+6wabQUBETl7LFx+shKPy/a6bcbAyVsejVdFF/hVpf/vxFvuHCvtstgvFhDRUMrnXr+oHeH/RnzOzPiCgltaMO7yqubEGa9uS97Mcejv5tr7/SfyN9XD4NF/gseMNx5ZKctcxyDVg7X4Z8mknRcH33FzbyTJ5Kedk/3zp9JkybEA8kEoSOusR9EdQSMO/nnELqDfVTXBpeXVePnEbWKpNf0g4PZrE0Xx9SUOCa3uTRHd9a7UH+8JbCY+MaLcWC4ZHkQAiwCT5BjMhYqtrCfIiT4aQBj59BiCV0iOMVSlvAz5G0b2EdvQ==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by VI2PR04MB10570.eurprd04.prod.outlook.com
 (2603:10a6:800:27f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 06:41:28 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1%3]) with mapi id 15.20.9520.009; Wed, 21 Jan 2026
 06:41:28 +0000
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
Subject: Re: [PATCH v2] i2c: imx-lpi2c: support smbus block read feature
Thread-Topic: [PATCH v2] i2c: imx-lpi2c: support smbus block read feature
Thread-Index: AQHciqD4iZGxTCOuFEu77Xns39YlRg==
Date: Wed, 21 Jan 2026 06:41:28 +0000
Message-ID:
 <VI2PR04MB111476EC2286A529FE09F774AE896A@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251121110100.1909603-1-carlos.song@nxp.com>
 <aW9jUs2-kiVIxTfn@zenone.zhora.eu>
In-Reply-To: <aW9jUs2-kiVIxTfn@zenone.zhora.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|VI2PR04MB10570:EE_
x-ms-office365-filtering-correlation-id: 5d7788f6-d6e1-4487-c387-08de58b81ad8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?woIz26F0j3OUxzh9ZTKdANwCKd5KRxLPcI6MjAqCTI1ggEYzyZaSWRDgRHUA?=
 =?us-ascii?Q?aaVxg6iZ1ntRfLhsthblIZrGAmwZyu3qI1clMQeuO8orJhgQXzVzfR8eiaZi?=
 =?us-ascii?Q?hDjyvqsclBxQJYqJe1sKY6wqFv4ZEV2QdxFogojlqG3awxf7BwNoRRXZaA6o?=
 =?us-ascii?Q?CU5ysDszc/OplpHT1/mNBstKVW9c1aNL6prjHofFpFgwN0J9CNmnJB1WsUtz?=
 =?us-ascii?Q?XX9qafI0FAqnR0YRvNLuy4hmpCZIg0eEb/KNj/PYE1sFMR840TEs68xi672w?=
 =?us-ascii?Q?hQzR17sC0lFk86PBm5nhr59FS99Jr5oTrq3WNZXD3hW9c2FU9Vb7x3iR06RS?=
 =?us-ascii?Q?S+zFV9jrnMF9t+94zMXaCA1eOqIt74P5fa8s6EAHLNXavcuTuIUPYVyffHVn?=
 =?us-ascii?Q?U1Ix2Xm738VwniSHMMmDn99aK50l3nN5zelAz9Ay3XShI0stCLAwO5Mr5IXC?=
 =?us-ascii?Q?x3AsjRTq5oWZblfRVxSjDhs5r7dlOEGehRTXTLkNWh8vEdKmN/87xwSyVM3b?=
 =?us-ascii?Q?6X0bq7J+EF/8S9s9yZukz/8yO+P4smFj641GLor5pCzVkW00BRrscvlsSkkT?=
 =?us-ascii?Q?5SdYYt+TNCV8YxatCgnnb2nMVHloOvi7VR2AWAfTLgfmKQzXsrhCNQeW0krY?=
 =?us-ascii?Q?AlDAwCdpToqJG8lc5Zyyvx48K6SiTwuvrwG4msmSOn68KOMSxfL0niWBJ6N9?=
 =?us-ascii?Q?j0hCiIwwsC+5mBFjrDw5jZS+wl+QpHRklwW4jZOUPtYQHn8x8tx+JKI1sKAo?=
 =?us-ascii?Q?f0e2WEuxG3IUt6QuF+4f9fDizKomVIU83GTTLoaxmb1fCpwEV+0uS4/Nlxjv?=
 =?us-ascii?Q?u92GOBUvpNoPxxSGgeQ6RnqgqVf4k3qKddEyEHHARojWQrm/hvVXHtNOZ6aA?=
 =?us-ascii?Q?MtxlsCPFp+uR+dsalVWK/pmRVO72FKezQBIvOXzQt3FGc06feUHEKMQ7iGJY?=
 =?us-ascii?Q?aHD83GVQ8WMzWmR7ln9ktbMeSDI2ExzwVCBgOh7Ak0b3Cd1BF2Vrta7DiZnb?=
 =?us-ascii?Q?1InlQdH+3rH+dHBRHWxZ4+fjyrGmHhUK6aptjwQZ5DH1NDoCqEph7w6FUiea?=
 =?us-ascii?Q?fxZSdceJi+yzafbe8SUARnRH/AMyeHDYLNLrd2w/RbfVTnRTH1of9VnEyyts?=
 =?us-ascii?Q?5VIOxKhONTpldwqKjESSJVI142KQJdUh+3I68N7f25c1I+gPjHbkVQEzyttb?=
 =?us-ascii?Q?bnCXam3/cATlFx46hzwn7uN9Hzv6qPH6xfcW0hmvafd9Nurj7hQ5DDtuZEC0?=
 =?us-ascii?Q?vFUTVsKn9eVWcvhsPeQak7tXaGTbhj7zi4CdMvSCeSbono39t0h9Vjd/ZKy9?=
 =?us-ascii?Q?oF+peiKkbtjwWgrw7PKNaA2NHQ9VJWyT5g7xpuYseEWKrBmjm/oxRkGKCS7N?=
 =?us-ascii?Q?HODqcYYPQk94vPRiFujZYvNCpnVJ+Om9JKxyRFUDePyRpAaD+Cop1D1D7akG?=
 =?us-ascii?Q?jU2Bpdyr4oW+0yspUxZeOC7JlX7nyf105EsTRb02N9ZBkLkQstlwMBMIfpka?=
 =?us-ascii?Q?I7Nw4LrL3djpYfEYkytQ1bufuOFZZYhrN1sE7B/jXkZ7O9BAi3oE6JS7TLCT?=
 =?us-ascii?Q?2vMrJuLvi7pUbKzQHZQ2ZikJmnGeWeDxpHqZp47AxNUBkgtYI+khed8t4RBB?=
 =?us-ascii?Q?obnGbeDHc0KssSS4izfQbDo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XhrQky8tGdizOrF/zSz17akB4wRbA2eHe9dBWx7TrJPfj3FQl1PK6UGVkBOU?=
 =?us-ascii?Q?FfFacMkUYKzG/3UryBj6fykOY4Qt+PBspUw9sQeheitex/WdtYMbOlrvBdSc?=
 =?us-ascii?Q?WAmersfHiOcfYG8pq4iDO7JGJyTGA+kDua9JciXXLudAd6yE5Ip0NNTcPsg1?=
 =?us-ascii?Q?/YojnPHan6mIXVB383y3k+eYD417vRzVoz8Fjxt3mNKvpmvN7QTqHI5buAUd?=
 =?us-ascii?Q?1VJ5EyPcSh3aPy5HxFJkSEqzwa9aZTEBetQhiCI1H6846TrKEigbfC9zvQ15?=
 =?us-ascii?Q?LboSMaVGaoFuqQJFhbJR3ylL0BuwtAGiygKloe9GneD1Mqo1Sqb0W/fsCdcs?=
 =?us-ascii?Q?b21h4G5yX2+pjo7jUH20t9sONdH8/3+8zoPIMqniaPEhxcbSMJGlpHI93kkY?=
 =?us-ascii?Q?p9UWeTSZEkkNmKoMSblFnal68gIE6TYR8Spd4R/CswIMRv83tkbaqfs2PLFy?=
 =?us-ascii?Q?fpnVoIil6BRTcz4F4v+gXQszbmptkjAbf+Qb1fV8YsZUH3OewULrcb1CAEzB?=
 =?us-ascii?Q?UTeFIXCk1COYmLdnVm4fs/ZeTAn0iMNt0R/qmPlqVj+l7jPhri46mzyzKITi?=
 =?us-ascii?Q?ZjI4Et2z6gUWhHaiQN7I6mRxOCmKV2kd7dY0WRLeYSUQuRUgyJZwJTt4n8Tt?=
 =?us-ascii?Q?idrF3J0s2GNIPcRFj9JILxuwqESkZssFOQIoJe3eRsqIEdomjc3KZotZknK/?=
 =?us-ascii?Q?8OmZrdSEqn0gfMR0SuA0NbCNIwFrRX+J3jjZWiQNCDaO8NufK8hrV55113hu?=
 =?us-ascii?Q?2H3UYsBQrN60Yl+22JvcY31RIjBtpHTPCR0s5K8b92SNX18Yd2KtFdIi4Rbv?=
 =?us-ascii?Q?PTWCld6EL7YkMxt1M4edM392BVQgwFPzLlenvls6BAe0Im+m93ZMZjWlENDh?=
 =?us-ascii?Q?1TxV+AMggCAhFOEDJXrT+4Tczi8DGVf3WQL34LmwnpSWB3UP8fODuf9Ww81c?=
 =?us-ascii?Q?C0iXuyaRvhFbmPRsvnDmyWFZNkD9fpDfEiQQluT1lAv4IckyVzjs61yh+UKm?=
 =?us-ascii?Q?+om3JOk86ZbuHjNFpJkznXCA49yOVV8cVETRPzGk8j/Jj8LEAcYJ40FDuFan?=
 =?us-ascii?Q?drSlQS45OL3BWC0uwtko5igLJT1sS3jLjXun2kd6ZaxTRNdW+tL2KzuuBqrQ?=
 =?us-ascii?Q?JB3o90x3uBJWVemC0ohxb0DuHtg0ub0eCxypYzyCWJabVzDOpVIt9CQGfljG?=
 =?us-ascii?Q?0X0BLbOyb0a60a6moFPDBZYvV69lL3JB8QJrbV4UGUGrasAaFnyqRR0y11Ty?=
 =?us-ascii?Q?I952r67K598nAdNOTJ5C2lycIFA4PGcE2wZ5NG1HZpxbYZZlkS2v48fnAgAq?=
 =?us-ascii?Q?X9icr5tFVlvV1KE5KgFAD/K1p7SVMa83RdNLW7QoMWHjnWrE3NY5CWPWpryL?=
 =?us-ascii?Q?AFOoQy4Sv6BCc6ouLwE0DZNxe/c6E0SVcGccsE0kDErZhMmA+OZ4VYwqQ8Yc?=
 =?us-ascii?Q?qbSgYGu1Mu07/SazE2ShLjywXJguGI5NsEOCEjvnupJuC7t+h7CYLwet8NLg?=
 =?us-ascii?Q?VTUO4Osp9lBzTaVIo3BKYcZumSwUH482mdw8KiLBNTbgcwTcw3l1F1RxpiPw?=
 =?us-ascii?Q?sCCIeTJIqxNW9WUCfT4dIvARSuXKgI6oghnVJeFoOsHuHTxdTnjgxbsNu7FG?=
 =?us-ascii?Q?hjbsB79WJqd/DJqg8tHxNV6854MXvo4PAWrM0Ao2Yr3o5onWBgrQ93qJheXK?=
 =?us-ascii?Q?TuJYqjg59ntxrJBRFy1dkbYybRmRX1Ke5m5fmS6YN/jWnYiJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7788f6-d6e1-4487-c387-08de58b81ad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 06:41:28.0798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xLEOZPVAurkXw8cvqVCDRF3Rx6KLuaDbRCGLXx36lQs3AQHe6ZW5FnfElLrYWvkIA5aBIjmsU9PuE0oPHZJHHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10570



> -----Original Message-----
> From: Andi Shyti <andi.shyti@kernel.org>
> Sent: Tuesday, January 20, 2026 7:31 PM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: Frank Li <frank.li@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; vz@mleia.com; wsa@kernel.org;
> linux-i2c@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH v2] i2c: imx-lpi2c: support smbus block read fe=
ature
>=20
> Caution: This is an external email. Please take care when clicking links =
or opening
> attachments. When in doubt, report the message using the 'Report this ema=
il'
> button
>=20
>=20
> Hi Carlos,
>=20
> On Fri, Nov 21, 2025 at 07:01:00PM +0800, Carlos Song wrote:
> > The LPI2C controller automatically sends a NACK after the last byte of
> > a receive command unless the next command in MTDR is also a receive
> command.
> > If MTDR is empty when a receive completes, NACK is transmitted by defau=
lt.
> >
> > To comply with SMBus block read, start with a 2-byte read:
> > - The first byte is the block length. Once received, update MTDR
> >   immediately to keep MTDR non-empty.
> > - Issue a new receive command for the remaining data before the second
> >   byte arrives ensuring continuous ACK instead of NACK.
>=20
> What is the real fix you are addressing here? Can you be a bit more descr=
iptive?
>=20
> > Fixes: a55fa9d0e42e ("i2c: imx-lpi2c: add low power i2c bus driver")
>=20
> Is this tag really needed?
>=20
Hi, Andi

From previous code logic, looks like driver want to support this feature bu=
t when I use i2ctool to test, it totally doesn't work. So I make patch to s=
upport this feature really. Sorry for my misleading commit log. As you sugg=
ested, I should add more explanation about "what I'm fixing". I can fix thi=
s in V2.

> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
>=20
> ...
>=20
> >  #define MRDR_RXEMPTY BIT(14)
> >  #define MDER_TDDE    BIT(0)
> >  #define MDER_RDDE    BIT(1)
> > +#define MSR_RDF_ASSERT(x) FIELD_GET(MSR_RDF, (x))
>=20
> This name sounds more as an imperative action, do you mean something like
> MSR_RDF_ASSERTED(x)?
>=20
Yes I will fix this in V2.

> >  #define SCR_SEN              BIT(0)
> >  #define SCR_RST              BIT(1)
>=20
> ...
>=20
> > +static unsigned int lpi2c_SMBus_block_read_single_byte(struct
> > +lpi2c_imx_struct *lpi2c_imx) {
> > +     unsigned int val, data;
> > +     int ret;
> > +
> > +     ret =3D readl_poll_timeout(lpi2c_imx->base + LPI2C_MSR, val,
> > +                              MSR_RDF_ASSERT(val), 1, 1000);
>=20
> What is the value of val here?
>=20
It is the value of LPI2C_MSR which CPU read out. We only care about RDF bit=
, in order to ensure real-time, I have to poll this register and once RDF a=
sserted, move on immediately.

> > +     if (ret) {
> > +             dev_err(&lpi2c_imx->adapter.dev, "SMBus read count
> timeout %d\n", ret);
> > +             return ret;
>=20
> This is an unsigned function and you are trying to return a negative numb=
er.
>=20

I will fix this in V2.
> Can we also add a comment saying that readl_poll_timeout() fails only if =
it times
> out?
>=20
Yes, you are right, I will add this comment before the readl_poll_timeout l=
ine.

> > +     }
> > +
>=20
> ...
>=20
> > +             /* Read the first byte as block len */
> > +             block_len =3D lpi2c_SMBus_block_read_single_byte(lpi2c_im=
x);
> > +             if (block_len < 0) {
>=20
> both block_len and lpi2c_SMBus_block_read_single_byte() are unsigned, but
> you are comparing for negative value.
>=20
I will fix this in V2. Looks I need to split this function to make the retu=
rn value type aligned.

> > +                     dev_err(&lpi2c_imx->adapter.dev, "SMBus read
> data length timeout\n");
> > +                     return;
> > +             }
> > +
>=20
> ...
>=20
> > +             if (block_len =3D=3D 1) {
> > +                     ret =3D
> lpi2c_SMBus_block_read_single_byte(lpi2c_imx);
> > +                     if (ret < 0)
> > +                             dev_err(&lpi2c_imx->adapter.dev, "SMBus
> read data timeout\n");
> > +                     return;
>=20
> do we need to increment msglen here?
>=20

lpi2c_imx->msglen is not needed to update here. It is only for RX bytes cou=
nt in IRQ.
But, msgs-> len really need to be updated.

> > +             }
> > +
> > +             /* Block read other length data need to update command
> > + again*/
>=20
> Please fix the commenting style here.
>=20
Will fix at V2.

Thank you very much for all your suggestions!
> > +             writel((RECV_DATA << 8) | (block_len - 2), lpi2c_imx->bas=
e +
> LPI2C_MTDR);
> > +             lpi2c_imx->msglen +=3D block_len;
> > +     }
>=20
> Thanks,
> Andi
