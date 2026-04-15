Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6413BD64D;
	Wed, 15 Apr 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272392; cv=fail; b=KwWyBuXeGpGvuo5H1C1wWcRH62XNtTKlZ9ukTsqpQI7nH3Kog0QDLPhVsLWTKkx5X+P9oRG3ANhWDpp+fyPnRd7aouTiTHPfaAXr363gTCBHqXJW6KhbGhXhvc9A6wrFvBE3dbdF4REGokLmfD+hN9HZPwqbAkVm7wmr6ihBwME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272392; c=relaxed/simple;
	bh=qPDVSAeZqANhbVeTa8ykmuBeTTD8EuB3wtFxFFm44Uc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZbXo3T50Rl3Uxvvutwxnlo6xKvdPCXJuJpB5wBTjOaM0vpcNHxo+nlLEkcKGyvsAzBbTAqbmCj1aRjQAPHRGTXQGfQEN5n/d78cJXALfnvZnJJYf5qGP0PAH/2uc9C5riQQ4DdoCyB9o++ywbC9FD63i1nCmRjJzAXzWPnHaFr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ZvBqnP9o; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ZvBqnP9o"
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FE3DNI1424589;
	Wed, 15 Apr 2026 16:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=aSSxgOJL5gu62RNUrvpk03ML
	j/2Fs7PtCGp09Zs43cU=; b=ZvBqnP9o8/RGXc06baqmH92e5Zb9nkuumDlkB4nK
	pHAcU1jPMJaRS9N4ltMddb6Qs1q1Ula9SP9TKz8ThWR+X00k+aTuiqdRPlok7/Ta
	ZEWa+cspa8vVBtObS4ncvn86C3guRl/tuqQopPuZj1BhiF74nw8NOSFbXKfqixMW
	l6JDIaCZTxCsuHArgJmJX/jiEK2/ujbfd24mc3VkGFTjBi41KDODcdpptCMRNB33
	FqdNm0HpIRlJya2vLaWClsDpEQdEmJRWYoCdSFQn+/O72M6IhLtaX7syMaUD03pg
	DgQ/AlqW7wtna4lbjipF+3hVKyzfFoE/E2Mxpvs7SDjKkA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dj89ddbxy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 16:59:44 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id ABF4680171D;
	Wed, 15 Apr 2026 16:59:43 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 04:58:57 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 15 Apr 2026 04:58:57 -1200
Received: from BL0PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 04:58:56 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTqY2KejZMkhY7GJijmPTUlmBcyu52z59CaPo/Zjl9oYh/dh+MOGxbHVtcZKK2Si7Qwt2D2JrXfH9ApOeDL+k0hla7lAsSIBYLuNzE9q/jRCZXaVLn7Y7lZIOLf+by6A98nM95uyXOpraTyU1Fb38BzU7UCiZA6svAIbDmEY+i9PufOi+8RhFVW3Uy7NwlJiuGR9+wu0qR3ouXWge0U/zuUOx/6l16c3O/gbUQOpww3XHlTv9YHCtsWd5UToGMZXxml+sB3JC8sd3LgA65CkMZn6d3fW7vWx46sAyDIWBG2pvZ8Iq7E7bReAf9defR646ffpvheVl5iQ9bxzgh++Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSSxgOJL5gu62RNUrvpk03MLj/2Fs7PtCGp09Zs43cU=;
 b=R/tj+kB/S6q0ebSsK64XMCI2gE8Nd3Ei/WXhJ/XLt3knlM7QGIFuANlL2glVKQ8Qv6w7lgE0nub8/ytdAq9lbw3b2hov9DV3c/NshLJ+ozKHGjYAse5uqzhiDc7+FNkGJD1NBZMWm2dlRV0ef5fQWL+B2bvkm6CdpnW13HWulp1ktJ5E8cVyE/KApfipD5a2jWLC2l0enw4bnmUktQyUwA2K6Bu+lXjfVV3hKdGugYEnoBbqQgSvrjXaNhETOElnFf7WIvctCspS+6CWWK8CY6u8sq6l2WK5iv3gVsfO5swffa/6BwpmPrr+GyqkmyPnleRDqPLVwz78Az+2BdlHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by EA2PR84MB3809.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 16:58:54 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 16:58:54 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Peter Rosin <peda@axentia.se>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>
Subject: [PATCH 0/4] i2c: muxes: pca954x: bug fixes and cleanups
Thread-Topic: [PATCH 0/4] i2c: muxes: pca954x: bug fixes and cleanups
Thread-Index: AQHczPkkEjYtjOazvUa1I4CDVPXIVA==
Date: Wed, 15 Apr 2026 16:58:54 +0000
Message-ID: <20260415165846.43926-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|EA2PR84MB3809:EE_
x-ms-office365-filtering-correlation-id: 6f425104-014c-4f8c-267f-08de9b1046eb
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: UwdeCsoR6/TPSD10HxNlXF4opcRJsSV3enKGP5KSTDhCYA0IOXcFu6DyBhkFvgnE54iieNAdR8VhmF5cYe0+yDTDCuc6gcyc1WC2kjltEB/Lnj9mF4Rgy491Yk0UVms9rKujjoy5FjEBWTF7ohkaMrWdu3Agds8Yed4tLzaMsM7rjL1esJcUuQbvl4cY/Ya/NOXBZhwdQdL1DFizUyXFKCpslvVkT/isNvFQ0/O397BIE58nbJlrNUIqwAkeDBAaJfbVEaW8prUDIsaSOweZscGcQS8DRYovEPQtb5zhnASvlo0TbDsUyqwi4r8MDDogkExWy6/8XiwsJDQYLLnXb/EuDDs0aqIn7ms0trSU7v72nt5YNWFg0BPgxPTzt+p/Od4u6LpUiOp6i1YHAKqNs/+Z4WAW+bfQzAAqVBMGOXwDkp+2AmK3yCtSEK2gY9LXRnv5D/DGJ7Lyk3PGRRqCH1pwPu5s4X3tfB2jinob50xk7D3/F8lbgIXQ70/8Z8lYo9oymw4HmIZ40bQ8EnpYWG2H/L8y5fDujSjRJcdQzjjCpKUhjhNcGhAVikaQq8v0QeYErgyZkbvr1+BsZSSq9zu14OCx3wYdv68ruBOJfIVSMjDeq54/nl1ZiH9KED7MdTjiv1WSfctHO1cIqNfXH8ADObpUljnxJTuwlrzF5pyF6Yl/KKL0BvTKMo5EZlyug2BhS1Ol4i/ND/+XOf7+OlOqo2TA3Rlc3A3fcAILCbzq38PL73Qup1k7KpCSlS09kiTfjcGBZED1itSEpdeDGUJsm7jdcbYeWjbsQS+KgVY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CxbH4Sc2d7u8daiR8KyacPND+dArnhiIg50MXub2JB9g/zibjNLDeO9Ebd?=
 =?iso-8859-1?Q?t5RaFGrMF0iV+KFJAXaWU6uc1zIj5kNwrHDnjWVVSHW7/Im1cWji0Js7c7?=
 =?iso-8859-1?Q?0z6UBE0JDoy39QGIOUA4GEM8rbIy3ESHDaAlBHkQSgeNBzc4jEm/GO2r2b?=
 =?iso-8859-1?Q?/j0d7WJR1TI8iy7YjXucVEk/MyjmdOO+Npy89pphsIeSFZd6pWr9x4AIaL?=
 =?iso-8859-1?Q?jMXrMtLMSUqx6NvCx7/j1uZ/6lxLW7pmeNT/3Pv8/8liqkWlQkqZxf7HLh?=
 =?iso-8859-1?Q?2LNPyd+LTLdjL4uMV7lYLfqGOQqtZ1dfNM1R7+dBtEgZTtpXEmQ/GLLBKU?=
 =?iso-8859-1?Q?NtyJSx2hU2dg1F0veAXa62xvH6BYPTlOnYckeHv7zfmDLbQ724wb856s7b?=
 =?iso-8859-1?Q?2lhr83J/WEP8TJhHDZMAQXyyDnxBkAU3HopfN2NkEi+ygf+nUAz+GZw6Le?=
 =?iso-8859-1?Q?yhlVC/vowCAPZm3343/09CEO9jEqbjilAX6AByFq56RjaJZhz01doWsFmY?=
 =?iso-8859-1?Q?7xAIKz65SfXGmm1n68ewPWSHMHN340uO/54OrOFBppOIBiFRmcde0iXgLt?=
 =?iso-8859-1?Q?Ok1OXOsOe95xQQzf8Xek4cg46TFBILNCf8uz6IQbU/fxjcSmGygipu57Cu?=
 =?iso-8859-1?Q?O7U/HQMGXR4Eriv2CA6q3DAC2MaDS5TfrwTtXFthPfymjQsYEp8FnIu7kl?=
 =?iso-8859-1?Q?1wZmgWUK0dqPbOsEgHv5IBrc2Va6xeBtbddNlg2W7ngpovlyGqM9Pd0K/e?=
 =?iso-8859-1?Q?neAHF7zzJ90ngsHEPoeSYX8sqR89rosTP6M4UMmnP+RqsN4L2DwaWxD/mR?=
 =?iso-8859-1?Q?SdlNxc4eu3h8JQLf6KItz6LDhu+kCzz6sZICbsSC+jQvoWaBWaI6P7OXcS?=
 =?iso-8859-1?Q?JmOB/N/mwnf9KIbByvM3ax2UTgYy5nAEcEE7neWWLyZjmDkFF5xVUZfA+Y?=
 =?iso-8859-1?Q?O7zYv6FvNB6j9oH4KvcXvwaX2jwBc4JNlT26Av7XSawLKu0fXf/hbI4uht?=
 =?iso-8859-1?Q?Ue1kEe/8y3ZkdcvoZ/xB5j4UzTT3EjWIUmGUS021vqN5egzol0mIzFVUbi?=
 =?iso-8859-1?Q?Q2mz49jk7q4V0HM+BCyS6KoH/SD235Na+QTPNxmJTywdxzlTI3P9TpZ0fp?=
 =?iso-8859-1?Q?z3RPKTrn5rBtzxOK2ND5V/6OG6RyDzLnjwodsYIIfTr7U3PFjU9HUrmSeA?=
 =?iso-8859-1?Q?yCj+TNZq1qm5+D4gNNvC4vwC3Y3F4rJ2KYPOLKoJlkAgvrVvEZMRoZDRop?=
 =?iso-8859-1?Q?S0pQRW1Nx1MsZEPxKr9dd5oeUDMzeg+FSzfsd5MeukZWwI8m9hbm+8kRaC?=
 =?iso-8859-1?Q?3n1ZRBJQj/ywvxt4+k0zppzR/f6qfAaIwScyTfgHLDHNItRkY9J6h6QDoD?=
 =?iso-8859-1?Q?5RpAfZueOjhBhxw/7po4R8FXdZwGwDrfebZRBoTcPAHxjKxqhGde+AsGen?=
 =?iso-8859-1?Q?fgV0T8DP2BZoAOkE2+XhEnH9YBkrj/A/jYjsPh4P2VXRE6fU1Zz7B53m2E?=
 =?iso-8859-1?Q?pDXG16la5HjtGeqjqTtLD2R+iTRRGNSa4QJSIAzy85NJlztCZz4IqEXhL+?=
 =?iso-8859-1?Q?JJoIItZ+kT5k8Dt3ooumw2yMevswvEKljnnFl/CGulPVRdPJNR99SQerpr?=
 =?iso-8859-1?Q?r/XDcJFqUSMROTDT9WVqwZDnXoU3dI3Q2AHPMj6wiWXRTQj0HmXIIudTr5?=
 =?iso-8859-1?Q?um2HmxHhuwDHboWJ2GLPL19UAmsMVnrGezQBS3Il+0auF+5zzOXAFPAKEX?=
 =?iso-8859-1?Q?spWbJAD3J5QR+dyMBYT+RRaArfY4S/+Sg6sA8zajCSaYLMXnF/IViwjOAA?=
 =?iso-8859-1?Q?FGs4CgQKVQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mlzDgWfa3tlztYrwZl93klIdgVgl50hFKkrAH7LH7RYDPzSgAObOZUvLHOcectvkMqZLA5qThkx1wsG32VOucy0gtaabkrdLD9w4w0mQE6iG3hq2lMZAIksKa4Oek1xK0jajKgcoygApD1tlp3uqzLp3NbW1AAogujzCHmhpuzg4WSz7RUt1WebUxWI8G+DwGzb9GtdPNfuRu4p94ZsuWy/lnderhn689sRf7LMphjxzlY2t7qrk+dMxeZx6L4q4AKx2U7+vWRvk3ACBJcMTkIdgvMMMy57t2Tx61wiF56U8E2gOAweokO+KLRdD+ZlTiHPzZk9Ql4aPyjy4bfyzoQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f425104-014c-4f8c-267f-08de9b1046eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 16:58:54.4132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqEiyqnUPcvV8OHPzKImhNdfgDxQsF82ul36owZ2Y5qi4Nnlc7kJ1v0FI7hn90oRAmpo2BHy6mqfEBDAMRgGag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR84MB3809
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: hF9oYO14UiuCaQbbH7mmWOnnyBjBT9PB
X-Proofpoint-ORIG-GUID: hF9oYO14UiuCaQbbH7mmWOnnyBjBT9PB
X-Authority-Analysis: v=2.4 cv=GaonWwXL c=1 sm=1 tr=0 ts=69dfc400 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=g3u0LPWLDYfGfufhFw6-:22
 a=OUXY8nFuAAAA:8 a=qJzJes-MKhheoe2nl-IA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE1OCBTYWx0ZWRfX1NVkk8js8ZmH
 3arR3oMciUZk5LR1OMm7xNi9Gu2rG7T1+rhaohtSaGb0d32shdSV8PYTTGI8tTUJu50sVA09CK/
 XDXOG1oLTXBZXLS5ZNy9+Ng9fS1fQnBi0lyZmj5Ogb9XAJ0geaYuibHjVWBWENjnVhk7SyAdX32
 zD8bnltyrm8pSpCDOHojB9j4zj6UahK+FXcHtfETZgGWvv4xzdUDw9fTwob4U1qYKF3B9sdfc9L
 G15cPphjkAvP2gdTE0d/hCiyv+Lb3Rmmo0t9sBkVmvOOyTxJpTFXUVHb6UpTKkXiinC+6/mNRDs
 Pi3DFy2Q6SXAg8CbBEkMroemXwBQdTVg9koiCZ7g64nVypqQtT/avo1O1/A6jTkJ/Geyny2t8ox
 GKoiluLdCSKjZhJMJPxl+psi3mtRaL4PeiKPcQyv8gHy2CDQ1kOEkudiRBq35h2iCwGyTN9SHxv
 RkT2XWWX6JMgOeJXF4A==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150158

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
This series addresses two bug fixes and two cleanups in the pca954x=0A=
I2C mux driver.=0A=
=0A=
Patches 1-2 fix resource lifecycle issues in pca954x_cleanup():=0A=
=0A=
 - Patch 1 reorders cleanup so that child adapters are removed before=0A=
   the regulator is disabled, ensuring children are torn down while=0A=
   the device is still powered.=0A=
=0A=
 - Patch 2 quiesces the parent IRQ via devm_free_irq() before removing=0A=
   child adapters and tearing down the IRQ domain.  The threaded handler=0A=
   dispatches nested child IRQs over the mux, so it must be stopped=0A=
   before either child adapters or the IRQ domain are dismantled.=0A=
   Because pca954x_cleanup() is also used as the probe error-unwind=0A=
   path and the IRQ domain is created before the parent IRQ is=0A=
   requested, a flag guards the devm_free_irq() call so it is only=0A=
   issued when the managed IRQ was actually registered.=0A=
=0A=
Patches 3-4 are straightforward cleanups:=0A=
=0A=
 - Patch 3 replaces sprintf() with sysfs_emit() in idle_state_show().=0A=
 - Patch 4 marks pca954x_irq_chip as const with IRQCHIP_IMMUTABLE.=0A=
=0A=
Sanman Pradhan (4):=0A=
  i2c: muxes: pca954x: fix cleanup ordering in pca954x_cleanup()=0A=
  i2c: muxes: pca954x: free parent IRQ before dismantling IRQ domain=0A=
  i2c: muxes: pca954x: use sysfs_emit() in idle_state_show()=0A=
  i2c: muxes: pca954x: mark irq_chip as immutable=0A=
=0A=
 drivers/i2c/muxes/i2c-mux-pca954x.c | 18 ++++++++++++++----=0A=
 1 file changed, 14 insertions(+), 4 deletions(-)=0A=
=0A=
-- =0A=
2.34.1=0A=
=0A=
