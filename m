Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C737FF75;
	Thu,  3 Sep 2026 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479126; cv=fail; b=hJHapFjLs9JQG7hUgjnDWiU22YYKqEJ5xOWEIZ2457vfmKDRvSyGOWo/Xs2CY6ZuL8JFzuxprnPwuYyPaCy9PcChUOgR348t+6HgAg9SYGGhR8GygGlJ5j6FTuwsmT94k9KjvkNz4sYK3vBxnCRIZFP8zVHuvF6yCJA/sWwRZ9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479126; c=relaxed/simple;
	bh=6BrLYlOy/bNcvIhEMUiOFFxkqk2qDXmyJB0fJyJpgZs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q1lBlpkEK7E3MKzrWTVYhv5uAi/c0rjD6zlQgJyZQUflBX6rxzerthhvv4Bm1Rccom2SNdjbDPeToa+wSqC/TWdyfNRaCGwwlGjEHy3TP8vAaAePSRr7o7m1+rqbGz9qK4AV2wymfznRiioIigvLd5QoR2u9S8vpwF9F6EoEanw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Nyi/OVXT; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Nyi/OVXT"
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683NbmOe1531650;
	Thu, 3 Sep 2026 23:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=6B
	rLYlOy/bNcvIhEMUiOFFxkqk2qDXmyJB0fJyJpgZs=; b=Nyi/OVXTJhAIU1JuBn
	q3djmkyT0+8nfORgr9c19g+v0Q0XMduSC65feRhSMSbZLwnmfdtmw5paQHw8sGMD
	yg9lacvzWuQw/lW1fwhem8bpVtMCBCDhY+QocbKcEUc1xr/mxKJO3h070JChr8Kr
	pcgrUa+DL+CkClf0JKgL0MH2rdWAt1bOQy2SGg0a1rgfp7EuvGLbdi/OccWYBuNK
	sFkBL9LSfzCrU7DAGliiSxBPz3Ole1XAeWz4Njy19uubATAnBKteNJMNckJKSYeu
	83XqiVD9eDb0TT75FpexBO6EJhP0Vh0HauXeJ59NLdeQZ5XS6RfmMFXgx7ZKXoDR
	FoCg==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4gfh231bn5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:44:58 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 6699914785;
	Thu,  3 Sep 2026 23:44:46 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 11:44:46 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 11:44:46 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 3 Sep 2026 11:44:46 -1200
Received: from CH4PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 3 Sep
 2026 11:44:45 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoJUUN8uMKWjMxG+im/NmtfrFpx+a6v/XLxIhox/37A14RZyWDkc2ExeFZVrGROBwZCcpxfk8CQoyZtsc6Q/i90K+XwrJDQKwlLoxYOC7Xb1UJAZYyoMYyTUWv29DClREsa0KYT7uaIRuvuwI1U5Dc9C12Zm3KkCQzuxpy4aSpnIJMiO1C9y/M1bve7YlKiXOu2/gD3jDWVZWwSLB5CmegioXQepCl//fPC6k8h/5vnUYh8pN/uMt8sO+Juz+LptHZTZbNw+KL/RfUW6QWZyfWijLdqkX7lqDVkmAZYTUur1Zh+rM7FgFRijnl0FWh8rLoWIshcxpBPG4RGn3nuW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BrLYlOy/bNcvIhEMUiOFFxkqk2qDXmyJB0fJyJpgZs=;
 b=Rp2MAym9IdVXn6+Dy9j/+gJZhq/zQnDihr/GVqeEKOqIAYF9ky9U0X3h5rjFuyoV99X2G3SjkErAizA58vnUgXOvZ56JNBby++aixpesCzI1SKrzC33AQRK9CVBjao3xNmsKWwc3kjkpCOi35uIKT2KmUc1/cwbNdptP+tdnfJV69seSeCfO2HW4AbPbIvVPsOLpuX1P+NQP+WS8gazkWfVxnYz6z4HmyLsfUEugwVNul18/DnJ6H5Hh5UM/PACsIqUpZ29C/UF/yMSn+XJtyFhYw9TbDoPlKX7GoBXOMG85pWManHSb1ICOl2Y+LuvoWfI2c7wRgavWfklyorTqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB1684.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 23:44:36 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 23:44:36 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Peter Rosin <peda@lysator.liu.se>
CC: Wolfram Sang <wsa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        "Patrick Rudolph" <patrick.rudolph@9elements.com>,
        Phil Reid
	<preid@electromag.com.au>,
        "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>
Subject: [PATCH v2 3/4] i2c: muxes: pca954x: use sysfs_emit() in
 idle_state_show()
Thread-Topic: [PATCH v2 3/4] i2c: muxes: pca954x: use sysfs_emit() in
 idle_state_show()
Thread-Index: AQHdO/4tCpfoQIQBYEacdqADS+t27A==
Date: Thu, 3 Sep 2026 23:44:36 +0000
Message-ID: <20260903234410.1896930-4-sanman.pradhan@hpe.com>
References: <20260903234410.1896930-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260903234410.1896930-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB1684:EE_
x-ms-office365-filtering-correlation-id: 9439b911-4548-494a-b187-08df0a155009
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|6133799003|18002099003|22082099003|56012099006|3023799007;
x-microsoft-antispam-message-info: qS8ekeRHd3Is22PTfvRSv0t277SU3EgYRwawk1MAw3gOGQ/22n4BiXV/d0b1MW19u6auFLjbw6X0R+e06EeAK7n/BjSXNXFvcliwVJiivuFJtZR42Ckl2GpdvH75Msx311H8gzXP0ZlhwCa/i9RClm1IF/SB5AyZiG1p6zmNVwJy8c2gYsSY/k7sjVViMZLxZyOA3NTVG/yL/qTrIafx4EYgCjeMeuS0D/J/81oZI4L0Y5kCTWGjw3miTWaIQwJ3IdkYiINSXONqWP8Uvkp21Koc2zBHQzwBgvbaE7ud2TtnJ4AlYipLnutcmBc/QoSCOuAlj728m0EAwF4PV7L59L6BOY79GT/WtBP1NXih6BS6+V4m6W+jd1KWtubH7fVREZAN7DSlSx5/t5RHnLgwp+fSwJYyBk4/xKXog/dC2tCe10Cc5tYDbIC3y6Yd/vD8CZFAOvhjN3v/1HDJNFbVfegYvcEeqx2fBsV5/KXCZ6E9I4t+1qJS6kn08wXhJy5ExTsr7qjGavwV1ff4o3FTpkeymdqOJz22YeADlrPnD5WrGzZyphitkNnjzJdBWOG5VwREICxlpwbAlNDYC0qvr/BAWWP6nvBa8i7jp7YhrN2JJZnhZsrNtuwGdGOunzpumes4EnHFvwyhxJ4yriBcWlgkxL5pUo06owPc5iWSgC/ihLjgNiy6XNZoPwzG1jecUwvOrJUhTgxymALKh2irYomMopUHJixehGeMCBSnsPI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1RlYnlxRVpRUUZ5OW5kUGplN0tSL21jMkE0RTM0OXJ0ZzRRbzUyK2gxcFZh?=
 =?utf-8?B?Nk1ZcjZ5VEhGcEIwenJ1b0ppYm9nM0o0M0IwMXd6V1dVNkM3MzFoV0w5MHJo?=
 =?utf-8?B?SE40Y2EvU3lISHBBUUhmNkZyWHN1YmVDVHFKZXBCbE40MGRlMHhEdFFHeVlh?=
 =?utf-8?B?NFRHQm4yb2V2eGdTdi9JakJSWGxkTnFXVEk5Uk4wNk1BQmJXWm00bVdWTXlr?=
 =?utf-8?B?d21mVnJuc1ZXakJ2MTJSL2UrNno5enVjV1ZKM01xWnBsd04wNzNPUng4M2xR?=
 =?utf-8?B?WDBXMzJuOS9ETWlnUk5lMzhDUDBXMHU1anQwUU9CU0xsK2EvL1FVVjFDY1h3?=
 =?utf-8?B?TEhaUzJxaElYREVqZElpbU5SU3E2c0hhdTJaNVZWNVVpVG1OS3BPeFhDUm1R?=
 =?utf-8?B?aERsMzFGS1JxbXFISTU1dCtHNEpzMmxzdjZ2Yk1pSWVQTUMvM0hIMDhuT0Y2?=
 =?utf-8?B?MjR1bnFJcGlCSmVhSG8yKzFUdkl4TDNXUURWQTBWS2VVS0IxREVwNnpiZUVs?=
 =?utf-8?B?dVdaV3htYWU0b3ZIaFRoNWdvNWUvcTNVam03SzdZRnJNNUVQc3ZYKzA5U2w3?=
 =?utf-8?B?NTJBOVdLbkRmdEN5SjRSZmcyOGdYTkZuT1QwWk9BVTFKWVpaSlFLOS85b2F6?=
 =?utf-8?B?WmpUbnJEQ1BCNXErRzlvUzhoNk1ndUJMM0lvbTBhTkk3MjgwcFd0MWpzTHYr?=
 =?utf-8?B?L1ZGbW5mQXdyNXU4bVFLRys0cEh1ZThSUzRlSjkxRC95VEI0azQ0UFVwTUNi?=
 =?utf-8?B?VDQzN2ZXOTFXOXVZYWtHdVZDTWlDc3l5RSt2U0VMVWZ6VUhGU3pEQmIrUFFo?=
 =?utf-8?B?N1oraEVKS3BmSTNNWDJqRVNZcTBlcDRQclFFcmFkd3hNZXI5M1RIVUtzNlRQ?=
 =?utf-8?B?UmtGTWRHZEt2L3VvN1ZBZzE5RFhiZTNMaUpsOENCaWU0VURUQUhVS2VUSEha?=
 =?utf-8?B?a2orblYrM283WWllVTdtMXN5QU1xZG9uUk9CZ3plUkJTSHpMKzJqTjQ0cUdW?=
 =?utf-8?B?VWkvMnFjeG5kalZKeGpZb3FJZzJDZVVtUzBKUzhZb01DZkxhVEsyL3N0MlRx?=
 =?utf-8?B?RnZFd0QzaEgzNVlUV3RJcHh2K05MVGhXckJQb0NoQ0daNHgrSEMxY3IzcU05?=
 =?utf-8?B?NlpTM2FpWXR0ekVnSUJnUXpvZjRlelFSdTgwS3FGU2gwRHBGMW5oaGNUajRx?=
 =?utf-8?B?QWMyR0RmTkxLSHF2L0ptNEN0NzRUeWpBeTdMNWhQN2c4RG1GZkdIOUdUSGZH?=
 =?utf-8?B?VURJdTBHTjYyOFVUTW5qTVh6THhhdDhPZ2hxZTk1UTB2V1M2U0lZQ25JSDdm?=
 =?utf-8?B?eGV3ZWVNRG00UmNjZ2tnZFhoRW1ueWRDZDRDOE9TODM4ZFVjTDBiclRRL1g1?=
 =?utf-8?B?aU0zZjdzSGpyZW41Y0Jaem01elhiRlRNNkc3clNGQjlsZUNtQ2ZTaWtNc3Yx?=
 =?utf-8?B?NXZTNm1rQXpROXNpNmZXUXFLOU14RzU0WHlCNWhnY3djTWcrUytmSkNOUU1l?=
 =?utf-8?B?cW1RWGNod1Z3NDZ1SWNmQnI0VFlqaWpCOU5uSnhJaDZDYlJ4ZHdOVk92VTFl?=
 =?utf-8?B?YTV1TnU4bU8rR0dvWElZVElEZWxrakoxVnZST0N6TzU1TnR4MTZsc2tIek8x?=
 =?utf-8?B?eXV4NXVUTEZrZ3FWL2E0VlZ3WmNHKzZpUGNvbnVhVnlWWFpnanNKTU1JbzdE?=
 =?utf-8?B?NmIvNDkrOUx3emkrc0M2MUJqZ3F4ZEE1dmZWUDdZamNTMDRuN1o2VTJGRW1Y?=
 =?utf-8?B?SHJpSUtRb0JBdEVQVWN1WUpSbEpXOW5mREhqN3VIRWFqVmRKcDkzNytSSlFz?=
 =?utf-8?B?c0p1dVV1ckZmaXdadmFsZXZ5T2Y5dy91ZlJYeTNYZlhQaE9UQTVPR3NtNCtW?=
 =?utf-8?B?eVVUTGtiNHJ6cEZQbnVqOFIrck1sR0tpcGRBYVVLVXBjZ0JFaUxhekFWM1Fz?=
 =?utf-8?B?elYvUlFxTENJR25VM0tCaDVMQXdBdzlDbzlEYXF6Nmk0d1Z4OE9qVVlWeThC?=
 =?utf-8?B?by9mbU03WXdGUUREbTRHY3Rid0ptcDByVHRGS2FoVFVyVC9WMEt5WTFjL0hG?=
 =?utf-8?B?MXFJTS83ekxxZ3Byd3hMdUpoYlZ6MmcvTDZ2MnJqOThlZ0cwVjhPQUxtVDU0?=
 =?utf-8?B?V2kvczBPZkFFVmZWdldqcmxhMytDaFBKU1FDa1FxalJvWkdGRmo3Vmlyc1hT?=
 =?utf-8?B?QnJTUTd6d2M5WW81WXpHSmtXTitzRFNKYTdxcER6OVg2Y0VCRWNnRTRVdWpt?=
 =?utf-8?B?c0h6Qm1Xc1JPdDU0Y25BVTNwckZWckJpNCs2ZjZVRGxvU202Wkl0NmZzZjFm?=
 =?utf-8?B?SDNEMEhESk0yaHRSQnhEajNrbkRCc0RTaG5KTjVsVkpBYlNGd0JtUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wlMgI4e8A2yFcxVUW9n3OfDUGqWU7qe3OlzqYedB4X16jHU1oBYJAMMA1SclUYQZesdWwt1SGqcbTXpMg5vTvMYF0MTcWkSrw3/ZaPrCG+QIMs7MImUb69IJCKqqRQ2/VFrUJW6eZi/5ozY2ZVmWw4E7IYBBxFSWzFKWfxWXl37ahjUH6zOiR2puwLuGPVd9MgFjPeR0pZZeDyYsbVHVttSDR0yRrTxLEC7ZOtZObz2X0chFrf+bF1VgFhymOdivQlCd1MtvPBCYC8CNPMt39+3Bz0rvSOlLuRlS7K9S6xgAxdoGXa0Kxjwn0lj1+aKiYcKGGng+OcmblM/y+YBg/A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9439b911-4548-494a-b187-08df0a155009
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 23:44:36.3123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2hisGKuV6UJIW+ANGNTNO/YUlRbyz4jkBjqq8uMKReUxCYn4RjJjxYcqpSrLUs+S8B1CWarjsCaSxs6JBwArQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1684
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDIwNyBTYWx0ZWRfX0RlUDvnYRzZo
 go0aIZRl9JRRZMYXaPQNniXxMruqNYzOeY7zmZACCp9VeN/YdKYrjHOSOhPzlKi3v83sa36DEgy
 9ULPGznRnhZuB7RoH/hvsx23Xj1nOYlN+CbRvB0prCJf8ZoBOJ+PHKMYk1f9B60E8p6tqTlt9SF
 /dXtpaG8JYIbBHzh6/al46FeI/0qRKj5CJSDj4Q3ErVMFd3aXoFV6xwZoi2YtmfA3P4f9i1VrCw
 0u7RwW1YzQ9rpS6IXZikUfbTGsn2nqX8c4WDQMoHrQqKER4OYb4sSYJXbyh1pRUegjSW4bGlxYM
 RBUKq2vYJ4LvrW8x9hvO049e6A5OPxPL4HcDBmQuYYAKui+JMUF60M5ihTbz64VZqkZYZcpceNZ
 5tByhrhRcbifa91ODX6URYBiRy8eSjGWLHf46IqxI+DqDAnh3GA/p+npvnIG16cVUnCHa1edNOl
 XH90OYuRB1yxKYN6WXA==
X-Proofpoint-GUID: jW2H0aFmD2B2cY2kWZTwe6BKn1UorX9y
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDIwNyBTYWx0ZWRfX+Y+BwnMcOURn
 Gu01ARbVgbpPBOd7IHtpZpPU158eefYUaqO3rnKWdTd5ixV5yj1hyB7yJhRSMs73YvslEjRlBy4
 iyk94NDBOAqg3/6qWObZb/QaTcu5Ev8=
X-Authority-Analysis: v=2.4 cv=S+XpBosP c=1 sm=1 tr=0 ts=6a9a067a cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=g3u0LPWLDYfGfufhFw6-:22
 a=OUXY8nFuAAAA:8 a=3DC0bkzbA5w0sGD52AoA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: TreIyzyBvsLo66pzhAVIpEowmf42cnbt
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030207

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpVc2Ugc3lzZnNfZW1p
dCgpIGluc3RlYWQgb2Ygc3ByaW50ZigpIGluIHRoZSBzeXNmcyBzaG93IGNhbGxiYWNrLCBhcwpy
ZWNvbW1lbmRlZCBmb3Igc3lzZnMgb3V0cHV0LiAgTm8gZnVuY3Rpb25hbCBjaGFuZ2UuCgpTaWdu
ZWQtb2ZmLWJ5OiBTYW5tYW4gUHJhZGhhbiA8cHNhbm1hbkBqdW5pcGVyLm5ldD4KLS0tCiBkcml2
ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LXBjYTk1NHguYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL211
eGVzL2kyYy1tdXgtcGNhOTU0eC5jIGIvZHJpdmVycy9pMmMvbXV4ZXMvaTJjLW11eC1wY2E5NTR4
LmMKaW5kZXggM2RhNTRkNWYzMzAwOC4uYjUyZTA0NjRiNDBlZSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9pMmMvbXV4ZXMvaTJjLW11eC1wY2E5NTR4LmMKKysrIGIvZHJpdmVycy9pMmMvbXV4ZXMvaTJj
LW11eC1wY2E5NTR4LmMKQEAgLTM2NSw3ICszNjUsNyBAQCBzdGF0aWMgc3NpemVfdCBpZGxlX3N0
YXRlX3Nob3coc3RydWN0IGRldmljZSAqZGV2LAogCXN0cnVjdCBpMmNfbXV4X2NvcmUgKm11eGMg
PSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKIAlzdHJ1Y3QgcGNhOTU0eCAqZGF0YSA9IGky
Y19tdXhfcHJpdihtdXhjKTsKIAotCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCBSRUFEX09O
Q0UoZGF0YS0+aWRsZV9zdGF0ZSkpOworCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVkXG4iLCBS
RUFEX09OQ0UoZGF0YS0+aWRsZV9zdGF0ZSkpOwogfQogCiBzdGF0aWMgc3NpemVfdCBpZGxlX3N0
YXRlX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwKLS0gCjIuMzQuMQoK
