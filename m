Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.88
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795681452;
	b=qJG7ndxgbOz7UAT1yF7qInWCLUyLRFGsHUkbs0JWqm/H2zPIA5W4XDewEd+yto6b21Kk
	 hvUWuCRWaV0u+0xe+oQfvf3gTZPSJmfBdoRqKrm/2NdGmmrG5sfZGSRwCqV5Pnzkh8BnZ
	 BzS0QdzRIz5GL070EN1L5bsw7pit1jf2ik95lYn827e+snqfgk/r+Kb+vYN7tjEgGGOHS
	 ep1DH5NUZizZ7ZlinrJUhKmmoCRDO0IPz/XShnYFBGoFbIRtN0oOBDzqhZyHqqVf2taUG
	 2eLPdO/o96GXGhhouXvyVaEG8e66y+VbA6gghiBncWwInEhzsJ6IzoxdWnqtGTA41Hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681452;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-PublicTrafficType:client-request-id:
	 request-id:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7XYAynJwXY1DTWtJnnERfOecYaI8sKDCPCD5LFVAgQI=;
	b=jzEj+eqmt5z+lFL5P1/vWkMGDr3h9HBqQj5O9lnmrQVfGLGhY8hlSTXiJJzDViwB2gk1
	 k4WjUkOOIkb7L6Wv8VUQhn0eYsSFRqUY0NTFuetBedOKxUaC+/Lsnc/CyQZHUW/TJ+dsA
	 ywahFPLMBaN9zYhIDAEigk/d3UIwcvaijjQQfc3YQCLCiV55xlRNH+0ku6tCi4L2qesof
	 +VTgSrEOgtJlHHwUr8PSI958uLo1LozRsoANw7qYfVP0PE091a/8d+cNjB2bbeixMN8NP
	 qvRBh35jKLSWOeiCWAM9Qb6+KMNACfjjl8czVOMyISiytCjz8Smua/cXJsq4h8xXY8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b="jc0k2rK/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.88
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022088.outbound.protection.outlook.com [52.101.126.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B1606A339;
	Thu, 26 Nov 2026 08:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 920B1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=jc0k2rK/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZwbbcPEtPJYwlZdAFvmLK5iwIK3x0+QDNi7KLivxpqUOYTUrrGY1UI2gxdCMGk3V4C//ficGPc6THENQmEtIO2aTLE61rqDa3T4V6NekeYwaKyGOt1BnKVNCPk4YxIfyRT86SgxgQt9CvQMMY2y7Y/BDCtsGwV66rnnBGLdP+jchxt5ruaYGKvotkPUufZK7vnS9wVZN+5k9Iis843K0piuTOmANcC7rYrhXQkdXIXxAW+QqLd/G4ImjQYFwPpwyY+qjEeoTum2F4qxzjDwaGrEVotLRNtPmtHftqm6OXhl4lr44iFmrHqSceqSWJthG83Y4RL46hW12Oi0XWwEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XYAynJwXY1DTWtJnnERfOecYaI8sKDCPCD5LFVAgQI=;
 b=ZZeiIkazS2srel4P8hxM+G1RcO7lotbDX1ZBhaN3rL4LVMDhMbUlUynUVR6a9r7MBZf3Sxhjk0+LMR46VNjPvsP6cRqaY2fmylC/gKCUNmVjSPy8oQklCIiLQwPJpEUnTJfMmvtLI57lf4laVvySQlkm+eccj9fgA0BNWt65bcLgpoKCJgVoSTHEkx8O84fD/TLIKMVZaP3nXo96bnD8sM6h984r1NSjW2i+pb2B7lCdeJnm+H3oNU+5mjpAJic4jmpSkNAbJk5YoeoAwGupXowfwt2FL9llmYBaqgigxPurYt0L+qrs73xw+8LCMqiPS0EO9qutN/Q0KCR/VCTS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XYAynJwXY1DTWtJnnERfOecYaI8sKDCPCD5LFVAgQI=;
 b=jc0k2rK/6nnt67nC6Ut2ulo4LbVG7YPRZUif1UhnWBM8HSrJkCdB0ZBhejGTDR3xc63mLkpYnAWsnc4gnepjUBdOLVBJr1kZd30Eph/JTYA32+9B8LkzGEgeJejY/6+wME0DcvoeXsBWPeHqHwL237IXbCaq5zqWy63jM3K0q2uTScWzXrB4LTFhAGJVH52EM3gLoh2DMzdASP294ABYlqhblHAnKqzBeJyOERDuZGTGf2bK9P6Rys2IWJ5RHu9l8L5YdeKpyOJ9Kj+Yb93DgOh/zx+gbwaKTNmzt5xsOgD+UtViwPY0Co8bmx7Hz7shRWE/gw9O+q6MpJ5/AyxpCw==
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by JH0PR03MB8290.apcprd03.prod.outlook.com with HTTP via P2P; Thu, 26 Nov
 2026 08:24:05 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 08:24:05 +0000
Message-ID: <4e82e617-3d59-4779-8d09-b01e3a7e3c34@amlogic.com>
Date: Thu, 26 Nov 2026 16:23:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/2] i2c: amlogic: Add Amlogic A9 I2C controller
 driver
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>,
 Junyi Zhao <junyi.zhao@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20261126-a9-i2c-v13-0-926e2072cc4f@amlogic.com>
 <20261126-a9-i2c-v13-2-926e2072cc4f@amlogic.com>
 <5d75177b-a86b-4728-92f6-87f37a51d4da@web.de>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <5d75177b-a86b-4728-92f6-87f37a51d4da@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|JH0PR03MB8290:EE_
X-MS-PublicTrafficType: Email
client-request-id: 7e65d5f9-e5b1-418d-b5db-4174a182f6e7
request-id: 437c869e-0c79-4408-83f6-08df4b96a22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10067099003|56012099006|4143699003|11063799006|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lW0OdPC0ywi2T017ZvisFGP4Ub/ZLX3UUQ5S27X4StlKNUFVLKVtxHb5MbGzHU9J02oBd4ww/jAIEU6Ad/8VpZ2XYr+xMx3S5LIJCiJiVC9wxfd6bNxSttnxQnqtnTqRaWfZNa9xPQucRjNUrFX6tGs4/4TPcctNpb8+h60Ccto4dJIHdsoEB9N17/sZdCm6DJ5cLaM4EIeqPrgIpS5KdITyxpT6tKHxgATmGjmeJlCT5jE8elonXCeo33UgjO/v2wbGMKpXAv/6rH5ihQnVUyq39jveXrQgTsY5CymWau2YRZSc+NCShvHoyQgImQwJepYMTrhd3vrfBGqVF/rFIyRsyea4THJ43as0BMqQSjENQhnP07DQPdnjyIBM3G79vf+TCEspqylBdqhR2sPiojDvd2Ogp/RyQDwy+onkacr+nkarrwBWaW0eDByzC0W2ofsjtJhGnLDb6XMpSx0maYh/aqG+oCRykLy7J2Dp+HIKnrqLMcO2Z4aTF/C3jBpaafyueBGVML7IrWdNtIe8OmunEI/aWR1QZdCmEGI9UZGjMhkRSuXAy7byD9yfyyBjfhiqSvivxAd/UjNWn10QKaUBH3xTFS/bYDoL/2sfxgMQogm7TCm5/onCNGFEVEah1+U4ZTtdC7D62euID1vOyySs4FvuCrMg4UldkR8u6MY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck9RQjNoaFBmK3FRTHNEeWNyRWdyOEM0TkR2WHN3dU9mbDBDQVlDM3RCTVFz?=
 =?utf-8?B?UncxdDRTT1h6dk93bTBhNGk1OHpIZkZYa1kwOERZZTVPRVZ2QkVmMlJONU5n?=
 =?utf-8?B?bS8yT05WbWd5M1BFcVJJbmFCTFFCZGdiM2wxQmY2dTZSQ0F1ejNlV05kVmVP?=
 =?utf-8?B?eTVZWHEwUEFHZ0RZUHRSVXNPbXU0amhBbllEbXZSd0ZacFhoekNkTy9pR1Yy?=
 =?utf-8?B?blpMZGdRL1VHVGNhUXNnKyt6bHAybFNKRkVUSzZPNW5PZGhidDZuYThEaytN?=
 =?utf-8?B?aHVNTkZnRUFFcmo4QUo3MHVPZ0hLbFowL1NuWFE3ZFRlZzhrMWhDWXUydERs?=
 =?utf-8?B?U1lyUU1JcDJycXg1WThYMnVDb2IraDgwNDhwc2VPRll4b3J2MVBpellScVND?=
 =?utf-8?B?dlkyVm43NUh1aXN1YmlDK3pGUjdjUUJEZy84WmpxZ0tMQU1ORzJSMHN4WHND?=
 =?utf-8?B?ck8vWnFDeFM4aCtCV1Jacm5xUUhJZ0t0bmIxdmxKVTd1dE9HUUxlQnI0aGpX?=
 =?utf-8?B?S2dPTk94bnhHcEEyRjlWMG83ZEhPMjdRdVlZZzZHY0hyV3AxNWhkM3JJU2ty?=
 =?utf-8?B?SGdwRWRoUWZWT3RQeFRsSXB0amt0bmFSMWtKSmdGWENaZHF6N3M2VUcxYVV3?=
 =?utf-8?B?Z3BDcjhqRmJPQ3JWbU5hWkNiaWNuUk5FaG9jOWwzcjROdXVXdkFYOWdVZ2RY?=
 =?utf-8?B?NVFvd2FqUHlzMjR0QzZRU0ZqTGxacnp2d2JyYTFuOXZ5VHBrK2NGcGhYYk9B?=
 =?utf-8?B?SGc4ZGxrcXFHYThzLzAxUXZaTlUySG9temJmYkpxeFRDWnZkUlVUNS9GUWhJ?=
 =?utf-8?B?TTNnMkZ4YmZrTUxNRTR6MVJ0VFlqaTRKb0pPS0FiNnZMY3RyaVhhUzd5M01U?=
 =?utf-8?B?ZXZJMm81VCtmWXlXRkxOd3ZlS2VzaUNSak5hN3J2MGNCeG9BYmxLVWFzOFZP?=
 =?utf-8?B?aFJxRzhIRHRHV0Qxd3MwWDRKOTkvcGpaUzA5WlkvVXduVjVPeGZHR01VdUU0?=
 =?utf-8?B?VEo1S3FsUGs4eDJ5UmRpcUV2RVJIZUhXQnVsM0lJQ0NiWFBreFdJSERsOHhV?=
 =?utf-8?B?eFZwd0o5UC9oVC9KL0ptQU5xRkdSUkhvUGg3dHpkTnBGNGNJOGlRQmx4QXVh?=
 =?utf-8?B?d0NMclZSVjA1cmVrWVhJRUlKUExqTnNJNlkxRlpoczQyUWZCTDNxYjFPOWVn?=
 =?utf-8?B?SzZGK01RSGRpWFRySGpvd0RXbXJOUUJSb0diaFVHQ3J3cE41aldqRFZPdkhm?=
 =?utf-8?B?RnUzSFcyMlRpZjdPOWlBSWxBQUlnbWg2NGtONWh0SW53WU1lMzU3TWFUcXlT?=
 =?utf-8?B?a0RoQWhPTUExZy9lcHlpaGo3aG0yMStZOXdMUExvVDBoUm1BWGhqV2FFNU8v?=
 =?utf-8?B?L2dDKzBHVjVwRHdYQzU3ZXp3K1hiZytER3ZZRm1MRzBTUk1CQmsyTzVYZmpW?=
 =?utf-8?B?NjdrYzVjZEh6ZVhpZW9sVmdoSko4MktWNVlsQVFaYXJxK3dBbldJVTgxd2Fq?=
 =?utf-8?B?NkhUZE5DVDhqeTZSRC93N1ExOVdLcUZmeHBtakV4Zk1sTlYyRGJUZ2MxeEZU?=
 =?utf-8?B?aDgrNGJEdDdZdmxUejRTWW5WWG9RR1NSRnJWZkU5K25SN2FHbTZERmJmK011?=
 =?utf-8?B?ZGZrWWhJTnVNNmpaOXZQZXJOcDVvSkxFOVp1Vjk5d0NwZXRWNDVWUDBrUzRr?=
 =?utf-8?B?Q1JZUGwvcll3ZUhJb1NicEZRWUVBWi85c1R6VitydGwxNVVqTlFVRWJlUzdT?=
 =?utf-8?B?WDE3ajVVdWFtMGJjTGxpWThMcVNVVlcrcFZtRGxPL1RQR1kyQW1NTmV4aUdr?=
 =?utf-8?B?emg3OXNCeGpkampaVmdaL1hHN1JPWVFWZklieWdyNjVZLzY4N2s3TGpzdDJl?=
 =?utf-8?B?RWNSN2FQRU9hYjNjTlgzTkRKSUQ3UEFNQjJNeDFiclQxRGJDSFVuMGZycFp1?=
 =?utf-8?B?TVBrVjMyWldYYXBEWHJnOW42VkJNYjNBaDBLMkxaYVhuUDQrcnBwQTU2NTE5?=
 =?utf-8?B?TkVPQzA1VTdnd05yMVdBYWxOM0VCeGdXalloT3VYTnF4K2EzYXE1cEdmUW81?=
 =?utf-8?B?R29JV1pKREtpS2sxdGFDcFlMYVBzeVNNSlJUM21EOVdXN2RWY1pRY1llb3Bo?=
 =?utf-8?B?M3VoOXhkUTdNZCtkaExzUXJJSU04bHNlU1Z1Uk5KTmZJVlFSc3N2S1RGZlVZ?=
 =?utf-8?B?QVpBSUNUaEg3YjV0anNnWWpQREk4eEtXdFRWdHFranRWQkpGSGZVWlNUc0pz?=
 =?utf-8?B?dXZjWlFrQWhsclhlZlo5bVB3ZTNVdFlVT3ozbjY3WnhTd25uSFhzdjZRYm5m?=
 =?utf-8?B?bm5aOEJHRWc3ejAwckJWeUdEaHMvNmVrTXBidXl3c1BKbmZwZ1UxQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437c869e-0c79-4408-83f6-08df4b96a22e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:24:05.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPGm1C1qtGoBiJoDukCaKnIPhMtNReYR0mpw8SckOWAtLq2GlmkairXohA3ursZo0m5WWz/ALbFs8kkqMf85bmn1uSeNWxghAE0dbZQPAp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8290

Hi Markus,

On 2026/11/26 14:51, Markus Elfring wrote:
> …
>> +++ b/drivers/i2c/busses/i2c-amlogic-a9.c
>> @@ -0,0 +1,428 @@
> …
>> +/* Amlogic I2C register map */
>> +#define REG_CFG_RDY          0x00
>> +#define REG_CFG_I2C          0x04
>> +#define REG_CFG_START                0x08…
> Can another enumeration become helpful for such constant values?
>

We use #define for the register offsets on purpose, as it matches the
common kernel convention for register/memory maps.

> Regards,
> Markus
