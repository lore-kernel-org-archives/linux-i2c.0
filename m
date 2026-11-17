Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.96
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794881799;
	b=VIAwUEIpJMSb45GhTT6xBtn/g/xP8uUnxMMgg0CHSevEY2n0PUVwmn2KCVQlbpRG67Ka
	 m67j+UjgAFiacxJdyu7U0Gyc+Jal3CAocxP5n+5AjGL/kLV5khQClQk7Drajmy2aWdyx+
	 UYV38aK8RIhPLadsB+AwU691kW4K/VOVs43lYxrlMRRf4byJ56h6c0+G4h7BzXR0R2YCO
	 gT50h989ykJp2lWLsKiNqkF0aB+L6oIRbLlDzEowmK4hbQmIfm4qhFgO3dgRHxpcpA0/K
	 mHdhzs8cCbubxL4Ll6NDZmBc9m5sDGc6EJXSXr9qO5qn/XFSCPAU1ZEuyCF1s6HvDlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881799;
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
	bh=oAVbl3wyxgAyxFAOIeKYasNczE+VOh/J9Jvh0vPQmKc=;
	b=C0CyZh2y5jCbWR1qsgxKfk/WK/HT59N6ZHZOV14NpBAcl/ukN8jhCj/25OO+SnImfdvu
	 ltgfsD1pwZSX/dnuuSJbouBBv1t8IDEKIxah9rIvYq9kgT99+F00ZM9Cr3ZZuHA+vcmE+
	 ZqxbobBXMwYjQ8iwX8kKVAu65XYHNRSeqtHvuYB5UKO0HJWeaX0GaTMPnHh1VJc52Ae13
	 c/Fg3fzLxuBuNcex2nrgNj4DiqBlneujmq+uR84J0/RbkR/xlQ+6OXEzKDVcJKcNNMzpr
	 J5FGh+pkuBpWPDSQq/Rt378Mr+hyoZVTa9mvVGDERx/g8EoPi/OefK6LQ1cZMGfY7YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=X1EAy2Ks;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.96
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023096.outbound.protection.outlook.com [52.101.127.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3E606A31C;
	Tue, 17 Nov 2026 02:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D3E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=X1EAy2Ks
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIvNXMmeQPl7Y7tTfbU+BFxY6T/is+2xKIuHvURx+cFCEM/zWrQAcNWR9XyV4JHBldI36GgZyo9bJ3K4yBo1rnRUwhwTAChkfbK+0ZYSYh17FeYDL7R2z9Yem1wxXFUxTXGeD1Uvjf7Z6t4ozT5QmV3akpjcmlmV4xyY7UGUYmIHHLhmGVl14oi1nG97uwkFKy/GfnoxhJXCnJFRDEohKAPtL3OLE6cuetPRrp8XXLoQZnMAckdk/rIxvjQFaEFSDBrWcUWLaEQxSkBggkfZ7yAZLftdytM+BzAJ94Rl5LCEJ6yTGyl495PMuwzigQF6yLWI/UXqmumUDSRkUCYAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAVbl3wyxgAyxFAOIeKYasNczE+VOh/J9Jvh0vPQmKc=;
 b=WNRmbje6sPM6r01TPm+OHGzGoW6gRm+8zfXpzvo//NdDAoWwbWZARvJY5RFm7mC/EhvNwm1pFXY3Mb4lBSg38ALDxNpdgyiaX3bkVU+Vgb6NK5VDQnMq+VXuAdlUzXswwErQPtQXgkDQZ4nQXeLgfut9VKq/q6bg+Z+se5oLOwH9dN2swk0x3GQUrLVCBvN2iW1y2ICEyQIswdDAC5k+lGCLIZFixFty1c3TactNUiM1S8Ue9hItNUIz2tNzk74Yj+hR2sUlcRbSE47aenkl+a0CYA+s5tJcrADG5vedMonuvI/5XLp6ZTA1+0LCxPfJfXZhDQM0iONb09bUa9zlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAVbl3wyxgAyxFAOIeKYasNczE+VOh/J9Jvh0vPQmKc=;
 b=X1EAy2Kspd0wmt1dJv+x3Ato/1uB2h/l+pQmk4ew9qiyM2SI0r8Z3RKZllq1YYk34QWm3AxpwN/kva8ppeYZNnk2SIL9GJLUntJoLR0HcnpVy3eWBS9zW9JvxpIiLN3X7NTNGvvwmnpErjIK5I7mJMzPFRDshB/3duxY2f93kijY3fR/9pxsFTIvy9m+Dpdes60a2CySYPMa13eMDbzKNtuLKx2Hcz2fJFctHtFKFt4QPa4C0l2E3rUcCnSx6jcoaOPi9EiXhrkG+RIiU4mhouHQCgBf+6UcAj3ElV9oyYtmn8NLjS/jL7JXGIVHRBCEUgjyYFHBs2w9CFs6JAtgHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TY1PPF48FFD4CF6.apcprd03.prod.outlook.com (2603:1096:408::a50) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 02:16:35 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%7]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 02:16:35 +0000
Message-ID: <e871777a-8b87-4434-a819-130443dcbf18@amlogic.com>
Date: Tue, 17 Nov 2026 10:16:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] i2c: amlogic: Add Amlogic A9 I2C controller driver
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>,
 Junyi Zhao <junyi.zhao@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20261110-a9-i2c-v8-2-1e9d2682f86b@amlogic.com>
 <c879e1a7-8e5e-4bde-9742-5384ffaa13fd@web.de>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <c879e1a7-8e5e-4bde-9742-5384ffaa13fd@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::12) To TYZPR03MB6896.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TY1PPF48FFD4CF6:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ca862c-1ae9-4be6-74f8-08df4450cd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|4143699003|11063799006|10067099003|261022075727099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	t+4mIbF1ucotANjb4vG1TgdJ0InVWRVMkdf0xlH4bAd/rNLb5p6OqibBOezbVyoZyGN9a0GxLS0t/AP9aHNjKy+dH80ODwsWdGd9KAn55Bp2Elml5afw0Y1W/2VhVVWSjfcK4UP/WQidpHi1wOsi4XViQdYclH+qUh+B8sOHicngJkreNE9OpzeXlyu2IrgMI2l3d4ie6Pvabfk57tD0Ln/iBfrKyphpo8jCcPYRF9z7FcZhTmtT+hCTJQukAWjjmyTAc+gYO24Dz1ruztT9ToEVhzGdF7Tu5P4+1jOFtW7q1W1ZUa9UqYrtda0LvlGdlH8BtlOOrXpXScI+f4LoD0p1a/IPom2TASmeNO+glb8EAKnyYrVz/D0OTjnGWvJsvdn0NNgAGczoPgXFOJhE5ZTHPT1iotaSYi6PzJTOL0nOrE/ZHD06WhIx+AcPWMjlyoq7CJqmvym4qxLXFdt0JfP85KaIZh71+FyqRcQ7Yv0Z0iijTKVl2iLg5VLqSDfSo42XBlD+nAHgRIbfvni5NGV7HtNZyhSp28lNqFs1nRSa7jMgr71UMTEPEXRWXeXFehlEAvMw6LlnOgmtjrQ2LUVc9WOFq4XRvbtGzt86+v89n6X45r9QWVs9u7W71PCf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(261022075727099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnF5R21rMThjc3RGV2hJbjUxNTdYdy9yZmsxbU15bFpVb2pKUThnQUJ3RERp?=
 =?utf-8?B?NldFRjY1Y0JYUmdCSktNK3o0WW1UUFZPblovcXg4S3pzbm9rR0htMVFLOG1B?=
 =?utf-8?B?Y2R2ZzdQb1BnK0FiU3dDaWFyRU9aaG9NbVVEcm5STnhDdmlpTE00UXpvaE9a?=
 =?utf-8?B?NXgzODJEak5tN3lDalVKdExHeG9LRnRXWi9RYWNYNnhCWDhodlB5ajlHUjEv?=
 =?utf-8?B?ZXNsaG8wZzBHcURxR1pjcUhPNG92Zlh4TzhoaTBlWWFRWXBiRmNWSXlPeUVM?=
 =?utf-8?B?S1UwdXBNS3pXejNVeUxVTVRvTUNIbEs0N2RWaU5VVElVV21oK0JmdUdRZmVC?=
 =?utf-8?B?NVRZamF6WjN6VEZEOFNUSGZ3OUZtY00rWWlXbUtCUHY4V0JBVWRSYzJEWUR6?=
 =?utf-8?B?cjlPVDQrZzJxejRka2s5c205YVUwZm9PL1dxTnZJZVF5TnRPMTZyVFhMZSsx?=
 =?utf-8?B?Q0RudHV2WUxTZGdYcHhHMElaT1ZkV3JLeTMvZnNuaHk5empoSGMvdzRNUStV?=
 =?utf-8?B?SGx6dEZUOXNkRWQ3M3kycTFOL0hWT2Z5S1RDQjIyMjEzV0I4NmdSUkV5dld1?=
 =?utf-8?B?eDBERHVwZjhNdDBaMEVTU2x3dkMxdVRxTVZ6VitCMVpZdjJJZ082czVVKzBz?=
 =?utf-8?B?YmJkWVNEaXpoZTFqVzVueDJFa1dLd2ZqM0JSMW5uWjdObFdaQjNCV3RGQlJl?=
 =?utf-8?B?dzFkN0xFRnhHb25DcDdUWlNLYUpVWjZmMmtlOGR4bmx4aVN6UnAwM2p0b1BQ?=
 =?utf-8?B?dldYRmlRKyt5NHcwOWJtRUhPYmE0NjVNVU01cmd3em5qRmx0UEJoS21jc0N3?=
 =?utf-8?B?bkVNMldxWCsxVlJHYk02WHBNK1V0bHExZDRYc0JIbm40NXR6K0NndnllUjdo?=
 =?utf-8?B?QllNZHZtZDlwNWdlOXBHTk1WWkNHbnZCOElBS0xTanYwblM1cXdBNWVOaWYx?=
 =?utf-8?B?eGhvVUtic1hWNFRmNzBKekZxQUxmTktoK25NUDZnbktWM29rS0dqa1h5V01C?=
 =?utf-8?B?Z0FNc2d4dzI1cU9GZFBZbWxKNmFoaTBDcUFqbVpWV3ptMmZkUWtKY2xPT25H?=
 =?utf-8?B?MElOSmtLYk9oN3g2V2dOWWJaQmwwcXJMVDhHVXl0aGMvM0ZEU2F5c0x2Mkcv?=
 =?utf-8?B?cEVuS1c1Wk9oM0UrQlcyVGFiU2dSWmtPL1puZUNCV3h1dTllQVBvMktpQk0y?=
 =?utf-8?B?TFZqOXFkeW5NVUp6NXNGRmlJQjFwT2VjVFhTN2I2bng5WHkvWThBMXR5Ty93?=
 =?utf-8?B?RTVISW5IdW1qVWVDZkFsL0J0RnlnN3lVb2xOV2dQZGViaUtXT1hoODh5MG83?=
 =?utf-8?B?ajZaWUZPbTJ2Rk5iWVplbm51Qjl0YnFZcmdPNDMwUkdMUTNhbjFzcnJGQWUx?=
 =?utf-8?B?YTJKY2RzSVJUWHhtSzdBUmNldHQrbWNBelhtYVpDU3VYRXRqVVNOUHlDVlFE?=
 =?utf-8?B?M3dGck9EZVVjTVUyWC85dmNUNnRVb25xbnBiWGI2aDAzR29qY29mTkt0a2VE?=
 =?utf-8?B?cjFkUjRCM2tsWFFMeEM1WllJbUdvalZLTGFYVnBKdG5PRlFmbHJ4WlhIVW8w?=
 =?utf-8?B?ODBXZkF6dzh0VXR0dUI1ZEZrOG5rZFZRZ3JmYmQyU0dSbHJwN2x0ak1jenBh?=
 =?utf-8?B?Q3hpeTJWOGk4bndBcmZ3R2VZT2c3K0pGcytBSnA3eWZwNHhDUjRjaTlCYkgz?=
 =?utf-8?B?M0taNWxmU083UGdnWlJxZEZIL2N3RzAzM1JIWEhVb2o2eWNnbVRUMmgvaDBn?=
 =?utf-8?B?L1N6dW9wLzRobUhDWE9OVlNZZnFJLzUzejd4VzJiZlVoU3F2T2JlbHdEbHhn?=
 =?utf-8?B?d0lOTkhLN1J0b1p3VGxHb2ExME9Rc0hMcW9MSlVYUVV6anNlQmFFZDlVTUtv?=
 =?utf-8?B?YWhpNnpmWW1MSXZSOURCcHpQVkl4Rmw0aDhOWmhYOHZuR2pQRUlNVTdFTXFZ?=
 =?utf-8?B?cDQvZDlpTUJnL3BLYnBuTGEzc20vYTloNDgreGFTaENkdmc2d2F4WDk0cytH?=
 =?utf-8?B?Z2E5b3Z6ZnRuNzRlUVk2MlRINHJVSHdFUnlhZFV2UythNzB1andXeFRRNFEx?=
 =?utf-8?B?OHRUMHJsRlhoY1ZUMDRMSEZpRnB4dWRDOGpYTTdzNXJGMTloRnNkK09TWUJr?=
 =?utf-8?B?R2ZRTk1rQmpGT1BrL0RJeFNvSEZVTlRMVnJ5cWNNdTBQb0haTFRSbU03amZK?=
 =?utf-8?B?bHc2aSs0Ylp0emQ3L3N5Qk83QmlsM3NYTmZUSFFOYXV5L0w5LzhQN2p2b29v?=
 =?utf-8?B?UTY1S2JwbGlPdWhZeGhlRzgxT24ydWlVTEVRM3B4dmlaZWtNU096bW50T0I5?=
 =?utf-8?B?UDRSMnNGN0N2bXpnYmZ6cTlsWHh3U0lFL2RoUnVNWHdGZG5RMzZqZz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ca862c-1ae9-4be6-74f8-08df4450cd91
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 02:16:34.9578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhK3WWt4xlSSdl7qDNwyjp6RL4nzC7DDZlS0Yg+Z2DfQXr912rRFNFWJryxhP1TT+tcRAgUEHYz0jMdBlZW4A24dSjH7XME29jFVz1iAelo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF48FFD4CF6

Hi Markus,
    Thanks for your review.

On 2026/11/14 17:10, Markus Elfring wrote:
> …
>> +++ b/drivers/i2c/busses/i2c-amlogic-a9.c
>> @@ -0,0 +1,430 @@
> …
>> +static irqreturn_t aml_i2c_irq(int irqno, void *dev_id)
>> +{
> …
>> +     spin_lock(&i2c->lock);
>> +     irq_state = readl(i2c->regs + REG_CFG_IRQ_STATE);
> …
>> +     clear_irq_status(i2c, IRQ_ALL_MASK);
>> +     spin_unlock(&i2c->lock);
>> +
>> +     return IRQ_HANDLED;
>> +}
> …
> 
> What did hinder you to avoid duplicate source code a bit more for such a function implementation?
> https://lore.kernel.org/linux-i2c/84565a50-0c52-45ff-b43a-3d30902690df@amlogic.com/
> 
> Can another lock guard become helpful here?

Indeed, Will use guard.
