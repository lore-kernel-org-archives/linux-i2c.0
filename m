Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793596634;
	b=vBdRbXWV4c8ifZqQ2vftk3OSr9IPW82+ZKIKrb1FuRWhT90VgR5mPbFJkgdTbczDn8jr
	 YOpY235IvXXucSuxO6WFHwUoYpI2nr3Gdu3qU3b7oAFvnN/GMyAWu75V0AmgrVrl+6vuN
	 E41tcSzXpchjwxN/dJyEwzpP4ZkAIynbCjr0uCFbydjq5AYTJel/ppGq0GFXg4NMaQX5P
	 R7wkMNY7TEespFfD8gUH3b7qLflbLGrLXzNjVYVpMVALpl4XsyPT+kekNwC2lEibSk5AI
	 DrCike5QIIZ4ITOHMoQmbEEU/zKBRC1Dw0Eq3g2kXdPQom+ZNmlo7VIx6P6XbTq00IQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793596634;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sL9+bcqPmE2PVv6KmGE4dLL9KjUANbOKJy8nIfvRR3U=;
	b=Cwoxupinf6DxSXuQVU/lADIc656VEnc/5wXWRO0t0SFjEJ6G1lIJIG05mNsDBQ+J2E8N
	 GDoV+lmWxb7BuXUeCQsQS5bLJyDsLbHYtEbQ2erqT9WymIO+fl4fCGtKVhrQnUOO3kSy6
	 kHh6uyhrDtr4nemxHadbn1EpiBPamvUKZa0G1uDLVuAtz3w3KyZHVJxtAF2UmtYZrGJ/x
	 iSYmNIiqzUiQudvqHXZxcaS4MTbylowhzgDYPzXxs3j65/1RbG5F1ySyU7I5HNYGxaVGV
	 SZ+UpdXfHmXmcZLoBEUBPxkwrrHLxiuPQF8Y2Wqo4JCkcgQhODW8M9YEBVuk0NriF1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=V0+oPE6K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.72
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022072.outbound.protection.outlook.com [40.107.75.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1ED606A326;
	Mon,  2 Nov 2026 05:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB1ED606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=V0+oPE6K
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grUTM0BKWqE58avjvAfHy9LbxaUZEyjPKdjNgzRjHGKPpIomix65s7U4Jt+Low7FQeuO5rCJRhnWUuIzmiOE0oiSPabCSxpaViFsaZsCiVUkW0mbcpVKrev+Rxu53pQ/L0U5Kki/VdziRdaxpFFvsoDuUcPlJxZXDObI17ar+R/5fEv/LOFvCdhDyizRHJYTttjOkXK/KGyiKf8EgfpkYVgKlxEaCsAG1A9BKfQ6AXquapr9sZ8VEvy7wglmE8DDQhvi5i1uwgrMCqeYwL02/NbaeqtMXbpk74gQ4ceAdD4lez2dApjGLsvnwiDgWCXi2umihaqlkVoALPrEkOqBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL9+bcqPmE2PVv6KmGE4dLL9KjUANbOKJy8nIfvRR3U=;
 b=ZuYOct/SvYzVZgBPzRzlibGSUaJ46lao3mgwCtnjyKDGC6wj2MKTfayhJMHXMSvt+8NWzaFHFcsBp6cGvaPSLb7jIqziwR8Wd0tdDdEztstZ/xaW4PJ427nAnLxWj2SWWdhp/3rK7jT4F7LsGcMsSXPDdtGevdhKtuTk0ueAba9aYdt3yPz8Oe7boE3fEmZKFIYwR0o7xkF0s9LQs1u4wHY38ZJZuZUpv4nq3N+k7DOL0FIB5bl8l0FeImVFGo2ttsip50AbS+1B5BvchWWnG5E1CBMlpEUHMz+pAt9kbI+OJcamAUZQYVSpHEW5LCQxzAWwoqZC8aFzVKZL1GsLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL9+bcqPmE2PVv6KmGE4dLL9KjUANbOKJy8nIfvRR3U=;
 b=V0+oPE6KOe7Omr4xEW8RXpJ/ed9U3dU3ZCDxWW/NPEPKimh/HVQ+bi8cMvnguNHG3QmBfzaSWiXS+NduqK/1paG3CDcStPEbxz3XyYaneMZTnaXmNQaH2WYsCKho8dU8MY3lDQrPrOidKqforLMKUaxCldQRb2phDfHar7L+h3umlkow4H/sWbKiQFZX8X0k2DRTAx65/crktMV3bgQcReIxD3IoQ00UUJmuiQm584ekTe1m1vvB5JFWVFTKnaIYiJTmLQ3LG2qeW3I7vaIQGSJmG6kg6jGQlGlwHo6mQWzRf/fIFm85zJB6IOjHcX2dMjTMnkkbzFPO6YQeNsoqdg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB6604.apcprd03.prod.outlook.com (2603:1096:101:84::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:17:11 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%7]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 05:17:10 +0000
Message-ID: <9a654737-fa21-4c6c-878e-7a4d69e65b70@amlogic.com>
Date: Mon, 2 Nov 2026 13:17:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] i2c: amlogic: Add Amlogic A9 I2C controller driver
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>,
 Junyi Zhao <junyi.zhao@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20261029-a9-i2c-v3-2-7b30ccc00533@amlogic.com>
 <fa1813ed-c908-47f8-8176-24b8fb5acfd7@web.de>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <fa1813ed-c908-47f8-8176-24b8fb5acfd7@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0039.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::13) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4dda50-3d4b-4fa6-f1a2-08df38a08c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|4143699003|56012099006|261009223027099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	StWNJGePTOCSMZ6VSSz4VHH2k4nVzwVA8OitMA/e6w1qMO0nLmJz+mB/YG/nC9rK3YLZ2jvkwX6FqIMzYlELVBkMdgX1YV2IuzuKcnkHVMtvpJFcgNf7wOgp3dN5n/EQ4mJSXq8bC3Brn0309822WlBhyRpWCKzmqE+XT5S0PYXZISW6Rvtnbc3DgINq8BsYsJLIIQzBI4M+jzKbShVfvr/w8vQT0xCP2iiRkaWtSY9abrRoe0ll4NTvtbWcV0sVDnXO3/JdJ93RGfKjV68C31jB5wH5PgepUv3B7bFuL6ONa+nHHhvxlVk/A5jLR4I6yt8Z5rHCXtc1tXO3GtlLWC9EdJG76XN/SPie6IZcg8iughO93wUdKcl9EMj37zW9upA2ngg1SBhLbMZR9kkbgWSTH46YRkXNCdT8b53SFbRvQDerI17UOp2aOy361H/tofcKM8DwsNfpRtwo0VNJFRG+PtVWwZHJK54uQWZBtVGhkgRT663IHu7fQxxkMvSRkB1rq3R9KTK6ympyz9JHx9sS1/qjc+mcUALwKdVL9uX5+pzFSASwWw1Ldq0rRA5aLXgGyo0iJsNXx7pv+Ls25t8DI4KaQLeoKcWdB4ti1t/dgJXbIDt3PvAdyQ7XjYi5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1Rqc3ZkMzkva1dtSWRPOGNuc2hrUUJhTU94aEI4SlBkVzVkc3crbi8yN1lW?=
 =?utf-8?B?V0lHeUZJNFdFeHh0NVBQMWZISFNWUFBKVTlqNHhyQ2FUdkVtajdsemwxRDRW?=
 =?utf-8?B?UVlzOFo0YnMvYWNrUGNTcE1JZjlSbnI2blJkZ0hLN2gxbW1QUktXZkw3T1Ir?=
 =?utf-8?B?aGV3NXppNWVnTlZnYTZqY3M4ZndVZVpwUEZTaHk3bVUyRXZUMXIwSGhWdVZZ?=
 =?utf-8?B?cFhIVlNlNldYQ21rK3hGZGxFb05CWWljZGVENXgyR0ZWenZMWS9wcjJJQUxl?=
 =?utf-8?B?d1Zac3FZb01EckVDT0M5RmE0eTIwK2FUNjZnSFJLT2FSMzJiV3V6cTFHVENs?=
 =?utf-8?B?RjNocDFhdGRCWDRZWkN5QUxuZXZIUklHWVB6TnVjVUViMGZKcUpjYkJkeEFT?=
 =?utf-8?B?TWl0bjdHcGpTQVRDSEdvVmVQbjJ5TnJqWVdNME14MGNacGNtNzlJYy9MVXlz?=
 =?utf-8?B?RHZPY0JQWG1JYklXMm5FLzNnbHhtRHlVVkpQYXg4cTUwUkJHampQcUNEbjBS?=
 =?utf-8?B?SFpyVzNxbnJyb3B5azFQcjljdXJFTDhKaUYvVnBkQ1VydzVTcFIzOFZhL1R6?=
 =?utf-8?B?UVgrMXBQdTJCeVNqcmVOVHZXKzIzTHI1Vnh1cmdqNG02Mnc5KzJiYXlGSTVO?=
 =?utf-8?B?R0MwUDM2bjMrZ05YSDdEUGtqUW5jSWgrTTdoTXd0SzB4cjZ6RXM2bGFoMDJa?=
 =?utf-8?B?K1I0cW9BU3ZyUHVWb1RXVWU3ZXpuVk1xT2dBSm5maTdpUmJTR2ZKOFBEdm5M?=
 =?utf-8?B?dy9adnlJVDdsU0cyaGRIWmsxS3g2Q2MwQUc4Z0VJNlZ2bWJnTmp5WFdtQjQx?=
 =?utf-8?B?WDRQckprcWhiZStsMTdOV2o5RzgwODI0MjZQeFlWTXFtNktaVU5BaDdyYS9X?=
 =?utf-8?B?RjJlVlFqMEVGNGl3VlJJZ1dsNGx2ZGYzTzNzZVZPUEZMUnRWN2xZNWllcGh1?=
 =?utf-8?B?RGtwS3pBWWw5K2Y2YkE3ZUE4YUNCU1hWZ0lpQ3ZhRm1RRGRKWG5SeVZDVVJn?=
 =?utf-8?B?L0FMRzNGbkhFdFdHOUlZZ2JFZjFWaG90MDBXTVhqbHZPdElTekV4a3duNWpK?=
 =?utf-8?B?RUh0S2VNWHJObVF3OTdQYlVZcHkrRDFSWW50MEdscWRiaHNEREJ1bEF2OEpr?=
 =?utf-8?B?bDhmQ1dUdmpUZCt6RGtLY1lxK0o0SjNBS3VMT3lRRmhMeThjbjhNN254dk5r?=
 =?utf-8?B?bkcxdU9kVkFTNkRPTW10VjlYOHFSbThQL2FnN2gzZ1ZKalFXS1hYUkMyekdJ?=
 =?utf-8?B?MStYVy8rbVIxY2pENjQzQ1dKdnlWYUt1UFVHTzRXTng4Sk93SEhpazMrZFJj?=
 =?utf-8?B?US9HaHFISWpDWFg4VHVPMDVGMVZ3ZFROMVd1MFZIMGNrVUV4aGF2NHNNM0xG?=
 =?utf-8?B?YUNtSVVCanp1dFRHSWdsSDZFM0dEOUd6bnRHZzNCbk5tMW9teWQvSnR3djFv?=
 =?utf-8?B?dDZwUkZwcHl5M25ZRW4zVE9CT014Y29GWkFBQWhWdGc2eEQ3cEhRRWFkYkpv?=
 =?utf-8?B?QytGMyt5Wm9wK2czYlByWkdrWUxZd2dYL29yQ213OXhTVmFVSjAwSVc2K1VB?=
 =?utf-8?B?Q3YrVU5jbFhNZ2pVMkdWTDRYNUN4bmFCL1ExajNZWitwcWRNTzFwYUhjc3pZ?=
 =?utf-8?B?TWJjRE9zRW5QSDBnQzVycHhVNXJNcEZqOVJGeFVZSEIvc3A1V0Mza3hTMGta?=
 =?utf-8?B?ckR2dDVyQnNSRlg2UDBJYllIZkVTUW85MHQ0eHl4ekkxdGNVNjRoZTlhTEhh?=
 =?utf-8?B?NE83dVgyRkszbStXakxFTTBScUpKYlZZdjR1Ynkyayswd1Nyb3NYZ2hnbkxt?=
 =?utf-8?B?bURTbTc4QTVIUS9PSVVYZWpDN1BTYXdmOHB2OUdSYndNUVZyYVRPREtNZGdj?=
 =?utf-8?B?dkViSW9HaVhMcHZOQ09LVUIyQUNITExBRXNEWEo5UVFpZG0vcHVkT2hLL1pp?=
 =?utf-8?B?QmxweVltSlFoY081UVA4WDJxUVpHSkRLRlQ2NnRIc2FKWmhMekdJNG9jYmtD?=
 =?utf-8?B?YXh6RWtOSzR2UllBNGlrL0svSE13R1VqOS9wYWE1SkFsT2RxUmhuY01ZeG9u?=
 =?utf-8?B?RUI0MnhEWXVZbXhvMEU2SnJWYTN1V2FVVjlFZnZBcUgrYUhUOFY3Nk1VbzlI?=
 =?utf-8?B?Z29Dc29aZDBJcWN3MlMyc1N6NGU4SUxxMWhRZThDbmp5RTh0OGZ1azVWRVdK?=
 =?utf-8?B?WHpwcDB3NU5zd3UvUzdmcnAwbW9uQm1Nb3NJMWFLQlRyanFNRlZTcVR3cktz?=
 =?utf-8?B?RzNrMDZmRHRXVzZzY3c2RW1Ldmw2cnZOcUN6eFhtOW55ZnQxTXBIWjVVeEJK?=
 =?utf-8?B?SjVCZXArNlZKWU90eWlES3I4QVRLVXo5N0hTUnZHNXYyVFZBTE92UT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4dda50-3d4b-4fa6-f1a2-08df38a08c1b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:17:10.7873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JY5SIB2xanaXdceCR4FNtl81dotUwNWXRVoJUka5RmcFA1p87uYqvE8/WE06HWeG0ES/IcHg6QEpdWd3rxfiCVeHGx9caSdMQQ8OG1dkKBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6604

Hi Markus,
    Thanks for your advice.

On 2026/10/31 16:09, Markus Elfring wrote:
> …
>> +++ b/drivers/i2c/busses/i2c-amlogic-a9.c
>> @@ -0,0 +1,445 @@
> …
>> +static int aml_i2c_xfer_msg(struct aml_i2c *i2c, struct i2c_msg *msg, bool last)
>> +{
> …
>> +     if (!time_left) {
>> +             spin_lock_irqsave(&i2c->lock, flags);
>> +             i2c->state = A9_STATE_IDLE;
>> +             clear_irq_status(i2c, IRQ_ALL_MASK);
>> +             reset_fifo_pos(i2c);
>> +             spin_unlock_irqrestore(&i2c->lock, flags);
>> +             return -ETIMEDOUT;
>> +     }
> …
> 
> Under which circumstances would you become interested to apply a statement
> like “guard(spinlock_irqsave)(&i2c->lock);”?
> https://elixir.bootlin.com/linux/v7.3/source/include/linux/spinlock.h#L642-L645
> 

Will do.

> Regards,
> Markus
