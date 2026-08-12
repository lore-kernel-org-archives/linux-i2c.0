Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E5A41D20B;
	Wed, 12 Aug 2026 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531054; cv=fail; b=nB7YaF9NwYvP1410skTEbPtk3yVSgrdc3svWPefXgwM40eQZZsa4oMPEK4jpd431enuL1tTVCHKiqNI36Qw+SWzZD3KETJBNKYBUxcE/r2SaW6UNVFSuVaWQ8tihuXreIXNk6rEaMNInAsdrd3v/Xk61HjPcezKN2UiEt1X3OsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531054; c=relaxed/simple;
	bh=hbsHe6FFeXPhAf50pgPamhAtjBFoGdN+LgNhO4M8S4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PN07SYieHeMXfRnQIca5McwR/+J/WUABDgPgKwah1e6Oi4zo2T5ieMzgl4WIJepNr8O5Fq8mEjFb+cM5N9cKpBvlmwWsshYvYZHP+Cn+bEojNwZMRPf733Bq9dhrM4lnzuPIn0uSXErnaEyHVU75C34bPLe+T5abrL5/1DgQgDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=pgzaqVys; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="pgzaqVys"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C9j0wn1483021;
	Wed, 12 Aug 2026 03:37:28 -0700
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023083.outbound.protection.outlook.com [40.93.196.83])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fyjvyy61j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 03:37:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ed4zPOsHGXwwJb8juUho3WWUYEYly4re10FQzFSaq5yL/QScaM8+ZlJgmEf03FqwxmoOWlZTP+ZKWCXh5N0lG1UMJDi+afDpCRbgxkV0WbUy/X1T1+mwHwZg5a/y0gkbguZy1aKzr3AymYFzylJ+4ZhHJhR/RMz049t76MXtMij5atdIqPHVamWdpjtgx+RSMBGyfoY91563x6IIt+GElXW1C+4FoD8jqY4VqTsfbl/Ifp0ARdSHOs+b3aCly6iLHy3P/vMRMq6zU8PK1Y4WDqgoOTAcAzSODWplqbLG6fEDH8hatXgdfiywkgJrhhpjZF5hMnRQmj2+WZNEem2ngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbsHe6FFeXPhAf50pgPamhAtjBFoGdN+LgNhO4M8S4o=;
 b=ZO0f8tPHfhUl8FVc9rJo+CF2PynYJDb0WPkpUO3IezQDBG2rkbQYQB60ilTH6Ux869bXUjUbq5kt03/ikn6zsb+vGGc5BCZX4a4FYZjXuo1mmZybx7LKRiT1g+yabF5YLprBstg6NKBCw60R7hq9ILeRxlTxebpC9HuBoeFbJdDllO1wCac6rh0P8ooRmU/Xnt9c0jQG9GmUG59oH5qpseL/DMJLVzded9VyyVRNYuosvSE7lMiUpHzZy8ApsLImA+20UJeaiNszn2D/z3gbpH8macojL6nWNBqddE4Lu8dYLNn6fLgH4r0aUWb6GhwSA8JG6TuAtU+VKHY/7MDVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbsHe6FFeXPhAf50pgPamhAtjBFoGdN+LgNhO4M8S4o=;
 b=pgzaqVysDgaHBUtNzxcnSXhQ1NcTQtiue9D+C7RTMD6FBIyrhZ5CP1TCjU0zyVmUe/int9o3fUaQSMsHSulQW809kPh15cppbx0phq4E2He1po8otvt691+qMuk69vuUqTqeK9u1Y9evuzFtspVySVnHF03kFUtPCCEqtrVhbBk=
Received: from PH7PR18MB5750.namprd18.prod.outlook.com (2603:10b6:510:30b::11)
 by LV3PR18MB5779.namprd18.prod.outlook.com (2603:10b6:408:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 10:37:25 +0000
Received: from PH7PR18MB5750.namprd18.prod.outlook.com
 ([fe80::ce3c:977:a1a9:9f02]) by PH7PR18MB5750.namprd18.prod.outlook.com
 ([fe80::ce3c:977:a1a9:9f02%7]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 10:37:25 +0000
From: Umesh Kumar <ukumar@marvell.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andi Shyti
	<andi.shyti@kernel.org>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2] i2c: designware: Enable SAR in slave
 mode for Multiple SAR controllers
Thread-Topic: [EXTERNAL] Re: [PATCH v2] i2c: designware: Enable SAR in slave
 mode for Multiple SAR controllers
Thread-Index: AQHdKgxQpR1sZ6zup0aiBYRw4iA5Q7aaAOSAgAA21mA=
Date: Wed, 12 Aug 2026 10:37:25 +0000
Message-ID:
 <PH7PR18MB5750B4E3CAFAA88C7E9D298DCDDC2@PH7PR18MB5750.namprd18.prod.outlook.com>
References: <20260804041842.3205356-1-ukumar@marvell.com>
 <20260812034017.3654884-1-ukumar@marvell.com>
 <anwdzfNei-2GhPrp@ashevche-desk.local>
In-Reply-To: <anwdzfNei-2GhPrp@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR18MB5750:EE_|LV3PR18MB5779:EE_
x-ms-office365-filtering-correlation-id: f2c157b4-ebe4-4c5c-bf6a-08def85db2f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|56012099006|38070700021|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info:
 v43FhczlHYr/PUG5razYwtkynqy6tbmdjRQeFqSuJHJIFIMIUMmd68dMRDNe8hkObs4ESRiEwPwQt9GGz/G5/uWhEspImjQlrxXpXC8I1ntKNi35aATFOyZ43mUb+ARyDgBVo14RFA4r16eGoISuglKiYIbaj4kJnuRJRnJmFHN/gF2Fd35zsxyS6GI3JCgZPVxYjG0X1JzgY6rZVervfclpRebtoj1B4Ss8h0CDEbtBjFf37Jmsyt6R8pyib+mhq2JyQx7yLdDQ+Z3OGrnZbcShpgvfr+7Sx/3ZKkmNUDZ7+znCVRNpcMMk+UcpFTdNAnBqqttkgj3ZgXCJpvnI9QMQWJrboB9npq9jcoyCmeRwv6Z5XIz43j6Jk/RTE1EmntLe71H4EPlPeKJxG0vtAAPmyclm9bcibPX+jm2PEccy48BojuOW7jSQELRXX54Ap6ckBLj+BYZMOW0936rHgv9bEtRCsaiVgTBwUhmEA1YWqQ0qj0v/3wtGiETcadPpiOqFeEse+VdpCvrEUe2BZasQt1QH+hjJ/YcrCssk/kwTgL0P76KA6g1cWQX/qc4rtOOz4jTV8C4QOk9hHADRFwQqFpVPCNgZEjvBFPPIKR8M9q8LNO4sbDtRxLU1hLXsUDVw3ZFGKSsm1R9Cg19z0PeJdlrTfkhoR13Nn2Zt8NTUmnZSk3rUs8eAZaoa1Mn3xqdWW4OUK+rr3Y6uyq82k74NnlvvVuVB8lwO+u5O/4Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR18MB5750.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUZrOHpjVlVESGcrWDg5REZhVDhRWjc2bm5hYzk2NHExMzFsREk0Zktsd0I5?=
 =?utf-8?B?TE5TWTk3NEdmRThkNzh4bzYyM0ZpR0tsUDNZajJvbDVPL1REUEdaaWdUUFA1?=
 =?utf-8?B?d0N5WFNWY01QVXVIQWkwdWRVMis2bHdKQzkvSzZhRElwSHVmMitQNmErU0dS?=
 =?utf-8?B?RjNST0hHZmxtc3lXbGZsR2QrYXR6SVlLNFRESW9aLytWbWVnSDFwQUNkYUhT?=
 =?utf-8?B?Q3RKdjVpN0ZiTmlCc0dkYzU3Q1pTN0Vsc2I5VGFHS2Zqa0Z3R0ZENFVkdGVV?=
 =?utf-8?B?N3pUTHAvWWxNL3NjVDdDeGlaRnpFS09VWWFYWlFVc0FmSFEvdjk5QXN2N1Zn?=
 =?utf-8?B?dlF3WGtrNm4wWUpMeHpXUzJBa0U4Yy9DOFRJTi9USjdzM3UvYTBlZCtKYjhH?=
 =?utf-8?B?NHdUTUFEVUdHUStwWVdnbGtmc3ZCN2pkZ21TS0dDNGtaUmV3RnNoN0VIOUQ4?=
 =?utf-8?B?R2dscjNuQ09HWXJlNytlWmNzRjhPU3hxeGtrY2hRYXBZSy9TcHhtKzMxM3Fv?=
 =?utf-8?B?Zi96ZUVpeHQ1cnJ2S1VoM0pjN0VhaUpTU3dHb21LNW53UmZyaGYrQ0lobGtL?=
 =?utf-8?B?UHpLN01nQW5XOFRyQThUM29nMUFXcjFMWko4Sk93dE9wR0t5WmpBK0pLc005?=
 =?utf-8?B?NjY2eVY4WkZ1aXVyZ0wzckZ5KzkreFdCRS8vRE81WVlqV0FzYW9SUG5pWmZE?=
 =?utf-8?B?L2VPQ2ovYjhramlhUjZrRzh0YjZScmkrMm5uMkFhZXREN2VkOVRjSWhyWmg0?=
 =?utf-8?B?UFBESFVxbk1wYWpaNWRIRWJYQXVkTHpsUk05MVo3SWg0MUtMdlJKUW1zU1k4?=
 =?utf-8?B?K1B2Yy9yQld4bGhRRDNDYXhZeHVNdnJUZm9QY2tJTjNIM3ZnTUVyYm5rZUkr?=
 =?utf-8?B?dnRxcWFSMXFWR1NxOFlzWjZPM0hTSVI1a0Y0ODdvL3l5dWZVSFkvcVY4ZXUx?=
 =?utf-8?B?UExUTlk4ejRFSmZKOTA0WDdTeXVNaUgzQUVIZndZMUF2OXNEL2RseEg5RVcx?=
 =?utf-8?B?MFQrT1NCUnNGRlIyQ3I1Y2x4dUJwYVk0cDhKcmRFaWRKa1c3clBGeGNjV0Z2?=
 =?utf-8?B?NUo4di94MGlpZm9Pa1hFQmNVTzY1KzhSS1pOU1hBdjdzcWhsYUl6UkFTNy96?=
 =?utf-8?B?RGJsVjlVYzVvczJZaWk2dFNnajljc0dUVXc5N0tBVEtqZDBXTzVMZ09LTFlv?=
 =?utf-8?B?dThka0RtbkI1LzllWStkR1Q3L2xCNUpHM0JEWlR6ZHZnaDJ1TEF5WElsZDVI?=
 =?utf-8?B?Y253TDEvcTZ1c2JIN0ZTU2VkYmRPd2puYnJJQVNXU0Q1N3pJeFROWTM4N3U1?=
 =?utf-8?B?YmlSMWpxQnlCR2JsU3Q5VE10SGZNZkpZM29JWGVEakhpNytJK2pzR3pLd3N3?=
 =?utf-8?B?cGZlWUdxb3lBLzdXVlY5ZHUraXNPK2NBYk5obnBHekpReldhMFRGWHlhRjdG?=
 =?utf-8?B?V1h4TGNNYXZ0Z1o1NElVZXp3Mi8yYitIeER0bXdROTh0cFpGaEp1WUtEd1NI?=
 =?utf-8?B?Vmw2QXNwdHMzRXJaMW1UQTcwQjI5YzVyUi90aUlja0VlbThMVFhaVCsxTGxa?=
 =?utf-8?B?ejRCcVJUa2NKWVVxeDVIb3RTdjNpT3pqdDgwSlRRTGd6UE5VNUVPWnNyQzVy?=
 =?utf-8?B?WFBEbjl5TzJFUVNaSDZDYWVnQkhOM3RCRDJ4RjZUQlMyNjR6dmFCRGZ2SzFH?=
 =?utf-8?B?Z0RCUW1Ed0VqTXpQZmNQZEQraE1CNmxXUGV0SDNDaFhYNHZYeE5ON2h2azVY?=
 =?utf-8?B?dnY1TTlSclBidGNkS3ZROU1hQytGWXh2eWpJbU5IaGYwOU1KWnRFMXNhTS9S?=
 =?utf-8?B?ekRJaEtpbU83ZjdNY2tISnZsQmlzWkd5NnAyczl3S210Q0hzSk1mdXdCY1By?=
 =?utf-8?B?QjlDMzgyN1RvNkp1ZWhIeUlWb09uN2VVWVg5TTdjUGNUTWcvZEUwbEl0ZURM?=
 =?utf-8?B?NU9pWlJrUDcyWVdXdlFTS2JXanZpRXk1Qk9SazBFL2NxcjRHb2g5Y0Y2Qi9W?=
 =?utf-8?B?V2ROQ3ZBWkx0ZWpORXRsNW5vMUdzMk4yQjlBZzBnanlsd2ZGTWpTRGhWTXdr?=
 =?utf-8?B?WHRYajd3Rk44Nk8rbEpTOEVUTHZxT2RFbTNBNk9mUUJUeHhKVnQ0RXFJKzha?=
 =?utf-8?B?RzMzbG9oay93U2M5cG1MNU1uZ2tyR3ZDWGNndmlIR0syTFg2ZjNyUk9kSXU3?=
 =?utf-8?B?ODlHNWNUaTkvVWNqYllEN0pKcHJIZnBKTjhrMWM1bjA4V09MNnhJRytmdWlt?=
 =?utf-8?B?d0FqNEp6Q1NDNGZZaHNadGFVNFdxWDdKTkxLSGtXZHUyVkFiQ083UmNVRUV4?=
 =?utf-8?B?YnU5amlvd3NlWlJZdDAvQU1hNXovbUZUSmtKbk52WWpRZ0tCZWxyTWJRU0xZ?=
 =?utf-8?Q?fBVwltwxrruMidvaqn6qgvBJeuNcMjKStwbJR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	QJU9ej6ZSZDM2uwxnPBlxn/qGbPxfbBFO5FG2bwJY+gGFxLLpkJg1UgeEvas/I0+Kjh+ZjdqpEIE2pxMo6qXHc5PM90wT31NKJLziJgV8t5rvm2HKNLxu4Myiv9Ihjo/+SNPH3Ox93aA8+Wcqr0n018HODVCKjDavF0NROqDl4m9LxH1kcnpX15WmFRmpS/FrjjCINHdOqKlrD4I4MtKh670cIZCbkXpkNmQS35hoA9LfEs/oUQ8d2AIR5WpgW/x4YLiOsJJmc/jgfeSx8A3SfDvD6KidWlj2UM6zdxCjzK+g3KsVNJyFYRQFdgsqoA65yXaPMdaWuKxXk2GajpxAA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR18MB5750.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c157b4-ebe4-4c5c-bf6a-08def85db2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 10:37:25.1254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2TkICGoNqxTshBi5XOBHLyK8e6h2JVVRwWQq/SKGRXbQO8p1F9bOn1RNunUTw39s0QIwXJwn1MPnEbJRDPQPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5779
X-Authority-Analysis: v=2.4 cv=QJ1YgALL c=1 sm=1 tr=0 ts=6a7c4ce7 cx=c_pps
 a=/AsmdbFdlFTi7zs8q1N/xg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=RpNjiQI2AAAA:8
 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=dnWkpfBXLDa12dVJGjQA:9
 a=+r2PwrzZYDIhU/6H2dNeUemIy1Y=:19 a=PRpDppDLrCsA:10 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: qLJoMxpX5aUH_Kj74Eqr_NqdUUk5i8Ui
X-Proofpoint-ORIG-GUID: qLJoMxpX5aUH_Kj74Eqr_NqdUUk5i8Ui
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NSBTYWx0ZWRfX2FeY3+UBtt5/
 dayOikm8bBq6qRbaPOLGkaiLwvXBD6BZMmadMOn5BrW+FBxFfC5TSRDhVUi43umfnJkLFK+JKyo
 jJ33a63aInMcqRxS7hYvr16ZSqmmN2s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NSBTYWx0ZWRfX+7acei5AIY11
 0FxlATbUchKi6RPJCsTYI1AZ2qA/DKtEEK+Jaq/Hna2pkNlkNmCPjSZccsH+eeLoivhB3VRVG6P
 7z7ve8id5aULRsCF7kGjg3sDPMIDe1cGCpI5PVPVgE8QP3QtlDyIo5X01sZXSKzlAdB4FPIWLC1
 y/4IpagPSTYxNCWxFZKcVgq2ipoCCmcgkSHt6ZeZHOjRtv5zJUHxK/eBlxWsW9tkdqMhekjvgMp
 bjYJKW/meCDL6Y/9nfTSOszECFTJGO5gUJ22POPRk3AQ+34rWtviXAeUv71FP8eFDKZJHOlz5d8
 pMsi8CUvhmNkeO8C8WZQLplKv5J7wDC2Tr+0uhqSz+UDAeeZ/ARPfMakb2Jt+WAoczyE4cdSWjr
 hZ4DBdfN3zq9eiM3H1obnm6V+YrTjJ2o5o0GHwGxtDBKyzpjDdz8I0OhYF0MHHJRmnWea/j6oCP
 MZV+gmAS9z5B9epti6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01

SGkgQW5keSAsIA0KDQpJdCdzIG5vdCBhIE1hcnZlbGwtY3VzdG9tIGJpdCDigJQgaXQncyB0aGUg
U3lub3BzeXMgRFdfYXBiX2kyYyBJQ19FTkFCTEUuU0FSX0VOIGZpZWxkIChiaXQgMTkpLCANCnBh
cnQgb2YgdGhlIE11bHRpcGxlIFNBUiBmZWF0dXJlIGRlc2NyaWJlZCBpbiB0aGUgRGF0YUJvb2su
IEknbGwgYWRkIHRoZSBEYXRhQm9vayByZWZlcmVuY2UgdG8gDQpib3RoIHRoZSBjb21taXQgbWVz
c2FnZSBhbmQgdGhlIGNvZGUgY29tbWVudCBpbiB2My4NCg0KUmVnYXJkcyAsDQpVbWVzaCBLdW1h
cg0KDQpGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVs
LmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAxMiwgMjAyNiAxMjo0NiBQTQ0KVG86IFVt
ZXNoIEt1bWFyIDx1a3VtYXJAbWFydmVsbC5jb20+DQpDYzogTWlrYSBXZXN0ZXJiZXJnIDxtaWth
Lndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tPjsgQW5kaSBTaHl0aSA8YW5kaS5zaHl0aUBrZXJu
ZWwub3JnPjsgQmhhcmF0IEJodXNoYW4gPGJiaHVzaGFuMkBtYXJ2ZWxsLmNvbT47IGxpbnV4LWky
Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6
IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2Ml0gaTJjOiBkZXNpZ253YXJlOiBFbmFibGUgU0FSIGlu
IHNsYXZlIG1vZGUgZm9yIE11bHRpcGxlIFNBUiBjb250cm9sbGVycw0KDQpPbiBXZWQsIEF1ZyAx
MiwgMjAyNiBhdCAwOTrigIoxMDrigIoxN0FNICswNTMwLCBVbWVzaCBLdW1hciB3cm90ZTogPiBE
ZXNpZ25XYXJlIGNvbnRyb2xsZXJzIHN5bnRoZXNpc2VkIHdpdGggdGhlIE11bHRpcGxlIFNBUiBm
ZWF0dXJlIChlLuKAimcuID4gTWFydmVsbCBDTjIwSykgb25seSBhY2tub3dsZWRnZSB0cmFmZmlj
IHRvIHRoZSBwcmltYXJ5IHNsYXZlIGFkZHJlc3MgPiAoSUNfU0FSKSB3aGVuIElDX0VOQUJMRVsx
OV0NClpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydA0KUHJpb3JpdGl6ZSBzZWN1cml0eSBmb3IgZXh0
ZXJuYWwgZW1haWxzOiANCkNvbmZpcm0gc2VuZGVyIGFuZCBjb250ZW50IHNhZmV0eSBiZWZvcmUg
Y2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cyANCsKgwqBodHRwczovL3VzLXBo
aXNoYWxhcm0tZXd0LnByb29mcG9pbnQuY29tL0VXVC92MS9DUlZtWGtxVyF0TzNUdmplLUt6OFZQ
cVNmR1pPeFlsLXVNR3JnNy05bHlwbGlIVE5FYk5tV0tfUFhkYmZYbC1OX2JCcHJmOW9tX3VKUDJv
d29jRmV3U3BnUlBRJMKgwqDigIwgDQoNCg0KWmpRY21RUllGcGZwdEJhbm5lckVuZA0KT24gV2Vk
LCBBdWcgMTIsIDIwMjYgYXQgMDk6MTA6MTdBTSArMDUzMCwgVW1lc2ggS3VtYXIgd3JvdGU6DQo+
IERlc2lnbldhcmUgY29udHJvbGxlcnMgc3ludGhlc2lzZWQgd2l0aCB0aGUgTXVsdGlwbGUgU0FS
IGZlYXR1cmUgKGUuZy4NCj4gTWFydmVsbCBDTjIwSykgb25seSBhY2tub3dsZWRnZSB0cmFmZmlj
IHRvIHRoZSBwcmltYXJ5IHNsYXZlIGFkZHJlc3MNCj4gKElDX1NBUikgd2hlbiBJQ19FTkFCTEVb
MTldIChTQVJfRU4pIGlzIHNldC4gVGhlIHNsYXZlIGVuYWJsZSBwYXRoDQo+IHdyaXRlcyBvbmx5
IElDX0VOQUJMRVswXSwgc28gb24gc3VjaCBjb250cm9sbGVycyB0aGUgdGFyZ2V0IG5ldmVyIEFD
S3MNCj4gaXRzIGFkZHJlc3MgYW5kIGEgcmVtb3RlIG1hc3RlciBjYW5ub3QgcmVhY2ggaXQuDQo+
IA0KPiBTZXQgU0FSX0VOIHRvZ2V0aGVyIHdpdGggRU5BQkxFIHdoZW4gZW50ZXJpbmcgc2xhdmUg
bW9kZS4gVGhlIGJpdCBpcw0KPiByZXNlcnZlZCAoYW5kIGlnbm9yZWQpIG9uIHNpbmdsZS1TQVIg
Y29udHJvbGxlcnMsIHNvIGV4aXN0aW5nIHVzZXJzIGFyZQ0KPiB1bmFmZmVjdGVkLg0KDQpJbiB0
aGUgY29tbWl0IG1lc3NhZ2UgYW5kIGluIHRoZSBjb2RlIGNvbW1lbnQgYmVsb3csIGNhbiB3ZSBy
ZWZlciB0byBTeW5vcHN5cw0KRGF0YUJvb2sgZm9yIEnCskMgd2hlcmUgdGhpcyBiaXQgaXMgZGVz
Y3JpYmVkPyBPciBpcyBpdCBNYXJ2ZWxsIGN1c3RvbSBiaXQ/DQoNCi0tIA0KV2l0aCBCZXN0IFJl
Z2FyZHMsDQpBbmR5IFNoZXZjaGVua28NCg0KDQo=
