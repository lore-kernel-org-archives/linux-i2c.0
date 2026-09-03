Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C708638E8AC;
	Thu,  3 Sep 2026 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479111; cv=fail; b=Jxcei6tQbL7ue6pH101+MUF6zXYOp2HQIezJrQJIO/th/o78I19X0UsDUbXLWNR1AB13ePxSJZ9cck2b6aBrzQFFVNXwsNEnWzgAMmfmDv+A18x8OjSzxQ5xl5BdrMsWvGWSgao2/q4Q3wwVZKMx3R1v6jxUEhiWhjCHaqcW0gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479111; c=relaxed/simple;
	bh=tNYcBVnW7nehATpa1FPIE2xYB2k8C6HYiTglHgo4dCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HoL//ahlWbGl7y0NuymU33t8hyQGMgER4ofBR6SDpERkqm0Y/sJ1K28IWBO4x2+4R+t9xwFcWZ1pSG3ECHnJG45hPuhki/m0A0pysxi2/tHqk+E0Bo7mZcVDKdqgqrDIHVLrOfzQxlJlTXUWa336Ado/OHytGpnHmql2o9k25fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=YaO3B+pS; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="YaO3B+pS"
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683Nfqru3836730;
	Thu, 3 Sep 2026 23:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=tN
	YcBVnW7nehATpa1FPIE2xYB2k8C6HYiTglHgo4dCE=; b=YaO3B+pSC7PV4D9CxD
	WxZqVXZa/8M1ccXSa5xQ6h8W5S/6r18KGkoYymuURkKPA5EpsIm1Yb6JJSEYKMoI
	7qUeFSdNEUjbop83zqT9Uf0yVdnLowDMf5zX5pPccZHZJvpXGBHss/t6y5dSRBOn
	6Td4dUjlE+mFCC/WA05ZPiiQD0RVwT+PCLLqrbZryrOxS79YQdBdCF/7vM7wkGMx
	RjYBS9+AUplVQlKrVfNR4LsXmaVFqOXA3QWVs4VE6STFl+k8PtPDINl+PxTKtz72
	z7DU3Y60cKuOzw3MFMKB8yYaiZuERFBJAwKN93EVV8Y103JJ+qszy1pZObxm5fkz
	k3YA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4gfe6vkr6f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:44:58 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 1756B806B1E;
	Thu,  3 Sep 2026 23:44:58 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 11:44:46 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 3 Sep 2026 11:44:46 -1200
Received: from CH4PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 3 Sep
 2026 11:44:46 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGgtx/RKeAZcAKoNM2s8B2fLvRzlYDTBed9TkqO1n5+VHdU6zyTkGw6OF1L24vqdqmG5xTLeX1qnBXBDyDldt0CPClvwJu+Ondxy75ljaPTZY8JwiNv8G082M+00x6Wg/+xYCF8dJkf3DN7NCMukPXJ4UkigMPL+rWmIXZOWV3tMF2H9YDPs14cEAjiNvtSK32dAjgJo+h/UHn20mp4uIjc66WPU2MhZelwlMlC8TEThhJonDktjGJnU+lmHY4/fVsGCP11lOusX/JfqsMZWvUG+trl7u8Q9eNWinNhUkYxJjyMbYVtSPhkMN7CFkAt9kt+jjVa5KzkOwWOBGcQ/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNYcBVnW7nehATpa1FPIE2xYB2k8C6HYiTglHgo4dCE=;
 b=FHXuszh9OmY86hkbHB3fKdaWAstMGwI76u6Xrsyvrkg/886oFAdojBt+Zaj2cj4838U1MzcNfyvbksfgr+afSgLPu4w9YSiswp1yQXwY1oFge9qrnYlxb9Eya7LBLlfEK4o+KLXVcpJpLLn3RWi92Iv045tF0sM3xwn0bKsP6QIQ7q5kjlhIDAbbJOCOFMb/0orQdKR67x0WbRLeM/5ft+7euMBjECYmu/mR5ecU0n1wcyGjLaYeN0t/RTwBDX5a5W88C++qpGmQ/GGI38Qp0MLXltrsLWJnf7rYvc8b2rKKM1iH8MI69PLqh9KsCoA6ffFpUygg/z90XfRyTdM5QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB1684.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 23:44:40 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 23:44:40 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Peter Rosin <peda@lysator.liu.se>
CC: Wolfram Sang <wsa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Patrick
 Rudolph <patrick.rudolph@9elements.com>,
        Phil Reid <preid@electromag.com.au>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>
Subject: [PATCH v2 4/4] i2c: muxes: pca954x: constify pca954x_irq_chip
Thread-Topic: [PATCH v2 4/4] i2c: muxes: pca954x: constify pca954x_irq_chip
Thread-Index: AQHdO/4w0jYeYIWfgEWObmQcTAAcRA==
Date: Thu, 3 Sep 2026 23:44:40 +0000
Message-ID: <20260903234410.1896930-5-sanman.pradhan@hpe.com>
References: <20260903234410.1896930-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260903234410.1896930-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB1684:EE_
x-ms-office365-filtering-correlation-id: 87006c04-925c-4a44-a9b2-08df0a15528e
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: HSDxl4CgOFRhdTEoymsW1AXF8MmZvPe+KGPmLfVF/Q800GtpcP/MDV+FAFhs1zYhwpmqmTuUmoIq5+G3LM7VGp8pb/V0NMYPyfVxzKaMJ4vUAh9jol5qGOGHSGKLEBNmDPShoU5B5CnBEYwwmYZLCaXBNjTuk0NwfUw8X/PZEZAe0LLLdGO1tvTiEQ8Ds1fyAOlFawo2632gyaHlJWoq0bg88uAq5JH3HOIyKQDx09aimvRw4KPM5q8oDKkLLvOVpqXvF9pKPajk3h7DtawphP5Z29v4HcCXrynvcYbkkdgGnZjS5iQ8dUfZhYxKdOz/9kio9ejIy0mQf6TNTn9V27+gKthAsY55mn9n1It/oA2WQAnMbHhzq7Jmlws4tH4c6hscpDt25J69norXGb3w9CJ4awIFuax9PRbE+IzBS7p4eyUaNWC0zduCYK1zURWRHAy7zTzSTPnn/hnJyka31dnM/7aamJnzpxDqEz6f2ZjfUeJv9x6B4LLGFgbq9MVyR3ibzPJaUjA7NlnFq8Nc1wAxCaTQjNPLbzygiF4qRVF9xjryQafyozoW9NmTkitWAk1Haxm0ZSrK4IcQ5FxKP9CF+yCYqHv2gNbnIoo5Ar3ssrB4rAuOFCiUGR5OiHpu8mqIfmLmlSG4t6/Gvp/dtSq/zSWiSLquk8jJlI3rh3SSEZouiFL0XtOn2v2wyyu/+0dwaQcNFEby4Rr+MIvmqro2+F9zePcr5/57eP8zIJY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGpQQUdpQzlTTWxFdE0vNCtaQ3U3YW9iQ1JwTDRSK1NDZjh3UjZ2UHpNVTVs?=
 =?utf-8?B?TStqdXlvVUUvQTZOd2JjRzM2WjdmNkNpSHNPWGo4USt0SlZabVA2aFZtVUpR?=
 =?utf-8?B?b2tQUVltdkYzZFhoOUl4dEozbFVWYjJPVlVYUkVOZ0xHUEdIQmJrQ3N1TEdp?=
 =?utf-8?B?ZDQ4VnUrVUtkNXo2RE1xaUFVTEdaZHpJTk0wUENTL0xhVmNSNlBhNmdiVFkz?=
 =?utf-8?B?dDJWVEwxODFIbkNIWVorZ09KWFI1NnU2UkIyQndUQ0hmVkV6ODd4N0k3SUJI?=
 =?utf-8?B?VEUxVTc3RlZPMCs4VVZsQmo5L3ZTajFkWUk1aThVMVpDd2Q3bkMzKzBjcmc3?=
 =?utf-8?B?cHlVMTN0c0lXYTlsQTFNd0tySENxYXQ5Q1kxNE1OWVd1U0NBamlTTXdPRXV1?=
 =?utf-8?B?RmdaNnRGMnk3VnV1c0t1SEY0ZTRRR3kzR1U0MVdoYkFVcFJPYm43R283ckhk?=
 =?utf-8?B?TFByY2NscFh5UE8wUlVyWUZuc3UwdHVzN0phR3JPWGxSaVNVWjZEcHYvcngx?=
 =?utf-8?B?N3ZMK3hmaDhuZXJ4UG1hUEZGZkh0bWVsNGNJN3JtL3R4ZzRkSmIvdi81aDdT?=
 =?utf-8?B?QmRXN3JSekd2Z2YwanBWNFA4NERIcFFCRExBVmpRTk92SnFhRVdvbXRBMm5T?=
 =?utf-8?B?aE5hZy9Fd2xzV3JPZXBCdG0xN3BXWlZndTF5T296ejQxZ2tBcjJxSlVFMXJs?=
 =?utf-8?B?ZmFoYkdwOURqUWJWY0VkUkIzcVp2K1UydWI3OStLeEFzNVdvV0FrMS9IWm5i?=
 =?utf-8?B?MHgreVJVOEJYTUpwN09kWHFueUxiODJxMWNFZXAyWlY4YllENDJsWlZuenRQ?=
 =?utf-8?B?cDR4NGhPMHA1T1E2NUdiemVWR1BEUnk2Qi91MTR0eGkwR3diNWtYOHBMQnpN?=
 =?utf-8?B?dlRZb095M0p0eE55N0RGVmJOcjh2cGs0ZGZkM1piWFVQSWxRbklRL0xWSyti?=
 =?utf-8?B?S0VnTEFiTFN3RmVWaFYweGxUWndwM1JhTmtrWGZMQlh2eGpHYXZaOEF3OXBo?=
 =?utf-8?B?alVTekFzbkt4SE1SektXcTNPbVh1Vm1aWkJqaE1uKytUWTFJSzBHRkl4MzMw?=
 =?utf-8?B?bFkzOFYxdGZxbmxsaFhKbk53REsvOXpFV3VJWVpLb2M0YUFENkdJMjZQelJ3?=
 =?utf-8?B?TURwZEtJa0xQUlZiUWVTWlhsa0FyZC9DUjFrUkxuOUdnbVVsalFDdzNiRUxR?=
 =?utf-8?B?ZFNrZzllRSs2MmdMQ2dzRHZjcVF0UHBxb3ZqaFo2eG4wTHJnb2xFOUpqUHln?=
 =?utf-8?B?ZVpKSXRMN2JoODc4VmNadkFaSmlxTHpUMVkvRXQxSE44WDZCKzJIVmdobzln?=
 =?utf-8?B?c0hOYmNQOGlBMExnN3pRZGJWYUlSSXh3eGxvcTF1SWtnTDNlNEhQRTF5a1F2?=
 =?utf-8?B?akZoOWlXTWJFVVRQR2U4WW5CVTROZmVFNC9lUWdUK3VpblNzUzA1Tzkva3FU?=
 =?utf-8?B?bkFpM20rK0RYOWlKczhjUmlVeERnUTBhWFdVRXhhZ2lXR3RLTXlwVTdIZWhN?=
 =?utf-8?B?c0hWblhZMmFUTG1oQjNkV1FtcEprbXhTSzh5UjEzTkJDVkVuTVp4ZExZcWtN?=
 =?utf-8?B?S1NwalZaZ2VhWGdxT2pKTEd5dEhKUHMzQmF1M09wdThkaWs1U3BpSHFabHlR?=
 =?utf-8?B?dThqMGd0V3RDM3E1QTQ0dTlYdERLMDBjSmtBbC92UDlvdkFoTFMzd09hclZ1?=
 =?utf-8?B?NldacVlOQkRCUGcwN05GRVNXN1pRaTVDYTRRNXBZYkNRRjZrc0FpRUdlL01m?=
 =?utf-8?B?cHdGbEJqZy9qajZmcGxtKzhlNzZDRmRTOVFFTDN2dFlCYmhSRTd4bWxUUVlq?=
 =?utf-8?B?NWpldXZYWWdaNWdmMHFpNE9rZlBRUDBsaDc1aDBjMEVYUG10WVV3VjB1TmVw?=
 =?utf-8?B?YzQ5S2FrblR2MEdtUGtGenN6cll2a3VsWS9iSTlmK2xxdDJYbUQ1TmNKbDRa?=
 =?utf-8?B?WmZoVVpZT1FHbVlNcUlLUnNpdjBqVFZxbzdXeTJFLzFYa3VkbFZQcCtTTURv?=
 =?utf-8?B?UUhEQldYNC9SSnRyZGIvYTlCNU5Ka0krMlh1TVd3ei8yL0Vvc1AyU3MzWWV0?=
 =?utf-8?B?NVRVZ2RodWVTcGJBTW4yYjlFMS9JaHY3SW5vMGpiZy9yQU5nb214Y3NvVmh0?=
 =?utf-8?B?Z0dwUjJkdVNDVTJjblZzT29SU3NCbnJncndkaW9hQXoxSTUyaEJsWWk1TStq?=
 =?utf-8?B?ZVJlNzcrMm9ZVk5SenFveHVXa3QrSURhVG5pMzNBZ1pMbTBlcVVpbEtQeHVz?=
 =?utf-8?B?SlZkUnhUOHcrVFEvU1Bya1I4Q0RMOGhGQkpsanNBM3VQS0VJRkpxK2pCOE1J?=
 =?utf-8?B?YnRGeEhpa3RRNGkvZUo5REJIdEZFSTArU3BhcC9Ya2VEbCsvbUFVQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Fdl5EiFtk0XM04ZbbQjxwnuKoLlBl7ZQaXR+ReNnjmVLc+4IyUBJEkBpoEVIo2mWK6OSIQ9/Aysv6RMLWp0m6tD/UkPBLu8LetodBwg2Y9GsByhsrzVfazmDDoLwSgYsYtwYA2saHlJ/j4za4Xd859Mm5U/rdGrrrpeHtT7NOJll6ZMnaecxLrARPrlXdm1K8cGxGIAye1IPEbRF3c4tL8oI/4YHbMyazpZVRwFdBCrHN1ajrHAYHIuuPP27YYzjBdiYl4prnWtjDz7eQZAsGh9n/Cz1EAqxm2pQ9/BHbGzwQbfzmSazJmc+HxjbSB+BK3atjCwJ6aWjfUDeWtf25Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 87006c04-925c-4a44-a9b2-08df0a15528e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 23:44:40.5267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6p8iwA2j8g5ZgQPMhF5vCr0svW4UAtZPE0+tv4aCXkMNMoqKKgUr/VWb9nG/oVV81f2qufiPVtY52hhInD2SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1684
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: M2mN0nTjEtJe_QiRyIIAmi-SfloOKmYC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDIwNyBTYWx0ZWRfXzZlfW5y57cz7
 /9Yz+Knk8qRoRbBEgO31/vWyw9gAfRarLLbPmyGpaI31eVjHn/d3r+xgku8gD0TaLaTFA9fV+sJ
 9J3WhAGOaMc2W9MdPv9IUVeV9G2zA/s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDIwNyBTYWx0ZWRfX8Ykr79SZDHsu
 V2M8J9k5s+GXCc1pUGCDvFRqfYhVfEIQt1YwMW1AfUWhneRSGzqof5qfEM03w48QeWmFZgAAE9K
 /RxDvg8bDrivp3IQh1AlbacU6cl3mg9ROarQgncCXC64tkza1ODE7G79K4pwaWANqw3/eGoKn41
 4uN/OhbnCCq0j5ffeXjnXpGUSYSlkgx1Z5MoVOIhLUGdORYEu8fW1VsSvLMbzuDuNTJc166Qgd5
 Tdfcy4YjXcV2IrdGzrhJvg7aIakjKdCcxRd6FReLOB5KOR1ndJy8jocABRz8Wm8mxTT8k5VC6vU
 qroyZDyw1pmAj/f/MZTDaGhr5dhIHVNcR2SveFe448kr7JZPZNRROTftMGGxjHLDt2315gPRgTN
 fAxnhXso8BzrCeGiuQ8txbHpxoWx9UmLtokPwVn0jsljBZlwM26gM9+h3EXas7POau4Xj75lj8q
 Kcq2oGFXaeEgkSGLqRg==
X-Authority-Analysis: v=2.4 cv=FdoHAp+6 c=1 sm=1 tr=0 ts=6a9a067a cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ModqzXLkJJ0tFyq98apW:22
 a=OUXY8nFuAAAA:8 a=XsdBHNuWQXWZDRUPiHwA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: xZR34iMVZJe0eZR-D0OiIEzJZoZ9A4T7
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030207

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpwY2E5NTR4X2lycV9j
aGlwIGlzIG5ldmVyIG1vZGlmaWVkIGF0IHJ1bnRpbWUsIGFuZAppcnFfc2V0X2NoaXBfYW5kX2hh
bmRsZXIoKSB0YWtlcyBhIGNvbnN0IHN0cnVjdCBpcnFfY2hpcCAqLiAgTWFyayB0aGUKaW5zdGFu
Y2UgY29uc3Qgc28gaXQgY2FuIGxpdmUgaW4gcmVhZC1vbmx5IG1lbW9yeS4KClNpZ25lZC1vZmYt
Ynk6IFNhbm1hbiBQcmFkaGFuIDxwc2FubWFuQGp1bmlwZXIubmV0PgotLS0KIGRyaXZlcnMvaTJj
L211eGVzL2kyYy1tdXgtcGNhOTU0eC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvbXV4ZXMvaTJj
LW11eC1wY2E5NTR4LmMgYi9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LXBjYTk1NHguYwppbmRl
eCBiNTJlMDQ2NGI0MGVlLi5kOTEwMDdjZjFmMjM1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2kyYy9t
dXhlcy9pMmMtbXV4LXBjYTk1NHguYworKysgYi9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LXBj
YTk1NHguYwpAQCAtNDI3LDcgKzQyNyw3IEBAIHN0YXRpYyBpbnQgcGNhOTU0eF9pcnFfc2V0X3R5
cGUoc3RydWN0IGlycV9kYXRhICppZGF0YSwgdW5zaWduZWQgaW50IHR5cGUpCiAJcmV0dXJuIDA7
CiB9CiAKLXN0YXRpYyBzdHJ1Y3QgaXJxX2NoaXAgcGNhOTU0eF9pcnFfY2hpcCA9IHsKK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgaXJxX2NoaXAgcGNhOTU0eF9pcnFfY2hpcCA9IHsKIAkubmFtZSA9ICJp
MmMtbXV4LXBjYTk1NHgiLAogCS5pcnFfc2V0X3R5cGUgPSBwY2E5NTR4X2lycV9zZXRfdHlwZSwK
IH07Ci0tIAoyLjM0LjEKCg==
