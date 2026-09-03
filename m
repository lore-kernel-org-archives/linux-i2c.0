Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B83382F4;
	Thu,  3 Sep 2026 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479100; cv=fail; b=n7iLotiM3iDPF8CTk9IK7JJDi1Lk+zg3npFT+50/u4aL0pDivHd1d8rytU7iYldOBjTqM8pTwVGOu9bEDDIdx+2djmiIZAskrZ+Ej1Hl04ZHMjLilK+04TQvvxE14s9V9ucYyZ7KVll/IHByQ82t7Rglp+/zdAXtVlK2zpqEfeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479100; c=relaxed/simple;
	bh=0599nDU9sM3EKTvhgE1zHrOWCWDN8kbvi037tfQTtEE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u2mywrD2gqFJLcOJV4CkEwKCQMqkbYn5ipNdn58D0UZSOf7iKz7fEyLAoLIMGERzCd4rdqImXt8x5bH5OTORcoPjUTTX9U4qLWoDP00T6rAHP2gEUadS6bZ0Rb5jnffvRaonNdromhJqd5XUAc4Tk+ybZMiecaJXuZ79UkRl410=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=We66r9fP; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="We66r9fP"
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683NgPND3837692;
	Thu, 3 Sep 2026 23:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=0599nDU9sM3EKTvhgE1zHrOW
	CWDN8kbvi037tfQTtEE=; b=We66r9fPovIVGBeNihgRhoKsXRhAjZ+eIwl7elXE
	f8JvGdl6pmiH11lo0Svg5ZJKIKsUlgWc4G4S9qxrzYURWqf/okXVEVDAVMjIcDPW
	kG+mj5m0ktZQPniLsceQ3sLJGMrD89zyyeRKBl7uTAIMnBszhANLwV2Mm6SdO6SA
	TRICLT0xPn2XvGLWSZA9tHFwU8OUUGj9TfzkubzSGjsDUD5i2DAUnbngcHwdymEN
	KluxRN2fszeWCVPPQV95pFafHBRTABUL/slns4uh3l9dmdFWY4jmFm17AShKGJos
	sQG4taRrfIKxkv82WWAiUoJ15nPrPp+zQeu9I8+rtYEwIw==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4gfe6vkr32-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:44:38 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 04AE7806B21;
	Thu,  3 Sep 2026 23:44:38 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 11:44:31 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 3 Sep 2026 11:44:25 -1200
Received: from CH4PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 3 Sep
 2026 11:44:25 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHXHAlMRmEPRw9ZITBvbWMmm/jMgmXcodJ6uBiD345UrgR5mdhRCWi0iHsH1KD4fsEde45kA58LQUErMVkjcsoVqcvcCR/oAWvutGsyBGaIRuoQKvg+SyFChB6qSGVfA1ht5Ytv+skEyJWckWn3VHJ0RH/XGl8D2G2adjrhZzN+WcIdvV6gvL7KutEbtjSbMngks4XAIxRTtRd/YpSkiyoJjjACI8hxuavjHqqbfeNTfawa7jSWjgPvWP23ldO8phosgtl06OC1Cv9whWEgOwvnTotBTuMFKuDmDmqfqXaMwXNXCNaxIRTmhPILoL6FFm8DJg2RT5Q9OApeqG7RXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0599nDU9sM3EKTvhgE1zHrOWCWDN8kbvi037tfQTtEE=;
 b=T+Oh+xFoK/eqCdItoYkaXvyVXexqG0MB61N5bJ5LByFtDokNXx6mvOB9WzEeZYcAmGxR4v367nrbrjXMZAsUTX1Nu83sPueJ/o1u/hnhohueQQaLF9YGj9/42qQhmW7/4UcuvpglRQVoLPmkmid3Fwk9yH2Wnzo1ke1W00IQett05ckAVpMTFL3RPa9aQNozdFX5V1AIOU1r/Pbm0vNFDEd5z8ry8Xs+H9MFte6T0anDtyhai4Ly1vuDlueLpXxyMK3J1FXbBeUl8Yc4wqs2u5BCM3uhvQI/K8PFm0Jpt5UstUsDdkD8w1NnRLOuo03QiJaAVmJzxAtDGgDzSxQGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB1684.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 23:44:20 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 23:44:20 +0000
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
Subject: [PATCH v2 0/4] i2c: muxes: pca954x: bug fixes and cleanups
Thread-Topic: [PATCH v2 0/4] i2c: muxes: pca954x: bug fixes and cleanups
Thread-Index: AQHdO/4jx4thXz6Jk0yPXe720gZkUg==
Date: Thu, 3 Sep 2026 23:44:20 +0000
Message-ID: <20260903234410.1896930-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB1684:EE_
x-ms-office365-filtering-correlation-id: 6ff92e93-4ed0-409f-194e-08df0a154677
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|6133799003|18002099003|56012099006;
x-microsoft-antispam-message-info: XaFkDNGrQkmkdRJWUQil35Skn6p+5Ba3qn7kMQIzMuHW8iYNg+x/BrMwlTWXTPRq6dos1R6QvT9ViJDlsHXil4rDbVVnb07MXV63G+tzLXJsncXsFAp5LmtrDvX1hEIlA6unZ/TMGHTbQXwmqi4pNEr9RrN8O+hfsPFtftqmJVbjjAWzMfep+ceGOzSLpDuJKicQSgP52TFP3nNROsqPy49FduCBDOlLwIX/sbiD9EKiWQV3l2wvC/ZTR+vcPlUH3AbLRdjecAk2KMq3RFIaCbC5o3Ae2+cFC79l0ugGn4xKL5Keo3goVZxJgk+7P10sLFAK82fiD7Da/9rzMhPKCq6fj9WuyDg7GiRexoolsa1yUkMlxWjPMBcpA8rZN7Artd5Hnu4U7dLjJjY0pN43xZ6lHyXPF/+eU8uUY6jxf2FSZEv8L8lPBQGMycdT5g8IC+2CP45E/4iN+g8ecTKGq4NWJ0Qynq88p1T5pxh99YYpBB1c73+NwN1jl2CI6B+p0yGsuqa9Ja5Ng/Ucc8UgqmgznNnspmWjwqIlEH10m3b+mzZX5CdE+wF2QqU+EVD6V+zAzm7snmPmX44/d20hsX5jdTnCdWE5tvd1qtAuSKcw6L838reEWQkImDIusEBHdDgeQhMlo5y0DNbYxOQlPiruoS6hNmAg30VIRusQkTc7SKxlAmlov6XnZ9lWB0I6T4Cbfmm0/nR/Z8ypdtoS6BKxntFHo7/5UTFMDc6Dsts=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0ZwT1F1OGxGNjBQVmJkQXRIQlhqa2pLdXF1YktEYlYvY1hKN1RML3M5TXAr?=
 =?utf-8?B?S0lWeEY1VkFoa29yUlNRU1NvbC90YjRXbmtwWERTMEg3c0Zza3hBNkNpMDBJ?=
 =?utf-8?B?bHo1TGlPaUZTU0N5RzNPSWhxRjhLSlExS2JkWWgrWkYrUUhvTjRUdWR0WHZJ?=
 =?utf-8?B?bCsxcTVRUjdCbWc5T3ZxYm9sYjBqVHYxNUxUVGF2Y1RTZ1NBMWdtcWRxY0ZY?=
 =?utf-8?B?OXBydXJFdStTa0hYNDd0dG12UHFzTXh2VmZwc0RXMzczS2ZqSVp5RVluUjZu?=
 =?utf-8?B?Zjd2dGU5RTZsVnJxeDkwR01JcGlWVFRvbFhiZmhCaUlsaTNzSnBGaVhwa2FU?=
 =?utf-8?B?Yy9UeWY4NkEyb0ZUUmQwUzJHSE9xQnRuT1g3MTFLVHN4NDBrRkwwV1R3cC9X?=
 =?utf-8?B?SGE2R3NCMnZ3N0lHSWduWHZOWlppdFpWYVJHajF0eDlPajAyYjI5Q1Y5TE54?=
 =?utf-8?B?QmNRK3IvV1JOR3cwTXZ4Z3ArWm1OdFhpUGlONTlRaVpzZ01SaTBoU3dNZjYx?=
 =?utf-8?B?cFhtZ25TYWxRR09RSXdLT2lrMy9lME12eXl2cDJnTWhFVElIMTJ6MStvbG1Q?=
 =?utf-8?B?RFdwd25iOGJybk9BVEFjODR4cmI3bFF5OWdUK0ltbzZvaGkwMFdOa01lM0lV?=
 =?utf-8?B?dThLQTRHQ21NNExIQ05XbjkvRDVkNnVGNDVmaXJKR1JNeWtUNnRsOXBpT0VD?=
 =?utf-8?B?UTR1MDlLcUgwOVpLNWgwRjVyK05jQkNGTC9ESlVialc4M3pwS3ByYUJGOGRo?=
 =?utf-8?B?OUt3aU90aVRUSXl1bW4vMmQwVjZuYWNoWHA4MUZmZDVaQ2twNFVncEtYTmZq?=
 =?utf-8?B?QlBNcmd4ZzhQZCtsU2xDcDFwcnpEbFBWZHE3dER6eHZLTHVzQ0duOVhhY0dN?=
 =?utf-8?B?TFdET0hReDN3K0lIWkQ1K1hXTEhJWDY5OUhRdHh5b3FYVEt2NFZ0QXpMdWM2?=
 =?utf-8?B?RStCdldudzlobFJOV0ZFcHY2ZXZmeGR2aFdoei91aUxHSDRDOHI5WHVXaWsy?=
 =?utf-8?B?dzhia25DRklWdXJVblpOSG1NTWJIVFFNb3ZEckh1K1lQQkk2M2NCNE1vTEx2?=
 =?utf-8?B?ODR0RzVrc1NjWEx5WElQbXhNY0Q5cVRwdWg4OFl2cTZvdHpxZ0pJMktCbS9q?=
 =?utf-8?B?NXFFOGwrWEJjNGt1cTI2d1U3eUlFOEtTQWordndWZTFvMnBqclg5WU1EL0t3?=
 =?utf-8?B?dUY2ZzZEbDRNRVRsMDlaQ2YySCtUa1k2ZEpkcVBFdC95enV6TUdlRERlMmVD?=
 =?utf-8?B?dFBWRUxvWE8vNmZiNVloNy9hakxSZ2hzaUZlMUlSc3c0MS9tcnVVd042MFh3?=
 =?utf-8?B?RXF3cGY1OXFZT0pYMTYreUcwK3dYSWtia1ZFY0Y2aWlWYTVIQ3Y2b0xLZGZy?=
 =?utf-8?B?aTI4dStEbW1xSENGNU56MEEwY2hlZ2JOeXU1VmZsd1ZiTVhBZU12dit4djB2?=
 =?utf-8?B?MUw3Y2xsUEhqaUZzdGVvTFlkOEptN2hZR2xOclNQMHpUNVYvUUlLYUtKWHJJ?=
 =?utf-8?B?cFlDWGRaVVhyMWZ3MUNGNnlvMWxiR2ZVeCtiSmxCNGI0a2NySlVRSlNPYzZU?=
 =?utf-8?B?QXZlN1ViM1ZpalpjUmNLTldNdFJHd2s4S0MzMlZQWWZ5Q2lVdlJkK2Jrc3V3?=
 =?utf-8?B?UjNOZ0RrVjg1OE9FT0VuKzZvd2hCYUxyZWhIaGdoUmxOOGxRNXpERWJXWWRa?=
 =?utf-8?B?ajJKTTN1aUphVCs4RG8xbnJoQXg4dnFYbHM1RHBIVkw4RDQwRVYyL1M1NGVL?=
 =?utf-8?B?NGMrcHRES1Q0KzlvZyswK2NIMXpnRUVabGdjV0Z6VFJnVTR5S0h4SWR6RnA1?=
 =?utf-8?B?T1EyT1lJbWhNUzNReGNnZnI4dDVTUXN6MUs0dzBoQVlIK1UxZDMzK1RFeW5t?=
 =?utf-8?B?dE1OcFVwdGVlOVdnZTk1cjZBTkh3YUdYR2RkYjFPYUplTjVJNXAwYWtVeU54?=
 =?utf-8?B?b1JpN1NyZGFqMDBaVUtSZlVwWTVJYmdyQ2VMRzBWdjZFUklkY0dhSWltRE9p?=
 =?utf-8?B?OUR1MkdnT1NCMERlS3JzNE9vU0ZZZG9iMGxkVVBjQ0tKM0ZUL2IvbDZaaVlm?=
 =?utf-8?B?YkRZOVJxU3VzRmdSWTgrUzdjR0ttd2wyVmRvZzRQVDA5Mms4bUtEREJQOWJC?=
 =?utf-8?B?UjQ3Q2hQRHByb3VRRlZnYkUrdDljYlQ4UDBXMm5DR29IWEZXMU8vNFoxWkhH?=
 =?utf-8?B?cFZnUG1uNlUxV1Eyd05rSzZNdGswMUdMNWM3b1FxblM2WVRuZUxLQm1saTdS?=
 =?utf-8?B?eEM2OTF0bVBKcHBiUHhieU9EVWhDUytvN1pHcGZpZmdUbHFaUGRrNUhINnN2?=
 =?utf-8?B?Q3ZPcGhRbWVkK1Qyay83K016ZVBmeVlnMC9CSVhmZ241SzArVHR1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eeDdgkXuQ6ER2bEMOFgyBGdUPPvSETSa1Y6xC6lZ6nLqUvn+kUWbN/KJwMRkd6VXrFdCDSrG5R5n2bDixBfEbOzVU3w16T2tLZTHffLxZuJeAniEC5eM0leMMaOCWJMXphgHXg1g4JaZ5fzXb+Smxs8UuUbfi7GG1BvjGdlyFDZv+tDWhV55ojdybZKZtIZjfDtwJ9rKkYB6sD54pvlp3H+x8ZMFz1JSAZtupsboN1AtIWZfID126dt3XI6osDT33ygQ0VkQTO6baDhxokDa3ouXXnsvsw+UOKyaZXvTD8SrtUM9QWeikeAb8pwW2NdDSWmAOi4snfm9HYcVC/QpZA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff92e93-4ed0-409f-194e-08df0a154677
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 23:44:20.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nO24GU8je263WISuGNH/2VMCLmVWJc1Znzgt2yk5x9z7AvNK+CaYmKzDoUPaJrVeS8oY3+kDfknU1V7BcMnHWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1684
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: eydK13Sw7oFGlDEYSpCxMNFXWBdGQKKM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDIwNyBTYWx0ZWRfX+pNNEr+q9XDT
 RZtBCZ4h/72F8WC10iyqeb/CsxQXaCwRjcxC2nL3sLMfeTHnTo48mMV74yyGZbjjLDY7YiAs90q
 RBHBqubJhSG8lJB/tJOC58++MjfmuLA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDIwNyBTYWx0ZWRfX5KsQQUL4yud9
 nX2Z+40C1sJMQXPZx+yssfTWHTtAv01JLhBC11dhjlmdH+kJ+wplC/BQk6rORUKH/dTOD8U9ydq
 vnzBsWzZ66fP/0SmUlw27CmFgT8V9jrcX5bWPeMSrVUthwL/Qhx5iVjQGBWV7+4Z1LkkBXm6uH1
 TD37wcrEkh78UTmEmBthSKdikft3+ETHvTqXAFyXPnx64JdL9yi/bz/6ZSZTBUDZJqEm6Pp8fjw
 4F/xNSQVUfBIPa5ELIk97C137o5sPjPPzKViza53XDRaJSDSllIQ922rLhbX+ZlNh0EL4Mqy4Vs
 gPko3DNMwDc0ODkgHeBHSJyvivinUyJ1+PbfgfB8DWq/pPjCXlSZS+s/svz1d6p07lNDFhCfZ7c
 tRjSnFT9QRqC1EqhK4iLflfYNOZfOab9opYKEAyDEBeK2j2w2ZAFTVNsEmx3MvFvdTu7+2Dex7+
 0xqjMNjv7q/VLMBS8tg==
X-Authority-Analysis: v=2.4 cv=FdoHAp+6 c=1 sm=1 tr=0 ts=6a9a0666 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ModqzXLkJJ0tFyq98apW:22
 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=OUXY8nFuAAAA:8 a=GvdYcfGa9KfluWhVlH8A:9
 a=QEXdDO2ut3YA:10 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: K0XVZKS-MIU-nkYT61co1vM7i3TSqdfK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030207

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpUaGlzIHNlcmllcyBh
ZGRyZXNzZXMgdHdvIGJ1ZyBmaXhlcyBhbmQgdHdvIGNsZWFudXBzIGluIHRoZSBwY2E5NTR4Ckky
QyBtdXggZHJpdmVyLgoKUGF0Y2hlcyAxLTIgZml4IHJlc291cmNlIGxpZmVjeWNsZSBpc3N1ZXMg
aW4gdGhlIGNsZWFudXAgcGF0aDoKCiAtIFBhdGNoIDEgcmVvcmRlcnMgcGNhOTU0eF9jbGVhbnVw
KCkgc28gdGhhdCBjaGlsZCBhZGFwdGVycyBhcmUgcmVtb3ZlZAogICBiZWZvcmUgdGhlIHJlZ3Vs
YXRvciBpcyBkaXNhYmxlZCwga2VlcGluZyB0aGUgZGV2aWNlIHBvd2VyZWQgd2hpbGUgYQogICBj
aGlsZCBkcml2ZXIncyByZW1vdmFsIHBhdGggbWF5IHN0aWxsIGlzc3VlIHRyYW5zZmVycyB0aHJv
dWdoIHRoZSBtdXguCgogLSBQYXRjaCAyIGZyZWVzIHRoZSBwYXJlbnQgSVJRIGR1cmluZyBjbGVh
bnVwLCBhZnRlciB0aGUgY2hpbGQgYWRhcHRlcnMKICAgYXJlIHJlbW92ZWQgYW5kIGJlZm9yZSB0
aGUgSVJRIGRvbWFpbiBpcyB0b3JuIGRvd24uICBUaGUgdGhyZWFkZWQKICAgaGFuZGxlciBkaXNw
YXRjaGVzIG5lc3RlZCBjaGlsZCBJUlFzIG92ZXIgdGhlIG11eCwgc28gaXQgbXVzdCBiZSBmcmVl
ZAogICBiZWZvcmUgdGhlIGRvbWFpbiBpcyByZW1vdmVkOyBmcmVlaW5nIGl0IGFmdGVyIHRoZSBj
aGlsZHJlbiBhcmUgZ29uZQogICBhdm9pZHMgbGVhdmluZyB0aGUgc2hhcmVkIGxpbmUgYXNzZXJ0
ZWQgd2l0aCBubyBoYW5kbGVyLgoKUGF0Y2hlcyAzLTQgYXJlIHN0cmFpZ2h0Zm9yd2FyZCBjbGVh
bnVwczoKCiAtIFBhdGNoIDMgcmVwbGFjZXMgc3ByaW50ZigpIHdpdGggc3lzZnNfZW1pdCgpIGlu
IGlkbGVfc3RhdGVfc2hvdygpLgogLSBQYXRjaCA0IG1hcmtzIHBjYTk1NHhfaXJxX2NoaXAgYXMg
Y29uc3QuCgp2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaTJjLzIwMjYwNDE1MTY1
ODQ2LjQzOTI2LTEtc2FubWFuLnByYWRoYW5AaHBlLmNvbS8KCkNoYW5nZXMgc2luY2UgdjE6CiAt
IFBhdGNoIDE6IGV4cGFuZCB0aGUgY29tbWl0IGxvZyB3aXRoIGEgY29uY3JldGUgZXhhbXBsZSBv
ZiBhIGNoaWxkCiAgIGRyaXZlciBpc3N1aW5nIGFuIEkyQyB0cmFuc2ZlciBkdXJpbmcgdGVhcmRv
d24gKGxtNzUgcmVzdG9yaW5nIGl0cwogICBjb25maWd1cmF0aW9uIGZyb20gYSBkZXZtIGNsZWFu
dXAgYWN0aW9uKSwgaW5zdGVhZCBvZiB0aGUgdmFndWVyICJtYXkKICAgc3RpbGwgbmVlZCB0aGUg
bXV4IHRvIGJlIHBvd2VyZWQiLgogLSBQYXRjaCAyOiBtb3ZlIHRoZSBwYXJlbnQtSVJRIGZyZWUg
dG8gYWZ0ZXIgaTJjX211eF9kZWxfYWRhcHRlcnMoKQogICByYXRoZXIgdGhhbiBiZWZvcmUgaXQu
ICBBcyB0aGUgSVJRIGlzIHJlcXVlc3RlZCB3aXRoIElSUUZfU0hBUkVELAogICByZW1vdmluZyB0
aGUgY2hpbGQgYWRhcHRlcnMgZmlyc3QgbGV0cyB0aGUgY2hpbGQgZHJpdmVycyBxdWllc2NlIHRo
ZWlyCiAgIG93biBpbnRlcnJ1cHQgc291cmNlcyBzbyB0aGUgc2hhcmVkIGxpbmUgaXMgbm90IGxl
ZnQgYXNzZXJ0ZWQgd2l0aG91dAogICBhIGhhbmRsZXIuICBUaGUgZGV2bV9yZXF1ZXN0X3RocmVh
ZGVkX2lycSgpIC8gaXJxX3JlcXVlc3RlZCBib29ra2VlcGluZwogICBpcyByZXRhaW5lZC4KIC0g
UGF0Y2ggNDogZHJvcCB0aGUgSVJRQ0hJUF9JTU1VVEFCTEUgZmxhZyBhbmQgb25seSBjb25zdGlm
eSB0aGUKICAgaXJxX2NoaXAuICBwY2E5NTR4IGlzIG5vdCBhIGdwaW9jaGlwIGFuZCBkcml2ZXMg
aXRzIG93biBkb21haW4gdmlhCiAgIGlycV9zZXRfY2hpcF9hbmRfaGFuZGxlcigpOyBJUlFDSElQ
X0lNTVVUQUJMRSBpcyBvbmx5IGNvbnN1bHRlZCBieQogICBncGlvbGliLCBzbyBpdCBoYWQgbm8g
ZWZmZWN0IGhlcmUuICBSZXRpdGxlZCBhY2NvcmRpbmdseS4KClNhbm1hbiBQcmFkaGFuICg0KToK
ICBpMmM6IG11eGVzOiBwY2E5NTR4OiBmaXggY2xlYW51cCBvcmRlcmluZyBpbiBwY2E5NTR4X2Ns
ZWFudXAoKQogIGkyYzogbXV4ZXM6IHBjYTk1NHg6IGZyZWUgcGFyZW50IElSUSBiZWZvcmUgZGlz
bWFudGxpbmcgSVJRIGRvbWFpbgogIGkyYzogbXV4ZXM6IHBjYTk1NHg6IHVzZSBzeXNmc19lbWl0
KCkgaW4gaWRsZV9zdGF0ZV9zaG93KCkKICBpMmM6IG11eGVzOiBwY2E5NTR4OiBjb25zdGlmeSBw
Y2E5NTR4X2lycV9jaGlwCgogZHJpdmVycy9pMmMvbXV4ZXMvaTJjLW11eC1wY2E5NTR4LmMgfCAx
NiArKysrKysrKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKCgpiYXNlLWNvbW1pdDogOGNkOTUyMGQzNWE2YzM4ZGI2NTY3ZTk3ZGQ5M2Ix
ZjExZjE4NWRjNgotLSAKMi4zNC4xCgo=
