Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793873815;
	b=hBpBxY3lmskd1SiqlpUT3uLXCKuJAIrY9TszBWKJPyj5LYhgICM9U8Ou9Ohh15Qe4pru
	 seth16PmN6LgBSSIisvl8P9680RRgpNiMURra+6GKoXCJFIiFkTZyuJxxqJLhglMhtsed
	 D5NWwFjDLttqLfjt/gS6TgCH7j0xEOhr92MXSxz74DcGPOHWyx2i57CQnE490HWCR5N+Z
	 aXJ3Rv1lU9TXNsisRo9mLh0RLz2NqqPwiHaodLSPuLvkBQWJCqBu8r2UMdqufBOg9AMoo
	 T8lGWETt+inkqlHhw0uVFNEU8BMk0l+YA0H5vWAi/5DcOyF2dexj9yH2X6FCGKj90zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873815;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
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
	bh=erxqdpt2wVno2HAxGmzf0IKHBaKAor7Dy4z2P2FC5jY=;
	b=FdlyDmrxyDHxFDTBcI/Zg9IC3ICJ5v8sChG445YzgaBqEUxoBGDhisj35iODMuRVFbuq
	 0flp5x0TXXW6kwDNV+J54Tjn7yCOLSucff2VAWIt9Ln21ghQqcVdXj+Cy9Z6rQoBFEtRh
	 k9Xb2rFOWHCn9nU7ntXBWd+xRubBNp/S0Pvu/6sHn/BMUVkeH0GRaN79HU1RU+qvdxOBr
	 RgFqBjmjFGjhjhCUUgSmj5eyzz62M6O+HvOGKSVW7ly6OTac+30VyFHUyLG+R/vlD58Go
	 BL1UflEhogPRozDnkb0xrnwPVhEvL+d0NquzsR9EHVHkY3NLMmzD8sDWfxoQCZt+VWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=p8wAqkW3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.37
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA9606A32D;
	Thu,  5 Nov 2026 10:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41AA9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=p8wAqkW3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOqaTRdtyY64YakNPgNM0nb0uAlRBM7d9Hs9tku+9wA2lLpX+etw2JjLgVjE+4WUc/ddsHvy/iFYVnv05IQ6pJkEKp74Ts03Y3FF2TVmxVpfgIZPLRzptbfvNXGnFa9y/Nl3zRsGnhFF6dfMIF7Bs1tdzJlorxyrp3ZEX49nBDTPR9W3+Dkd4vhTr5pBHzyZBJWx8rnBYKX85aMh2lwuDaBUHLlodiSvtYG2RbKeB23Jexu3K72HwT82iJitJkBLllBnAMP9bYu5twwqy/wHZDaNxU8z2KQEW+oaoNpseObfVhBwYDYTJDpwp70yC8WTweGKZdZjM3aepN4kK2/KvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erxqdpt2wVno2HAxGmzf0IKHBaKAor7Dy4z2P2FC5jY=;
 b=U/bkhggsQQcWBDTQpCNJmihEOi2CIVolFbY4522D/Ht73SNSd/iJqHP1QZDyDoiSkBQ6cs1e+/KrKA70YPRIjj+2ACJ/Qp+WerEvxUT6FHivhZHniie0z62Rnwle09JASvBFoQZhG4/nckQabYqIZBqYkO1yuznh+qDBEOUYxbiFEywV9oWD70Hte4+tpMwJmgnfTl7TsvVuAuT3Cd4EIP0Vb7hLOfh4IULnS0zFX2RfAszbybNcUY8bQVkZExLb6vV8dyA44vmO3YMFH+H/qWUMN+mrRrszYRKFgvGDng3qAwOwcMOebJOlsrm0Av1bQC8G/Iv3wYTygcsEhKbhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erxqdpt2wVno2HAxGmzf0IKHBaKAor7Dy4z2P2FC5jY=;
 b=p8wAqkW3I5VXGAbNSIJicfCQxZVNINAZKVnsGRpr5FUb33mfJY5IgtycxEVXxfvneN3DslbSHFiIv30WKowXqs3F6zx2YkyYzu9UVC/oqOwvfFYv8EF3CQtKMBRmnwJktIP9+N6xW0LUCi/c8khrnfnvAaFIrOzPqtLVzRCUBEzWRCLBxuYRostOIvwkTpKdnM2ebpiNZe1wwF82lluKwiumTg1QUQ0/NuO4mwrrrU1eQ/RdOfryctrT10xj5md/HXxfLhKaFxiLGN135JUtlkhRvGMlgKXfvwTXYeL8vTjSHrbjfhMSWFuxJMWlIKya3muELokPV94YkUpJ60T2/Q==
Received: from DM8PR02MB8087.namprd02.prod.outlook.com (2603:10b6:8:1b::11) by
 SA1PR02MB8589.namprd02.prod.outlook.com (2603:10b6:806:1fc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.10; Thu, 5 Nov 2026 10:16:52 +0000
Received: from DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497]) by DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497%7]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 10:16:52 +0000
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: Matt Johnston <matt@codeconstruct.com.au>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>, "andi.shyti@kernel.org"
	<andi.shyti@kernel.org>, "peda@lysator.liu.se" <peda@lysator.liu.se>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] mctp i2c: add sysfs control for mux child
 netdevs
Thread-Topic: [PATCH net-next v2] mctp i2c: add sysfs control for mux child
 netdevs
Thread-Index:
 AQHdXH0gJEQaa7DeYESRNm+vhnedSrcEkYgAgAyNxfCACXoQgIABm7iQgAFhsICAAclfcA==
Date: Thu, 5 Nov 2026 10:16:52 +0000
Message-ID:
 <DM8PR02MB80878CEE639FB580244355628E772@DM8PR02MB8087.namprd02.prod.outlook.com>
References: <20261015081341.1262695-1-kenny_hsieh@jabil.com>
		 <179239912623.3135.11352652156626817288@kernel.org>
		 <DM8PR02MB808768B7D02FF12777B7777E8E602@DM8PR02MB8087.namprd02.prod.outlook.com>
	 <7486b1fc4dbcca755dd2f6b6de54d17919af873a.camel@codeconstruct.com.au>
	 <DM8PR02MB80878075D2520A9CAD7DF0928E692@DM8PR02MB8087.namprd02.prod.outlook.com>
 <e89969f13177f2e7b3105851d0cf42eaf11bd98e.camel@codeconstruct.com.au>
In-Reply-To:
 <e89969f13177f2e7b3105851d0cf42eaf11bd98e.camel@codeconstruct.com.au>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jabil.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8087:EE_|SA1PR02MB8589:EE_
x-ms-office365-filtering-correlation-id: 0fdf9b31-42a8-4dcc-c950-08df3b25e93a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|38070700021|11063799006|4143699003|261026140227099003|261028144727099003|261022105027099003|56012099006|261026121527099003|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info:
 t7t/0rznobOsoO8yBvSXJ5erC8lZrR83XMns0zyNJd/NKRqQGuzoaH9YVPF2pd2q3XRNEytFi7R8nb7z5szfxCM5uviL72mIgekzMIpqedlkdcpn58OGsM7sXD/223TxmNWtz7HlZ/TIu0lxpeRQrRZlaHH5K6163cz7XUDaOi24Tr5XzMnkkXSWB7euz8nUaUuGtAMxF7XPpCeIpTJh34EQNrSmBijo/DHWJR3DwJdCjbic3xN/fdmCaMLzjWPd+JyRPTdaSXCAXA42jhsYH1WI//P43Q5y9sTYMyRTIhSoUraNi/LlFpU0iHoNc+KaJryYnLHDYCDgRMmVUvIX73EBnDDExDs4YnCQuqESZnfuA3xrg0qiL22ewnmPktyIzh6AI9rR0moRDMyUCr/VS6PxXjLLuECzps8OJoF0LfRjbVMdEsUoGKVerv6Yxp6x0CK5PgG7UBW+JF++FyFTN8zTTqbUsfE8k7L2n2gPnizaj8VeveO2TzKkz1BDwEaJeYD4dyDcAGtbIgwDYwpdv5+JkKs1LBXLxmlwi6QGo3OTbwXV8jSeT156VqCdrWRxdv1vpn7ff5kkXxzrIssj2HKkeQO2b71mVJ8Oo01AcBSqaiuAoT3akG+upOX+mgx9iTAZIHL8cxQxQAR6QInPPlY32ueifr59F3wSySjpjGJLFEHbg1zFtWSTTcdfe+6gqDKSapO1WiZD0RRtuhH8xB+BbfwOPZPZjr3wA6pYYAE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8087.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(38070700021)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(261022105027099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDZndkRDc3B3VVhXay9DaE9EbFhhUi91TC9Fc3ROWFlzNkZKZDZXWlhibnJU?=
 =?utf-8?B?UHExYjNlY0ZJaFBteC9vWUFDUE10Y3ppaDB0WmdKSm93b2U1NnVYOHRudUU1?=
 =?utf-8?B?U1FXQmQ0RDFKODJvQ2k2WE5WcjlCcCtUbStjK0J1Ulc4WnhYNE4rZnhOT3JD?=
 =?utf-8?B?dGc4UDZ1c2ZSSlhlL0w2bFJxSFZvTzlDbnBrdUVuMEJzWHJDUm00NmQ1RWlR?=
 =?utf-8?B?QWgzQ0prWUFlb1dVSTdsakR6RjZhSzUxQnR0L2NLZ2I2M2NUYmxodnNpR0Nh?=
 =?utf-8?B?bUNFTzU0MGc1Y0hiWWx5bEdRZkFjMlJESVcyK01hTjE5QTcva1pHZXp0R215?=
 =?utf-8?B?NnNXT0ZrRUZqOUoyTG5oZ29zZnlBWWkxS3FZZmxTUHVHbm5yQTBCTFJ6QjJW?=
 =?utf-8?B?eUVRWmh5VWNZdURreTE4c1NRWTY0VzZZTjhiNlpFanNyNktSVmdFQjNOUVRo?=
 =?utf-8?B?UE9rb1pSWWkwYzJqVTRrc0xRTjFLN3E5ZU5ZT2E0NUQrN251UUw0R2ZHOTR4?=
 =?utf-8?B?blpxZDBrR2NSemdPYTJqZmlkWFFKWmJiRmtzVHo3MHkzRGlEcnk0cWhZQWs0?=
 =?utf-8?B?R2kyYmFUbnJnaGhTNU1NYmlxMkZtR21qMC9MSXRYMmpYN0dLdGdhV1drempY?=
 =?utf-8?B?NFc1YzlIYmR2cFlTS0ZqTUJqWHkvSlFldVhsNmFPRHhraW40ZTkzQm5vRUhD?=
 =?utf-8?B?dk9jL0dGUWU3SzBxR2ZYbDFPUW1sSTZiczNNZlpQUklFeWxOL1pxUVVqd2lZ?=
 =?utf-8?B?UnBvVWtzQkFXYzB3VXFkdGhVajhISDJEM1lZb2wwYmI3alRMTHFWNGFWcFY3?=
 =?utf-8?B?MXgxWEpoejZEN3BuUE5nTmRKdDY2N2VpVWkrY3Z6ak5QZVl2UmJ0a2VERU13?=
 =?utf-8?B?QVZmVzUxZXdsbkl0b1Q2UklEN1AvQk5rMHFBRlpObE1MKzh5UkN6WUdxUXF2?=
 =?utf-8?B?a3VhbUZ4VEtoUGdaVzBic21ERWNZSm9TNUcrVURDQ2g3RGdmWVBKdFEzYUg2?=
 =?utf-8?B?aW81dUNNYyt2eFFTci9FZmlJSDd2L24wWUEyQ3RtZncwU0tRbzJoMmhKOE1I?=
 =?utf-8?B?Tng2K3hMTHJxWnRTRnBma1hWcGNISXA5UlFhZ0lMd1RrR1hudi91Ui9WNUVy?=
 =?utf-8?B?VXAyVmFrREMzNjJUSUc0U2I3VVhHTTNLMjVWNFVGNlZ4bWNwYXd3OVFWeGlu?=
 =?utf-8?B?TkNwcmVkdDFIZG0xK2xDUmhnR0ZJaEY0QU1RRjhJRi91WDhKOHgzUmtmQ3Vq?=
 =?utf-8?B?WkJQTXd6bytzQnVPQ1hpLytYRGt0Tk9CbE1WRkp0dFdFbGYwOUxKSUx1ZEJz?=
 =?utf-8?B?aTBGaU5NVVlZMEVMR2RTWkdtOHFVSGJHUW1menUyNGdmOUM0QWd2UjRZayt3?=
 =?utf-8?B?YTBJSExTTHBlcUpzMXVrZXI3MTF1SlRjeldkQW1VYi9Na0FoRnUxTDVlTStP?=
 =?utf-8?B?clFqa3lzbVdzSTBrcFRmZ1hpbzV1MFdOZmt5WHFWUE12R0hjVldpRHppeW56?=
 =?utf-8?B?YkJDK09CeVdpeTdhRlJzaHNQVmhCa21RTDlHTFNNUVJrRncrbzRzOG9NWEM5?=
 =?utf-8?B?MnZUNExKZHJpakJ0UGZTOEFEYmtXY3VCQ3Z2UDNsWUJLN2FYNHZSUFZEcGpR?=
 =?utf-8?B?NzhVTzNoYUtGczVuQVJtUWpqUlo5bTNaQnNNV2NVdUlDaGhHODBtaC9kUnpy?=
 =?utf-8?B?VUtSQzlSRmRNaC9TVitsVmIza2UzNWw0dlpNcXgrQU4yL1NnMWJEeWtLZ2hU?=
 =?utf-8?B?Rkk3NTdLeUdMdytaSERIQkprTTkvZDF0RnlnRGRkWXAvQmc3OVJ0ZHpoZDdk?=
 =?utf-8?B?b2FTRWxid2hJc2IzejdFQzlvN1kxTFl6M2VOS2xldVljMVBxTUg2Q3dvWGkx?=
 =?utf-8?B?TjN6T2lxZGVxTW40d3FkVGRFWWF0SnFZbHdIZEk0RGJTZ2lpSG54a0RMdUtE?=
 =?utf-8?B?dXdONms1MTV3Vi93VGhhZGxETU1ieStMYlBlN0VVanlJTXg5K0gvT2NkNWVl?=
 =?utf-8?B?SmNzR2hTWnowM3hBOGdMaHNwUG5CVENycjJldm8zSXpTd09kelFnaTFNMVpt?=
 =?utf-8?B?amM0MlZRYStQc0RZbkpIRlV0d0R1UExuZytaMjRSdVlBV2hFOWlHTzVoNVdl?=
 =?utf-8?B?U2hRRmQ4MzJic2JTYVFIeUxud0xkTS9LbExjNWdXamNGZHRwcXlsbXVWbGJo?=
 =?utf-8?B?QlE1RmNTb3owcFhGQlNqeFY1V3g5VjNzZ0ZkUEJMUmlyZDd5dHJwVi9LdW5w?=
 =?utf-8?B?cVRaTzdTZzVVVXYxT0VvNHdBNnQrcURGV1gxakI5TTBuMVNITGR5azE3YmdZ?=
 =?utf-8?B?K3F1UG9WVnZoS0h6ZzFqY0R3WFVCZFdMN1J2MDhoZ29pT0hTOSszQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8087.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdf9b31-42a8-4dcc-c950-08df3b25e93a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 10:16:52.2305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jE9VNUoSvuT69Rezvjr7V3oWKcqjgy9f68iKNRN4DPBt1hrGCWFsZVcvPCbSwHpHzWHGXx1DLvbyoKeJMNXCbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8589

SGkgTWF0dCwNCg0KQW5vdGhlciB0aGluZyBJJ2QgbGlrZSB0byBjaGFuZ2UgaW4gdjMuDQoNCklu
IHYyIEkga2VwdCB0aGUgcHJvYmUtdGltZSBuZXRucyB3aXRoIGdldF9uZXQoKSwgdG8gaGFuZGxl
IHlvdXINCnNhbWUtbmFtZXNwYWNlIHBvaW50IGZyb20gdjEuIEJ1dCB0aGF0IHJlZmVyZW5jZSBw
aW5zIHRoZSBuYW1lc3BhY2UgYXMNCmxvbmcgYXMgdGhlIGNvbnRyb2xsZXIgaXMgYm91bmQuIFNv
IGlmIHRoZSBjb250cm9sbGVyIGdvdCBwcm9iZWQgaW4gYQ0KY29udGFpbmVyLCB0aGUgbmFtZXNw
YWNlIGFuZCBpdHMgbmV0ZGV2cyBoYW5nIGFyb3VuZCBhZnRlciB0aGUNCmNvbnRhaW5lciBpcyBn
b25lLCBpbnN0ZWFkIG9mIHRoZSBuZXRkZXZzIGdvaW5nIGJhY2sgdG8gaW5pdF9uZXQuIEl0DQph
bHNvIGNoYW5nZWQgdGhlIGRldmljZXRyZWUgcGF0aCwgd2hpY2ggbm9ybWFsbHkgdXNlcyB0aGUg
Y2FsbGVyJ3MNCm5hbWVzcGFjZS4NCg0KSSdkIGxpa2UgdG8ganVzdCBkcm9wIGl0IGFuZCBkbyB0
aGUgc2FtZSBhcyBydG5ldGxpbms6IGNyZWF0ZSB0aGUgbmV0ZGV2DQppbiB0aGUgd3JpdGVyJ3Mg
bmFtZXNwYWNlIGFuZCBjaGVjayBDQVBfTkVUX0FETUlOIHRoZXJlLiBUaGF0DQpsaW5lcyB1cCB3
aXRoIHRoZSBkZXZpY2V0cmVlIHBhdGgsIHRob3VnaCBpdCBtZWFucyB0aGVyZSdzIG5vDQpzYW1l
LW5hbWVzcGFjZSBjaGVjayBhbnltb3JlLg0KDQpJZiB5b3Ugc3RpbGwgd2FudCBhIHJlc3RyaWN0
aW9uLCBJIGNvdWxkIG9ubHkgYWxsb3cgd3JpdGVzIGZyb20gaW5pdF9uZXQNCmZvciBub3cuIFRo
YXQgZG9lc24ndCBuZWVkIGEgc3RvcmVkIG5hbWVzcGFjZSBlaXRoZXIuIFdoYXQgZG8NCnlvdSB0
aGluaz8NCg0KQlIsDQpLZW5ueQ0K
