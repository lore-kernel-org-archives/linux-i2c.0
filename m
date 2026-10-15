Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9AB475355;
	Thu, 15 Oct 2026 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054520; cv=fail; b=maRj4WiO1ZU6TwljR0KWRRGrpvVSvLaqrA/CEYeNs8vfxVakEHA4g3HKnPCsDxMVmyq9AV6K5s9lGWwUFQj/XH1TAp31+o9MRXytFfooxDKZsrYyvgAKPdjtS2UmveS7G7et/CwCnvSqQabz8B6A6TjdNtDiM5k0po865f4tgjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054520; c=relaxed/simple;
	bh=qRf2oNcAAS3ufb8AiFSixxOwM/9Z88J9gBN8dm+13gI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uf6YnuL99Y1JHnl9e5SsbCn0tApVvf2I+90LFP3rzCaa8Oya3LT5aC80FMPhlWFVvErWwYu5/32l6rR7YnVw+HZ5ScBlnTiIbnmm3UhrrdZuL38r//HfJJdXaKUypyk4MaOmi1zQdeM+iUN6s4wAwLoxxu6JyWCnlT0jUACVNeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com; spf=pass smtp.mailfrom=jabil.com; dkim=pass (2048-bit key) header.d=jabil.com header.i=@jabil.com header.b=mxjtqfK7; arc=fail smtp.client-ip=40.107.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jabil.com header.i=@jabil.com header.b="mxjtqfK7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9QP5XiNigDeqOdFxUxZfbL2bLN4FSMt4caEWFS2wumPZiYHJf0KyuzlSfsj751SIVaQm8XVrgfyFHNEYPFrKRKDi/67YA8hk8Erhy3op+/RgP8RPOg3A1JXnfc0cfYd0zUUlYZte+b4ESPYKfEW/mHYfnEVXmdYbFeeHvhN2ovWasKyQaP7Wz2TYyeaFBT05U9GgBfkkwRbGYQHntO3qhOaB99hh/2LbIQUG+wY8fGX/vKb+7s9z48gTEkOfUYL9RUMQ1nfy7MYIgnYD37dCgvGZOD/u/i2w2M5yKpMIGEikK9a0P0h/4KTg+qKGdJ60PH5WvkS2yzaemmMfIkmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRf2oNcAAS3ufb8AiFSixxOwM/9Z88J9gBN8dm+13gI=;
 b=g0lVjzXvG4DzcHdgWgpOA4wl526W2XVK3VfRJ6Aicv3+nXh5mpGS7G7NLruj1knzQgd3lmn10K2qpouasUngEg4Yai/K9vcU7q1QqAzUUJhjhsvZGkBvXqNjiy1Clc3piBb/dVrolWNop8nF6DiYUuOmV7+JuYM1uiFh5YuQXHH5VlhGx29KuRWOExyhv9jm9FxH7e9rq4VWk37pAkCqBiSn+CqiNuvLkbfDfk0eKnzsb1XgM+emQSL0kdQXSMTpT5Lo12gY9fAzsSfdrl6D+OTp9YShKw5SmPHM1T8Hg2UW97mIIC+bpOzWz6waxPObjzPfTHWE/8Iw8519MRg5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRf2oNcAAS3ufb8AiFSixxOwM/9Z88J9gBN8dm+13gI=;
 b=mxjtqfK797RQ4fyNRXvqta4U7W0ne4aV/Jtp1kCh2RI+qmWnnURcH4wL6nbf9RnWZDIMgB9ChxKUhS/RCSDqqOWn1JdU7FnK8v2MLu4d9gV2Qzy6fFBb6SZxQ8UgssX11okUl0W+jWccOhjlTLVfOnDsSSLDl7H4V6U16saiEQCcuQakKSf1XLZL7/W7+qCWlssYVlBI0ImyIXhBt0SNzi+3iy7ZNcyxf4QMQyr2UEhhe9rU7qq5hzrg764aAtGYWM5bGtwASoCjGhJ8te9mUFbDYQIIyo92SzC3wE0OT9j8AHXCW/SgVG6qEXHijHNOh06Ps9YHRM3C2jTStHlDZg==
Received: from DM8PR02MB8087.namprd02.prod.outlook.com (2603:10b6:8:1b::11) by
 FT1PR02MB140537.namprd02.prod.outlook.com (2603:10b6:170:a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Thu, 15 Oct 2026 08:55:15 +0000
Received: from DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497]) by DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497%7]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 08:55:15 +0000
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Matt Johnston <matt@codeconstruct.com.au>, Andi
 Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] mctp i2c: add sysfs control for mux child
 netdevs
Thread-Topic: [PATCH net-next] mctp i2c: add sysfs control for mux child
 netdevs
Thread-Index: AQHdUkAl/BMP6YVmxUCRw1HAmghBBrb7HR8AgAM+TBA=
Date: Thu, 15 Oct 2026 08:55:15 +0000
Message-ID:
 <DM8PR02MB80878E71AC46BB3358DF3B538E9C2@DM8PR02MB8087.namprd02.prod.outlook.com>
References: <20261002073156.759005-1-kenny_hsieh@jabil.com>
 <20853c96b17ea29815ccc34fcc6556032df8291d.camel@codeconstruct.com.au>
In-Reply-To:
 <20853c96b17ea29815ccc34fcc6556032df8291d.camel@codeconstruct.com.au>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jabil.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8087:EE_|FT1PR02MB140537:EE_
x-ms-office365-filtering-correlation-id: e9d3446b-d051-49a3-2b0e-08df2a9a07dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|38070700021|56012099006|11063799006|4143699003|261009223027099003|18002099003|10067099003|22082099003;
x-microsoft-antispam-message-info:
 ROG2Ga6IHtPPDaOtkBYh87KZCQEu+33K6iD5XNEd8M210DBcl6ZX4Nrwf6Mbt5O5WEEd85vZSIB+A9NaS/RjC7ofFh32LmOE0Y53R5xrSNqjJjCSGVsH3kqqKuFcPHWPRU3Rbl0iilEREYDThxl7MFnsZiEI8+T0SJNYVl8wVXKiuurbxkwcX6EmPGuGLHlEHzg14u1V1qKiI0y1AllVBJQPFD/jbeCkhA/0nOaCY05Ehz+J8Y8b22/esCqK/SetiqlSS0OIAF8Y2I21DGNWqN1DVDvgyZPD0tolKahJnZbnOdJKgMy0wCBRdXw0wbp2xQWG4aDKx8U4hoiIc/fYogZHRsGJb+qlU+3PyNFxNs0+1YmV2N4BRgdp+ITZ+hXkBM3AWvz4ngs2BPSbuBtD0vQ0h7qZQewaFJWXmK6ghzH0BSGKQZX8/QZR9DITBN/qGt7jzbisyg3DXAiJr0l7AbUEHiAWfRxRmKCy7qACJQ54UeDQ1SKzVc2v+bsz/A40W5sF3a3fv7+7PHsBbfZlbfMVBvxYItzg7xATKBrXmP6gcLWnaySbRO1D6jWqxZ3oiwzbUWee4wKlZHxPodHXu4L9wkNpkSHstcdDq/V/tj7UK6As4w0YxF+I4cUy8n/s9PbrdPx30Q3az1zwGJ+u2qumkna26w+loZXkNGbr7es=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8087.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUNjeUlsazhtTWxXQVFwdVdqc0VNSWRUQ2xVYVlpc1BJaXNwU1hiN3VyQWcx?=
 =?utf-8?B?MnlGaGxMRmhON05idVZQTFdUczNtNzdLeDIzN3BQd3dIaWowNnd6QTZpK1A4?=
 =?utf-8?B?NkhIZzRKYno1T3A2Vk9TWmZhbk5yNDZsOWU3Zkpla1cxbTlaOVYyeHVyblBK?=
 =?utf-8?B?dHlNNzVpUXV1ODFXeVFzYUQ5bG9lTFBkeTE1L0R6eUtsczZXVURNck5NNHFz?=
 =?utf-8?B?cXZqeHJPMktBSThNYWdnUWpqVTZZSml2NHlhMWZ4TktUb2tTS1FtdXhFSS82?=
 =?utf-8?B?cEs5RlJ5MUJZL3kvdjRsWUVTZzFQc3owSDFnMUd0a0FhOTRQQzNlVnZjUE9Z?=
 =?utf-8?B?YnFSem9NZ0h1Slh0N3I3cVM5Q0MxYTV4dFRqUWtVcEorR1Axa0htWDUvM21p?=
 =?utf-8?B?L1JwN3E2aklMTC94RjB3MXY4cWxKT3BzNUFrT0h0cTk5QVluN1gyR1l0RSt1?=
 =?utf-8?B?RzNoaUdteWpxK1BFSDVPRTBPWmMxVnNLazdFM0pzUGlEMFlMWHRBVml0dXNM?=
 =?utf-8?B?L0ZxU3hkaWN3Ri9nbWZ6WG9KUEE2SmRSU3dXdDNaOGNkMURtQUxvUUROdWlH?=
 =?utf-8?B?Q0pkc3Y4WVBYQjR3Y0ZManBhdE5aZFpPRjV4OTN3akVBVE5RV2t5NThmLzFY?=
 =?utf-8?B?SEI2Q0s5eVU2WTJvdjg5V1pVWTZkdnIwM05SZHMvSThlbkc0Ly9TMVU5QXBQ?=
 =?utf-8?B?N3FUVmpvbnRobGJZMktxcWtDNlEvK2JyV1E5UE5HVlNjZ0NZQmRaL1ZURkw3?=
 =?utf-8?B?aHBtdkYweUNBbjdsNjFyVDJsam54Y01PdlEvQ2VMM0o3eEhwWkh6TFJQL1Bz?=
 =?utf-8?B?cURZK3VtSVQrcHZGR0daQkt1bmxidVlPRlhKNDBrc1Q3cnJNeTRSWkJBWklx?=
 =?utf-8?B?UlNRRnIrMVVkcHkvcHVNcHFBNE4yTXVZVzhOaGN4TEprRzdYWXpUNUtRelhW?=
 =?utf-8?B?MTJzSVBtcUxxdWhqU1ZLWllFZjd0UFBhTndQSC9Td1g5VG1lMy9YbnhWdFJ5?=
 =?utf-8?B?aFJpaDRTYm5RSEMvc2xHSTNaVnZ5NW1Gc0tDR2VKbXBjZjNIdmNyb2ZyRGx6?=
 =?utf-8?B?bEVUcEQrVEJnK1NqejExMWhPTWNjY2JVZHlFenNDWXh1cVFSdXdZNDFkUnZS?=
 =?utf-8?B?b2dhNlBoek9WM1hFd2dGNWgva1o0VXMzYzdaMFJLYlVjb2hRcWYya3lGQlVG?=
 =?utf-8?B?KzRmaFdjRHNMRUFtTnR0cVh4MVAyNXlTQVJsREtwU3VyY0k3T0plemYwNDVO?=
 =?utf-8?B?RGo1WWF2QzhpN09YRHdWanRZcEI2S1hJS1d1dW9VQndyZmx3ZGdvNUdFcmxU?=
 =?utf-8?B?aUNLK3pNNFlZSjNaUlpKNHA2ZE9UcnVSVlFJNGhLd2JiV2lWVmFNZWZ0NHlt?=
 =?utf-8?B?WlZwOHE3RS9hK202S0NJYTFCKzZGcE9PSjg0S0MyaEhlVE5kd1JvYkRweWJm?=
 =?utf-8?B?N0lmelFsWlBiVGZUMmFWZ0RMNDFPU1BiZmhxa1V5anpibnd4aStuUVdMT2hS?=
 =?utf-8?B?eU96WWg3K3RqRG9UVjEyRzgxTlh1VnJPM09iVnVmZm1sREV2ZnhXSjlHNzIz?=
 =?utf-8?B?Q0ZGK0RQMXQ1UGJJd3dHV3llMEliZUZ6ZzZwK3k5ZE80NHZwaC8wRFRtenUy?=
 =?utf-8?B?bU5CQkxMNmg1UTFOY0lnalJSYW0vbGx2c3VWRTNrdS92bElUc0x3Z1BQMVVJ?=
 =?utf-8?B?Y21xUWZvU2N4YUNveFM4bjk5NHdLVTZiOFRuMzlzVkxKTmZIZ3hGQ3oxcEJM?=
 =?utf-8?B?L05zendBZzcvenFMWktNcWdTM0lqaXR0NGFPNnA2cllqM3N5LzNScTU4cnRl?=
 =?utf-8?B?LzljWUpUKy9wOHlGVWZMejRSeUJvM0tyenI0SGc2L2tNMnVHK3JYbFFFK1BR?=
 =?utf-8?B?ZE1QdFZVeTdlOUo0bExRSnhqWVZBVWpWeEJFY2JNdE1BemU0d2diazVtY3pG?=
 =?utf-8?B?YWQrWTNLY0VMSVc2eGF2VkxGNDJJRmpGRk1RY0VBZk1rSUVyb1BOa2NrRERp?=
 =?utf-8?B?RkR4Z091ZkpQRW8rZ0J0d2lpREVRYXk0ZUdJalQ1bEJQNEs5Q2pmZm1PUURP?=
 =?utf-8?B?MmtmZjRhNnJ2em16SE4weVpnOGttNElycFdIQkxpaytXQWE2YThQNFp1TWo3?=
 =?utf-8?B?K2lOcCtKcHNCT3JyRnhXek5pN2doRUZLbGNzOWptdU54SDBQcUtJNVdyd2Fk?=
 =?utf-8?B?T1hsbUduNitsa0xtV2xLNEt1Y1FpcEFORGNjcVRkWGNpc1pSTFBBdDQwTk9k?=
 =?utf-8?B?azZVRTdTODhsdWNGcmcycjFhbVF2dmgzOTBabUl6d0FCUHBKaitWR2ZBZTQz?=
 =?utf-8?B?ZCtTT29tdTVwelpUek1OcmdpUkdKcUtvMlNPbVpFaHRORlU3NXBhdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8087.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d3446b-d051-49a3-2b0e-08df2a9a07dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 08:55:15.4520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLBLgpAJqiOrol7Ja7t9D7yWU/+27rsPi0wOTeMJVqQdQFWHF0HTS+/eRszRbd12+FVhlIiDh6Kcjnk2wdtO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR02MB140537

SGkgSmVyZW15LA0KDQpPbiBUdWUsIDIwMjYtMTAtMTMgYXQgMTU6MDIgKzA4MDAsIEplcmVteSBL
ZXJyIHdyb3RlOg0KPiBNb3JlIGEgcmVxdWVzdCB0aGFuIGEgcmV2aWV3OiBzaW5jZSB5b3UncmUg
Z29pbmcgdG8gdGhlIHRyb3VibGUgb2YNCj4gYWxsb3dpbmcgZHluYW1pYyBNQ1RQIGRldmljZXMg
b24gbXV4IHN1Ym9yZGluYXRlcywgd291bGQgaXQgYmUgcG9zc2libGUNCj4gdG8gYWxzbyBhbGxv
dyB0aGlzIGZvciB0aGUgcm9vdCBjb250cm9sbGVycyBhcyB3ZWxsPw0KDQpZZXMuIHYyIGRyb3Bz
IHRoZSByb290IGV4Y2x1c2lvbiwgc28gdGhlIGF0dHJpYnV0ZSBpcyBhdHRhY2hlZCB0byBldmVy
eQ0KYWRhcHRlciBvZiB0aGUgbXV4IHRyZWUsIHRoZSByb290IGluY2x1ZGVkLiBNYXR0IGFza2Vk
IGZvciB0aGUgc2FtZQ0KdGhpbmcsIHRvIGJlIGFibGUgdG8gcmVtb3ZlIGEgcm9vdCBuZXRkZXYg
YXQgcnVudGltZS4NCg0KICBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNjEwMTUw
ODEzNDEuMTI2MjY5NS0xLWtlbm55X2hzaWVoQGphYmlsLmNvbS8NCg0KSSBoYXZlIG5vIFVTQi1h
dHRhY2hlZCBhZGFwdGVyIGhlcmUsIHNvIHRoZSBob3RwbHVnIG9yZGVyaW5nIGlzDQp1bnRlc3Rl
ZC4gVGhlIGF0dHJpYnV0ZSBpcyBhdHRhY2hlZCBmcm9tIHRoZSBidXMgbm90aWZpZXIgYXMgYW4g
YWRhcHRlcg0KYXBwZWFycywgd2hpY2ggc2hvdWxkIGNvdmVyIG9uZSBhcnJpdmluZyBhZnRlciB0
aGUgY29udHJvbGxlciBpcyBib3VuZC4NCg0KQlIsDQpLZW5ueQ0K
