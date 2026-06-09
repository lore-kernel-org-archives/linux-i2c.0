Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55B32B102;
	Tue,  9 Jun 2026 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015977; cv=fail; b=fw1APlr8+tBWolIq5F6DPH4BZJe2xKMARbLTjIfu2CIF2Q9QS7ZpqfnPbOONsF7E7zo2cRA7cpYNKaM/CNmug2qNBwptE2Um8EGHfqL9y9h3zA7PgZE37Qy1GDrsnPfTjh6vDavO5VzKtUlvPW6mTwdqPbzcdw+EXY5TBXnNzkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015977; c=relaxed/simple;
	bh=s4HUZVy13fkopAryMkRMTuCw1XQJ+FBNviHHG5wMY8M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CCKY5cZdMSXbPx20lqOT0CrWy3iPpuSZ/dXK3L1lOK/sy8bnalwBhqJ7UhcLY/UOMXDnUfA0FPTF4YdQFo0AxkRtLadbpwPGLLZTaostUbhq3Vkjj7Za92BuUr7HaHnVojm0F9aug6nQrmjY9VGyx2yp6TPHb3rVmZolaLEuMus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mm9hrXxr; arc=fail smtp.client-ip=52.101.62.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mm9hrXxr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erpn5X9txyoWnIh5eHNL0bpuJGaQc0HG+xM5D49Wz+lkndit+69RW5V7R30qu30rPhjW5QwHiDbw1mY0e++zMrUqwGKg9BHKtgbw26Ux+bs9O/JHTxsC+Seg4dPmYJ7e+DufveAK1an0M+D7yhbfD/KOA9Ydbhryt6NFPXnWPckiYGCoERPR3WaiA1g17IZ6HRV0XyILN220rEkA8Qk7Jd22V6mfwEsNJhOb1E11ychKeZn31OdwMuTfZ65z5DWGs6mYklJQ3v0T1+Lpigb3fBsQ3l/6QyVATbklo9PzMkbLS9dIGyZV5df6WWyZ28hEp4Lwvx2sPn3LYEGIKcatrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYQ6SjyKljV7W5J1GWfUT/d1geSAsKuICmq9fCljWsw=;
 b=KT1EAnhguzixYsUqc5XdaPpG7B8XCUqqg4d18VdxqgH33SaI6e5C1O3oRk+VCukBZ3EaH6EU006vFX93bVt0nokjUrDPNDnVysRPClNIkGs5DH9iu8c8TlXKXd/rY/Y3WvSine7oPzqM9mzLCuuC9VZHrLab57COoEtaq9Bocag1/wnj8LXg1soUz/OQgSJo91X+ylnSKgEStyg1pyGvmVQitBobYqBVe1LyQaon8LH0JempAFptatvWU6jn+OI6bswye1JpAS9ooN3lHkCcWujGm0HGrtpP6TLGNFq90puoulPF8kVixFOfnbn5wSunyb2ge8owaOcIYKmvB61rQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYQ6SjyKljV7W5J1GWfUT/d1geSAsKuICmq9fCljWsw=;
 b=Mm9hrXxrXVoUmFFWC5rPBiJIvOz7Bqdd/joMj69WUtpDCd6nQ2ZerhsCpkFA2YIK8EZqcK9zmg33SB5gjpWrBpn2soGcstYwzPtr0b2dY0Xs0cvvLsdJYtvQhsv9NegSwvQ7gAqRE5b23hEFM7i/0RY9fpRSqMIbuYNmzYoprdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 14:39:32 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:39:32 +0000
Message-ID: <0dec4aec-5a62-41af-9509-3bd9e2854739@amd.com>
Date: Tue, 9 Jun 2026 16:39:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] i2c: xiic: fix SMBus block read and PEC support
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, abdurrahman@nexthop.ai
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai>
 <CAKfKVtGztJkU_HXZTrb2h3hrTJp0SbRo-sDHM4Sj_1SG8ymOyw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAKfKVtGztJkU_HXZTrb2h3hrTJp0SbRo-sDHM4Sj_1SG8ymOyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 05abc5b8-2b81-496d-546e-08dec634eb4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	HpUIalx6wc9vwqQqUb2Na5AdSbuWkp9Ck2xc59xdW3Da0ZsX3F1jxTxESCqA1ZPKssh3Kste8Ry4tEFq4aLFDj+QZRFRPVMeMSEq5EYIvMyAEw3Jh7qNP2NH1i+DyeYed51CJBKckeud2iU7ohk8ODdCrvcylIb8ep6+Pnmlfbsmd1YilMqX/eOUpeplp39IdhVBxQHLpd6cTUFXgREwmzCHY1euFznei7Q9Bgue1AGCWpUd3qhLOKuQmr9CoFl7t18dqKdCugRP6573wHHLwELHA1QoEiefi2ZubeqnsgxrVodbYFH1hQ0xhw0Fnb4/9ZNxhA2hH2RhYV5OjyFlghpkC/cFlLhJGzIRcaAhKuBYscfBSo5nywjy/LDLJ/npr04iXiKnrVsumrVin/Hf9dCd6VGclpLfJdrWR6OO8BwIK2Qwqr3B9ThlDtDbI2s+DDGt5O9IDvFbKP+RRmT9yT53ZK4yV9wKzZl6efDTWp55d9ELUE5S0/qemifNeq146T1bPOZi8SBqT74RFNwd8nvh6RcBwgZF5junV8at0mxVowHr+MkhefJ6CQfdPvQ9UjQiyqFdmaM/obMcdVCsQYADsdEIZjWvIsr8HL4/ugCEqq3H6GN51CUByGRSaw8pqbMlS/zpEf9IQ6cXmcTqalIkkJXL14z5CmZjpr4KIR7njoyoebk3ySYtdOO5f8K8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjRDSlZYMHFJTHVTdGNXZS9ZSHpzdFd6UEVuVTNoTDd4OXlJcjhmWlU1UGYw?=
 =?utf-8?B?NExqOVJuWEo0dGNsSk9VRlRBVzdyUlQ3WURORWUzb1FVVFN6TThDblgzK3V3?=
 =?utf-8?B?SGRuV2xLVXJ0UVRHd1Btck1aVHRuZkNnTlB3U3pwMjM1L0hPUmVrWWx5dk1D?=
 =?utf-8?B?MzdUQ1JkYSs3UU83aU5ndlgyZ3QxUTNxSndybWt2Z2M1dzdlNFRWWU1UT0lK?=
 =?utf-8?B?ZUJEbmJGZ1MraHNobzlMOTdBOFR5dm9SZnp5K2pBbk5KdFlKa3pMNzRlUU1S?=
 =?utf-8?B?RHEzODF1VnRsQlFKVXVzK1BpVDg5SkdESStNakhpTmVPN1pDSWJsYSttT0Fu?=
 =?utf-8?B?QkVrekdSUW4rTVRUbGFWL3NBdy9iV1hvTStsNEJPL1E1ZStGRmI3Mm9yd0I1?=
 =?utf-8?B?MXNyN1RVZmRPZXBEOFltS203SFpsTERvRWxBa0xuWkt0K2J6TThWeCtSOTVa?=
 =?utf-8?B?UEpkZjJDQmlGTGsvSFkzV3lKTGx0aiszaDF6Y0lnK2JqSUx1Q3RsUk81VEJr?=
 =?utf-8?B?WnVKVm9RaVI4MUVtUGxWV1dwOThNOHJBR1Z6UVErc0QybG45YnpkL29zaEpY?=
 =?utf-8?B?bmVuSStYcE8zMnBkVmlvVUkwbjk2Yk5sVks1VlBLc08vK0FjVXhHNnppZWsv?=
 =?utf-8?B?L01NQ0h5TVJFYkc2am5EWWVCL3FxQVdZOExpM2t4bWFrTDIvVUVtMnVGdW5W?=
 =?utf-8?B?NzVzb2R1c3R0YlBHQ2ZCOElkM1c2aDVkcWF3eE9iTk5XWE1xU0xlUlcyaCs3?=
 =?utf-8?B?L3lvOFUzM20yOXhSSlJRNjZXRzlMaldaUjhkb1d0N2VpNlpNQWp1SUo4RXQ2?=
 =?utf-8?B?VVAzUGxwQlE4a0xrQmRCa1U0bnF0OVUyeG5DeUtHcTZzOFRxVEd5SjUwaHBL?=
 =?utf-8?B?Nzl5OG1KZXN5R29ZLyt0VFhzVzU1WXFkWk9yVGxtWE9BUy9Ka1NBUWNDM3hS?=
 =?utf-8?B?WDRHcXl6dFZRUzlzb0dVaG9NMzQ5TXVOTGhjLzMzMGtONzhsbkJqSDAvR1cr?=
 =?utf-8?B?cjNQbG84bVRqUVVZb1duQVhROE5RWUV2VWtJcTZ6dm84M2ZGdFQrck1RdUxv?=
 =?utf-8?B?ZDlZRlZJTkRhSXJaakJ5cDVkZ28zeVM5NTJhRUJ1MkdENVZSSlh1K1NrK1BW?=
 =?utf-8?B?Y0ZwOEk3M29vT1ZiMHJvVXBqUnBBS1pWcndUR3lJdDVrZmxkUXVOU1AzSllF?=
 =?utf-8?B?VTNRUENuYjQ1QXVKUFgxRGxRNzE2a09RUGpWTVpUSit2ZHJLTkNMYys2ZmZB?=
 =?utf-8?B?UjIvQ04vaHlya2lhbUc3MzFYc1MzRThHVmVmM0Q5b3JLZVdwSjBUN2NLN0xl?=
 =?utf-8?B?MHRqNWN3YlhkQTdXNDVnTEhzRUtDQnZzRnc4bE5IK2FSN0F3RDhxanpaVEdz?=
 =?utf-8?B?ZUpCMTJiQW81a2dMVTViOGlFc0ZjZGF6RUtFcW5SMHVSSkNPNytPS1RwVmlw?=
 =?utf-8?B?WnFYRGNNMllrSTYxT2tMUm4yWExJQTZxSmtkSUpOeVJVMnBxZHduM20vT29n?=
 =?utf-8?B?SWNhckNhOFpDTncwQWtwUTU5dmdHODhEWm5yUGIySE5vcm5pUWtkSEdZcVZZ?=
 =?utf-8?B?dU5NUFBhMXozbi8rOTZpNkVNOTN3eEMxT2I0SjJncGJkSGZrNmtlRkYxZThk?=
 =?utf-8?B?Ui81Mjhlbkp4SDc5OWVZWXhVYW5xaFVxa29DUCtNN01FQnVGV2JtaXhadS93?=
 =?utf-8?B?TUw1a25XL1FWMFkxcWU0OG9xZHhLWWRFK2ovRXU2M2c1MUFMWDFyNnBkU0Fw?=
 =?utf-8?B?bDRLZHgxUVBxMFFuWlNYSFBIQVY3K281WG93cG1UWm9DYW1FRnRQaUZ3Y3pS?=
 =?utf-8?B?Ymt0VHI1SGVZQnBMZXJreCtwbHpvN1NuTWVINkp0cUUrY3Q1VlBjY0EwMVFP?=
 =?utf-8?B?ZU0yQ0Q2bVRrME5CcEp5MitRalFsa3NDNzYrZHR3Znc1VXpXdjM4OTJvR2dx?=
 =?utf-8?B?dGx3VStzREhxeGlFS0xocmJPMld1a045SjYzc1Y4eENHQzJFTE51MFJyUXJz?=
 =?utf-8?B?OElycldXbG16WjhSTHZsTnphNTBaUmxZNkJFVU5KcnFwU2tDVVRrUkx0ZGph?=
 =?utf-8?B?bFpOR3ZrT3JnVEZjSEhrdFU0TFVLRUpaYTJrdXlsZ1lzckx6Q3h2cnBIZ0Jw?=
 =?utf-8?B?NTBtSXB3NEkrR0ZvUTVGY0xuSUt4WndNVVBkTzJCY3NtUERDMWJIMUl2Tk96?=
 =?utf-8?B?OFoxTjJPc1dHREVudFVHYWY4cFFGUDVMRWpSL2lZUjhsVW9JWTB3TE5WVDlk?=
 =?utf-8?B?Ky96TXNhRTc0dDNyQVVObWtoTm9oYXlwUThXZE1mczI0RlpWc1ozYkNOSzQw?=
 =?utf-8?B?a2hmSVdZdS9BUXUvZ1Z4eWFBbXVwNTJvTXQxRzBTd2J1QUUwY042Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05abc5b8-2b81-496d-546e-08dec634eb4e
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:39:32.2920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mz8h2Acr9CzvBP+EHjElbC1xnpCoEzfUD0j2AS0YxdEYvzJxfWSxhD5S+XH4lFoO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322



On 6/9/26 16:26, Shubhrajyoti Datta wrote:
> On Tue, Apr 28, 2026 at 5:48 AM Abdurrahman Hussain via B4 Relay
> <devnull+abdurrahman.nexthop.ai@kernel.org> wrote:
>>
>> This series fixes three independent bugs in the Xilinx AXI IIC driver
>> that together make SMBus block reads with PEC return -EBADMSG or -EIO
>> on otherwise clean transfers. They only surface when the client has
>> I2C_CLIENT_PEC set; non-PEC block reads happen to mask each issue in
>> turn.
>>
>> The problems were uncovered driving an adm1266 PMBus device behind a
>> Xilinx AXI IIC FPGA block and reading its 64-byte blackbox record.
>>
>> Patch 1 stops xiic_smbus_block_read_setup() from truncating rx_msg->len.
>> The i2c core appends a byte to msg->len when PEC is enabled, so
>> overwriting the length to "block size + 1" silently drops the PEC byte
>> and i2c_smbus_check_pec() then reads the last payload byte as the PEC.
>>
>> Patch 2 raises the RX_FULL threshold so the interrupt only fires once
>> every remaining byte (payload plus optional PEC) is already buffered in
>> the FIFO. The previous threshold of rxmsg_len - 2 caused the
>> bytes_rem == 1 path in xiic_read_rx() to NACK a byte still on the wire.
>>
>> Patch 3 stops the BNB handler from forcing tx_msg->len = 1 to signal
>> completion. tx_msg and rx_msg alias the same i2c_msg during a receive,
>> so this also clobbered rx_msg->len; and because tx_pos is already at 2
>> in the PEC case, the unsigned subtraction in xiic_tx_space() underflowed
>> and the STATE_DONE check fell through to STATE_ERROR. Advancing tx_pos
>> up to msg->len drives tx_space to zero without touching the length.
>>
>> All three patches are pure bug fixes; non-PEC behaviour is unchanged.
>> Tested on real hardware -- a Xilinx AXI IIC controller talking to an
>> adm1266, where 64-byte PEC-checked block reads now complete cleanly.
>>
>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 
> LGTM
> Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
