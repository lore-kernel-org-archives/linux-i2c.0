Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2563D9036;
	Wed, 15 Apr 2026 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272377; cv=fail; b=RXyZqdOJndpRuYolRpaO6dXH2n2GP1SCKA35dljPrJYMSU34k43hE6+9c496FeUzbzi5n9bRNHMnq+DohFpLYDB5EWRFuUAsXemgd84O/q5VPTJ2FQdciXKbZUHX+RH9NGKMUrDnl0269HYv86lMsR//k6Sznx2Xd/YKM2usmEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272377; c=relaxed/simple;
	bh=9cZ5lfDxmJkYtmhlJzxgURW27Sdkz1MEiogg9XQzBNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qClN9ttjF7plSrP+xuB/sQ/c7fqnY4hfSr/yiAPkcl0noG+HQuoGh47X5HVrBNhJXbQnMh/eFlIo6uHMZJDxLIFg3ujaONmjSlHXZ7V52OBL0gbhdfCDzHT8gqB/n/7rMp9b8+JKVTZUsyD4d1HGXEehAo+hVanRGT5LgeMbeHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=NIdhxENI; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="NIdhxENI"
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FENFoH1463037;
	Wed, 15 Apr 2026 16:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=2L
	zA2Dw+eoZm8NehlQRwf2dK/DSkH3YUpDnePlRnYdU=; b=NIdhxENI8pFEaTUs0+
	dkjMGSq47peGcZuO/sf7BWw1IYvFcZiKbiaK/UugMlyifP4rtjeO2fO5p+d4hRju
	uvNjJ7ht9NvbXLcflO16vtM1sbgStTYxi8h7JsOrw/I30WmEqg40jQRTfK5cFmDJ
	zVg4IdOE1a5zHB5a63uLhZoHIQCZmrNtsU3NmMz+cXIe4yOU/ABSBn5MMaJ1ngRN
	Bgtc+NhMYOSuZ4mmr12dLbaUx2i37o3L/h4x8CVbbzRT/tTQ6PXMffx+dv0qgH23
	qh1rnvyNSd5zZIwba2NdSutXDjVL8S+jABhrLBNj5wrT9pShzbhB3i/u4XjB4XBA
	et7g==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4djcd29x7r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 16:59:30 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id E65D2897;
	Wed, 15 Apr 2026 16:59:28 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 04:59:16 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 15 Apr 2026 04:59:16 -1200
Received: from DM2PR04CU003.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 16:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRLoIHdk7bcZ6CvSJReB+FTx80NBCzFkx4g4NsbKDNNC2LDcRH54rodGJVeV3pDDgodLSeMpK5HBvKoN+iHOEE28wQeib7RWLKhHICLJHfnIgNKtZgKZ6vLwGVTkxHph3uZ6vzLGk8F4vL8j3PiQq97600ZidNGDCDBZrHkvbHc7ayjZLwpC2rZ5GX/VdnWEXV7bKxr3San+bChwuHsAIUrz/PazI/M1iZOZWKDFWiI0so3o+eRQVUAnKg4wy+U/k0luC7UYcVBZgxDw9o9wwe9i6P9dJ1vNTnbJ0IOZUic5elbd/MtwWu2/LW1QA92Guqu2SkOwtlmUBa0z7antXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LzA2Dw+eoZm8NehlQRwf2dK/DSkH3YUpDnePlRnYdU=;
 b=RK1XpLtnylKhRpy+Fx1Cs8zn+G4ryCv+D/9ZBSJ9MGrQXzBMAZnmw9k0zRh6MTesT3T7kRbvVnFVkkBFoviHxunX8+zF7PwyuC+nNuc4FZBO6hgMlZVAERyzwaJcrvMH2jUno7847Uaje+uBm9vrKLf+R3ee1hzkgNwJs0BGZ6rpJ04ctSmN65iSxtTz9Z/EvMe3Tme7HKNy6Pkw0FdfsoqofeRL5IsQM/qmBFbizv2Muc8+J4OuCxXtHjHS/pmSBCZ37LnLX6pAX6yhhERc/Ap0oAbDmq7tmEw9mAqfO9BcWw6fTDkWylu6sZdwYGHQJL9eNGGY5qUZtiZWTSlP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by CYXPR84MB3514.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 16:59:14 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 16:59:14 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Peter Rosin <peda@axentia.se>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>
Subject: [PATCH 4/4] i2c: muxes: pca954x: mark irq_chip as immutable
Thread-Topic: [PATCH 4/4] i2c: muxes: pca954x: mark irq_chip as immutable
Thread-Index: AQHczPkwFqAhgkAuBUmw6W85qdnq+w==
Date: Wed, 15 Apr 2026 16:59:14 +0000
Message-ID: <20260415165846.43926-5-sanman.pradhan@hpe.com>
References: <20260415165846.43926-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260415165846.43926-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|CYXPR84MB3514:EE_
x-ms-office365-filtering-correlation-id: d1c3c7c2-0796-4ff7-770b-08de9b10529d
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: PrPgxPpIts43xyKbmzAldUY3wMapHle87wvWDaQuTg/JzSHeZ+AAWd7XVFHswRmb4BrzD+FkFg2sZwQU9kNbpHFw2OhRsYKrodUxJx2w7gZXf1eLsq9JKBVjP6+vHzSU0Y+mO5x/tW7iV459NfOOcr3lEG4eSICyLKfxuJHNetAfcKSo6rwjJroMA0eewrxlJCBgmKjRt3Nh8v75Dbx5NCeLqi0OJdQhxblXqFeIsh31C7RrmxkSABrRkytsyrIFjZps4fQsN92/l4Kpaylo4rHxSPnBoaANs+bIGrlkbZKNmgz8vLbtG8k5AAoE+1RT6uvZWuMTkc73orE1Z2+m5DQ9ULe0by9uD3jTDNV31rQVX7SC1I9ziOo30tjCSMLX0wv5GcohbbVbIsgxEimqJYdexw9WepEZLAp6mTGOyPnuwzn3/Q7FeWDhzBiN7l0G/8/l/hPtqWNbfuQOI+5pvaIJoZJoSmfEwGf35TwhKEYbTGedlSVz1PexycfcyTQLo9csoWwbT8JP94q9H24LSNPgDEMQ2PBRpT/4kDnypBr8i4zbQSXald+mC9Swrm2oZkAqo1RDZkf6C+6gIOHvKekTOkmBMMBXTNGttLSYkj4Q6uPuiz1U3fNvCmmCH0z+R/YsSXgoU1DhPukjRkqr8bY3X8+BI9ZcWKeua98RjhQ53an/HI29zUqI6CTcIasoKtf2fliFaMWizgPrKmD5xFpyd8++yf4w9cGU5gMQk3rwudex9vEi6/m5fpJNaLOd23J2/oS6A2eZIU/ukkUnz4GymzwGEfg9bg2JGfmQyrI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nLDtdHOQcDXHFCufGg/dL/XjfstO39WJf4wegwEKwzFxu3B3BONCc1w7o4?=
 =?iso-8859-1?Q?i1BoItk5ZtI7S1gvAapLEn4Lf4r6Qecx5H8LO5t+uQCP3H4e7yFmsIMz7D?=
 =?iso-8859-1?Q?X9vuBYJ3AR+oZ1e0n81oiZw3mPZjrFuq9V7DEe8Wt/bIX8P3E/So9pzBAN?=
 =?iso-8859-1?Q?KIxlWcDgYvpPRxbMHJEX1QeTVjEv4/rsYS1fWdQ7j+trE1KXwI9RPr0guD?=
 =?iso-8859-1?Q?ZhRkkjyPy0exjANIHM/uba4e7UdsHdTymfrAOzIi9kGHkvX6hid7gX69a1?=
 =?iso-8859-1?Q?f2IotvjBJ8Ig/GDHraiWFvuHGafVCs7dj/LPqlELbqALpqe5gGj1e9Aam/?=
 =?iso-8859-1?Q?1MfwgiyQlAoyaRQUeM+cqJVWwZ3izHq+R0IuQjCiTB5p6kN0hBZSITfEx0?=
 =?iso-8859-1?Q?9OcKQOpRC57hmytlSMwXN5luCa+k6+fhGA7ZIJwtxYw43uGCbC6k4Jw7NU?=
 =?iso-8859-1?Q?B1vPGCTu2Xguojo7YfmjIdPQ3gqtWbTKGv0rQgLA1jwJMi6B5XJEQKYx7C?=
 =?iso-8859-1?Q?oECHCitTe5Fi7Abr6ouVsYTSNUByMd3Gwf/jKmmsKOvh8LYzUgetzpI96o?=
 =?iso-8859-1?Q?RdMMTBw2NqJu0pNCk+eGs7OfrlPJUIfp27d7nAvBCVaJJtd2PyEqnQOeq8?=
 =?iso-8859-1?Q?DUtnevZY0WDP8oncrYk6Aq+OK6XF3EOn27dZa7Y14Uez207WubEyxKJBc+?=
 =?iso-8859-1?Q?HJNkn6eUPawvQTbMpObOObCnwi0UafDCa/l3ixWYb6MFwFz8tjgn8P94GO?=
 =?iso-8859-1?Q?Lu/BY4QkuAfjP/BaoDWSFVWNTdxYpE0p/Oqy1ACVtB3I3OmTcd6hMfHAV2?=
 =?iso-8859-1?Q?4EJPM8YcGPlmwQBA581f4cldm17ThBvdlwZb6zV6gTc2qYj3R1a9uEnxzp?=
 =?iso-8859-1?Q?l9F9N8eKZ2FNf/Fu3P+TotZALZaflIc65zpSaHAv2tvE8WkVLzffmWmoz2?=
 =?iso-8859-1?Q?Y58uojdqIJgw5SZST74aNvii7aj87ZV8jzdlOqIr8uSjJAIA9MKVRSY6zh?=
 =?iso-8859-1?Q?QRABwF1Y0wYW9e5rszBTprC49V0K3VjKD/CSZgTQyYoMse9wWCR2dVSH0h?=
 =?iso-8859-1?Q?7KfBaoMJFRHHbnTF0c0MkBLUJA2z/QY0nSalrwE+8xhdwUVYtwQ4qTXE33?=
 =?iso-8859-1?Q?ljadUCDUgagLkN8Um4V13cUaimSrlAFIu0AbReER4cs8iQS4XklM0b2puF?=
 =?iso-8859-1?Q?n7ev+7RksRmPlJITlDaSnFIObBAwG5supCDCNqMg18sTT0PqSo+FXlKs6D?=
 =?iso-8859-1?Q?3pCgA3hyoeNjnwQXYjG9ov+zTVaeqsjjIzzfb+dWuIsQnVCHvnOyGhplm2?=
 =?iso-8859-1?Q?O5jIbuyLGoeNkdqiRR/vh1rhZTmDiZf3duowppo19S2P5+y2C9hGN95nD+?=
 =?iso-8859-1?Q?W9ikbSwTS5wD8SsnDaZkCqqtLkdzCxYJ8wVdOv2hM5jwlETFeC/aCRTZxs?=
 =?iso-8859-1?Q?KQvti2ZHtij/p3aBTXJfHgO5VfjmNcybJp44zY7wWKi6jldzaW8/EE3957?=
 =?iso-8859-1?Q?wFpiztOUBJrIJJdoNTJKK5r455MeYiiViHx/9Pwum7surUcCrB2s1cO9eG?=
 =?iso-8859-1?Q?nFErhktWLKwls7egxbH03GjnVhvqG1dQfNg/AR0/gCIULFhQHwPm+1r/u3?=
 =?iso-8859-1?Q?jjYpOMNq6J3EVARtyjSvu5PIGq4HdPNEisSvEBlozB5vf6Lw7QKKEF3PCo?=
 =?iso-8859-1?Q?cZtzbhd9VOUbUMvPtLuI4+XshZ4sQgwxCWRJcVRRqA2tS8ObuZQsW+5HzJ?=
 =?iso-8859-1?Q?hngY7qt5Vh/KWtm7fCGElSPt4JnUbNdyvjBLN/rmkCbpODjDZX56mvyFSk?=
 =?iso-8859-1?Q?ySY8+9W6oA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ctvRJC1zta+3qUnyNk/tyZ9/k03QvHGMxObu0QJIHFM2bpfS1bA04RC3eK2EMI6e0zg9m8QkaoDM/hMVucepW0fbayS+GJrtwT1aPc27s4T5JeO8YvfqJwO6SotU1q1QD4IdaXXkiQnAxwAwpCg1Fmtf+LWzIneuuVf50xoee4WMe+BXA38gqxGuHJJjOUKyjS7TI4kJKNLJSSoahc7YJwJEFCvLJYkFZ+s+Y+cqpNyqhPt0X4vNeSCJIl8y1hl/DraEproLNvIwOKDWjlNnsGwnRteqQe1+CBuHSt0GlxPSMSNe5NIPQahkXAPNgBmkP3I1fyirTElItMKF0Nuyaw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c3c7c2-0796-4ff7-770b-08de9b10529d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 16:59:14.0514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gm5EHH0zGDNGEYm6qRJO6+joS3KXI5wO5EIz2V722WvVsGxJFR1uefGIuv2iAdx+70IioUJS4yYR53nCbu0StA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR84MB3514
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: f9xZTixDImYchPrOwpYS_EboBIaVaCbJ
X-Proofpoint-ORIG-GUID: f9xZTixDImYchPrOwpYS_EboBIaVaCbJ
X-Authority-Analysis: v=2.4 cv=HoRG3UTS c=1 sm=1 tr=0 ts=69dfc3f2 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ZSrvDirOKP4VPF05hnFf:22
 a=OUXY8nFuAAAA:8 a=gN7OOAkR4Fhn7TrYoc8A:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE1OCBTYWx0ZWRfXx+UkHvLsfCQZ
 6Fn3aRRuvgmheBBkdyzY4V7Py0eQEPjGaTYNxHf9CRdYxwB6xhTJYANoacXUspgZ0QKAA+zBCT0
 ppxJYjMYkdT6dQHbcziqlPYj1omjJZY08ARvM5vjD8EwfN/bZ2LImYwMqIu/lmuKyqS1/21xgS5
 bQMmdeLWMfhrMbjfyji1YqwQwVWy3XRE9ped9w0dtX515qDW5qx20P9nleYAJZmKHSeynXC3bJS
 3zPftcWKC+U4v1cUZAlG5G4t9QpEHcOXXv0IvdRTyX2lVGfQAqO15qK2KwjM5jYNvFkc9wxhkAt
 YpXeRCLsljDMQFOMz72rgsKRPspHqAoYkDw7TUponxAtRyF8MXlKGxO26jT+XRdsctPeEN6ZTLL
 oCmHlhTRksXOf+UcJYFcYGeYMiAdE5iSRpXXy0Dy4PU0Kp2w0WLtGb+eCSVBHk/ipMDyAoqXMVd
 qVnOCgP5VTc+kVA7LRA==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150158

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
Mark pca954x_irq_chip as const and add the IRQCHIP_IMMUTABLE flag to=0A=
advertise this irq_chip as immutable.  This is to make irq_chip=0A=
instances const and immutable.=0A=
=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/i2c/muxes/i2c-mux-pca954x.c | 3 ++-=0A=
 1 file changed, 2 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mu=
x-pca954x.c=0A=
index 4803231e4c4b..20f7cbb2fb71 100644=0A=
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c=0A=
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c=0A=
@@ -427,9 +427,10 @@ static int pca954x_irq_set_type(struct irq_data *idata=
, unsigned int type)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-static struct irq_chip pca954x_irq_chip =3D {=0A=
+static const struct irq_chip pca954x_irq_chip =3D {=0A=
 	.name =3D "i2c-mux-pca954x",=0A=
 	.irq_set_type =3D pca954x_irq_set_type,=0A=
+	.flags =3D IRQCHIP_IMMUTABLE,=0A=
 };=0A=
 =0A=
 static int pca954x_irq_setup(struct i2c_mux_core *muxc)=0A=
-- =0A=
2.34.1=0A=
=0A=
