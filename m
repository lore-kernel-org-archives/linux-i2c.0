Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793951617;
	b=p8KgYp7ZsJ/Yvn4ilPSNmXTyCwPSwasQY0cnSB4XP3XyvZn6vTX3peeuLF4134pELBXv
	 5huRVbHAh2ziIZPj85gpwlhTrAcOeAh8e1ltI1gP5X3BQp2Yq2TGR597kW8IYs7KCZ11d
	 y1COj/PmC2hTzu4seiAecjTKYOYKwvzy84FakbMH12e6yILw91negvyUgC/3/NaAi/N6I
	 +BYZCMBWAVpmB7fW/oWPwmAEfvtjdQWnooI8Xc6lnGUr6OVgkD+b/iMuoj+0iWZGlfoGW
	 95+Jcviwg5lw18LZ4TiCfM+2cuNh0KNfdsTgd9dU/rToRml+ERos3+DT01xLofJYgyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951617;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EPtksfaiQsxxOsas0H+1hKPRZRX8RSDJE3WLIiGROrI=;
	b=2BG9Mgsr3UpOJThIjhcgUMdzoQ2M7Kx+akewP99JPMCpulDQqq88422VObA++tvxXNze
	 xnslEHZ/QJW8ecYbRTwt6JfG/iibUXFAtGJRKg/kYcJsGQo1mt1F4j3IIUulZ5EQ5afVx
	 CCFH8O/A+u26yrTBWU256OlNkTT3U6K6R1JFZEvDHhOuU0oGiBjyeFm0a8ArQpq44PM7R
	 UPMxKoohhrZvhrUg8zRFBgSUlw9b+WUTtm2xafpA7c9Uav4bntv4FH9CiQmSa+4K/P7Ll
	 3W2g1plKRD/POChLZP0SNqnMaveBTkFS7vQ+IwzzN4LIaUkU4UrVskarujAEKzqQr1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=einfochips.com;
	spf=pass smtp.mailfrom=einfochips.com;
	dkim=pass header.d=einfochips.com header.i=@einfochips.com header.a=rsa-sha256 header.s=selector1 header.b=UK7nbv7i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.60
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA52606A326;
	Fri,  6 Nov 2026 07:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADA52606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=einfochips.com header.i=@einfochips.com header.a=rsa-sha256 header.s=selector1 header.b=UK7nbv7i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxlPHPkCfVRigQROR+K3qct/qdgjRGHRWGAn0svW6lnJKNGmaFDA2tYPxNQPotb6HR29R8ixCXRa/E+Gg1wC7R1TXGh6ZXg13ffiU7kFS5nMYkh9FUrCwpNvIRJN8uagfLFNrfIFkMg3nM+8FJxsKHr826ZQYoVw5KZ0lptYNQWFSdxjGgWVUl6Tho+cU36WJfzC/r4HGQ2C0KNp+Pil8DS0iSqDmYYqYTsHn0jsm9Gq5ctHkDyCP2bdusEGWNwmqZUcKnExe03cxQnmig5Bhvo86W5rYWORLrLVNAxpkE0o9oXqVfgYN0I7FMyKZX5OhCklVf7nKyWU0+66Yb/00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPtksfaiQsxxOsas0H+1hKPRZRX8RSDJE3WLIiGROrI=;
 b=vR0SAABhmVHMuRfngCMbOCkh4oH2YUKMzzB1LU16KoXXjOuBRZeUHJ0CivDAafM+MZ2uXWbKJ8ej25M24Zu1OuCZxk7fIR6ZO1zfBDixL3fhMPd/nUR0zKyNQfqaQqnf9xlsIT9/gLgQGoV48qbcgF6BGypxJDdpna5BXBFogtX4NoFXENnOIir+GHGfbwaZu2xaIpggyWZ8zYmEj178HUUwzT6jEa2LA3l7AhAC1FOksdx3Ag9/GzKUTBfMzezbVdl4ipLF5AjtQjJIe3718dwm+BdrCZ+LlYjMK/SI/EgSwJDKM2354eO1Ja00FKIGvvrZ2HnV6LWDTiyqn4tvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=einfochips.com; dmarc=pass action=none
 header.from=einfochips.com; dkim=pass header.d=einfochips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=einfochips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPtksfaiQsxxOsas0H+1hKPRZRX8RSDJE3WLIiGROrI=;
 b=UK7nbv7ilIJ8VK67i0m7pF3odP7hFnGB8DLyxchIIwJ0laa9eFBrjUtM25ZIhr+37e/gun21Kcu3a0clFeXkaOKM3ZKz/LEB06Kk6hLyCegm+ASndHMpMlGccXnC8da552NtxVHn/i6TMnGTc3CQ/tAL6EIvkeC9EUKOXv7laZk=
Received: from BY5PR04MB7025.namprd04.prod.outlook.com (2603:10b6:a03:22f::17)
 by PH7PR04MB8754.namprd04.prod.outlook.com (2603:10b6:510:235::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 07:53:33 +0000
Received: from BY5PR04MB7025.namprd04.prod.outlook.com
 ([fe80::97f1:60bb:2ae8:6f01]) by BY5PR04MB7025.namprd04.prod.outlook.com
 ([fe80::97f1:60bb:2ae8:6f01%4]) with mapi id 15.21.0546.021; Fri, 6 Nov 2026
 07:53:33 +0000
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Andi Shyti <andi.shyti@kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Min Lin <linmin@eswincomputing.com>
CC: Yulin Lu <luyulin@eswincomputing.com>, Samuel Holland
	<samuel.holland@sifive.com>, Darshan Prajapati
	<darshan.prajapati@einfochips.com>, Pritesh Patel
	<pritesh.patel@einfochips.com>
Subject: RE: [PATCH v5 0/7] riscv: eswin: eic7700: Add support for clocks,
 resets, pinctrl, HSP bus, I2C and watchdog
Thread-Topic: [PATCH v5 0/7] riscv: eswin: eic7700: Add support for clocks,
 resets, pinctrl, HSP bus, I2C and watchdog
Thread-Index: AQHdXKRlUYF2T2bi0kumuFCJfQ/2RLcgziCA
Date: Fri, 6 Nov 2026 07:53:33 +0000
Message-ID:
 <BY5PR04MB7025AC1D7DF56B1F60B6E78A83762@BY5PR04MB7025.namprd04.prod.outlook.com>
References: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com>
In-Reply-To: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ActionId=ead9e8f5-c11b-46c2-8a30-878c7b564e9e;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ContentBits=0;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Enabled=true;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Method=Standard;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Name=879e395e-e3b5-421f-8616-70a10f9451af;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SetDate=2026-11-06T07:52:01Z;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SiteId=0beb0c35-9cbb-4feb-99e5-589e415c7944;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=einfochips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB7025:EE_|PH7PR04MB8754:EE_
x-ms-office365-filtering-correlation-id: 1943339f-bbf8-4057-7818-08df3bdb0e76
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|921020|38070700021|11063799006|56012099006|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261021121427099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261102123227099003|261026135527099003|261026121527099003|261026140227099003|261026130827099003|261028144727099003|10067099003|55112099003|18002099003|22082099003|3023799007|4133799003;
x-microsoft-antispam-message-info:
 l9IvN8wWLMKL1mcZaD+cDiyLsa8bbCuLpC6iDvGlynLzUXTJ7reNUBiMDW2NjnnQ2sWnMcSy3FR7dqEE5Yowh/XV6xFHBSCQh4qvz0bhbTJxniURdKp8QKfPmbS7TMFDasPa5zHwrXbqdXcikUzl7Fip/Jywuoea3E5DBZgm2BYvWTLv0gO5gIMRCVOkLM3CJLA3wRaoE4YaQ0WxtFlsbdi0VIlTklL5tHAUls3ssox6XidSogBtj6Y0ZscHcCDX3L5Yztp84zIhkqSwTuAbN08odSVmbpK4rrwXGIbf0LaIoiF38GSe0uxmRiyA5ZasFs5Q/3MM/NaBvuzdiD9xzeuz8QNMa8QWQnx9x0ldA1MxrIjzz+lQjovBUPicIKvp8NQnlhNMAOn/P0DTnIpf6YxVscMl00cYOJ6wgL5ViCl+DkEVI7dpaEOAe3TekIkjvSYSfSq3hK8K5KxPV2ilC0hdOklGu4GJcE/OC0VHtrd50pIh+a1jjrJHv3KPCKVtW68WjvdjyvKqbd7VPn9QGcu/l3w+29F4gw+99PPGBCVJEHi/o1nemkRVy9OowHpRd8Y7e3dIigOgua+fZAohggt0o12MBn8Zdgig+U+GsN+BK+GbCv90SIGGHIiGlgteoK3QGpSYgqtznrUWJa8hBRyRxLFHEXiO6+B3SnmnCJ21Dax+m/gtElMp6Kb0xPnk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB7025.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(921020)(38070700021)(11063799006)(56012099006)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021121427099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261102123227099003)(261026135527099003)(261026121527099003)(261026140227099003)(261026130827099003)(261028144727099003)(10067099003)(55112099003)(18002099003)(22082099003)(3023799007)(4133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fnMhp2CYcFTfM/GirQ4E6YZoTtE1q/n0o4qOGtaWmO2aqZW2a58CXerPT/rF?=
 =?us-ascii?Q?R52u4lCF6SoEXjO0ZreHQx5bM2lyUnFCol2YW6FTp5hCwVhAu/ia8TtFQZnb?=
 =?us-ascii?Q?4pI+1FU3riferd6k0Eu0ORN4WcpUnU/GNvXOMxPu71izMgYJGZVzRmLNnC/P?=
 =?us-ascii?Q?KrYrop2wwU3ELn70ZS1YtRAAsSwBrfxLQufT0thcX6FquL0NWe9TBPCCmf7S?=
 =?us-ascii?Q?uTj6DBEVc1H8IoQZtD2cQXjbwUeSpoFQtNAgM6TCOKORFvSltqZ3Dhf+riz2?=
 =?us-ascii?Q?CwAgolUNQWNpfi24pC+2VgwbxyeBbpkGx559gGmQr7pqnMi04Xf89T00JFwb?=
 =?us-ascii?Q?tOLcXSf8y8/xAC70iNknKuPfKSegDX5pECI7d48Qnvh2DXuD0NaDVtw+CY2Z?=
 =?us-ascii?Q?8ziSS+OnlEd3Q1njQkR4d8k1wykli0dy2bKckvyEQutfPhpT8Aq4AP0DzuGN?=
 =?us-ascii?Q?HjTcvQ7jr7wOZCcYxY3X5Q6DE2ml8PB/IDNk13ZVJ2eN0MJlsw/kmVrohByY?=
 =?us-ascii?Q?24+9W8qfyTUOBCVunKG4M2PLM7T/ITUah0yEeyeU7vHUe7EcT7KlF9KhGsio?=
 =?us-ascii?Q?n0vo0TVLuS5bOsGlDMncRKQcEZiTnHxNZkuXbTUPVBanqSBhZhwWWtKwbyuJ?=
 =?us-ascii?Q?IFgbniPqdbWPSKrZth6PondtTRM77PSky5M85QTA/UDg9cn5dvDnLxNIVwNZ?=
 =?us-ascii?Q?y7vCoJqWOCKs9vng0ut1cJg+OVlsMQETDsR8m6GX6tJ9ofsJlRSA5VLqCplp?=
 =?us-ascii?Q?RF11gnr3Gj3SZdFwbzVASVnwftDEVka89FRZ2ke1V4zRWMIFmUkT6Syk3bnC?=
 =?us-ascii?Q?N8prdZ7xW8U032+ZmHPmZWyoR5tN3ZUt88gFAyrFhXfY+DurDhWyVxLeVxAH?=
 =?us-ascii?Q?caQxfR3WFXA1+kObO7HYfj9Q0Yhi4E7SlT9kGXaTAffzMz68e1TSnlK+whSC?=
 =?us-ascii?Q?WpPO+rX2Ifnbi2NzQVf2vDT7FXd0aj/v5QkN41jf136qO1zFZ3xMzz1PYZNw?=
 =?us-ascii?Q?n8riWzeBUXzzee8xk5oQmU8CGkF0OKGCqcfcMQcQWuPqw/wrGvgtqcqT+urc?=
 =?us-ascii?Q?Kf3JQ4bTBp6khEpUpfGF1mJIy+URxX0ORwnu7ytOKr7+FiBNWKcmkIssGpQ0?=
 =?us-ascii?Q?SzBTgOUhsPhJRDYXLv2oLx4JEGxECxYARe8ukWcNbUBtdyHgCTcz2Peia4qM?=
 =?us-ascii?Q?+ABg06fEtATP5fmqSbKefY17KtuHRd4V4UpGRgF5MgA84QRmKQPI8Xx80Xc4?=
 =?us-ascii?Q?q92Z826OXR6QtDGBwo4chwY9zwvT/gQDrKg8OYnr+YgVR2pG0FOvFtPQJ3KR?=
 =?us-ascii?Q?HERfAFDoqromsVGV/or7d6YVOpk/C+7F8L2osTeETow3PqS3rsM5HNvZkQcz?=
 =?us-ascii?Q?DKtAKDuXjAEe1XvMT6UZ5YVxUMHjgfW6ibhO8c40kUve8QmvEH0vjqEKSwEN?=
 =?us-ascii?Q?XDMu0ViC3bj/gB2V+leOBIVpTWF1XMLRtQb75NENpbciuRauzpcw8pUl0Nt5?=
 =?us-ascii?Q?ky6ApmGq8dGYxGG3ZpNOHQFmkOu4gJ2mGNSi0fICEgCULIGfNxFu3/Irs/1u?=
 =?us-ascii?Q?ZLwkBloNjeHHAxPj97yQV1rigDfhEZ1ZVaVXNBvH7PqvCWnL44aeS++BtQxf?=
 =?us-ascii?Q?pqO3Z6PWKU2G+sGU01VZhx/j3uGggDALlcwKFHEnHNMLWTIHBYE7+qyuG+4u?=
 =?us-ascii?Q?kT0B6yfchb7bIAQtyGQWHie/wlGqsFhDerCEe8cpBQ3Y9RlFesNFM3RAvDjH?=
 =?us-ascii?Q?Hs0tqcGEug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB7025.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1943339f-bbf8-4057-7818-08df3bdb0e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 07:53:33.6252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0beb0c35-9cbb-4feb-99e5-589e415c7944
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3Z0LlvsMz6d14+fPzownRA8Hm3AjMNam86vPvrDXeo5343TT7yEBAvWuIL8710ROfKvmiywL73+yvx5htdlFbOwqWpxeQ1jkMTcPhHTcvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8754

Hi All,

Gentle reminder regarding this series. Any feedback or comments?

We haven't received any comments yet, apart from the sashiko-bot
(which are already addressed in previous versions).

I would appreciate any feedback or suggestions on how to proceed
with this series, or if there is anything else required from my side.

Regards,
Pinkesh

> Changes in v5:
> - Rebased the patches to master branch of linux-next tree having
>   latest tag: next-20261014.
> - Updated dts file
>   - Arranged the nodes in alphabetical order.
>   - Removed the board-wide GPIO pinctrl state and attached GPIO84 to
>     its gpio-leds consumer.
>   - Moved the invariant I2C pinctrl states from board overrides into
>     the corresponding SoC controller nodes.
>   - Removed enabling watchdog nodes and describe them as enabled at
>     SoC level.
> - Updated dtsi file
>   - Added pinctrl property to all I2C controller nodes.
>   - Sorted the always-on I2C controllers by unit address.
>   - Removed default property "disabled" from all watchdog nodes.
> - Updated pinctrl.dtsi file
>   - Resolve missing space issue.
>   - Annotate all nodes with /omit-if-no-ref/.
>   - Removed duplicated base pins from the quad-SPI pin states.
>   - Split UART1 RTS/CTS from its TX/RX pin state.
> - Added "Acked-by" tag of "Andi Shyti" for the I2C binding patch
>   (i.e. Patch 5).
> - Link to v4:
> https://lore.k/
> ernel.org%2Flkml%2F20260814070007.1662455-1-
> pinkesh.vaghela%40einfochips.com%2F&data=3D05%7C02%7Cpinkesh.vaghela%
> 40einfochips.com%7Cb78c1508aaeb4bdb3b0e08df2abb846d%7C0beb0c359c
> bb4feb99e5589e415c7944%7C1%7C0%7C639276657039833278%7CUnknown
> %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAi
> OiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D
> 0Q%2BILsWWcdMH%2FxKUR5Bb9%2Flc3eIl5UTMl18p1KxQIX4%3D&reserved
> =3D0
>
> Pinkesh Vaghela (1):
>   riscv: dts: eswin: add hsp bus node
>
> Pritesh Patel (5):
>   riscv: dts: eswin: add reset generator for EIC7700 SoC
>   riscv: dts: eswin: add clock generator for EIC7700 SoC
>   dt-bindings: i2c: dw: add ESWIN EIC7700 SoC I2C controller
>   riscv: dts: eswin: add I2C controller support
>   riscv: dts: eswin: add watchdog support
>
> Yulin Lu (1):
>   riscv: dts: eswin: eic7700: add pinctrl support
>
>  .../bindings/i2c/snps,designware-i2c.yaml     |    1 +
>  .../dts/eswin/eic7700-hifive-premier-p550.dts |   91 ++
>  .../riscv/boot/dts/eswin/eic7700-pinctrl.dtsi | 1065 +++++++++++++++++
>  arch/riscv/boot/dts/eswin/eic7700.dtsi        |  255 ++++
>  4 files changed, 1412 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/eswin/eic7700-pinctrl.dtsi
>
> --
> 2.34.1

