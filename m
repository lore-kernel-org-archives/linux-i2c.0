Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023082.outbound.protection.outlook.com [40.107.162.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED923EA88;
	Fri, 13 Feb 2026 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000526; cv=fail; b=gsqYHMLH0QOMOvSRT0BnoErtpLsuIyCY3cuRHj7CWSTlRw/48x2WHA5XY6bGP04zEv6owah2jVCbaB76FCX2xCltbDYbVUChpI5piM0mofe/jPH3/eL5vNQJfmhc/UhC/4UVb7wKOP3hu5tTDVDl8eQ/pKzUMlfkGBwpa7rVKPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000526; c=relaxed/simple;
	bh=GMi76JmhtLAkpK8yhwIuBmpSsrtvAiP5hC63wUtnnKk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=StgaHgZxcmc/AxeGp2ZJT3PxyqvG0ykBtmOaam7QyKOQgJZIgtipyc0YS2TA1voqbZfBzRO80Vg+P98hLWhkU7f0TneBSIgAJBZAS2why1KqSlcvdNOClw8burKaKTWbnk3ZKGenzIITt+YmJNFO8VIP5h9GTLOHPgafxZWC4SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=FmztqHWS; arc=fail smtp.client-ip=40.107.162.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="FmztqHWS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnunC9fi10Bf3HlT3Mh/3qnLMhesoE/WMSiNxaMq5O3cnv+46bu7lfobPwXYXv9JbOczoCD5jMvA//DW2ENVWUfEYBHpba1+3Rzi0xkefeGarma1ySp0lo+c+rGs9J1k357I7IBq83+93ZaW6vQWmNR+8BKcd/wk1xJbF37kOSCnX3ughMpK07QqBc2tkbooKJX0MJJjMzoyAUXC51tMJKasctca0g1F40j9b/k6zcFi9aOhAzRNu1lhu2THMSG1LYnt/0cbHOS/3fGw0BcUfFSJe07aDHxOVPDnQdaSajvFoeZb5Sz5yT9m6tQaT+r8OFcCfNIXg+Q8VIiaYMp4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU5pQd7mg4anD0q1AbXwGa2vMGXu4qK7pzstp94rERM=;
 b=MZb2Uw68NW0gZdiWEAp1aao57sRfsCU4TcrH2iWKy5JunEmc2zA/lY4QGmKq6G+6sTlQMgNSZwd+r48Neu0tRhB0eOPdaFmwsZJtUIjVbzzJSaR78Un9Ov+RhNoAkYyR4xHGwjdtRiEMgfxow+Tix70tNZSI2GwWbrLJxwhUhsTWodRdZRbm1RRRNgRUAnXKP4DJkyuU2MroEoAK0Be0Rx14FOQxnhzKSD4aPBw2TOtt/LK4tnRU508ExKgh/IQR6MNKGWxGJmtGEcei+Fah3E6pC0BQPImnVjc14E0y8dHvewsaRIjTDWWq7GGLZKTJiET3nIyWAFj3mu9xp/Y93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU5pQd7mg4anD0q1AbXwGa2vMGXu4qK7pzstp94rERM=;
 b=FmztqHWSc9oiTVPTs2WBXrVWTlvS1VJPZn7zeqe/hsFAXBI0SgJ5gZt0vDnILkZeh6DBINbY1CHjq2Xo3dDh1ay1lGmnkYcleSRbxaVUHqe5LbyuXgvdxqbCTqTCE1mmSCKfNv4fHe5U9GNupxxvCGdRAAr77n36y4BOUkVa2tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by VI1PR02MB6318.eurprd02.prod.outlook.com (2603:10a6:800:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 16:35:19 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 16:35:19 +0000
Message-ID: <1f2863ea-6132-c5fe-e513-9d1203248a82@axentia.se>
Date: Fri, 13 Feb 2026 17:35:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 2/5] i2c: mux: add support for per channel bus
 frequency
Content-Language: en-US
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
 <20260213-i2c-mux-v5-2-fb2cbf9979b3@gmail.com>
 <ccd960bb-9dec-3a1b-cf3a-d22b4ccf4df9@axentia.se>
 <aY9LvwgTS50jLSCH@gmail.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <aY9LvwgTS50jLSCH@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0042.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:26f::9) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|VI1PR02MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a31eb9-d85b-4cb9-5195-08de6b1de060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzFPcTVmTndGaGJ3Mm5YV3lnTUVSSC8yQS9oMk5UcnpSdDZuS2tEQlBVbEhm?=
 =?utf-8?B?bE1aOE5ZbVNSSFJETXBhOFV2OEtENEZEUktaOWEvNWtDY2dUZXlybmZZc1M5?=
 =?utf-8?B?UWlOdXJra2NGRStmOUdKSzRnc00wcUFpSFBuWUhIRHZ6bGJLNkpYbFE2bkQv?=
 =?utf-8?B?OFhmYTZZbVk2eUNERjNXdWI2eXAwSzVWL01aL0sxeWdTeCtFTGxYV0J6V1lz?=
 =?utf-8?B?VEp2Nzl4UG03U1htSU5KOFZLYjBVbjk5c090WXB3cm5KM3AycjFGc2xFb2NW?=
 =?utf-8?B?WC8vczcycWVXaDNWR1BwWTRvU3FySFhOb0wzaXhMdjFVYVBUangwcDVEM1Bk?=
 =?utf-8?B?Rmd6MS83SUtkYkZiVWJZQ3dsQUdXZFFZVktFMFNJT2hPbXlnU0htTTRIanZ1?=
 =?utf-8?B?TFFDblhEemsxeGNrYTRHMTVXNHlmUDhYajlGZ010RFBVSWc0RWpDdzgvOVZM?=
 =?utf-8?B?Zml0bmVOM3pIeEk0akl6YkUvNU5EQnp5VnAyWVlaelgraTNycmlXMTB0VGpU?=
 =?utf-8?B?TDVIVmp5TmZYTy9jUlo1VVMrRjRsdklyaWwrNHhLR1VvMXpYRFVyckZpd1ps?=
 =?utf-8?B?cDdVVHFUbEpaRUk2MTBKRXc2NDNQY0cxTXJZMTZuL2c3UUxIMzZMakZTVjZK?=
 =?utf-8?B?NWszcHVkQ0g3RVNMVTQ0UEJ2S2NDQkl0U3N0UGJvQ3NNKzdPTGVySEFNUkdQ?=
 =?utf-8?B?Z0dFSGdJM092eW5LYXpLT1QwbVNJZXJZZGJKT2Z5TjZpOWNxV3l2UWxPNTVh?=
 =?utf-8?B?R2I3bDd2b1Z5ZDgwYW9YazBKQy84UDF6aXRvaVJoRVA1R0x3ci9TVDVDcDZo?=
 =?utf-8?B?QU53UmNESTFIc3RQZXN1cjdkVlBrdmNWaHpVOEd2TFNDeGlLazV6ZW5WL2Rj?=
 =?utf-8?B?UGlYSWFCRnQreFhlTzA1MXl1TUVLY21QUTlqRmFVM0VjMDJJU1hvMlFKeTlE?=
 =?utf-8?B?RTZnYkpQUXlOWGNIOTRzelA0akZRVWV4Uks1TXBTN1p6VDMwUU5heVJXYkw4?=
 =?utf-8?B?QkpvUlIwZ1R3dUZ5Zk9nSy8wMHN2OVdvcWh4NHYxMXJVVkFCd1E5aUNDWnZn?=
 =?utf-8?B?YlpJOUNLWUZBaVpYNFhYTVd2NzJtVjU1SU1nOFl5VCtvZCtYSXZjY2h1WkRB?=
 =?utf-8?B?VStFbmlMTzFpb0VKb21kQzZtTjN6emQxZ3RESDdIKzJ2QlUyTjhYZkU4aVhU?=
 =?utf-8?B?b2EvNXFVVkNZK1FGWDh1Y1JhbHJodG11djBiUkRRNG9iWE14RVo3THh2UzEz?=
 =?utf-8?B?OUJUYkZXQkpXcFVLdzQxTXl6dWZpaExQNUVMZ0pvaHh0M1M0a0dyRVVYZEZ0?=
 =?utf-8?B?Ym05RkpOZXNuZC84VzJFR1BDR0w1N0VWTTEreW1TWnIwSTczR2FYZG4yRU9j?=
 =?utf-8?B?Z2lNQjVFMm5Kb0VvOXRxTFYrTUxOZ2IreDg2WHNveGhLQklwS1hxVFU2Zm9j?=
 =?utf-8?B?Mkp4R2ZwSlQwdU5aYnhvdzlnQTFhNnprV1pKQlkxeERXTEh2VDZvZEJZVUFl?=
 =?utf-8?B?Z2hLUGVJUWN1Q0dzS0Z5cS9NSGlnS3FNQmxZRVExNkEyQ2pqeW1DeThnMnJr?=
 =?utf-8?B?UUNNMHdUQ1AzMkRma215WFRVNkhBSVVVZG9lcVYrMWpOODFnQndWYUpqSEdh?=
 =?utf-8?B?WE0vUFUvRzdEbjcwRlpDdUJlTHIyelRqaXA0U00welhidzdOaTNJRC9NZ2FN?=
 =?utf-8?B?NE9LZ256QzQ2ckdsNjJYSFVhYysxR3lWT1d2WmtLTkYrcmxmUG5IMzZ1aEoz?=
 =?utf-8?B?UTg2ZFNIRXhhUDk4U0h3OHZXazZ5UEVUeEhOblAwTVU3MkV0QndXanY0RElI?=
 =?utf-8?B?NFR0cnU0NlZsQmlnRWNOazJSbVZ4SW11NXc2SGhlTklTdm8wUVh5M0thbjAr?=
 =?utf-8?B?ZVl4V21XcmJpbFVYSU9IME1sSVgyQlQ4V0o0Vlg4Zy9rbzVuMzFPbjVjUzg5?=
 =?utf-8?B?U1ByUjZGMGo2MGdZSzBJVjAyUG1lcTVtTExlT0pnZEVQTWhDSHVWMUFPTGpH?=
 =?utf-8?B?T3BMVXpUWG5XNkMzbG5naUt3NkczV2FoZjEwc0Z5QmdURnZoS3IyOWdEaS9X?=
 =?utf-8?B?ajZoKzNPS3l3dFNBQXJCVXc2K0piZVZsQnZ4Y3BLbXI4ZmNmS2JzdGFQUUpC?=
 =?utf-8?Q?EkA0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnNhNkMyQlZrQnhLbkRmb3RleDZMWUg4bnh1dFI5V2xhSHFuTmkzc3dDeGN5?=
 =?utf-8?B?ZjhCelNoZWFhRTFhOWo5cWNoemxRQXJIdWZvMlVIQThFcnFJRURDZzJ5cmU4?=
 =?utf-8?B?VHBXV2ZGbkQyZ2pndEtmeG1abUVub21ES0lyMjdrc0dRQitoK21wQjE3K3o2?=
 =?utf-8?B?cWpNVy85Q3gzdlhySHJVUUZzalZnODFWak04N015MEdIQkkzcldSeHBwTlM1?=
 =?utf-8?B?Ni9pRUFwQzZQOW1OTmplZVFCb1RIM0hiRXU5dFNINTRmMktxSk9ZN2Z0eVpk?=
 =?utf-8?B?M3VCb05FVENKazFPVnJhMWs2aTZhdFEvMlB0MURad0d1eUZMMXZvWDkrWkl3?=
 =?utf-8?B?N3FheHJsL2Ixam43ODllbHN2bEtvMFExS2pzRGVuU3BLVkFra1JQWmJmUmpE?=
 =?utf-8?B?TGF0cUVDMkErbFhwOEdZY2JVZ1dPeFQyMlg4TmRNUWlyWFNrTjNkbEN6K0Nr?=
 =?utf-8?B?UEpQeWtzcWw1NDFRNG5TRGtudElXQno2QmxMQ3lzaEZpNXYxcHpqKy9xeUJr?=
 =?utf-8?B?ZDFSYWtRWHQrR0dHblBYUHhDU1F6WWdKS2plODdvL2h5d0s0blc3eVUzTVBV?=
 =?utf-8?B?bko3ZDlNbGV1WlE5NEtZMzBuZHJGRGRQRTV5RVd3emRBek96ZWdLbnhZN3Jx?=
 =?utf-8?B?WXlyOW9MMnphQnZDZXlBVHZVM0hDUWwrUWdKWGxITVBqT1VmME5BdGlnYnJC?=
 =?utf-8?B?T2x1SHZWaEt0REsvby9UTmFCa0RPQUJBbWtrMHFjUlNXUExaYmFPYXhDTjBT?=
 =?utf-8?B?MU5kaDRiNGJ3T2dhTm04cTF1Qk9rTThnTDNFcXp6V2NpZ2tIMU5FS3l6UHFu?=
 =?utf-8?B?TkkrSjBrREcvY3oySFNDTUVaM3ZKaWcrbjFXYkJld3R2T1hmL2dhdSt2dm9B?=
 =?utf-8?B?c3k5RnlDaklqS3dlWEZQVnYvSG5rN3U0WTBrK0lwNzF0Uk1JNmZXQW4rZlo4?=
 =?utf-8?B?cmFRWmZFNjV3d01rUmlndDdBa0RVdzNnTVRJTzB0SEtIeDEvTDhYTmozUjVu?=
 =?utf-8?B?U2hRYVZJT3pJcmtRSGllSldSVHNJRWMwdWZZR2N0ajhZNzI0ckdLZWhSNlM0?=
 =?utf-8?B?aTFxeFoySUYyMVBmZFNqQ3lMMGR6bzZ5b3BGSTB2Ylg3SnZUbXdJaVZ5Zm40?=
 =?utf-8?B?RklyVEZSYWhUeGZxTlV6VWJuSFkwbU9hbFJIa3NxZWx3TFNnWUFGdHM3ZnNl?=
 =?utf-8?B?RU9XOHBFM01xR2xLRjhoK1VtMW9NRU9rempCNjd4a040R1NLVlQ3bHVXRmRi?=
 =?utf-8?B?SHl2WmJYMFdiZm5TRHNsVGhhUHgzQmplZlBqUXEwbStUdjdsU3FyQXplclIr?=
 =?utf-8?B?dklwaDNmSHBmaSsrdnFOV2xhR3NZbFdDM29nSnNpVVo0NzNLN1I2eHlRQ083?=
 =?utf-8?B?dzF0bVFRZit3anFQTCtCUTJTTWM3djBFZU5qb0p3U2RZazg5WXRHSTU0QUpX?=
 =?utf-8?B?VmRneVdBSlhHaUZxUC9DSHArQkZ4MW5HS0lldkdpYVU5bThMa0hsN0d1aHZh?=
 =?utf-8?B?RlZKbFNJWnBXWnhCeWdabHVRRzNiY1lXeXFTRDdyZStua2E3ZldxQVVpQjBO?=
 =?utf-8?B?V2dmaTZkb3g0bGV3YkxDK1Nhdm5UdzRhUnVpa1NSUklyYmdra1daOCtzcll6?=
 =?utf-8?B?bW9LeDhMMVRjOEcrM1J3eUQyeE5VWkY0SktHWE1rQm1zbjBlWWRuZUhYN1Nv?=
 =?utf-8?B?eFd5YkVnNXJCUWp1VTBxdTRHTndSSnR5U1hBbStxM1l3VHQ1R0FIZXEybWJQ?=
 =?utf-8?B?WXNLMnltZkdNd3lyY2dVdjNjL0tuSHV0Vm9qNUhndmZ2TXN5UHVkWmttYmxa?=
 =?utf-8?B?ZzAxeVdVWmR2Rkk5V0JYQ2p5ZEc3N2pqZlNaUm1wUGxJN2dRZjF4cXZQYUlZ?=
 =?utf-8?B?aW5vVnFEVHRsRWFvR2xibEpIYUdIcHdoRzdHOWwrZnluc0N3KzhRdGNnbndr?=
 =?utf-8?B?N0xiN2tLYWZ6aFVSd1dRb1lkWHFSQ25RY0I1MGI5NStKYTNiSHp4a3pYVHVn?=
 =?utf-8?B?U0NnT25MNC9ZVVlpZU5BWFRva2hiNHgyQWpMWFFVZHVZWnl2MWw2Z1NYaUFI?=
 =?utf-8?B?WEkrcTdrRkpnTXkyL3lNMEZTenpwTTlQOGlDSGNxV01kQ0l3ZHhpdnd4eTJH?=
 =?utf-8?B?TndFbytVbm5ueUlmdnozUW5VUU5pWkFZZ1V4clBteTYzYmcvYlZJZDNjRmpR?=
 =?utf-8?B?MmFURmxlVU8rQllRS0d0ZW95dmJiLzJ2L0FvdUNxbkg5RktlSGFqR2F4aHJy?=
 =?utf-8?B?N3VpZk9PTmpGRS9ReHlRNlRMY2s1TERmSGxMTEs0MU9EMG1qM04zSDdQTEZR?=
 =?utf-8?Q?5mXrIMORTxE8VlHQkZ?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a31eb9-d85b-4cb9-5195-08de6b1de060
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 16:35:19.6845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pU9E9NG3J5PSTDw275jaZputpWIavHMFvh5KYTERiGpC7tooiYg4dn+mv4cms7r2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6318

Hi!

2026-02-13 at 17:05, Marcus Folkesson wrote:
> Hi Peter!
> 
> On Fri, Feb 13, 2026 at 12:48:13PM +0100, Peter Rosin wrote:
>> Hi!
>>
> 
> [...]
> 
>>> +	if (priv->adap.clock_hz && priv->adap.clock_hz != parent->clock_hz) {
>>> +		mux_locked_ancestor = i2c_mux_topmost_mux_locked(adap);
>>> +		root = i2c_root_adapter(&adap->dev);
>>> +
>>> +		/*
>>> +		 * If there's a mux-locked mux in our ancestry, lock the parent
>>> +		 * of the topmost one. Mux-locked muxes don't propagate locking
>>> +		 * to their parents, so we must explicitly acquire the lock above
>>> +		 * the highest mux-locked ancestor to reach the root adapter.
>>> +		 */
>>
>> As may be more apparent from my recent v4 response(?), this is not
>> what you want. You want mux_locked_ancestor to be the nearest
>> mux-locked ancestor.
> 
> Hrm, I think we are pointing at the same thing but naming it differently; M1 in this chain:
> Root - P1 - M1 - M2 - P2 - D1
> 
> I'm thinking 'topmost' means the one closest to the root (ancestor most
> far away), but I don't stick to that naming and I am happy to change it.

That fact that we both point to M1 is incidental. If you instead have

	Root - P1 - M0 - P0 - M1 - M2 - P2 - D1

you still want to "restart" locking from M1, not M0. I think.

Cheers,
Peter
