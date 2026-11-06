Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793975440;
	b=Esb4st+otwJ27W3A8CvSVqC2PV6kwJX5exSYaMm5isylvLlGaQOHtKvEaU6DUSGdPeUN
	 b+anLYEDL3OEKXXDhVSW79NG3vlRPOyxkIahjbDeZrARo3+EtwRXuFlLXvTTwqGZS5Dkm
	 hF8KWla/3pAZB54GROTrfFb7h92YnQcpoTrgYnaJuqodnWxpGFJN2kUAhNN8mSCGiF5gm
	 3SyuvmbROtQeQDi0qHVh7gDz/lSr4fz4t+XFftZa2A13zHTe7B70mw7oL9Q2YV7jF4Fnd
	 KmE+3LChI42esDzd6WPZk+PRvp+c7FDfDLpz62at1EUT2v6jZoOX3YVdf14U/Oygpeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975440;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=Xt9Zhm9YHvvFC6bkV5iJVplR1XjWbz0EC8WE3hHHqOI=;
	b=XwJSkCyBsn6ORTlwnpxrl1y9wnWsHP8hWI8jdvo2vkd5GerBazeTPMzPmuZ5JBjPiuHE
	 91H4AAosO6oymMYt3C5YN105vJ00KnnubGQhG+7SfSFxfN+vzQdK/NkdMwHyIuWAtlJ8F
	 l2ZJQHNa+K/Q+I/Iq/2Wf7pBAr0zCegXzqw4gh1lFAxG/pCMRcC/dyxpK6ibvqFthNbMS
	 fotf7SagPuOH9Rfww4BeSBRk0zsv57i4gnMxzglNcJ5ar+UwFOt5RMxTqen+kgSTh0WM8
	 tXw+fg5jRoO+q1mxhFqKCLGO3C3Y1t1lGWcla8VTw5OI/Ztbr/ngWEQ4uCPym//ysRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HRVrY5cB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.49
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013049.outbound.protection.outlook.com [40.93.196.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C82606A326;
	Fri,  6 Nov 2026 14:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01C82606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HRVrY5cB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVEgnFPH/B8sU4nTAaPr0Qzz+MvFpLGnHMeX7kWZ23x8Kio2nnfWEWjgVP8FEJvkn/7ovThe+f0SOCL+4pVHzFXZi97Jl6FGPg0NBMlXitf5mOSXXQ8iO2CPQZ2Y0rFMe64j1JEhLa5UI+SdVH/cXyunjla98II1Z+ItpptkRzsG/pxlJ3jKnCjiVzgB5GcEUK4glC9mWQLBWGRTAhw9r2VhXywalBW6arUEhRZcn3VnrXVbsG3CGORouOWBNuXOeLNJjwfAa25RNOus+VlBysXrVyHTPku75rDbkvUHHuekuv+C1x+qFGmYh0ZzaAIvK0Z39PwLAvPt5S5vsSscOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt9Zhm9YHvvFC6bkV5iJVplR1XjWbz0EC8WE3hHHqOI=;
 b=fTj3VZhnetpmpit22JZjkBp3FYAdDpITe/vVb5L+kAAAVvuxJ8FM9p1DXgHBfLDc5ZjwNqtnLoNOjEHriiVvONNAPY/GSC6+/U33d2iWRLeJz/JWBhhFEhnU3Begn4GA6uLVYDpGYMb6K3mFcqVp1VXfnp3I4yQ6DecPbJ2Dh+Ga90Q/wJO/aSPfLbdJZ70CweXvsiwLMO4O0kgS8QpTDkme3r1f8ckHBHdzDVzhjpVu1u0J0Nsl77woKl7Q3NSArYToyk5fHtraIkmV4CTHdy/zzmhNjxQsTc5jpO7gC/WbWCPkFtmJJbV5jn+5+2dSdeAS5Amaf52m9/I54V8ytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt9Zhm9YHvvFC6bkV5iJVplR1XjWbz0EC8WE3hHHqOI=;
 b=HRVrY5cBGM5LlAXgDPGtXNBvgD/xmCP6HangZ1xqXnxNHYO0H4vBbIc1ur+A5C0shf+aPLoWZ/BCUjh2CXS6dRgGMGMFTxoyjxZYV7VCzh3mY6Afb4P6bQYoB+ZMyWUOlbK5rnfjpnj3YJC2r3VlXqF/vk8tLWGwpfvtpM7sK1U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 14:30:36 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 14:30:36 +0000
Message-ID: <092f0494-97ae-445c-be55-67e761cedbd8@amd.com>
Date: Fri, 6 Nov 2026 15:30:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] i2c: i2c-xiic: fix clearing of bnb irq and
 waiting/ clearing while atomic
To: Thilo Zirnstein <thi.zirnstein@gmail.com>, andi.shyti@kernel.org,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261102093228.2751576-1-thi.zirnstein@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261102093228.2751576-1-thi.zirnstein@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
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
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: cb32ada5-cd5d-4300-0906-08df3c1285c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261026140227099003|11063799006|56012099006|261026121527099003|261009223327099003|261022105027099003|261009223027099003|261021121427099003|261102123227099003|261009221727099003|261009220027099003|261009221227099003|261021123027099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1JPj/tgxshCFd2MArgcCvbAgxB9GPOf8Jc0zLG3CKmcvZSHF0tLCeL/aHcYXIFfq1Ta5YHJ9X4PzicyPS5K/WeLarQy4bLATQ5wAhAxr0CUAmBTYuqEKZawWH4wHJU+VfPr5K4pq3L2BbFabWZleuTxEsj/WllYAifPVzpe5F7F8vs/v4fRy1W0fjA6kxsXjZfnPSJgEpckbuw+2Qi8TyKoBdo4S99MwHYtHE8cbIoGG3NDkJKuS7CMaGiiiqbqjD8yJICfLghx99Q6fJQnUQN21WtqFirOJh2Ph+cecGr2OC+kdhq7gFb7h5a+b2E22dCeQainXIEsihBeUgJqBDszubgHpJbnO8weXgw25A0ceV8RiIxERoulw5dvvaAv5WPBUBATEZzrQOvQ5m1Vqg1Yg6ExztgfDbNbucGSNQx2fyX+Aevpjf+HO9EH8JvVuZdbUfunWYgpkek61xoQY3AxISJ84KvRXlmFU55JqDrlLeIgz8E+oHNLWiyWMb3SlVhjuGprUZ1/aSh8D/AxJLzodyQjZ0/JG/crGNnXGa0BJ+ZL8xTyb3aK/M4/O9IZJ7nL7+q4fIvVPrPLQZIsE8z0J+Dc6lRCfVo8F45kRRZ6oLR9PCINZ7n/lcJHFHD0fy5jK5F1Ol1wywhUODnUy3nkzMKKWRPIdBRV+AQdAPng=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261009223327099003)(261022105027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261009221727099003)(261009220027099003)(261009221227099003)(261021123027099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTdPeVV5T01JK0t1N3VaeTZlWUlQaDdWWkdEbnVDbEpUMjdvZm5PWEcxQ0ho?=
 =?utf-8?B?ZGFIMDhwUFdyME5WLzRQdTdnNVJzdjY4N1FOSzkxa3BjcldPaXhqZzBwdGZF?=
 =?utf-8?B?MDU4cWdwckNIQW5BcXdValJQTUhHR2EzS3h2VUljeEJkdnBEMUhKeUkweFhD?=
 =?utf-8?B?L3VQVDFHNlVCWGwvaytNNDNiTm9BVmxZelJqZUtpQWdvTmJIYUwxVFpZS0xO?=
 =?utf-8?B?WlVzVnBhem9wM2J2OFZhbUxOcHhIVElIaHE3RGJMajZUVW9XT3pQZ2hFUWwx?=
 =?utf-8?B?UTlHNFZRRU90WVhVS3JoUUVxMkQxakR3NFZwQ0tPWXlPQnQrT2N6bHBSTElZ?=
 =?utf-8?B?aGJwMTBOeHJQWW85aWNxME9ZUjY1Q3NCTHM0K2h2MFlrdUc0R3FyVEpSVnVh?=
 =?utf-8?B?OEpKRTZBNHlrMGJHV0cvM2Nscm5BZmhuYWRNbjF6Q1l3TlduUFh1TVBjTWNo?=
 =?utf-8?B?ZHZKZzJyNndqcXBuMkI4eFFZYWRnR1RkeGJ3dWUvTjZ2bCsyKzhvWXNrd2dy?=
 =?utf-8?B?Z0JJeERBWVJmSk42aGZEY2FkeEVkbDNpTGJVeGpZblB4a3hLZkV0WWp0eTFl?=
 =?utf-8?B?eFRzWW1VNThSMGN5cXVOQ0M1WldiOUdNS3FrT0h3bG56RXFKSUlLYytMeVoz?=
 =?utf-8?B?VkRHd2x2Y1ZOTzBhdkI0T2FSNlBzdWxUOXQ1enovWHFETnVBb3FxNkVCekdM?=
 =?utf-8?B?KzhkRmRuQUlHRFlMczBWMUNXL05UTUF6S3BHTEJ0VE51YTJMVXNqczJaYUtI?=
 =?utf-8?B?VEpKZXJVWjUvR0VLRTFVRVlSZzBWK2NhTU1nVHgvU2dRTW9FWm1URkE0SllU?=
 =?utf-8?B?akNZUEdWNzdVUHhaVndRNC94RVZDc3BMRVU0MERvUSt0U2FDN3AyUWdkRXNt?=
 =?utf-8?B?eVUvajlXSXlVcDZrZlFJSldHNzJnQUZiMjBIem1xNUpHWkNrQnZuRjZnMUFM?=
 =?utf-8?B?UXhyY2hZeW1mVVF2ZGVaVmtGdXRMUHdTMkVuS2lOeWQrK0Z1OXR6bk5Gd3NW?=
 =?utf-8?B?QVBHMHYwWWJnZ1R6ZkdTUWpZMWRqSUs2L2xuUzdkQTRTcEVQSDhFQTNVNzdm?=
 =?utf-8?B?RytyNzRYUVVTNUQ0WWVIeHJ2K0k4dFBtZWdLaHl4VGdvbTY1cWgrT2pRRThS?=
 =?utf-8?B?OGRVajMzVjRTaGFIV0J1MVZ0aVBqb2kwYXRzMnFQN24wczRMbTkrak5ib3Qx?=
 =?utf-8?B?cUx0ZitiZlM1SGlPUGtIVE5LLzFoNmdNdCtza2U5RTlqTDdWbzY1UC9UYnpt?=
 =?utf-8?B?TnFjT1huenUyTGNPYU8vUFlIL0dLdjdZUUpPVlZuaWdkS016UjdsUXhhNW1R?=
 =?utf-8?B?K2RZNWlJdjlkYWQwbXN1aWF1aUdxN3FSeUgyVDc2NFprU2pPbHhQeTZWbitU?=
 =?utf-8?B?STNwT1BoNHV0b0QzUDdpZFl4UzUzN1BHWVhMQTE5cmJtSjVwUUgyaExlNUw0?=
 =?utf-8?B?K2YrYlNlRUdPN21YQjIrWHAyYkpranl6Y2xPWEkyZEtWcjJRdFNWOTdIMFB0?=
 =?utf-8?B?MDN6Y1B5QmdNb3o0aktTcUEvQUErQ1d5a1BXMytoRDhISW5BNGxmOCtEQ0RR?=
 =?utf-8?B?TXFoRUVSYW5JUkczVlU3SFY3QnFhQ2tEU1ViTVMvdmVlMk5Tc0RibzJtcXdw?=
 =?utf-8?B?MHY0MHJudUxhTmdQZHdxK2RkTG5NODhud3kwQkFIbFkyRXFKSkd0Nk8vVlhu?=
 =?utf-8?B?LzJYRmRUY2lEM0FGT0xkRDVtT1FjSmhNOTNPRXUwVzcxMDdQRXRndldoc00y?=
 =?utf-8?B?aDZJL1p0MG91NnZVdzFvVW5YYUpGcHhBWGpWUm5aYVlBb3FhblprbGltSVJV?=
 =?utf-8?B?N1VIakRPVTNsMkJaam13VUNobEhvaDdQZEJIMHl2YWt1bm1tWk5UWEpLYTVn?=
 =?utf-8?B?WlpScmNWOHB6YngycWpLTk9VTE51YkIvTVJ5U0tlc2pOVlJjMytGeEhLSWk0?=
 =?utf-8?B?N3NkUHhWeExqYTdUZS9sQy8vK2xlMld3SDJWVndQTTBNMFR4ejVyaklmZU5I?=
 =?utf-8?B?czdnYjVTUERMTmhDMnlqOHFGRlJSR1Jua1hRaUhyVEt1RngyWHQ1cmFpeld2?=
 =?utf-8?B?YnZKbVFYT3BGR2tMWVZGVmxsS3V4azJDQkkzUHJzTWpLMzhHMDBLYmQ2Y2xZ?=
 =?utf-8?B?UGZiK1gvSVNmMlo2MjRVdFFMTG9qbTYvUE1EZ2xyQmR6a3VZMW1UVlVucmRw?=
 =?utf-8?B?b25JTzRJMmsrYThlYitGUFNnd3hQOGMzL0ZCUm1tMm5ndlRoTTNmWFVJS3cr?=
 =?utf-8?B?aEZ3YkFrbnN1M1g3eWNkeE9LWHlZL3JDUUd4OG9FTTVHU28zMW5LaDBGMU50?=
 =?utf-8?B?MDB5MnJZRXArMGoyTldQcVVuVUNiMGZRSkVXc2hFYUJlQ1ZSeUp0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb32ada5-cd5d-4300-0906-08df3c1285c3
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 14:30:36.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vx0hVD7cScxCIRHHjxMAvMilAN3knp/IEYFPWM0F5h2kI/LtAkHcPa9ZxL8bR6iN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072

+Shubhrajyoti,

On 11/2/26 10:32, Thilo Zirnstein wrote:
> Dear all,
> 
> This patch-series fixes the clearing routine for the bus not busy (bnb) irq
> plus the waiting and clearing routines while in atomic context.
> 
> The bnb is used to indicate that the current transfer is done.
> A high level view of the software flow for tx:
> 
> * init i2c controller
> * prepare all registers ( fill fifo, enable irqs, ... )
> * start i2c txfer
> * clear and enable bnb
> * wait for completion
> * ( serve interrupts )
> * ( bnb interrupt ): complete completion
> 
> The datasheet ( pg090-axi-iic, Interrupt-Status-Register ISR)
> states that the bnb bit can only be cleared if
> the bus busy bit in the status register is set.
> So the iic controller must have recognized that their is some activity
> on the bus. ( Start condition )
> 
> Currently the bnb bit is cleared without checking or waiting for this
> condition. This can lead to spurious bnb interrupts.
> 
> Andi suggested to use an atomic-save function to wait for bnb.
> This was applied for other waiting/ clearing functions, too.
> 
> Kind regards,
> 
> Thilo Zirnstein
> ---
> Changes in v4
> - Fix timeout argument of polling in atomic context
> 
> Changes in v3
> - Use atomic-save functions for waiting and clearing.
> - Fix intendation
> - Unintentional changes removed
> 
> Changes in v2:
> - Unintentional changes removed.
> ---
> 
> Thilo Zirnstein (2):
>    i2c: i2c-xiic: fix clearing of bnb irq
>    i2c: i2c-xiic: fix waiting/clearing while atomic
> 
>   drivers/i2c/busses/i2c-xiic.c | 70 ++++++++++++++++++++++++++++-------
>   1 file changed, 57 insertions(+), 13 deletions(-)
> 
Shubhrajyoti: Please review this patch.

Thanks,
Michal

