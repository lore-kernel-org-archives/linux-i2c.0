Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1662C3DB326;
	Wed, 30 Sep 2026 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773703; cv=fail; b=Q1vj1FATmkFi1DtCZ+/mbjb3xNbjuvx/XzZ1PEWm9NzuTZJWOek/lxKRrEcqMR/dD5+ex9fq0bfqwUMaAS5aqOraVJ2qIcsOdEcP05EgWA0KLYTKIGXFwaSnYRL2aIo2papFjq8oBOH8YTqsR3y5Ga7HyOk3AuSv4t+EorGYHYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773703; c=relaxed/simple;
	bh=2uzY6ke6C1adGcZq5ssZEyMyNrFwJ5FGdpP3gxIiUb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UHMAfVoNsA7e3hC5KZf0ovQl1Gr/YYH0BwtyBP7vWaD+4iR4ozBpw6d5ZcznawlJAWla1x/FxKcmhZUl9TxKGP0P74NFdGMgR1tdxjksZB7GQuEXefeLSa0p5RQYTO7bycAnVAw7xYdDOkS1W5sYYIHlpn6UI0v16IOcfqSBdNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=vxYVLnMf; arc=fail smtp.client-ip=52.101.46.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="vxYVLnMf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pH/jZMtoHBKZk1xcQWRDVjs2FtDmC6K7Hx8T1GkHSkrKvssvsUfDw0Mmr8jfob1JTXsjVP5AdongFE0RxY/0utqzBjwQLlgois6FU/pr2BbijYhTeMrkbDhM662N0nCmu3t4yhcDP/ekeE2pVRDJMc1d3UZ8U+7Q03PkDtqEaa1OPH6BkM+3bTGEURFyRt6xjS7B+No1Rs6BH+Xo0E+3i8rTNRI5kA+vaGmemRdnXIIkdn5Mq7mUaUNYAU6D7nIryUkPFMqxIMpZkLgDZVACi9Nvo2IP5VKpiRZIdJIeyHJBm5+iD341zehB+hfPoOH8YlLslSvvRxb9AYsxzP64Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uzY6ke6C1adGcZq5ssZEyMyNrFwJ5FGdpP3gxIiUb8=;
 b=gmDYTjt1agb4A/o9Ockc1mv1dTcslUkLwcylqV6O9y5jUY80WFO5OZW37kqDKHuZIBHodbSAcfDAXrHRUnyxR7crLdNLfJLAAG3jelNlVzGre4LOQFg3pnt7l6NoHzf9iGx4mphKFwCePud9OjObjWPQffm+eSnRaRvZWU5rnNVTM7abejFfOS1xGZ4TywQSIf5Zyb7CkfksMaWaJK2Sh57LwxxP4AATEKHcI5IeJ069Vlg+PAefI8LsIgx6Qj8Vt80+VXGm9/Lnv0pwYle0rSiWh7dWYGhKVJw1Q3p868LiJJNACwC9EoidvjkT4mYLYwQrWRzUsKpO/zXSi2t0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=einfochips.com; dmarc=pass action=none
 header.from=einfochips.com; dkim=pass header.d=einfochips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=einfochips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uzY6ke6C1adGcZq5ssZEyMyNrFwJ5FGdpP3gxIiUb8=;
 b=vxYVLnMfoKL82qeKx8aY72/emP1+xXrv9d1Tpy4zKNf10CxR5Fy+1jY4TYCXYIfWe2zeQXf34UuElS+u93DyV0jFv7IV2C7bYox7j86UALNpNfVLh6RDGTJ9Pt8M1XEEtySMwaip13RYN30s2PDbATqNxmUmui4EdoNaTUjvE60=
Received: from BY5PR04MB7025.namprd04.prod.outlook.com (2603:10b6:a03:22f::17)
 by MN2PR04MB6926.namprd04.prod.outlook.com (2603:10b6:208:1e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 13:08:04 +0000
Received: from BY5PR04MB7025.namprd04.prod.outlook.com
 ([fe80::97f1:60bb:2ae8:6f01]) by BY5PR04MB7025.namprd04.prod.outlook.com
 ([fe80::97f1:60bb:2ae8:6f01%4]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 13:08:04 +0000
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Yulin Lu <luyulin@eswincomputing.com>, Darshan Prajapati
	<darshan.prajapati@einfochips.com>, Pritesh Patel
	<pritesh.patel@einfochips.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Andi Shyti
	<andi.shyti@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Min Lin
	<linmin@eswincomputing.com>
Subject: Re: [PATCH v4 7/7] riscv: dts: eswin: add watchdog support
Thread-Topic: [PATCH v4 7/7] riscv: dts: eswin: add watchdog support
Thread-Index: AQHdUNy6FlBf28PbNUyVHt6pMSZwCQ==
Date: Wed, 30 Sep 2026 13:08:04 +0000
Message-ID:
 <BY5PR04MB7025A06D2F1D1A9EB66BE6C1838B2@BY5PR04MB7025.namprd04.prod.outlook.com>
References: <20260814070007.1662455-1-pinkesh.vaghela@einfochips.com>
 <20260814070007.1662455-8-pinkesh.vaghela@einfochips.com>
 <e27dd631-73a8-444a-8747-84d51ca3a57c@sifive.com>
In-Reply-To: <e27dd631-73a8-444a-8747-84d51ca3a57c@sifive.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ActionId=9c9fb6e6-dd90-44c8-afb9-9244deaa7757;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ContentBits=0;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Enabled=true;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Method=Standard;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Name=879e395e-e3b5-421f-8616-70a10f9451af;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SetDate=2026-09-30T13:07:15Z;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SiteId=0beb0c35-9cbb-4feb-99e5-589e415c7944;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=einfochips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB7025:EE_|MN2PR04MB6926:EE_
x-ms-office365-filtering-correlation-id: f1861758-9b2a-4ea9-cfb7-08df1ef3dd1c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|55112099003|18002099003|22082099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 0L9/UzALTtj9Ej0om9Z+LNB1G3IFsyf6XlYQlscICiIXxtyyR7pnGBuHTVqh+M3Lfw1vSujia08Lg1VBtUAzPxFnJKUnhd29ldrJdbUtPmevsX1LbNC+fclQ8NZXQGxDwzODsrFGT9NYsz0WuwPUrAeklQfiKME0MQebc60IHaWxjr6NkaHKVhtI4bEJjOc/4kT/YtpblyS2ivHddT3wgQZjAx6ftYDTYy/s0yi/KDsnzFMipwegCzLoj13pY5w9z6gXuGcQpUGcvs5dnVqsGVdZuHUx/fegZDXXFRnDdovqNNxUyNzqgRFXfTwY9qUz0zBmF9wu0iZHy48Kc5adeA3iqYhpjpUJsZ04m44VpTrp5+UxP2XIWPPeQgTHQSd3zwgp4HmxV8dJdQEQL3y7SCReXLPsLERuUihBCkTqTS00YvpXatOT6AYhtFOAr6NC+yZ8pjkNvFH9CS3+b+xyhNBFWZPPS5J9pPes4u4uORNkmPWQIM2sJEb4ri78P9ngkWmSwavH/hoPkzBc3+6R1F2F6M9XTyW+0mIN4DZuCnps0d0J0JUCEvwL5qgWCRlNj2EyLP8FxDWkQs+FQHpBgG5b6WCH/KPHa1w0EvpRLnHx28TCKlqxTQgclLZoGIhER94OZ9difAR+fBM0lm2ZwlsdWyv3QcapKPsWqtvGKhHoLwtYRwq9Z9RcYVpI/7HkvQrLru5UiSFc/kf/n5uO+H++XfUu8pY8pVSuHnGJjQ0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB7025.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(55112099003)(18002099003)(22082099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGo2RnNIN1JKa01FejkvS2xNTE05NjFiTUdOOElkUGFnTzZMeW10NGx0UkYw?=
 =?utf-8?B?REZFT2cramhVOXVTUjJzc1huNlhhSjB0ajY2U3JNMU5nemE3QWFrS3JJQ1RB?=
 =?utf-8?B?NkNHWGVhVXE4Wk9NUUlJVWZhazAwNXZ0UGcrTHl0YlJ3dWVEYjNEc016dVVX?=
 =?utf-8?B?ZWpYZThTZUY4dWZkb3VrWE5zOUtCUHRJOW1MR1NHdDdkRWdMdnRjbGU3SDFo?=
 =?utf-8?B?RXJ4amVNZ2N2ZUh4dHoyVzNtK1dCVHNDeGhWNEtYL2c3ZFlCYUJQNFN3Wm1R?=
 =?utf-8?B?ZmlMbnM3QzJES21ZVldsNy9pYXVnVXZuL0dhUVYvekhzYk1lKzlDSzRZMTZ0?=
 =?utf-8?B?RVpzTUJyTzdIZXRTdXNXN0hzeHFpS0Z0YjBJbUd4ejk2aUp6dnRtRzArV2Nq?=
 =?utf-8?B?K1FiSXdEdG1iaTNkYjZrZTB3ZXFIVktCU3NBK21FeHhvc3NaeGFYR29NOGZy?=
 =?utf-8?B?UmNLVkJ0WGlmQ1hsRXNFN3JaT2hWbVd4aUVjTDRrS1lTREtpTjVuczFOcWZG?=
 =?utf-8?B?QjcrM05mRzN2OHBMY0hvQnh3ajAwRjZjWWkyb3JSNGRDcURhOTY5Q1BOb1Vw?=
 =?utf-8?B?ZDE0azlRNjlQOGE0d2s5d0VQRmI4NkNEVkFMVjV5ekN1NENWeVI1STdoejMz?=
 =?utf-8?B?TjJBU0pvd0NVOHZpaUM5a3RwWUp3ZDdVZGE1b1NicWErWWxnRVVoTUVucWI1?=
 =?utf-8?B?T21MeVJxZEtEcm9KZ1dsZ21xdkN3Z1BnOWNiKzYreXdoaVNSdDZuaUQxdzdm?=
 =?utf-8?B?OVBBMXQ0WUozWFliUmsreUZDWERHZmR1MUg5T20yMVM4TUUrUWt3RDNzTmU5?=
 =?utf-8?B?QnJOWlAyUEZ6WW1sdGMzTUFyOWlQTE9sMmpERXFYcUJ4aGhSclB1bnVCY0NQ?=
 =?utf-8?B?dEV1NmVRK254ZGZDY2t2Y1Q5c3VmUysvRUxmN1o4Z3p6QjB6czRuNVk0UWg3?=
 =?utf-8?B?WmkvS09oL1JUTE5oeG9kZXhpUUE5L3lweHEvYldsWU80SmVmZ0VsbkFtbEtF?=
 =?utf-8?B?V29zbStxWXFqMFJlL1lMY3VCZ3VzRG9VckxYQm1oOW04MGdSVjc5VlpPbTVz?=
 =?utf-8?B?RHpyY2JoanlSaFl4SFhvTHROQjdOUXE3M1BpVFAwdmNyanZHbTJiYWVHcTNl?=
 =?utf-8?B?eHNUTkZpcGJNNXdURWE0WFd0S1VEOFloc2gra1NmN0ROZERTUTZXTFpmOEpS?=
 =?utf-8?B?eVpmYU9XbkllbDk4MnpzZzFpbTZScVVpSXN3UnNGUElmakxRaklHQkEzOHNK?=
 =?utf-8?B?TUxxUkhIZnJ3NHlGeEdYUGoxMXlQM05melJENEtnWnhWQzNJeTNhaXRXOVc1?=
 =?utf-8?B?YlFGUGhHY0oxWjljc0d6RWxzRXVtY1loRHVEODF3UFR3T25TTWEvcTM5U3Qv?=
 =?utf-8?B?bW5CeHNiczZjUThBUlNhTUVBeE5yT2lkZGs1enNQcDZDV0dZbGhCY2lKSExR?=
 =?utf-8?B?Y2xpYkk2eENhTWhlNXlxcVE1bU1uL2s3Q1Z5QkphakowQnF0d1J3OVBMNExm?=
 =?utf-8?B?b3VzV0kvNE0wdjd5TXJSQ2NKdjFXZWYwMVdEQ243R2hRN3RMa3Exd09IYUZV?=
 =?utf-8?B?SjJ2TTM2Z2QxWGd6Z0dvMGpmTlk4OWsvaiswRTRXQUpEV0MzQU9xUGRXZVky?=
 =?utf-8?B?RUVtaE1EMUhtNWVpaGhYSmhjU3FnME52b2ZRNlRKMUNVSmtGbVBpSzBCRGth?=
 =?utf-8?B?d1EvcGhPaGxUOHQvMnFBOEEyL1JwMjFYTWJ0MGJBQjdDUC9OSC9XWHlDNGxn?=
 =?utf-8?B?SDE0NXNwSVhtQXRPYUJ4eHAvaXgyOVQ3QkkzU056b1k2YlhSQ2I3YllwN0ZJ?=
 =?utf-8?B?aFhaSmJaTnFiTXJ4U1FYTXA2dFM3YjBORERja2drRVFZNHNjU0NCSTFKclBH?=
 =?utf-8?B?QUM4UThDck83dFBxclpLREgzSzdnaElubjF2MG5ROElQU3VTYUVWM2dNNXkv?=
 =?utf-8?B?cks0QU9lN0prUFExRFVoK3phaGQwMy9tVFF0cHlLYStvOXRndUVGcGEvUUUv?=
 =?utf-8?B?MFlETVoweW1weFdOSWN0R3VkOWVLZ1hMa1g2MjVUaWFLUmgzNW9MZzdESFAr?=
 =?utf-8?B?QU9DZzFnSklnSFNXWHpwalJWTlhsc25TSnVmN01FSWJJdHRaUUZQcVVDd2tI?=
 =?utf-8?B?dXJvb0FxUng5U2R1K1JuMmI5UXN6ais4Vm9iTy8rOSs5SDZqTmdaTlRlcHFW?=
 =?utf-8?B?ZDhDTkJzZjQvd2VTeUJUdFdtZmpZRzI5VWt3MXNOU1VtSTRDendtRUc4SStJ?=
 =?utf-8?B?SXMvMjR4ZHZRUUZoV3V2UThEM09jQ0t1OU1WZE15eDBLdnhQTVEyV2NROUZX?=
 =?utf-8?B?MzZQZ1NNVEhNSjdSUXZnQzBZSHpmb3F1Wi91V3JQdVEyL2d6UFI4ekx2THdY?=
 =?utf-8?Q?tndfrS6YG2U+q/MU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB7025.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1861758-9b2a-4ea9-cfb7-08df1ef3dd1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 13:08:04.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0beb0c35-9cbb-4feb-99e5-589e415c7944
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prPnVRiP2/w5PGEFbMUdxglWoR6BLqa7d0Y6JkiCUlAOVOqY3VssVTUuSthVGfHFeKpzxj3d754jk05hDb+270qu7tlEDiugqQuwWW6FYpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6926

SGkgU2FtdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNhbXVl
bCBIb2xsYW5kIDxzYW11ZWwuaG9sbGFuZEBzaWZpdmUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBT
ZXB0ZW1iZXIgMjksIDIwMjYgNjo0MiBQTQ0KPiBUbzogUGlua2VzaCBWYWdoZWxhIDxwaW5rZXNo
LnZhZ2hlbGFAZWluZm9jaGlwcy5jb20+DQo+IENjOiBZdWxpbiBMdSA8bHV5dWxpbkBlc3dpbmNv
bXB1dGluZy5jb20+OyBEYXJzaGFuIFByYWphcGF0aQ0KPiA8ZGFyc2hhbi5wcmFqYXBhdGlAZWlu
Zm9jaGlwcy5jb20+OyBQcml0ZXNoIFBhdGVsDQo+IDxwcml0ZXNoLnBhdGVsQGVpbmZvY2hpcHMu
Y29tPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZg0KPiBLb3psb3dz
a2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9y
Zz47IFBhdWwNCj4gV2FsbXNsZXkgPHBqd0BrZXJuZWwub3JnPjsgUGFsbWVyIERhYmJlbHQgPHBh
bG1lckBkYWJiZWx0LmNvbT47IEFsYmVydA0KPiBPdSA8YW91QGVlY3MuYmVya2VsZXkuZWR1Pjsg
QWxleGFuZHJlIEdoaXRpIDxhbGV4QGdoaXRpLmZyPjsgQW5kaSBTaHl0aQ0KPiA8YW5kaS5zaHl0
aUBrZXJuZWwub3JnPjsgTWlrYSBXZXN0ZXJiZXJnDQo+IDxtaWthLndlc3RlcmJlcmdAbGludXgu
aW50ZWwuY29tPjsgbGludXgtaTJjQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiByaXNj
dkBsaXN0cy5pbmZyYWRlYWQub3JnOyBNaW4gTGluIDxsaW5taW5AZXN3aW5jb21wdXRpbmcuY29t
Pg0KPiBTdWJqZWN0OiBbRXh0ZXJuYWxdIFJlOiBbUEFUQ0ggdjQgNy83XSByaXNjdjogZHRzOiBl
c3dpbjogYWRkIHdhdGNoZG9nIHN1cHBvcnQNCj4gDQo+IEhpIFBpbmtlc2gsDQo+IA0KPiBPbiAy
MDI2LTA4LTE0IDI6MDAgQU0sIFBpbmtlc2ggVmFnaGVsYSB3cm90ZToNCj4gPiBGcm9tOiBQcml0
ZXNoIFBhdGVsIDxwcml0ZXNoLnBhdGVsQGVpbmZvY2hpcHMuY29tPg0KPiA+DQo+ID4gQWRkIHdh
dGNoZG9nIG5vZGUgZm9yIEVTV0lOIEVJQzc3MDAgU29DIGFuZCBlbmFibGUgdGhlbSBmb3IgSGlG
aXZlDQo+ID4gUHJlbWllciBQNTUwIGJvYXJkDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcml0
ZXNoIFBhdGVsIDxwcml0ZXNoLnBhdGVsQGVpbmZvY2hpcHMuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFBpbmtlc2ggVmFnaGVsYSA8cGlua2VzaC52YWdoZWxhQGVpbmZvY2hpcHMuY29tPg0KPiA+
IC0tLQ0KPiA+ICAuLi4vZHRzL2Vzd2luL2VpYzc3MDAtaGlmaXZlLXByZW1pZXItcDU1MC5kdHMg
fCAxNiArKysrKysrKw0KPiA+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL2Vzd2luL2VpYzc3MDAuZHRz
aSAgICAgICAgfCA0MCArKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
NTYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9k
dHMvZXN3aW4vZWljNzcwMC1oaWZpdmUtcHJlbWllci1wNTUwLmR0cw0KPiA+IGIvYXJjaC9yaXNj
di9ib290L2R0cy9lc3dpbi9laWM3NzAwLWhpZml2ZS1wcmVtaWVyLXA1NTAuZHRzDQo+ID4gaW5k
ZXggNWRkZGNmMTNmZDI1Li4xMDNjM2RhYjE4NGYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9yaXNj
di9ib290L2R0cy9lc3dpbi9laWM3NzAwLWhpZml2ZS1wcmVtaWVyLXA1NTAuZHRzDQo+ID4gKysr
IGIvYXJjaC9yaXNjdi9ib290L2R0cy9lc3dpbi9laWM3NzAwLWhpZml2ZS1wcmVtaWVyLXA1NTAu
ZHRzDQo+ID4gQEAgLTIwNywzICsyMDcsMTkgQEAgJnVhcnQyIHsNCj4gPiAgICAgICBwaW5jdHJs
LW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICAgICAgIHBpbmN0cmwtMCA9IDwmdWFydDJfcGlucz47
DQo+ID4gIH07DQo+ID4gKw0KPiA+ICsmd2R0MCB7DQo+ID4gKyAgICAgc3RhdHVzID0gIm9rYXki
Ow0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJndkdDEgew0KPiA+ICsgICAgIHN0YXR1cyA9ICJva2F5
IjsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZ3ZHQyIHsNCj4gPiArICAgICBzdGF0dXMgPSAib2th
eSI7DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmd2R0MyB7DQo+ID4gKyAgICAgc3RhdHVzID0gIm9r
YXkiOw0KPiA+ICt9Ow0KPiANCj4gVGhlIHdhdGNoZG9nIHRpbWVycyBoYXZlIG5vIGRlcGVuZGVu
Y3kgb3V0c2lkZSB0aGUgU29DLCBzbyB0aGV5IGNhbiBiZQ0KPiBlbmFibGVkIGJ5IGRlZmF1bHQg
KG9taXQgdGhlIHN0YXR1cyBwcm9wZXJ0eSkuIFRoZXJlIGlzIG5vIG5lZWQgdG8gc2VwYXJhdGVs
eQ0KPiBlbmFibGUgdGhlbSBmb3IgZWFjaCBib2FyZC4NCg0KV2Ugd2lsbCBjaGFuZ2UgdGhpcyBp
biBuZXh0IHZlcnNpb24uDQoNClJlZ2FyZHMsDQpQaW5rZXNoDQoNCj4gDQo+IFJlZ2FyZHMsDQo+
IFNhbXVlbA0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9lc3dpbi9l
aWM3NzAwLmR0c2kNCj4gPiBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvZXN3aW4vZWljNzcwMC5kdHNp
DQo+ID4gaW5kZXggYzEzNDMyZDE0NTA0Li5mODczZTllZWI5MjkgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC9yaXNjdi9ib290L2R0cy9lc3dpbi9laWM3NzAwLmR0c2kNCj4gPiArKysgYi9hcmNoL3Jp
c2N2L2Jvb3QvZHRzL2Vzd2luL2VpYzc3MDAuZHRzaQ0KPiA+IEBAIC0yNjUsNiArMjY1LDQ2IEBA
IHN5c2Nvbjogc3lzY29uQDUwNDQwMDAwIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgfTsN
Cj4gPiAgICAgICAgICAgICAgIH07DQo+ID4NCj4gPiArICAgICAgICAgICAgIHdkdDA6IHdhdGNo
ZG9nQDUwODAwMDAwIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJz
bnBzLGR3LXdkdCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHg1MDgw
MDAwMCAweDAgMHg0MDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9
IDw4Nz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xrIEVJQzc3MDBf
Q0xLX0dBVEVfTFNQX1dEVDBfUENMSz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNsb2Nr
LW5hbWVzID0gInRjbGsiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXNldHMgPSA8JnJl
c2V0IEVJQzc3MDBfUkVTRVRfV0RUMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHN0YXR1
cyA9ICJkaXNhYmxlZCI7DQo+ID4gKyAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAg
ICAgICAgIHdkdDE6IHdhdGNoZG9nQDUwODA0MDAwIHsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgY29tcGF0aWJsZSA9ICJzbnBzLGR3LXdkdCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IHJlZyA9IDwweDAgMHg1MDgwNDAwMCAweDAgMHg0MDAwPjsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgaW50ZXJydXB0cyA9IDw4OD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNsb2Nr
cyA9IDwmY2xrIEVJQzc3MDBfQ0xLX0dBVEVfTFNQX1dEVDFfUENMSz47DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gInRjbGsiOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICByZXNldHMgPSA8JnJlc2V0IEVJQzc3MDBfUkVTRVRfV0RUMT47DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gKyAgICAgICAgICAgICB9Ow0K
PiA+ICsNCj4gPiArICAgICAgICAgICAgIHdkdDI6IHdhdGNoZG9nQDUwODA4MDAwIHsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzbnBzLGR3LXdkdCI7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHg1MDgwODAwMCAweDAgMHg0MDAwPjsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDw4OT47DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xrIEVJQzc3MDBfQ0xLX0dBVEVfTFNQX1dEVDJfUENM
Sz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gInRjbGsiOw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICByZXNldHMgPSA8JnJlc2V0IEVJQzc3MDBfUkVTRVRfV0RU
Mj47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4g
KyAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIHdkdDM6IHdhdGNoZG9n
QDUwODBjMDAwIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzbnBz
LGR3LXdkdCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHg1MDgwYzAw
MCAweDAgMHg0MDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDw5
MD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xrIEVJQzc3MDBfQ0xL
X0dBVEVfTFNQX1dEVDNfUENMSz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNsb2NrLW5h
bWVzID0gInRjbGsiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXNldHMgPSA8JnJlc2V0
IEVJQzc3MDBfUkVTRVRfV0RUMz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9
ICJkaXNhYmxlZCI7DQo+ID4gKyAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiAgICAgICAgICAg
ICAgIHVhcnQwOiBzZXJpYWxANTA5MDAwMDAgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gInNucHMsZHctYXBiLXVhcnQiOw0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICByZWcgPSA8MHgwIDB4NTA5MDAwMDAgMHgwIDB4MTAwMDA+Ow0KDQo=
