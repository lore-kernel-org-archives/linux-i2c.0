Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC412E62B3;
	Wed, 26 Aug 2026 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787714637; cv=fail; b=Gb/yqJ2cD6cY+dnOm24+T6YU7eHyiClURpPJ0YuJvzPdrJUa4yix6ngfc4RVAPOUBBY4WaQGYuFQ+8vY/sMQIeLd6aiGa4475jX3y0CNYb0yGODoQRUCqNjARcOVJW2XtFvS9kHCnrto8Q5Rm1IYYnsTK8b0o6CG/HiZv1IRXe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787714637; c=relaxed/simple;
	bh=shOybLAlQ6UEUCbEiUEKQHldgHJ+dYdoQBj23c+Gg14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YR6D3zgT4sV2um5fhAQAl9kn0iEAtKej6y1ssf5lxoBImdSus8nmxFGezWcljObLpxVKHKK3k5dB9Kjw8ax7qq6CvyaqrIyMaCsDv6vMdHCmI+zz3oxGXNTtcSYTV3lUi+JspzD0Y2hWGiquvAAO0eN/YDxDaGWOiok9PO4YwSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=APAcejcW; arc=fail smtp.client-ip=52.101.72.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="APAcejcW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ne1TO53Yxt18TpAH31ukG2buVlKFNyg0ZR8OQxiHvRIsztrmf54ZsFqSkYrDuyk9hxyoJ7HBwqVfp7DZb2bqUJtsK/XXLmr4ACjUyF4UrXIxkupQVWbMT/2b9gC7LQnGR2SQP11JA0cpc2rjulDjb7Kjji0AztP9ueVCqYHN0+6eQHSANUEEYa2zdYY1FYKILqeG0VAZ4LsW6USVEKrZf9ZA7PApk2k7ywzYWf1dGCgGUxvyF8W8+rsVHJ2xVYJ7qTeEEOu5cQHlMn4Kx0bMRWyVz7ZfFDDuoAuTrcHr3IGMd11v+/q1yVplszG3Pv2lXcRUQ2GEXEfEuWYWiiHVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shOybLAlQ6UEUCbEiUEKQHldgHJ+dYdoQBj23c+Gg14=;
 b=JrXA1DvBuSjKhdrbWTTSF7CMr7ZCDh0XYzjLorxD7HEXcbPhNfqFjqZUwXAybuDg+nu8wcSrhYZjibtsPxWzVEWHtJWkvBGm9nNuIBuuwVqTZlhVoxwB6+6IoTVvvQcDtv0NHU3GuQjQtlPlVWFSySo9SVWYVzNAUoi6WfjeKTEQyTiGbAbLJ9X1c+8Rqc8xrw9Sp7Sly7qYb9qffC5wyDzX5rxlalIA6ITdKN5b6ETNc9vQi2jUoq97NRkC9jwvIVEiX27YEelPXOixFKW8W9tLS2txHU7uiNWc8DQcrlIdurzvBOe8YlCIe4n38hccQiQ72dlpoEc0FPGGcYpnKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shOybLAlQ6UEUCbEiUEKQHldgHJ+dYdoQBj23c+Gg14=;
 b=APAcejcWsoMD7q3EJ9OPuingjmGcm2xgn/LpfoY0tByUdXQmGAM74dCSXE3JwcLUMDr6qIS+GBotwXlnNr8Sxk4bKHvs2iopUafps1IW+Er5f17iyVCITfOacivDAZJeWCHb6RfnyOHfYNuSZKhI4FhujW9kbuigMDFDc3brBXUNQBq8IaXSvjy7cUpEH0HrffHb+5D9mT6aLHb90zzGjmXUUuiZVFciKdUyWmnAWFgVgbhBi3/wFaWDXpBQ86p6UFeC/Rr+pJLQko/hg2GLiryzomDb4ITD8vC9Pr0FX0ZDLzRoFHWF4FFdOk/6a39Oh2RhH+7n0AoKW5Jx2qPTYA==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by PA1PR04MB10119.eurprd04.prod.outlook.com (2603:10a6:102:45d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 03:23:46 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 03:23:46 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: "Frank Li (OSS)" <frank.li@oss.nxp.com>, "andi.shyti@kernel.org"
	<andi.shyti@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Frank Li
	<frank.li@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] i2c: imx-lpi2c: avoid accessing target registers on
 master-only controllers
Thread-Topic: [PATCH] i2c: imx-lpi2c: avoid accessing target registers on
 master-only controllers
Thread-Index: AQHdIvezrcu1QDeQKUGS+u8anmCtmLaS/tWAgBzO+wA=
Date: Wed, 26 Aug 2026 03:23:46 +0000
Message-ID:
 <AM0PR04MB6802B4CFB0FACAC0D8617546E8AE2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References: <20260803032705.2250373-1-carlos.song@oss.nxp.com>
 <anYw9d3s2mONCkfx@SMW015318>
In-Reply-To: <anYw9d3s2mONCkfx@SMW015318>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-08-26T03:20:41.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|PA1PR04MB10119:EE_
x-ms-office365-filtering-correlation-id: 3052f183-4056-4e18-1f7b-08df0321706d
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|19092799006|22082099003|18002099003|4143699003|11063799006|38070700021|6133799003|56012099006|10067099003;
x-microsoft-antispam-message-info:
 p4xS1nitJaQ/nzOv9Pcthj4wzPI2UOgjleyqgmKZrGCoI/ekszz1BO710taDJhfMBvigKUfoxnFr6tJy5TyJaMhyLDQHE02AuRIfOWbeFLi0F1LP0tGpRpVTcPyhPb9J+kU5EG+Mn+UzUkYoh6KKIdVycndSulkV2h0UPkOvEKgs05WQUEyIsDRtKT7IDZeqhxjyA6WmLG4Z1FAjExI943OBic9VfBULiolbxCk6fudl/uFu+HiibDzq/6/RjSvqe/xNjHY5OC2yKvLwpe7ODix5JjsNDSwx6vCmWBNmBrGJVY+UyHUxesesTv0KnCPxhf7GaGFeJ5bRHCE1+Ybd7C6HfHJaykntBISLylrjTh80RHRqtVZrM2ZlAf+7fdD6ELL0eCBtcOz6GsNFvbCV8lv7YJ+1ZR8+IR2EXfMBFkNMoyWJP13/EA/8Cqr+jUf/XIZL08gz5nV484AgCgoXhq/dDNICjELMqS/38tis2Ag9brFrbVA10kup7PelBbSt0D78z0n1HrRfm436NirArfGGl1JzhLThOEhcgvYg07bPhv2xvWQpzrP7tDVN2XmlV5kiFMJE4vYYcBM+skKqee4ru8GDLpbTmWdHwUgITj5lSywKQ6AxU55FCR2mnrLwEHg6itFjzIOYCNiqzB05+qf7mEU7ApTz7hRpGFRI428/fwX9LXOzaLh6K5Sk5c2qrbJ6QcqzzeDfUKNFYeb4YAsCQyGA0hEaFz0gFNVnJfc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(19092799006)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGJYWTNuNmVVY1RsSllIVkNKYTgzK01PbU9ySTdXYkdFZ3prOFFDTUNXcFdR?=
 =?utf-8?B?V2ZqRTFSQVlnbzFJS3lWWUl6MUk5N21VOXdYNVU5eDZrK05uaDJYQW1jQmdx?=
 =?utf-8?B?bmwrdDlzUTdGcFJuTFlRTEF5cEVxTUEvUGN2N0g4VEFmRGxoQ3I2VEkvVmhN?=
 =?utf-8?B?T1MrcEI5SXlMc3BPQTVnTmZWcXF1a3ZKSkNxSWRreW5renZGTWhvcG4xWGR0?=
 =?utf-8?B?bURUUXI1MkRhbjhpVktSRnU5U0xaNjhBNlp5NmFNTThKYzNvWkQ3RktaNThq?=
 =?utf-8?B?cWJvQTlNaGh1U2xCMk5UK0ExQ1V4S1lvbXNSMjNtckZvRDdYZHBzOEJpYmVt?=
 =?utf-8?B?czl0K3hQOXVvWVFvbDBDNnpjbzY4clM4T3FzZGY0RlFRSUZNVjNIRi9RZWJ6?=
 =?utf-8?B?U08vRjc0Vzd5MEVmMkRBYVZTZExHY2h2VmlMMHcwRjNXRlJBUXEyZlI5bkZk?=
 =?utf-8?B?NVIyNThnZlF6dDVENVY3MitFaTRvMDJCeSt0TnZCRTVFUk1LMThKQkpoczJH?=
 =?utf-8?B?NnJrRTY1OTNhWXo2WkszVXZwamY5LytrRkpxK2hjeGJRcFp0VlRSejVsYVgv?=
 =?utf-8?B?MGFtL1pka0hLSzMwdGFtWHZpTzJsL0dZVTBCaEtlVlRRVEdaQVVaN0tvb0JM?=
 =?utf-8?B?elNjSHp0OU9lUjI2ZDkxMEY4T2QzUTdBKzJ1Yzg3V1Q0SldFNEhhdk1PanV3?=
 =?utf-8?B?aWdLZ1hXdzdacXB3UVp2c0tJcHB3ZXBlRGhidUxOZThtUllEYlE3UHdBYzU1?=
 =?utf-8?B?VHlTcHRCdVNlMk5mN285Qkp1aVk2bTM2aWh1WEViaTFXaWRJdWp3OWgxbmJO?=
 =?utf-8?B?aEpFSzB4V1prVnBHZm9PN2lFZFZVbE9hTW9lRlBLc1FxKzZwcUZHUHdiQmNj?=
 =?utf-8?B?bm9iYzFwNGt0TXpSYTFSSUkzTTlKWkRBc01LUDFmc2hSYlZzOW9hZGZvZy9G?=
 =?utf-8?B?SjFSa3BBdDUzYlErVG01RnZjTW43RHAwWUhuT0xTYWRCVmZaOHpsRHkxbWdu?=
 =?utf-8?B?cnN3dHg5R3NNdnlubjlnYVg0UmVWa2FadGdCd0ZVOUtKK29JTHZuQmNkWk1H?=
 =?utf-8?B?ck44ejZ5Y2JNUHhHQ3JyZGluL0k3MWNWQWMrZno4bWpVcktvaHp2Nll2WXh3?=
 =?utf-8?B?UkZxTXF5K0Z3MjBTdUNLME1jYmp0NXllYlpEU1ZkQVFBa1F4ZGNUMzV6S3dR?=
 =?utf-8?B?djM4VG5uUUFOcVRqTFRqTTdlc1NxeFNqZGdjcGNNSTZlajZKT3pnTHpOcm1y?=
 =?utf-8?B?d2cxbkpOYkdPQU9TU1BMamFCUmdScDNjV1pIcHo2eGoyWEh4a24zWEp3bzdB?=
 =?utf-8?B?RUdhblR5Z3ErNVg0cURadHFiVjhwWkUyd09Wak5WVjhFWGpTL29GK0NEbnFp?=
 =?utf-8?B?MmY1Q2JLVFEra3M1T1dCekllK2J3dUZUdmIrRDJGYTF3a24raEYwODNvYmQ1?=
 =?utf-8?B?SUh5UW5uVmZXSFpGU0paZVZmZGszZDRrOGVYbElTcWdHOXhnVVlEOU5wZm5l?=
 =?utf-8?B?VUpwSDhtUjhkK0RWQnBWQy9Wak9uamprL3dQT1YxTVZrNkRJS0pGQ3hadlpK?=
 =?utf-8?B?U0dIZXJubDVyZER5QmhTbzBnck53QUtiT2cvVEFkZGVXUVlrZXptQlpMUXFW?=
 =?utf-8?B?anRhNzJ6UGNwbnpkVHZHWFBBZUZEbUhIekNiZTROQlBzQkhTMjl1ay9YdW9X?=
 =?utf-8?B?L0dWZWhBMFlUdGU1SU5rekVyb1Q5R0VNRGJUTjkvMFdqbWxQQU1kVjZKaWFH?=
 =?utf-8?B?NkpvaXNrUWZnejJpVytQRUI3R2tHaWVJSDZnekVEbEZLSG9xQ2VidWh4USt5?=
 =?utf-8?B?OUdDQ2dhZk1Jd1hlSWJmalQzVjV3NTR3YkNLNlZoTVZvY0ZYUi9ENzZYb3gz?=
 =?utf-8?B?UmVSQmJ5bGVyY1hpU0srdXB6cCtIUVQvZWIzYWwrTDcwZWlSUWUvczBrQzR0?=
 =?utf-8?B?N3p3VHl0RDZFL1pGWTJyK3VTdlZuc3NTOE5zbFd0ZHBxRExYazJ2SEp1NkJq?=
 =?utf-8?B?SE5GM3JBKzRwRnp4UWxrVW8vdzkwKzJmQjUvd2Y5ZmpxL1AvRi9zdEF5bUZT?=
 =?utf-8?B?WFBoT2pibjFtNWlZSUovYjdXMVpvclpheWpmRDcreUVLU1M4VmY2TC9BeExJ?=
 =?utf-8?B?Qm13dGhHSEs3d1lOK3dWcDJtaW85QTJlWlN3TGpFNEhEVU1seGhHSGZlNDNL?=
 =?utf-8?B?OWtySERLZGdmbDZ6SzFhMGtiRVZjc3Ircmk4NjRuQnU2eTZyQVFucmFpMkxu?=
 =?utf-8?B?QzIxZXJUd3BjV2ZaK21WZTk4WExjekdMT1pmTSs1Wm5iU1Fpc2o0ejVQV2hi?=
 =?utf-8?B?MTFDSThpcnFaZGZ1QURCdWpmaEFkd2s0UjZ1SVRPQVAxUTNja2tCUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3052f183-4056-4e18-1f7b-08df0321706d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 03:23:46.4747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WA8vS/T0i+QpT2VB8RJjpJuPmHTv0c5CtXvGe9Bsn0+1hUyN4RpXZwIf98G8LKfqcIeXkA6TrAUDLr0lpOmRrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10119

R2VudGxlIHBpbmcgdG8gYXZvaWQgbWlzc2luZyBpbiBtYWlsIHNlYS4NCg0KVGhhbmtzLg0KDQoN
Ck5YUCBDb25maWRlbnRpYWwNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
RnJhbmsgTGkgKE9TUykgPGZyYW5rLmxpQG9zcy5ueHAuY29tPg0KPiBTZW50OiBTYXR1cmRheSwg
QXVndXN0IDgsIDIwMjYgMzoyNSBBTQ0KPiBUbzogQ2FybG9zIFNvbmcgKE9TUykgPGNhcmxvcy5z
b25nQG9zcy5ueHAuY29tPg0KPiBDYzogQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNv
bT47IGFuZGkuc2h5dGlAa2VybmVsLm9yZzsgRnJhbmsgTGkNCj4gPGZyYW5rLmxpQG54cC5jb20+
OyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3Rl
dmFtQGdtYWlsLmNvbTsgQ2FybG9zIFNvbmcgPGNhcmxvcy5zb25nQG54cC5jb20+Ow0KPiBsaW51
eC1pMmNAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaTJjOiBpbXgtbHBpMmM6IGF2b2lkIGFjY2Vzc2luZyB0
YXJnZXQgcmVnaXN0ZXJzIG9uDQo+IG1hc3Rlci1vbmx5IGNvbnRyb2xsZXJzDQo+DQo+IE9uIE1v
biwgQXVnIDAzLCAyMDI2IGF0IDExOjI3OjA1QU0gKzA4MDAsIGNhcmxvcy5zb25nQG9zcy5ueHAu
Y29tIHdyb3RlOg0KPiA+IEZyb206IENhcmxvcyBTb25nIDxjYXJsb3Muc29uZ0BueHAuY29tPg0K
PiA+DQo+ID4gTm90IGFsbCBMUEkyQyBjb250cm9sbGVyIGluc3RhbmNlcyBpbXBsZW1lbnQgdGhl
IFRhcmdldCBibG9jay4NCj4gPiBTaW5jZSBjb21taXQgOTAzMTE3ODdmNDgzICgiaTJjOiBpbXgt
bHBpMmM6IHJlc2V0IGNvbnRyb2xsZXIgaW4gcHJvYmUNCj4gPiBzdGFnZSIpLCB0aGUgZHJpdmVy
IHVuY29uZGl0aW9uYWxseSByZXNldHMgYm90aCB0aGUgTWFzdGVyIGFuZCBUYXJnZXQNCj4gPiBi
bG9ja3MgZHVyaW5nIHByb2JlLg0KPiA+DQo+ID4gT24gY29udHJvbGxlcnMgdGhhdCBkbyBub3Qg
c3VwcG9ydCB0YXJnZXQgbW9kZSwgYWNjZXNzaW5nIHRoZSBUYXJnZXQNCj4gPiByZWdpc3RlcnMg
dHJpZ2dlcnMgYW4gYXN5bmNocm9ub3VzIFNFcnJvciBhbmQgcHJldmVudHMgdGhlIGRyaXZlciBm
cm9tDQo+ID4gcHJvYmluZyBzdWNjZXNzZnVsbHkuIEZvciBleGFtcGxlIG9uIGkuTVg4UU06DQo+
ID4NCj4gPiAgIFNFcnJvciBJbnRlcnJ1cHQgb24gQ1BVMiwgY29kZSAweDAwMDAwMDAwYmYwMDAw
MDIgLS0gU0Vycm9yDQo+ID4gICBIYXJkd2FyZSBuYW1lOiBGcmVlc2NhbGUgaS5NWDhRTSBNRUsg
KERUKQ0KPiA+ICAgcGMgOiBscGkyY19pbXhfcHJvYmUrMHgyODAvMHg1OTQNCj4gPiAgIGxyIDog
bHBpMmNfaW14X3Byb2JlKzB4MjI0LzB4NTk0DQo+ID4gICBLZXJuZWwgcGFuaWMgLSBub3Qgc3lu
Y2luZzogQXN5bmNocm9ub3VzIFNFcnJvciBJbnRlcnJ1cHQNCj4gPg0KPiA+IFRoZSBWRVJJRCBy
ZWdpc3RlciBpcyBpbXBsZW1lbnRlZCBpbiB0aGUgTWFzdGVyIGJsb2NrIGFuZCBjYW4gYmUNCj4g
PiBzYWZlbHkgYWNjZXNzZWQgb24gYWxsIGNvbnRyb2xsZXIgdmFyaWFudHMuIEl0cyBGRUFUVVJF
IGZpZWxkDQo+ID4gaW5kaWNhdGVzIHdoZXRoZXIgdGFyZ2V0IG1vZGUgaXMgc3VwcG9ydGVkLg0K
PiA+DQo+ID4gUmVhZCBWRVJJRCBkdXJpbmcgcHJvYmUgYW5kIHVzZSBpdCB0byBkZXRlcm1pbmUg
d2hldGhlciB0aGUgVGFyZ2V0DQo+ID4gYmxvY2sgaXMgcHJlc2VudC4gT25seSBhY2Nlc3MgVGFy
Z2V0IHJlZ2lzdGVycyB3aGVuIHRhcmdldCBtb2RlIGlzDQo+ID4gc3VwcG9ydGVkIGFuZCByZWpl
Y3QgdGFyZ2V0IHJlZ2lzdHJhdGlvbiByZXF1ZXN0cyB3aXRoIC1FT1BOT1RTVVBQDQo+ID4gb3Ro
ZXJ3aXNlLg0KPiA+DQo+ID4gRml4ZXM6IDkwMzExNzg3ZjQ4MyAoImkyYzogaW14LWxwaTJjOiBy
ZXNldCBjb250cm9sbGVyIGluIHByb2JlDQo+ID4gc3RhZ2UiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6
IENhcmxvcyBTb25nIDxjYXJsb3Muc29uZ0BueHAuY29tPg0KPiA+IC0tLQ0KPg0KPiBSZXZpZXdl
ZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+DQo+ID4gIGRyaXZlcnMvaTJjL2J1
c3Nlcy9pMmMtaW14LWxwaTJjLmMgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXgtbHBpMmMuYw0KPiA+
IGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXgtbHBpMmMuYw0KPiA+IGluZGV4IGUxYTQzMzhi
YzUxZS4uMWNmZDdhNGM4MjM3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9p
MmMtaW14LWxwaTJjLmMNCj4gPiArKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC1scGky
Yy5jDQo+ID4gQEAgLTI5LDYgKzI5LDcgQEANCj4gPg0KPiA+ICAjZGVmaW5lIERSSVZFUl9OQU1F
ICJpbXgtbHBpMmMiDQo+ID4NCj4gPiArI2RlZmluZSBMUEkyQ19WRVJJRCAgICAgICAgMHgwMCAg
ICAvKiBpMmMgdmVyc2lvbiBJRCAqLw0KPiA+ICAjZGVmaW5lIExQSTJDX1BBUkFNICAgICAgICAw
eDA0ICAgIC8qIGkyYyBSWC9UWCBGSUZPIHNpemUgKi8NCj4gPiAgI2RlZmluZSBMUEkyQ19NQ1Ig
IDB4MTAgICAgLyogaTJjIGNvbnRybCByZWdpc3RlciAqLw0KPiA+ICAjZGVmaW5lIExQSTJDX01T
UiAgMHgxNCAgICAvKiBpMmMgc3RhdHVzIHJlZ2lzdGVyICovDQo+ID4gQEAgLTEzNiw2ICsxMzcs
OSBAQA0KPiA+ICAjZGVmaW5lIEkyQ19QTV9MT05HX1RJTUVPVVRfTVMgICAgIDEwMDAgLyogQXZv
aWQgZGVhZCBsb2NrIGNhdXNlZA0KPiBieSBiaWcgY2xvY2sgcHJlcGFyZSBsb2NrICovDQo+ID4g
ICNkZWZpbmUgSTJDX0RNQV9USFJFU0hPTEQgIDggLyogYnl0ZXMgKi8NCj4gPg0KPiA+ICsvKiBC
aXQgMCBpbmRpY2F0ZXMgdGhlIHByZXNlbmNlIG9mIHRoZSB0YXJnZXQgZmVhdHVyZSAqLw0KPiA+
ICsjZGVmaW5lIFZFUklEX0ZFQVRVUkVfVEFSR0VUX1BSRVNFTlQgICAgICAgQklUKDApDQo+ID4g
Kw0KPiA+ICBlbnVtIGxwaTJjX2lteF9tb2RlIHsNCj4gPiAgICAgU1RBTkRBUkQsICAgICAgIC8q
IDEwMCtLYnBzICovDQo+ID4gICAgIEZBU1QsICAgICAgICAgICAvKiA0MDArS2JwcyAqLw0KPiA+
IEBAIC0xOTQsNiArMTk4LDcgQEAgc3RydWN0IGxwaTJjX2lteF9zdHJ1Y3Qgew0KPiA+ICAgICBi
b29sICAgICAgICAgICAgICAgICAgICBjYW5fdXNlX2RtYTsNCj4gPiAgICAgc3RydWN0IGxwaTJj
X2lteF9kbWEgICAgKmRtYTsNCj4gPiAgICAgc3RydWN0IGkyY19jbGllbnQgICAgICAgKnRhcmdl
dDsNCj4gPiArICAgYm9vbCAgICAgICAgICAgICAgICAgICAgdGFyZ2V0X3N1cHBvcnRlZDsNCj4g
PiAgICAgaW50ICAgICAgICAgICAgICAgICAgICAgaXJxOw0KPiA+ICAgICBjb25zdCBzdHJ1Y3Qg
aW14X2xwaTJjX2h3ZGF0YSAqaHdkYXRhOyAgfTsgQEAgLTEzMzAsNiArMTMzNSwxMCBAQA0KPiA+
IHN0YXRpYyBpbnQgbHBpMmNfaW14X3JlZ2lzdGVyX3RhcmdldChzdHJ1Y3QgaTJjX2NsaWVudCAq
Y2xpZW50KQ0KPiA+ICAgICBzdHJ1Y3QgbHBpMmNfaW14X3N0cnVjdCAqbHBpMmNfaW14ID0gaTJj
X2dldF9hZGFwZGF0YShjbGllbnQtPmFkYXB0ZXIpOw0KPiA+ICAgICBpbnQgcmV0Ow0KPiA+DQo+
ID4gKyAgIC8qIFJlamVjdCB0YXJnZXQtbW9kZSByZWdpc3RyYXRpb24gb24gY29udHJvbGxlcnMg
dGhhdCBkb24ndCBzdXBwb3J0IGl0LiAqLw0KPiA+ICsgICBpZiAoIWxwaTJjX2lteC0+dGFyZ2V0
X3N1cHBvcnRlZCkNCj4gPiArICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4gKw0K
PiA+ICAgICBpZiAobHBpMmNfaW14LT50YXJnZXQpDQo+ID4gICAgICAgICAgICAgcmV0dXJuIC1F
QlVTWTsNCj4gPg0KPiA+IEBAIC0xNTQ2LDEzICsxNTU1LDIzIEBAIHN0YXRpYyBpbnQgbHBpMmNf
aW14X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAgIHBtX3J1
bnRpbWVfZW5hYmxlKCZwZGV2LT5kZXYpOw0KPiA+DQo+ID4gICAgIC8qDQo+ID4gLSAgICAqIFJl
c2V0IGFsbCBpbnRlcm5hbCBjb250cm9sbGVyIHJlZ2lzdGVycyBvZiBib3RoIE1hc3RlciBhbmQg
VGFyZ2V0DQo+ID4gLSAgICAqIHRvIGF2b2lkIGVmZmVjdHMgb2YgcHJldmlvdXMgc3RhdHVzLg0K
PiA+ICsgICAgKiBSZXNldCBhbGwgaW50ZXJuYWwgY29udHJvbGxlciByZWdpc3RlcnMgdG8gYXZv
aWQgZWZmZWN0cyBvZiBhbnkNCj4gPiArICAgICogc3RhdGUgbGVmdCBvdmVyIGZyb20gYSBwcmV2
aW91cyBzdGFnZSAoZS5nLiB0aGUgYm9vdGxvYWRlcikuDQo+ID4gKyAgICAqDQo+ID4gKyAgICAq
IFRoZSBNYXN0ZXIgYmxvY2sgKE1DUikgaXMgcHJlc2VudCBvbiBldmVyeSBjb250cm9sbGVyLCBz
byByZXNldCBpdA0KPiA+ICsgICAgKiB1bmNvbmRpdGlvbmFsbHkuIFZFUklEIHNob3dzIHdoZXRo
ZXIgdGhlIHRhcmdldCBmZWF0dXJlIGlzIHN1cHBvcnRlZC4NCj4gPiArICAgICogRG8gbm90IHRv
dWNoIHRoZSBUYXJnZXQgYmxvY2sgKFNDUikgb24gYSBtYXN0ZXItb25seSBjb250cm9sbGVyIHRv
DQo+ID4gKyAgICAqIGF2b2lkIGFuIGFzeW5jaHJvbm91cyBTRXJyb3IuDQo+ID4gICAgICAqLw0K
PiA+ICAgICB3cml0ZWwoTUNSX1JTVCwgbHBpMmNfaW14LT5iYXNlICsgTFBJMkNfTUNSKTsNCj4g
PiAtICAgd3JpdGVsKFNDUl9SU1QsIGxwaTJjX2lteC0+YmFzZSArIExQSTJDX1NDUik7DQo+ID4g
ICAgIHdyaXRlbCgwLCBscGkyY19pbXgtPmJhc2UgKyBMUEkyQ19NQ1IpOw0KPiA+IC0gICB3cml0
ZWwoMCwgbHBpMmNfaW14LT5iYXNlICsgTFBJMkNfU0NSKTsNCj4gPiArDQo+ID4gKyAgIGxwaTJj
X2lteC0+dGFyZ2V0X3N1cHBvcnRlZCA9ICEhKHJlYWRsKGxwaTJjX2lteC0+YmFzZSArIExQSTJD
X1ZFUklEKQ0KPiAmDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZF
UklEX0ZFQVRVUkVfVEFSR0VUX1BSRVNFTlQpOw0KPiA+ICsgICBpZiAobHBpMmNfaW14LT50YXJn
ZXRfc3VwcG9ydGVkKSB7DQo+ID4gKyAgICAgICAgICAgd3JpdGVsKFNDUl9SU1QsIGxwaTJjX2lt
eC0+YmFzZSArIExQSTJDX1NDUik7DQo+ID4gKyAgICAgICAgICAgd3JpdGVsKDAsIGxwaTJjX2lt
eC0+YmFzZSArIExQSTJDX1NDUik7DQo+ID4gKyAgIH0NCj4gPg0KPiA+ICAgICByZXQgPSBkZXZt
X3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsIGxwaTJjX2lteC0+aXJxLCBscGkyY19pbXhfaXNyLA0K
PiBJUlFGX05PX1NVU1BFTkQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgcGRldi0+
bmFtZSwgbHBpMmNfaW14KTsNCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo+ID4NCg==
