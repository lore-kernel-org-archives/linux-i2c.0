Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C63E51EE;
	Wed, 15 Apr 2026 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272375; cv=fail; b=nARXmapN3QyN+C7xM6UQ9znae0ThoEeyuSkIVJjw3DGv8Adih+vrc3vdpZui1wuY8kRSS7Y9F2Aq43q408bVytZL0rIXKJPqKsKVohF7DmfaSOhvUXfzXpsV63YA0cnKkBjn2aMijd/avcgcPxj5DBPV/AvZhXV4K+o5leD/zCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272375; c=relaxed/simple;
	bh=NX/wWtHkCVMhYQJN3CjqQFMGHqwyrLCbt3dT75S5GuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ME1aaErCQri08Fneja/VTXbhA8XzrqjVp7/q5Fhc1v7PePQR13NJrBghq86NTIj3a43gix4+DctQtRD61IPSqtW8fLDoBWO59QnaztYCUq7NcmB3/Y6PhffJaFCTywXyh3c3Oohkn2IbKB4+bwZ+ro1ufRlIV9KFbC00WC2U9gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=i7aZ6ih3; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="i7aZ6ih3"
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FEsRgh312764;
	Wed, 15 Apr 2026 16:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=BB
	b4QEHN2ed6nx2kWLtYlu3QLpkBcHey4q7Rf8iZj2s=; b=i7aZ6ih320NGciV86I
	IL24QxVU8rAP1sbayy2cNc6tVP6u/7c/ACUjo8RSUsFZdRNvDmDhoE2nFyYjldw+
	dV2PiJvtQQxyjLVYZcyMThV3FFQDujk36u5qsHgC0YdP0kPZc1F4irdiJSBaxXx/
	Q+tx3NzsxJ88MIxusbwM+hBRki5lF0o/jw5M58A98bNk/bctgQRDCKZlhePMlvPu
	vUm9uIMy9JXlJnBDQuLL9nm6ey0gOmGuyGmpPoudatshRldaZSjyE3lq4gUhr/e2
	eZab2Zn8Tzvvkdsrle2ZBpbpwEtQf0Hh7DAYtWLboEzFKliYIPkhtzoNV6FqWkQu
	8IIg==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dj81kngmp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 16:59:29 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id BC5AE89D;
	Wed, 15 Apr 2026 16:59:28 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 04:59:15 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 04:59:14 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 15 Apr 2026 04:59:14 -1200
Received: from DM2PR04CU003.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 04:59:11 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCXviXVZJPgJOWKDAlzdXxqCGZAV6id1DIuKcg5DNCD3/XrdVDO1oIX9IvMS16SfhcQ3xrcxqntEr5+fMgSK/N+u8worFG3+/5JxXQ4zxQu3EPj28UpZE4JN7O2HkBZ3cYBvf2s41i1RgdzsTk0dRnuWY1AsPddsIenETca/F2WTLz90vBnrBZvSKLrJGZ7xkvBJM4rAEdPzaEoSXI8rUjH+79GAJFSQ+9HFnTZV56yzJClNRtD/5SjXOowpfsZihBJpj8wAl/sZWmgiYyagiMSOVEDQPJWrKoBgWSY9ppKmDLJhR+iq55U+sgcmA5LeTo2TUQ0VKxEp3ZXHyeS2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBb4QEHN2ed6nx2kWLtYlu3QLpkBcHey4q7Rf8iZj2s=;
 b=gPvn6Gn8P2aHXTkzCRDZqAChhWg5P8jmxc/9FevnMcxrvETDU6EpVDFz572kbZA2cLeAoCQqgPQp000J6WgcGq1h9pg6+nS4AlsqB3rD+hQIYbBGRhBYggmVbQgG2XgKG2ipvG6mYxhX/VkwLlIw1VKPmA9BhQIR4SMFaEEO9KBD4JpTmwki6HS+w8DYpFffZUZYMBa6/q//zMR5BYD8EqhU6+EIPoDi4WIbxUgrpzdorpFceKak4H98jQQwvNXMga/xWuAnFBaWbXMr1kxDtMwJsRWQbHoPqiNEH/JLOCYiYdopF1w8kbyoqQ0BVM577Qvx7ywtcKcwwuHq7HPW7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by CYXPR84MB3514.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 16:59:09 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 16:59:09 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Peter Rosin <peda@axentia.se>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>
Subject: [PATCH 3/4] i2c: muxes: pca954x: use sysfs_emit() in
 idle_state_show()
Thread-Topic: [PATCH 3/4] i2c: muxes: pca954x: use sysfs_emit() in
 idle_state_show()
Thread-Index: AQHczPktXnfom6K35EWibd1cDn+Qag==
Date: Wed, 15 Apr 2026 16:59:08 +0000
Message-ID: <20260415165846.43926-4-sanman.pradhan@hpe.com>
References: <20260415165846.43926-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260415165846.43926-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|CYXPR84MB3514:EE_
x-ms-office365-filtering-correlation-id: f9a77603-ccb5-40f3-a734-08de9b104f94
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: ZAR/HE/NubCGTvJeGQzmpJyXXYHeHehy4CWVcx0ptj9ZoxoWfA57kKmeA4DQyy95G9S2iBJM0RoZwUNWtvknDQPhpfG234A370pWqaleonxgdk8GYW2eelaqOrOxraT12rfIPmf2wUu/HDHVYSJh5ktqg28+Kv8tiZwnsPrEmIfg4gQ1C8VqRN5/rpHcFA0lEKxzUOPeCdx6d0oNHVghgvY0KxG04g4BkHHxO3+DfcUpsQmxruBjbzXf/3fWsNnpdrKImBr+9GbB3YQ8ljsV8NMlSkqmagyfWTKE1zUhafPohJx1YIc0vABFx44N7q/HWY8ZXJUvfY1NvwA/RYe8X5sOvtEBxkLQNU3zq9SrdY92JOW8z+kwxhXAsYTsun/+IxiTTD24YnIzRoUcXcZWp9FBsfCC6nCXPqs/QbQa91IjdfBy/z4RGr+ZgtcVXJNAfPNLOZLz81tDcfJeclLC2adEZaXAEd6dYv4/XOx6YnY3jzD0VlzefNcSHmsA2FKqwCSvER+nbp4BL09sfy/NGvlGY9NXoraw7w2EKTvLd3AbRaxgwzZOGG7z47JOR/W/towLNnXFyDU7X7+sQH1dvNaIN4qAYTbdavOloqIrWo/Etb4DrxYbjTF/NPjsGk3AYltX9zq59ig/gNJSR9xV288MqQM59eTmFNoE52k59iSIIe/MGjlXAhnubBGb3gNSBsG836VdE/Orv4vfwVChoZBkgqjk1gq/SA5W5raR7sG/VBroAQN9Q5XsV33Mq38VgAXKgO7Q+5QK5BOLOwxAG4Y0a/UofN4fP6IYAVAOYdg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VBYrJmt9XnXfy/AyUiupFUVjTsArWeNkm+EVoa+KRcTL0lfi16svFdpA2p?=
 =?iso-8859-1?Q?ujYhwpaQ8U8ns5kU68mxbV3ZPP+BHjflBw00AwB/QIeojqTj/RlqfE2lXs?=
 =?iso-8859-1?Q?EV6JDkFDlGZnTgJFpMties9ULCtmfCqsbhZdJ7EBJtJkKONtzV7ymY39iB?=
 =?iso-8859-1?Q?c0X1p8jHbame3IJvh6G//i8HxGJrSyopXd+g/VaxKeHDy3aMB/ZpuodzH1?=
 =?iso-8859-1?Q?5wdTYiwAuKM7Hj0Tbcrxjtx5IoI3yPGjU+4SWn0+xB2nRoQlPAO/BiEIIG?=
 =?iso-8859-1?Q?3h2h3R3kl36l9NsH41ubNwq5rLkMfAkLmwDY5CCX7k6DqRU367rnwbIj6p?=
 =?iso-8859-1?Q?/1Kjt9GHBAVbQPyTADhatxaH8bQjo2KnyMsAuL3kYyA8zugwWO1ffT5VLF?=
 =?iso-8859-1?Q?GSi3dsKck4LkzCUodkObpC098ENnfCZU0cfcCSxvL7UWeOVAYAP3btxbmb?=
 =?iso-8859-1?Q?XWbYv2UL+hN+xFF8fHP57npokbFSQbIW+svYDQ6LRbsfTD7iXdvDHyrvwe?=
 =?iso-8859-1?Q?ziBNS4tpWFJM82i7DFSYlqAWLVTA4C8C/pQgAa42wBIFAf2goF0L6EKNDE?=
 =?iso-8859-1?Q?acx//i0VkMVeSf9xfr/I3VLtZEVGPuGSMrOsQxGjwdQQG0WOoTMXQMLQy1?=
 =?iso-8859-1?Q?S1ThIFmTbIDvYYpTQzRqrMK30Xm1Rt6eHE6Tf9F4Y0yVv3gxkYg3sCHY7b?=
 =?iso-8859-1?Q?OC8vpV/u/gAv1FZeSCLR0uxAI1jVIOD4iyDu/MLdR2mVUm5rGNlH9q3mqQ?=
 =?iso-8859-1?Q?qhRLPFdjLL8MkFeImWDZXUpB4iMdTsUkAt7rCNjLFpx+ve37DpRA602+LM?=
 =?iso-8859-1?Q?kk50HYz+tRfQrB5t1YvycfOVk4iCU057IGL0+Ff9U3yOX26IYdOuLR1guj?=
 =?iso-8859-1?Q?3GnYQ9r++2uacSryLU3Q7jCGqKE7s36SWpI5VEanBXXYtuNMTuWmdNf6Fj?=
 =?iso-8859-1?Q?JIhhxRJvXpWovW4dwmtkWotr/y7rMZyLw7FeCICV2BjsTh4f5crV4bWO0T?=
 =?iso-8859-1?Q?ZlV3C7JnMzJLqGt0qC1EtRGKUmayzyk2HUXcL+vkjz2Im5XpSEpKWpPXD7?=
 =?iso-8859-1?Q?J6AFuddWVAtPBrjWC8HB1t/L2TU8Efx2ihcUpD3bwOoErsPOKmxOkVeX+b?=
 =?iso-8859-1?Q?QsFFE46Tq4gkj37AsHqB0OfgLIyDiYiHQReMLbi3bNrMKvFAde/97tYXQY?=
 =?iso-8859-1?Q?h1s7DMDTXRLvCaN6uHYRBSxA0Whh00schjG8Ah4roZ2d0Y6rt0eNLc3Xr1?=
 =?iso-8859-1?Q?sBTUFM81s3vRbAm/3/OHpcR0z/7KkPUaTR3mha+4sO+zxrYGqi9cD6J1ss?=
 =?iso-8859-1?Q?Wn/a5B0O2JiBl3gFdsmR+HKLowcSsHN/czmJFityGAE9RGMs1GfmqafCsh?=
 =?iso-8859-1?Q?gbahtnZkkgPziTliqaJkr1hElVG8K3Y2Mr8FZfGS1cDJ3SK37cGRp4juYb?=
 =?iso-8859-1?Q?ISde6octhAfxiB6VJxY8L8PUDeZWCHVbYUN8ONQxo9CPFEiSBSMzzK7AaI?=
 =?iso-8859-1?Q?KPUwOAxLHTuo7esjwgcDEL3hkEC4d+o+IrKtPULVW+hAKSSdQyFIuo0OFN?=
 =?iso-8859-1?Q?noYl16H1xlaesEAJ3fZSMo3k2oVyfFWoDrWBhazF9OjJFwkYbbNUdfeN60?=
 =?iso-8859-1?Q?KjlXi7/jX38r+NNM9ztMwt2ziAsS9hDeDD3a4GNbhPQP8NyYzDFZXzo36m?=
 =?iso-8859-1?Q?nGq7JuTwChJ50KphBaPWiSnFMQptZd3b9Xl61DHFDFS0gyvj1YrpHPEJQG?=
 =?iso-8859-1?Q?vtCWbWTQl2YINHS0TG5Qm0Oi5tpBRqcRb/AL2dfhYWLKhkGjhMpcfOCdng?=
 =?iso-8859-1?Q?4oiwusLRxQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OWuFJ3WikJ/R9lldxvXbflKEsa8mrz0nv67dKtuIr9dLrDFBjVdpEegPo7xcjA1+I8QmICB1RgS8DvjBlITKSegcVZwAKHsJ37EQdZp/NXjkXfXXvQ269bHRqlGeNT81T0CXt3BiBYim8lh5APg1CSfauMvQQF4HK4p427NzfZF5xWHT240vKs0O9x4b7hyLALTIwSkxsRmDFpzegrWUT1vPOLwaAhj7l2t+7ySEb8AlIvd2riVkfaU07Ku1EqFSSY5+loVCvmOM1k+vmmEU8qXMAPpXpBzAllB5zZhGi0hdQ7LE4niZ92p+dmRb2v/wNMdywfxv4O6966Vu8jXKEw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a77603-ccb5-40f3-a734-08de9b104f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 16:59:08.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+19SUwTXR4G6TFUmJLplaAFYFlSiiWHSVZ0ATJ/WfMAwwzvLN88tM/Yd7dlXou3BK3Rb44oPRQTzX3rP3GQyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR84MB3514
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: h4evFKtjHn_VJcUr61ZW3sZpz4s8MA5f
X-Authority-Analysis: v=2.4 cv=aJvAb79m c=1 sm=1 tr=0 ts=69dfc3f1 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=3haJ9R1Aw3gUfsUHDaCR:22
 a=OUXY8nFuAAAA:8 a=VocBZZsKFtyUyQcdQl0A:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: h4evFKtjHn_VJcUr61ZW3sZpz4s8MA5f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE1OCBTYWx0ZWRfX5imhmvGq0EvG
 KO5rT1kcVbZNnHzE3TXsLMPMDfXFbgLruH+Xze7LwZYY6sMoNRrwOzZg1rxKDoamvLWUEGW+Dr5
 F+rdag2n289uMzxehjmSO6VqpqlaCR0/wBIj/cnVairUWxqfIThDK9gi9ie8w8R9hy0rynFkigk
 wV6XiNjK6NiIPY2bum/Z3Gue0IZYeEx98BRewsECVtxhano1nSCFsOscwk8N1rU5aoMViZgqNuV
 6tpvXaEUC6pEIsUxzifyt28HxBPHvV29ds/tJI2irZvBYyOt+xRu1qSIXnDQwG+b1+uqWGYaIOs
 Z/Qjl8JKJA93cMdDe+Q9CLAuU40NjvjWw5dvKjz26Q5DY9FkR8Ir4F5Td16ka21iaSIe/D/G12a
 gFN/0u3hsrdkQXoL7J3UhCq4qNTiKFxuvS01WsixJho8Or+Bbxuq234B+8vlBHF0dwGamxldNmR
 Z0JhRx7gTRT3dh90S6A==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150158

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
Use sysfs_emit() as recommended for sysfs show callbacks.=0A=
=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/i2c/muxes/i2c-mux-pca954x.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mu=
x-pca954x.c=0A=
index c20a161e6a5b..4803231e4c4b 100644=0A=
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c=0A=
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c=0A=
@@ -365,7 +365,7 @@ static ssize_t idle_state_show(struct device *dev,=0A=
 	struct i2c_mux_core *muxc =3D i2c_get_clientdata(client);=0A=
 	struct pca954x *data =3D i2c_mux_priv(muxc);=0A=
 =0A=
-	return sprintf(buf, "%d\n", READ_ONCE(data->idle_state));=0A=
+	return sysfs_emit(buf, "%d\n", READ_ONCE(data->idle_state));=0A=
 }=0A=
 =0A=
 static ssize_t idle_state_store(struct device *dev,=0A=
-- =0A=
2.34.1=0A=
=0A=
