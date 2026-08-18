Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399DB27E07E;
	Tue, 18 Aug 2026 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062748; cv=fail; b=i/WBnh9Y1QoO23L5796GJD9NYdPTFabuMbUVB+8fAAZmT8sKUwARH8teNV4OSB4kbE18eAMw4S71c++N3B2Wc59Y68s2xFCaJPRQ+CfRSiBVByN8Net08+j3ZUfOsVhLR0sQjflwyenU1x6DHkEq00F8OdsdWQrCXpvj9mEAPfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062748; c=relaxed/simple;
	bh=k3jrAhD1BCiocWqlrkkGKGYpDTZ4STJkgSbimeKBkAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KbO1cUfuiGwYQ3OBk4nhD3M8Cx9goUCF4a56G/m4Wzh5TqTd4JbljCHe/EFc4Pv3HWSPt2LGRzPzbOmvynpkf6FE5K70trLEL0ULUZlb3bCLVgy77qnCafXj14eLKPgeBP7uflBYDLOyA0ClmvuLUejTRKgUYm+n5mtJ22LuFlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=O8CAtgcZ; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="O8CAtgcZ"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3SIn885826;
	Tue, 18 Aug 2026 07:19:02 -0700
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020121.outbound.protection.outlook.com [52.101.85.121])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g36v3ee8v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 07:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhzKoVXyWAcHQHisQEQwLYY2nLarKpeyxFUSilIL1DlGss2SaZtu2HxY6shG5q7AR925h4qfeerYZN5qa2DIxIdcZ6kHXJduhFxl75GSXKIu5uwe0qpj/SoEBO5WxfjzyhzXkcVsjygHBnNcGlhMABe9OgOOCjiH9YATxiEfHTwHLQgkVWoqscXaz6ALFBiAUQgrd2GVuI/s2Lz5hlyZrNDezPZzwgLJvH/uijQWyo56WupWI81O0Ub48Fztn06uuMaQbJN5GxrmrV6Ri1I3HnqdX2W/HSBa2lN8iZ9RmRNsuKcheNb+UAptE7LKIGJ1AMw+klV4r2dPjarBZDNgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3jrAhD1BCiocWqlrkkGKGYpDTZ4STJkgSbimeKBkAM=;
 b=yJprpcEjYt02OeiyLjevKZ2/VHDF7PxlxMvnwPofeuKdL6P8ZiMJUavGocnWYZaF1M9T3f3EfLPhOARnQYbF4guVl0/y3e4utRcFlc0YqVrMgYLEgicOzrC0c2mVFnHjSGJwsD7lk/SC4CNGZdNi+TUchk1XfGKlaXHNuuWPWbzx2HONEkIXMNrqNhStZTxZYUYJu0c1r2lyDW4nhVwK1/8wN8nhDHaTnvIe9P2JmPPP+EkAdHKRudRqt9AS0IHQNG7YrXaaXrLHdYRKJksOnH76TIqIko2meCvQKBwC0oZyXAWHjsJ+YOC7/Rbe/cF3qz3OT8d3Uh25wU6M/Q3QAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3jrAhD1BCiocWqlrkkGKGYpDTZ4STJkgSbimeKBkAM=;
 b=O8CAtgcZ6Xe9MoTGkkRLHKarAfFo02Msyf42A3diie2hhVUflIkttxAS7dohQpNL7EvIpAeJlNaofC84eFISonJBS3PIUVMIdNHUTK4TO4bi3FwacoMOMAnUrZZlTQyPZTnAuu9mhYJlv4LeTIMXto/cvn+Hf5mEppYJ5JfZr0Y=
Received: from PH7PR18MB5750.namprd18.prod.outlook.com (2603:10b6:510:30b::11)
 by DS1PR18MB6170.namprd18.prod.outlook.com (2603:10b6:8:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 14:18:58 +0000
Received: from PH7PR18MB5750.namprd18.prod.outlook.com
 ([fe80::ce3c:977:a1a9:9f02]) by PH7PR18MB5750.namprd18.prod.outlook.com
 ([fe80::ce3c:977:a1a9:9f02%7]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 14:18:58 +0000
From: Umesh Kumar <ukumar@marvell.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Andi Shyti <andi.shyti@kernel.org>,
        Mika Westerberg
	<mika.westerberg@linux.intel.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v5] i2c: designware: Enable SAR in slave
 mode for Multiple SAR controllers
Thread-Topic: [EXTERNAL] Re: [PATCH v5] i2c: designware: Enable SAR in slave
 mode for Multiple SAR controllers
Thread-Index: AQHdLmSEqaiOAmDUP0mRKqkElOYNWbaib4KAgAFrjqA=
Date: Tue, 18 Aug 2026 14:18:57 +0000
Message-ID:
 <PH7PR18MB57503E68E77CCC4F748DC065CDA62@PH7PR18MB5750.namprd18.prod.outlook.com>
References: <20260804041842.3205356-1-ukumar@marvell.com>
 <20260817162141.300658-1-ukumar@marvell.com>
 <aoM33xFR6cvpAY2m@ashevche-desk.local>
In-Reply-To: <aoM33xFR6cvpAY2m@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR18MB5750:EE_|DS1PR18MB6170:EE_
x-ms-office365-filtering-correlation-id: 3e8b25e4-2309-4201-b452-08defd33a48f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|56012099006|10067099003|6133799003|4133799003|22082099003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 mZRnIYEXn5xMJEgz63bx1hDvErwWklqNAKB8e0dgg0DWO3GxWBIUVSGvseq66NZdb7FsS4m7HB36ywJ3TZnhwdDzSpa8si8+Jy9oh0K4qvrBncuslG6hN2pBP6Gwbp7CgIMg2nMlH8zrzArJznocw9+YWSUyxvTaoVsC1efcdXTktn60apSJz6QxidceKtVEebFfBK3AdsDyi7Cy03pqDWAI/LCZO05umiHHOHFVxQhCFw5W298zOsm46kXgfnYdDdt/2bQr3TPWqiHXAUEh0OV4LGjn8m+Q5rM20tIYseIJeoSVYr2eXLFq+30YXJY9f4kfdrzomcZ0zeosPQSvSuxDfTUdRsuK6kSHIJiaFdWxcgLzP2u0ICU/Oh0s3ckIiiRRNmo3dmHxAy8EV8MXWDv8A3aQ0+hxeXgP6Qj2G+Zgu3kEfk5R+8Szyz9TVjeAuiC4hyAFIrA4kkz16gSN/PkRUI2ViZMfGHVjFlKqS9O0oow878Q6SNxjCqis1fRJtk7FObKIePbi3uhHoNdbTqiu7AHDIROMVWLhJTyrdk81RBkrqkHIBATHjOrYoJwjxBvjq64Lxoqkjy4xznanvjEG3WzCuqxwiyJUkG3mVMCT4sCEkYqEsK6gGaXzXUPawoDsCNFsPAFweoQubTTo5Si8U/8UUXrc371paP4+T9s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR18MB5750.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(56012099006)(10067099003)(6133799003)(4133799003)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0tyRHFWRXRoOEFpZVV2UnM1SkV2VS9HUWNDZy9pcXpZTkZjVkZJc2dPbXNj?=
 =?utf-8?B?UWVyQVlMWGh6WlVpNlVYTEdqVnEyV0xiUDJHQ0JIVkNIVEhVb0lWSWh6TTdV?=
 =?utf-8?B?THgzOE02L2VFbnRJSUtaY1Z5L3hHRjdWWFc2UmVvSER1anNLTjkrS3dpb1hS?=
 =?utf-8?B?NzlRbERMc2xEaWJzMmRKNVJWSllNQkd1bGgrWmZCTkNBdisxNTU5M0pEa3lZ?=
 =?utf-8?B?Z29OeXlKV0pLV0RlTUpVeDVNMEd5ZEhvREdIUTVxdlZJbGNzd1E4eEhZekhU?=
 =?utf-8?B?YlZiNDh2OE0xNUFQbi9HSUwrNzRaSzEweW1IVS9LQ3FGWE10U2VJa0xMb1Uw?=
 =?utf-8?B?cy9TT0JKRXQ5aWhBWDhPZW1JdFYwT0ZsS29RNUxiMmI2dGhlZytkMWpLN3pq?=
 =?utf-8?B?TGtCSUN5dW5mNDFjTVVvdkJlRllURUNvWXNHZzZXVjUxQWdlVHlwL3lPSDY5?=
 =?utf-8?B?ZkNUQlhuejFBUE5EdDNkZk56MzNOcGk1a1VLN3o1ZHpZeFdvM05VcmZvZnNq?=
 =?utf-8?B?RFN2RjVQMU9yOFlBbnU0cXRIVXlqN21BbVhwZHFXOHA4VHU3NjlJMlpQUzl6?=
 =?utf-8?B?b3lKR3F4aHVZczY2WHovTGNJQmVWK3JyT3lOUUxKRDFpTDZ3dmZxNGNvckQz?=
 =?utf-8?B?dWJJdXk4ZG1nOEpQVjlmekkwYmRkUmJoR2NwV3B0aVRhMTEzN0xHSVFCT2wv?=
 =?utf-8?B?L1NBTVh4RElpMmJLOCs4clZxQlNmbDRNZUg0NEEybjhGbTRYL0kxS1dNTmJE?=
 =?utf-8?B?Zkk2dkRadHdLaVVWWExtN3NFRUJSUUtOWk1rRU43UkJpbk9wUnhsS2M3UjA4?=
 =?utf-8?B?aXdPSWE4b1FnY2dxMXdoTU1tVTNWUGVRV2VmME9pcTlkeXFSTGg3QnlvWTFx?=
 =?utf-8?B?R1kwOVFSWWcrVUNwLzE3SFNINllQa3ZpWG03WFdxMURXc3k1dXkrdkFTWnRu?=
 =?utf-8?B?T2J1MDh0T2tXL2dobWhUTFNPemFGMVU5OFoyWjFoL1NYTnhkWElHRE40anN6?=
 =?utf-8?B?Mk9JcjVIZE5INWhaMFZ3YkdNblcyT0IwamF2dGE2WVhOM0w1OGJSdUxvZjVt?=
 =?utf-8?B?dCs5eURoMThNOXovMXhmSms4cG1xTGlRZ1dtaUVScWJ2eHBiaHNPN1E2a0RS?=
 =?utf-8?B?eC82MElHSWtRZ0tQWGdTWXJVL3plMVc3VHVablZOalc5RXBiWTJYTXo2aXJm?=
 =?utf-8?B?TXBoUzVHSFJVREFwdTFtZHRLcy83c2tsY3E4VExWWEpwMGNKQ2tvVDRVUFJn?=
 =?utf-8?B?bU5HLzFjS0NpYkdEdWcwNDgxRnFmQTd4aS94eU1MZG84ZDNrSUp1ZFUxWlBO?=
 =?utf-8?B?djFBT3RPRS9HT1MrM0ZIdHF4L2hzUHg4amFEZktIbGdyM2VHSnBLcmErUTJy?=
 =?utf-8?B?S2d3YU9YVHFNbVBnSkhTZEZtdk9HTEdKOExyZWt2NkQyM0lCeDdKOW51VXJk?=
 =?utf-8?B?eG5jc3NzblI3ZGxVMm9QZ2dLL0lPVUh5ZUdDTEl5eXFoOEloaGJ5ckVQTFF3?=
 =?utf-8?B?SVUvSWFCN3lJWXFtRFk5eTFKbmFJck9FUXFjbllNNVhGTnR1WC80SEI0Qith?=
 =?utf-8?B?SUZnMHB6dTN3dG90c3lvQm9ZaGEwcUlhSTRiTDhHeEFUdVoyTzlacnZ2cTZs?=
 =?utf-8?B?Rzk0S0xpUGRDM0dZMFh4YXlyOGNXTTNLUHhyMS9FT0xjRHpTQVB1bWlQS3Jq?=
 =?utf-8?B?emMraTFpKzJlRFlYd2hMcjMvV3BnTTFtdFFMWlJ2Sk1aK2t0WGRZYmh5QkpG?=
 =?utf-8?B?RzNzaGFNejZOV05CNGNiQU1XVG9mNzJQSFU4RzFabFlpamZ3QXJDdXhndmU4?=
 =?utf-8?B?eUlVRVRZbVRIaFY4MXJ2UlNOa3JXVU5UYUVrSGZ5QXZaVnlyWExUcmdxQWFs?=
 =?utf-8?B?UkxtWHRzMm9KMDBiNVdGbEFWTkJSaklhWk9YZzRTdjJUV0szcnA4K3AvUFpQ?=
 =?utf-8?B?SzhRM2RIRUI0cmhMUGRaWWJaNi9lV2lzbjA2bE1tYzlkQndaUWQ2U1V3M0NB?=
 =?utf-8?B?VGtZZU1NTHFFeEF6WlIvYkNkWFpORVNsZVA1NXRrOWpMU0R2SUlQZG1aSUcz?=
 =?utf-8?B?TnZCM0xFdTNVTGJnL1kyQXVQNzdNQkFwTytmTzNtVFczTyt6aldZSnhVS3Fx?=
 =?utf-8?B?WmpFOHRqV0g0V1pOeDhzSkh6d1BtTkk0TXo3SzJNdVhuZzlISWN1UFpvTEpQ?=
 =?utf-8?B?UG81YVNCbmNIVzRsLzEvWm9PTjV6dERPeUhORVVrSEU4d3kvVmRQZ3IreEo2?=
 =?utf-8?B?bE5qR0hDeW1uUFplaGwyVm5yNjZ0bTVxbmliNEhYYVJPNUtNTHczWENPS0Fo?=
 =?utf-8?B?TEVkTWh6cWptNllnR0p0eDZVSnNFb0FGYjE2encwc1dzVEg1QVZ1MnhZTEtU?=
 =?utf-8?Q?VGghBXielA6UhIwvnuMkedzOEvSaRw+EzkymP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UsoSDOR8+Z2LXV7f6FeP6OVxTA6TAHGJS1K72N38on5ewjL7o7b+HQdBPXBGwTC0xuIuE8rxe+sCztk6MtqN6j+Ok4iFgvcy9W/2+DPUYAR4GtSqmgngCBRTj5OzPaJQahSqo7YS9bIBloHOckUIWWgUknfnZmEPpdt4F/fo7q5s/0m0vxc6KFO60RcQXLBnPr4c6TMSr2oy6dzJzoCzs/6U+OFdxTa1w67ucO7roY/IpQazdIyCJhntGZRdu9npn0a6J/MJEvDH5/uXO4JDVDRSl8b5sKC5qG7njfRLHDwTcCc12m207A7CnaqDNBjUxCNYZB5ztNBjeI/p1PLN9Q==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR18MB5750.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8b25e4-2309-4201-b452-08defd33a48f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 14:18:57.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2cFu8Nrb+Qwjb0aFHh3ENHS/ugtV0oFe5fbkhPDSSoS89fLy6QDiDnUh6BjHPGes6zx60K8ugX/Gupef77nrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6170
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNSBTYWx0ZWRfXxyFQqThcouZH
 zDVEoOIG20V4QQNlz1YSwIFZmNHWP9cBiOWRvfgzT+zqV6zt48rUTSrHyFOSDK3CxpLqYM9rWwo
 ndz27L9cLDT+jLxcIBhTRZ+zDwEWrBY=
X-Proofpoint-ORIG-GUID: PLnlydgKTkfeTU55NxDCDHn_mPlM-j1G
X-Authority-Analysis: v=2.4 cv=MatcfZ/f c=1 sm=1 tr=0 ts=6a8469d5 cx=c_pps
 a=Yi5XoY1Pvk1/bV4Hj+lk7Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=RpNjiQI2AAAA:8
 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=dnWkpfBXLDa12dVJGjQA:9
 a=+r2PwrzZYDIhU/6H2dNeUemIy1Y=:19 a=PRpDppDLrCsA:10 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: PLnlydgKTkfeTU55NxDCDHn_mPlM-j1G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNSBTYWx0ZWRfX/Wfxs88FWz9a
 nyWNB6jVNDYLr1wb50zxVnMhjN0PDhF+lHhpBR5WGWcMaI4RFlHgiANFmdqnPsTlqQMnCpT6zZN
 57lSkRxuRLIj41WGcwxAL/cVexrpKYDYkoJUDrXWqdF8pr4j98GuLoqdg0XMVXtkhdYPnkm2gdJ
 F4HnSTh03GQq6egsYWX9CxD12CqTEo516rAym/fKJ5ncWfUAyMeCvZCBAFZ7whBjST/BX64clfw
 jJUA+tGb4WQMT+jko9qpawdWNzXzSkMtDBfQ36/a6e2VxqSu9pVmX1zKjrv+0ijIJ+cyRZDxzLt
 YZih5rHxBr738tPGQKGtN7Qp1kF32ZJy9wy4mo2eCrK2MmOsY9v1vfn1MkjodQDKO2Py3fXgPbY
 fHR3Kl0zXRok1xXKIuIpfEHcLpQ2bOoiyC295G637BYVf0KC1znK6JbXCKrFybM1dCvgxpS+i5u
 bsUREh37zwrzTCpFgxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01

SGkgQW5keSAsIA0KDQpBcG9sb2dpZXMgZm9yIHRoZSBvdmVyc2lnaHQg4oCUIG5vIGZ1bmN0aW9u
YWwgY2hhbmdlcyB3ZXJlIG1hZGUgc2luY2UgeW91ciBSZXZpZXdlZC1ieS4gDQpJIGluYWR2ZXJ0
ZW50bHkgZHJvcHBlZCB0aGUgdGFnIGR1cmluZyBjb21taXQgYW1lbmQuIFJlc2VuZGluZyBhcyB2
NiB3aXRoIHlvdXIgUmV2aWV3ZWQtYnkgaW5jbHVkZWQuDQoNClJlZ2FyZHMgLA0KVW1lc2ggS3Vt
YXINCg0KRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRl
bC5jb20+IA0KU2VudDogTW9uZGF5LCBBdWd1c3QgMTcsIDIwMjYgMTA6MDQgUE0NClRvOiBVbWVz
aCBLdW1hciA8dWt1bWFyQG1hcnZlbGwuY29tPg0KQ2M6IEFuZGkgU2h5dGkgPGFuZGkuc2h5dGlA
a2VybmVsLm9yZz47IE1pa2EgV2VzdGVyYmVyZyA8bWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVs
LmNvbT47IEJoYXJhdCBCaHVzaGFuIDxiYmh1c2hhbjJAbWFydmVsbC5jb20+OyBsaW51eC1pMmNA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBb
RVhURVJOQUxdIFJlOiBbUEFUQ0ggdjVdIGkyYzogZGVzaWdud2FyZTogRW5hYmxlIFNBUiBpbiBz
bGF2ZSBtb2RlIGZvciBNdWx0aXBsZSBTQVIgY29udHJvbGxlcnMNCg0KT24gTW9uLCBBdWcgMTcs
IDIwMjYgYXQgMDk64oCKNTE64oCKNDFQTSArMDUzMCwgVW1lc2ggS3VtYXIgd3JvdGU6ID4gRGVz
aWduV2FyZSBjb250cm9sbGVycyBzeW50aGVzaXNlZCB3aXRoIHRoZSBNdWx0aXBsZSBTQVIgZmVh
dHVyZSAoZS7igIpnLiA+IE1hcnZlbGwgQ04yMEspIGdhdGUgdGhlIHByaW1hcnkgc2xhdmUgYWRk
cmVzcyBiZWhpbmQgSUNfRU5BQkxFLuKAilNBUl9FTiA+IChiaXQgMTkpLiBQZXIgdGhlIFN5bm9w
c3lzDQpaalFjbVFSWUZwZnB0QmFubmVyU3RhcnQNClByaW9yaXRpemUgc2VjdXJpdHkgZm9yIGV4
dGVybmFsIGVtYWlsczogDQpDb25maXJtIHNlbmRlciBhbmQgY29udGVudCBzYWZldHkgYmVmb3Jl
IGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMgDQrCoMKgaHR0cHM6Ly91cy1w
aGlzaGFsYXJtLWV3dC5wcm9vZnBvaW50LmNvbS9FV1QvdjEvQ1JWbVhrcVchdE8zVHZoRDB3aHpV
T0U5MjBSVlVRX1hKUFYzTDI2Uy1sRU1ucTkyUkpBOU03aHg0ODFrWng4aktqRnpkUTlGWU9fSHJS
M3l3TDM0UHFTRnFXQSTCoMKg4oCMIA0KDQoNClpqUWNtUVJZRnBmcHRCYW5uZXJFbmQNCk9uIE1v
biwgQXVnIDE3LCAyMDI2IGF0IDA5OjUxOjQxUE0gKzA1MzAsIFVtZXNoIEt1bWFyIHdyb3RlOg0K
PiBEZXNpZ25XYXJlIGNvbnRyb2xsZXJzIHN5bnRoZXNpc2VkIHdpdGggdGhlIE11bHRpcGxlIFNB
UiBmZWF0dXJlIChlLmcuDQo+IE1hcnZlbGwgQ04yMEspIGdhdGUgdGhlIHByaW1hcnkgc2xhdmUg
YWRkcmVzcyBiZWhpbmQgSUNfRU5BQkxFLlNBUl9FTg0KPiAoYml0IDE5KS4gUGVyIHRoZSBTeW5v
cHN5cyBEV19hcGJfaTJjIERhdGFCb29rIHYyLjAzYSAoTXVsdGlwbGUgU0FSDQo+IGZlYXR1cmUp
LCB3aGVuIHRoaXMgYml0IGlzIHNldCB0aGUgY29yZSBhY2tub3dsZWRnZXMgdGhlIGFkZHJlc3Mg
bWF0Y2hpbmcNCj4gSUNfU0FSOyBvdGhlcndpc2UgdGhlIGFkZHJlc3MgaXMgTkFDS2VkLiBUaGUg
c2xhdmUgZW5hYmxlIHBhdGggd3JpdGVzIG9ubHkNCj4gSUNfRU5BQkxFLkVOQUJMRSAoYml0IDAp
LCBzbyBvbiBzdWNoIGNvbnRyb2xsZXJzIHRoZSB0YXJnZXQgbmV2ZXIgQUNLcw0KPiBpdHMgYWRk
cmVzcyBhbmQgYSByZW1vdGUgbWFzdGVyIGNhbm5vdCByZWFjaCBpdC4NCj4gDQo+IFNldCBTQVJf
RU4gdG9nZXRoZXIgd2l0aCBFTkFCTEUgd2hlbiBlbnRlcmluZyBzbGF2ZSBtb2RlLiBUaGUgYml0
IGlzDQo+IHJlc2VydmVkIChhbmQgaWdub3JlZCkgb24gc2luZ2xlLVNBUiBjb250cm9sbGVycywg
c28gZXhpc3RpbmcgdXNlcnMgYXJlDQo+IHVuYWZmZWN0ZWQuDQoNCkkgZ2F2ZSBteSB0YWcgYW5k
IGl0IGlzIGFic2VudCBoZXJlLiBXaGF0J3MgZ29pbmcgb24/DQpEbyB5b3UgdGhpbmsgdGhlIGZp
eCBpcyBub3Qgb25seSB0aGF0IGFuZCByZXF1aXJlcyBhIG5ldyByb3VuZCBvZiByZXZpZXc/DQoN
Ci0tIA0KV2l0aCBCZXN0IFJlZ2FyZHMsDQpBbmR5IFNoZXZjaGVua28NCg0KDQo=
