Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793091488;
	b=MaolrajI/Fv8ndFq9gDB7evDemHeFcBN+wCPLB+NSVf8x6EjMRLu+IZHNdhmgoU+OQcl
	 hi4B/hSlZE1dix5KEVvf1mkKuxZGflkkFniTZ2URobSQs4pI4FJ+n8cmKZtgqXAMyYc8+
	 HyffTN2UKSFDPiYpvUT3UlQ8YtB8U3icpXIBfMtm50ql1JzzX2sBkq6w6qLz0BuMJ+y7H
	 KWyJv8/59l04px1CxbS0V0+qloLfLY3Uo9miUQ6w0QMupVmXTmNWzRqK3ny0ukfP0OYrY
	 iLZxfyqQWzQsLJEeXi3ObJn9SwhdFvk80FaDcFKYjtLfN+/eUWWQU5K6wRCGxNsohHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091488;
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
	bh=4jt++BAt4OfYjf8SvIYwwePs+UxDVjIgVS8WB/cRm28=;
	b=zPAAKcMVutdH5HY/jGSESjbyRCK+Gf2Zm1RdICAPk1aAtMWyb5CUPmjxBQzptndw+tBI
	 zEzUCibr6VX/UbJxJEyM6Dh+IczHn8F0Kz5mS5wnyQI+uBJxrrdwAVkTo3JlxDPLBjYTh
	 Ztn5YFe7lN5SVgROUwlMOTuWyTDh182d4UXIh8HfYQGpj3LkOBvi+uTXhlw/i2dT+M1rB
	 hLP1u2mw9Tv1mjV3tIqkj+fbDVLAS5Di2aDa3C5Nx1qzGpCrlrAeXd53Qutw7DWBNUQap
	 Fe7xwTqEMAZXWKsxc4ZOx3nW6NDQ8BhvoRyAXToXcRqase9WdkN91gmN0K40COiMNjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=aGCv8h23;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.18
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012018.outbound.protection.outlook.com [40.93.195.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FDA606A31D;
	Tue, 27 Oct 2026 08:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28FDA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=aGCv8h23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HR9v5PQ1Q15OsaOCIYepm35b70vT8+tkh7bg0PMX8SoCJImzPayngRbqAqG+SS/8ytkUiCqNofFj4SuqT/W3xK+hfr4Sl3udm0WgcOhxSz07JZbJi3190cWcv9pybtEEg5C69OOvyOp9f3OT1ma6G+qvoRJIMQzflnSSK/G6jEpgLvdwEocCbyHGewPqXq/J1RdJgccsUk1e6pW/z00WLk8zvzHkl+2YjpLfMGZsl1yKWcq438VL7O4LmWhVZLSbnfPuoAB76j8hY0tP2KvZdPs6p2kxjM9pjrTeSS+PvNZyjV+hxPiYOI0iQSfCjdP5zD1LXWjZ+ZSeIX4HlNYRJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jt++BAt4OfYjf8SvIYwwePs+UxDVjIgVS8WB/cRm28=;
 b=JG6WtNyOjhAZ/ipOGScBgdaZ1ON27zI3g5uvfyalqgLe71VdkI6ilNTmBPLAQuOAcslfnylHaZVdgq1XQDbIyZCvHEle2GQtz/MSvW28zixpKTEWH/agWCSMdEoeTqQdJAfkAIuKMNu02duYokLP/x5p6sKUvG8Hnz8/HIQ/rL6440KtgDSip39cfbzjqPJwC8zSYIxRx2Nkrz8blZ+MxM8fjbH1k1fpcHMiWvzX3lQ1TYd9YCm0CjuYjCDdlAMH2htNbWDLjaSzgema8O48NbKo3Zv4JWsCdAGwBY3XrVexL0TERi0ffg6eK3HxkkaFz8VgM34eGyY4q/NV9pl+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jt++BAt4OfYjf8SvIYwwePs+UxDVjIgVS8WB/cRm28=;
 b=aGCv8h23QwHpHBFJ3JEKy1yF1A8lJZTGDUW66pGKyOcIXPO23vl+ZG5oXqdf175l7N4eh7ILpEfdLyK5cyuZqhPd32kADb4ivaD/j4+3Wm+rdwwKxcjB7ctkCjXFDpsh/OBszI9SAARdinD0ohV4n04waW8Fi3ktI70Ff06vmlGPxM0pKgx1LHZdDXSKRc7qc2XBELXr/OpAdAJAhIutlaLXaT0A3zAcX0klv6nIIyw3B3tS0NxcNA8UCfcAo7AubH9ZeYmw5XpCNyR2gqNV5tMz6/wGxCiAoJi9hfY8lGJQhz2SAoyr6euSmAPpdWkztmAWh7Duw/czJNi/2Sh4Xg==
Received: from DM8PR02MB8087.namprd02.prod.outlook.com (2603:10b6:8:1b::11) by
 SAWPR02MB11994.namprd02.prod.outlook.com (2603:10b6:806:562::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Tue, 27 Oct
 2026 08:58:06 +0000
Received: from DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497]) by DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 08:58:05 +0000
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>,
	"matt@codeconstruct.com.au" <matt@codeconstruct.com.au>,
	"andi.shyti@kernel.org" <andi.shyti@kernel.org>, "peda@lysator.liu.se"
	<peda@lysator.liu.se>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@kernel.org"
	<edumazet@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] mctp i2c: add sysfs control for mux child
 netdevs
Thread-Topic: [PATCH net-next v2] mctp i2c: add sysfs control for mux child
 netdevs
Thread-Index: AQHdXH0gJEQaa7DeYESRNm+vhnedSrcEkYgAgAyNxfA=
Date: Tue, 27 Oct 2026 08:58:05 +0000
Message-ID:
 <DM8PR02MB808768B7D02FF12777B7777E8E602@DM8PR02MB8087.namprd02.prod.outlook.com>
References: <20261015081341.1262695-1-kenny_hsieh@jabil.com>
 <179239912623.3135.11352652156626817288@kernel.org>
In-Reply-To: <179239912623.3135.11352652156626817288@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jabil.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8087:EE_|SAWPR02MB11994:EE_
x-ms-office365-filtering-correlation-id: daf56747-7213-4d07-3a92-08df34086a3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|38070700021|261026121527099003|4143699003|56012099006|261022105027099003|11063799006|261009223027099003|261021123027099003|22082099003|18002099003|10067099003|261026140227099003;
x-microsoft-antispam-message-info:
 MUH0ZOfQCsL3TexuU9BbpudvGYMe0KLNyLNoQhB0vI2tXiyrSy98Ty9JZshifD4C3vVXV/C+GytVf3P+8kQ7zNdNUV548WwMkoz74dfWLjISsdwkbpkpLWsYbqCUL37/ZXOtPzuXD0CMHIai4brMBBJB3iWi53Mo1LHpV90oHu+YOc55hyShOkVU1xdcq5Y7w1zFuiBSGRZlY6LcYgDPdrPkxJr0fwxQghylN4A0Ofu5jj7dILdTegzOz5zrf+W84geGJyzXzLVeecTppXXpy7vYoDLcGf3be/k+Spu4GHpavBq50yzktcuKFD/NgyTqsH51rIKYK6sXUbdu051zRBVYODbfzcuQEcA3nQHxmDU4ldejFqeECCtmhg9KRSFdpAZ3W8eHi/CtMB4tKEcmhf/ZQ9RTrR/ca3Z39IMGx/7ASTIOBOoBLjifJrrwqfkZUCnnSIqgzaID+YGIRa4cFz/ysEf1OUSdxC+tvoEHIx1HX2MdX7dzhebV04g1ydEMG5jBujc8og4HCvfRpcKo9248oSJfPYQJKMki8FkUoEo86ZeWy8by/CeztCKSlaUVw04s9FBka+NyYjeDIRMRMy35Fmiv4eaw88FSyyvgfGFMNqQYNW4OLyhzlx1gZqv7xM0UsPlVwyH9V37UiVyWkPUvgvVGYNbgscN30WkgWrc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8087.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(38070700021)(261026121527099003)(4143699003)(56012099006)(261022105027099003)(11063799006)(261009223027099003)(261021123027099003)(22082099003)(18002099003)(10067099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?elB3bHpYSVJHRHlZLy93ZmtDYTFZZm9MVUE0Zi9LM2Jqc0cwenBBMWlKY0V3?=
 =?utf-8?B?eVVZZ2J1K1ZLQ0hTQ25MYk5SQ2lLd1k4WmRVL3FmTEFsRHVaUHAvRS85S3Uz?=
 =?utf-8?B?RVo2eWxvd21BeExTMkM3TXhNR1hiM3prdUNyTW5lWkIrL0ZzbVpSQ05WcWFV?=
 =?utf-8?B?VVJpYVdGbFJMQlNNOUxZbXhwOFNxbkVYMTBCeEhRMjVYRndhT0tWOGN2ejZD?=
 =?utf-8?B?L0F4RlVCNS9KWERtUlBHdVBrbzdnTVpsWHhweVhra3phbHByNE9NclhLN2FP?=
 =?utf-8?B?ZG1uVmplRjFiWGJzRUF3NGliYnhFcHYrbENIYjNBS3UyWHkyYk80eTRaN29R?=
 =?utf-8?B?OGJ1MjdFR3ZyVUlveXU5M2YxODNxVXZkV1JTdmo0eTRsd3hZdjE1L1F6Tmx0?=
 =?utf-8?B?M2tGaVVWN2lQc0pSSFpaMmZiTTBFWFlldVNVQW1HRmgxVmgreGc1NkRMYlNY?=
 =?utf-8?B?K1JOZmRYaWpaeVN1aXFsSThnVitodTdTQ1d4aTByMjMwbjdZSk14Y1BnRksr?=
 =?utf-8?B?dmtFVU1BdHFvcDAvckhyZjBBaEJrQXlLazA3ckRDeVVBK2hXZGRkTjFzWGJh?=
 =?utf-8?B?REdiT3F0RENValo0WnZoVWxtQmR6Q0NPN3VJNzQ3UXVUVWZDVjV2QVdOTGNk?=
 =?utf-8?B?L1ZBK3IyU1pwSzV6NmpkK3VsSXNYUVVYbHNaZElxVmhieTBpejM0VVl1RTlp?=
 =?utf-8?B?ckdobzNoMGdFTXF0NVdtWjhaYjB5RS9mK0NWY3laU1NxTHNZdm9iajFLWDRz?=
 =?utf-8?B?K2hpYW9IYVVqaFMzNDREQjBUQ1JNTkx0NStnUlJmSnJqQTJzbTR4R0xqRWRY?=
 =?utf-8?B?L2IzbU0xcUlkMGhHYWxyUFlaOGdlejRxYVJZNFFtOG8rbURrVnhWdmFla0h1?=
 =?utf-8?B?cVFMY1BxMjVwN2JSV2lTSTdTcUdQaTBrelFpMmVyNlIxdzhCMGQvMUsrbnRK?=
 =?utf-8?B?NlQ2NjRFMENoRWtKNHFneGNUR1VzWldkSUVqVXFHQkNXSEpkTHdrTzJKWFAx?=
 =?utf-8?B?QnhEMHNkRmFUQUUwY1Z0WEVXYm54VnRraHUyZkc5QjNtR0lyOStJL0Jyai96?=
 =?utf-8?B?NE9jTng3bEVEYTZMTlhESnY3SU5qRkkrditHcHd5eGhYTGNsVVhOYXJ0eFlk?=
 =?utf-8?B?M29Wb2I4amdRNHhFUGljaExHelBkczZ3S3ViT1ZudnB6K3B3YTdLN05RQitw?=
 =?utf-8?B?RkRCM3BHUjhwVW1kNnphVHo5ZzVCL21ZVFJRSTdEeDhpcmNNQUJPdUx0ZjFK?=
 =?utf-8?B?WUxjcVBCMXIzcmEwNzJTYUo4MGZFYlZwT0JCWU02cDF4S2ppalF5Q0NjOFVi?=
 =?utf-8?B?dVNSWnVmNis0RTF0V3ZQR0I3UHgvOVRJZW1LTXVQaVNHNjl1ckNKK21RUWJL?=
 =?utf-8?B?ZnJDcjk2UkxodCszOXJIalJWa0dSd0gya0Z3bHZ6cUhPZmcwK3kyeW56bXQ1?=
 =?utf-8?B?RVE1SDJBc3hBbmNRcVV1eU0zUFVUenhONVJpbno0ZWN1ZXNoZlhwNXNiUXl3?=
 =?utf-8?B?c2ZSNFAwSGNaamxXQ2NrcUZudlpIZjlYUUZmdnNMYmcxZmpyLzF2THhmYUZk?=
 =?utf-8?B?U2E3eEFxUVpIRG1LaEZGR3pQUE5VR2tUNkY3akJ0Y1VxQlpRTzhSNGZiOGFU?=
 =?utf-8?B?SXBYYmwyQkR6VDdSblFMS2J6MTRiSjBONjhLbmQ0N2FZcWU5UlVEaXYrQWht?=
 =?utf-8?B?OW8wWFJVUi85anlOQjZPVytlTWtaUUhtWWUzNURIdzZqNUQwc3hnMFZYRkdS?=
 =?utf-8?B?T0lmWVNEdml5QVZPcGk4TDNpaHNZMHlybFlWVVd5OUJ2YTlBY0lvQjdPOFhU?=
 =?utf-8?B?d0dSMjJuWEVQMlEwVXNXbEVpbFpHT081ZlhlK2JmdjFGNWFYYmdkQWlnd3BL?=
 =?utf-8?B?VWZZbkYxT3NnbzU0Y0lvVzBGaEwvVitKeVU5NDRVaTUzT2t2WUJLdWJ0ZG1y?=
 =?utf-8?B?enRRRHpWK0xxQzlta3FhcTkrUFI4cWN2aWxndDZlNUE4cHEyU0lEUTRwWmhh?=
 =?utf-8?B?YTArRnRGZ0R2OXNnRTNKTDYrbUdzOU9GYjNLUGlKeCttSC8zRHY2UDMxaXVq?=
 =?utf-8?B?dlFEUDR4ODh2ZkZMOUFSVnI3Qy9DRENadlp4TC82RmJPMnZmR2JONVFIc0po?=
 =?utf-8?B?UEhiU2thRTVNY2NNYnZMYmVDWTBXQnV4dk5YT01VMFhhSk0rR0dJeG1QbXli?=
 =?utf-8?B?VjJ4aVBpanRmbEwvOXEzbzR2UXM4Q0VtVnJ6SkhxNEV0OUR0c2JSRmxQZU4v?=
 =?utf-8?B?MEovRjNoRjk3WWtPeHMxd3JmcE5HY3hwcUNnbmRzWXNKNUpOVzF1ZlJvdENl?=
 =?utf-8?B?M2t3bk5GK2YwMFhIVkE1N2djYis5eGIwUE83NjhwRlBkMG1HWi9Fdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: daf56747-7213-4d07-3a92-08df34086a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 08:58:05.6316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xu/gzsONsV0DqTXkujNRd0x16myRTdYWhgFqTuwrytViptOgOnu+SgP+CXZ1yM8AiCuy3jMp1v+fL7UIcaI3iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR02MB11994

SGkgQW5kaSwgUGV0ZXIsIE1hdHQsIEplcmVteSwNCg0KPiAtIFtIaWdoXSBUaGUgc3RvcmUtc2lk
ZSBndWFyZCBhZ2FpbnN0IGFkYXB0ZXJzIGJlaW5nIGRlbGV0ZWQgZG9lcyBub3QNCj4gICBjbG9z
ZSB0aGUgcmFjZSBpdCBjbGFpbXMgdG8gY2xvc2UuDQoNCj4gLSBbSGlnaF0gbWN0cF9pMmNfcmVt
b3ZlKCkgcnVucyBtY3RwX2kyY19yZW1vdmVfc3lzZnNfYWxsKCkgd2hpbGUgdGhlDQo+ICAgY2xp
ZW50IGlzIHN0aWxsIG9uIGRyaXZlcl9jbGllbnRzLg0KDQo+IC0gW01lZGl1bV0gbWN0cF9pMmNf
cHJvYmUoKSBub3cgcmVsZWFzZXMgZHJpdmVyX2NsaWVudHNfbG9jayBhZnRlcg0KPiAgIGxpc3Rf
YWRkKCkgYW5kIGJlZm9yZSBpMmNfZm9yX2VhY2hfZGV2KG1jbGksLi4uDQoNCj4gLSBbTWVkaXVt
XSBUaGUgbmV3IEFCSSBsaXZlcyBvbiBpMmMgYWRhcHRlciBkZXZpY2VzLCB3aGljaCB0aGUgSTJD
IGNvcmUNCj4gICBvd25zLCBidXQgdGhlIG1jdHAtaTJjIGRyaXZlciBhdHRhY2hlcyBpdCB3aXRo
IHN5c2ZzX3VwZGF0ZV9ncm91cCgpIG9uLi4uDQoNClRoZXNlIHJhY2VzIGNvbWUgYmFjayB0byB0
aGUgbGFzdCBwb2ludDogbWN0cC1pMmMgYm9sdHMgdGhlIGF0dHJpYnV0ZQ0Kb250byBhZGFwdGVy
cyB0aGUgaTJjIGNvcmUgb3ducy4gQmVmb3JlIEkgcmVzcGluIEknZCBsaWtlIHRvIGNoZWNrIHdo
aWNoDQp3YXkgdG8gZ28uDQoNCkkgY2FuIGtlZXAgaXQgaW4gbWN0cC1pMmMgYW5kIGZpeCB0aGUg
cmFjZXMgdGhlcmUsIG1vc3RseSBieSByZW9yZGVyaW5nDQpub3RpZnlfZGVsKCkgYW5kIHJlbW92
ZSgpLCBhbmQgYWRkaW5nIHRoZSBhdHRyaWJ1dGVzIGFmdGVyIHRoZSBwcm9iZQ0Kd2FsayBzbyBp
dCBjYW4gaG9sZCBkcml2ZXJfY2xpZW50c19sb2NrIGFnYWluLiBUaGF0IHdvcmtzLCBidXQgaXQn
cyBtb3JlDQpib29ra2VlcGluZyBhbmQgdGhlcmUncyBzdGlsbCBubyB1ZXZlbnQgZm9yIHRoZSBh
dHRyaWJ1dGUuDQoNClRoZSBvdGhlciBvcHRpb24gaXMgdG8gZGVjbGFyZSBpdCBvbiBpMmNfYWRh
cHRlcl90eXBlIGluIHRoZSBjb3JlIGFuZA0KaGF2ZSBtY3RwLWkyYyByZWdpc3RlciB0aGUgc2hv
dy9zdG9yZSBjYWxsYmFja3MuIFRoYXQncyBjbGVhbmVyLCB0aGUNCmRyaXZlciBjb3JlIGhhbmRs
ZXMgdGhlIGxpZmV0aW1lIGFuZCBtb3N0IG9mIHRoZSByYWNlcyBnbyBhd2F5LCBidXQgaXQNCmFk
ZHMgYW4gaTJjIEFQSSB3aXRoIG1jdHAtaTJjIGFzIGl0cyBvbmx5IHVzZXIuDQoNCkkgcHJlZmVy
IHRvIGtlZXAgaXQgaW4gbWN0cC1pMmMsIGJ1dCBoYXBweSB0byBnbyBlaXRoZXIgd2F5Lg0KDQo+
IC0gW0hpZ2hdIFdoZW4gbWN0cF9yZWdpc3Rlcl9uZXRkZXYoKSBmYWlscywgbWN0cF9pMmNfYWRk
X25ldGRldigpDQo+ICAgKGRyaXZlcnMvbmV0L21jdHAvbWN0cC1pMmMuYykgbm93IGFsd2F5cyBz
ZXRzIGBtaWRldiA9IE5VTExgLCBzbyB0aGUuLi4NCg0KPiAtIFtNZWRpdW1dIEluIHRoZSBiYXNl
bGluZSwgbWN0cF9pMmNfYWRkX25ldGRldigpIGhhcyBhIHJlYWwgZG91YmxlDQo+ICAgdGVhcmRv
d24uDQoNClRoaXMgaXMgdGhlIGtub3duIGRvdWJsZSBmcmVlLCB0cmFja2VkIGluIGEgc2VwYXJh
dGUgcGF0Y2ggb24gbmV0LCBhbmQNCnYzIGRyb3BzIHRoZSBtaWRldiA9IE5VTEwgY2hhbmdlOg0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjYxMDI3MDUzNzE1LjE2MjMwODctMS1r
ZW5ueV9oc2llaEBqYWJpbC5jb20vDQoNCj4gLSBbTWVkaXVtXSBUaGUgbmV3IEFCSSBkb2N1bWVu
dCBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLQ0KPiAgIGJ1cy1pMmMtZGV2aWNlcy1t
Y3RwIHNheXMgIlRoZSBhdHRyaWJ1dGUgYXBwZWFycyBvbmx5IG9uIG11eCBjaGlsZC4uLg0KDQo+
IC0gW01lZGl1bV0gbWN0cF9pMmNfbmV3X2NsaWVudCgpIG5vdyBjYWxscyBgd3JpdGVfcG5ldCgm
bWNsaS0+bmV0LA0KPiAgIGdldF9uZXQoY3VycmVudC0+bnNwcm94eS0+bmV0X25zKSlgIGJlZm9y
ZSBpMmNfc2xhdmVfcmVnaXN0ZXIoKS4NCg0KPiAtIFtMb3ddIFRoZSBjb21taXQgbWVzc2FnZSBz
YXlzICJhIHJlYmluZCByZWF0dGFjaGVzIGl0IHJlYWRpbmcgMCIuDQoNCj4gLSBbTG93XSBUaGUg
Y29tbWl0IG1lc3NhZ2UgZ2l2ZXMgImFuIGFkYXB0ZXIgdGhhdCB0aGUgZGV2aWNldHJlZSBjYW5u
b3QNCj4gICBkZXNjcmliZSBhdCBhbGwsIHN1Y2ggYXMgYSBVU0ItYXR0YWNoZWQgb25lIiBhcyBh
IHVzZSBjYXNlLg0KDQpXaWxsIGZpeCBhbGwgZm91ciBpbiB2My4NCg0KPiAtIFtNZWRpdW1dIFdy
aXRpbmcgMCB0byBtY3RwX2NvbnRyb2xsZXIgcmVtb3ZlcyBhIGNoYW5uZWwncyBuZXRkZXYNCj4g
ICB0aHJvdWdoIG1jdHBfaTJjX3JlbW92ZV9uZXRkZXYoKSAtPiBtY3RwX2kyY191bnJlZ2lzdGVy
KCkgLT4uLi4NCg0KVGhlIHNlbCByZXNlbGVjdGlvbiBvbiByZW1vdmFsIGlzbid0IG5ldywgcmVt
b3ZpbmcgYSBtdXggYWRhcHRlciBhbHJlYWR5DQpnb2VzIGRvd24gdGhhdCBwYXRoLiBJJ2QgcmF0
aGVyIGxlYXZlIHRoYXQgZm9yIGEgc2VwYXJhdGUgcGF0Y2ggYW5kIGp1c3QNCmZpeCB0aGUgQUJJ
IHdvcmRpbmcgaGVyZS4NCg0KcHctYm90OiBjcg0K
