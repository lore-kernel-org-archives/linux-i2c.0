Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD53314D1A;
	Wed, 12 Aug 2026 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538108; cv=fail; b=dc5uwFIublVDc+/z/rh6K213zcw5W3HppdTHxuvti6BEttldTMBF9PTprdqBqSeWYJo9GIGcDng1WgwDPUI21ThivHURete0riBNCrT6nMuj/6MDNDc+LTwUBUAzvOUOdoRVGSv/gdfq0wOSjYBcdT3u7qCEy7Bt5jEcBp8tZoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538108; c=relaxed/simple;
	bh=+P0bQZB+eO2IIjTXeo1qGRunGxi7BOleA5kmbF49+Vc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JiEawi27vEreuexnvbtwUS/IEAd9h6bTOrB8P/N/FnmfkheqvNTS7K/bzhb6iHB6Y7Uht97IjORlz+weRlcg0dHF6OY/iHOKkeq89N+qaRLJm7ooweJ85QD9IWBemP6wVDr75o2YCIWLOQ5NcJCrho37FBUW+FUhU8bA+f1LnX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=By16gZoU; arc=fail smtp.client-ip=52.101.85.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="By16gZoU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=io4kkdlbHOVIRPQFrkC9wgsqeBrjGCNv3AdMnAA9DUaRfoOMBFtsienidow7tJUdJui3Tc0ZhDpAPINjgquMT/WxL2JnJ7Pur0SR2lVIXaoW2CSZ/fOM8RhayODU0i5j8XgB3bY+pGUUR3YE4HecVAhPLu3yl7US+AZIOHR47eZAgGnZfvYCXozmNv+dG15hs34MZY98SSLNd/Ihajprk7r+mWJzsMl1TI996ASFmvjJCb84bv5XfGxMumtKaruaharrB6xZEcj/FNWQxL34/vJ5/cfukwmqR8GCPQkrX7D6Ca3BfBxmJDLU3jF8ecJRIMEiSnSJvsEtOrIf9rcFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Hjw0gBnNJrh6DVGoZmWDvKNCAN4jtrGJPWXRofYUFI=;
 b=OzGtJAmS40TxiUMVpgtJAqqTQ32Uz9RR4b+BuGFQKNC3btjzNqV+J7lSVT3CbXXPvKy+zOm/vCCU7Oevfjr+MfEaM6B5tfcDuwtK6G06s19AVLx86A2h0KDazLuc0Ag/1/VgSUAISeDd1Ia6Er6+x1UV/WGYxpoSjso3+bRe4fc4V37qZm+VE6ut1q80t7CqHMh3QJeq8o0JX8im0OwUO+iY9xQgqZTdyxAcf2QNzK7AVpSRuhcAlQPp/eKxxfRQRiOT98bl30FvrHyznufEs3GwQ0sTku/Gf7igKGACF5wyTXWOgrOpjEhkkBw87ry4rEcB7+VYmceIqMOHxeWWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Hjw0gBnNJrh6DVGoZmWDvKNCAN4jtrGJPWXRofYUFI=;
 b=By16gZoU8yE8r3QQZ2dy7AzpOM/T3bSYnIe6VTYL6tOXbrz2J2tGc67q4Wm+7ySTZpbWiwIAasphTtB2TxAJAyrG+IdtqHxXwkFO1+xMETQWzycTqEx2uDY1zBBOBqtNMRXVQGhAFz8LFoWQQusUo3KwPDDPUdj7vVOwTnjrKFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 12:35:01 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 12:35:01 +0000
Message-ID: <444caa3c-01ae-4516-b63a-576e095fef94@amd.com>
Date: Wed, 12 Aug 2026 07:34:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: i2c designware change broke touchpad of a thinkpad
Content-Language: en-US
To: Hardik Prakash <hardikprakash.official@gmail.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
 linux-gpio@vger.kernel.org, wsa@kernel.org, brgl@bgdev.pl,
 basavaraj.natikar@amd.com, linusw@kernel.org, nathan@kernel.org,
 chaitanya.kumar.borah@intel.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260718054330.8975-2-hardikprakash.official@gmail.com>
 <amhodWpAI3K6aeBH@zenone.zhora.eu>
 <b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info>
 <CANTFpSW+w1GZMbLXszuqZFCZjeVJfFG2bc1vJad+OMzsy-CPCg@mail.gmail.com>
 <aneQvMN_Zet2b62n@ashevche-desk.local>
 <b5b95476-636f-40b1-8575-47918169b7bb@leemhuis.info>
 <CANTFpSWzV9tzMwc2cURCQBhpZmrv1SsZqnwBEu0jt=ZQWfvWgQ@mail.gmail.com>
 <1a209e14-05c6-4796-a8fc-d0c3a776520d@leemhuis.info>
 <CANTFpSWnTjoTS8hBOvVM_w3pWHyOiBhch_GXe_mG-d56WeF-0w@mail.gmail.com>
 <5a5f7f58-b35b-407f-a5e5-293a88cafcc0@leemhuis.info>
 <CANTFpSWTkwmb3F9UnZmeaLizH-cC6evXD=kd1eNwJWkCfyj8DQ@mail.gmail.com>
 <a23375c9-d188-4737-bfa0-f10e66ae7f08@leemhuis.info>
 <CANTFpSWhqkw4735EFyQ4XoSEiqsgCKt4jTxH4SDO-m3=ybwccw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CANTFpSWhqkw4735EFyQ4XoSEiqsgCKt4jTxH4SDO-m3=ybwccw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:806:125::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 071a1950-2a47-424b-2b7c-08def86e2080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|3023799007|13003099007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	6quiC12s02wDrYjzLRbwb51g+0Td+8Fadq6Lal83qmyaUdcoNQ56ceBA9fPau1XlqRiUhaI2izWN8JdGr6pvwvAYe5HKNVjBjErdyl85Uu80pW5JAMvf2UrrJDsZYqsbfxuktdvb1dpS7IZQRXYjwmHVTqmcckG0bMQEXJ3ETCKd5lHIapizJ/vUdDIQQd9x53KBMu1idJM1Mttab9D1/K7b9di7KYRfYLODcxHPBttm2nyczdf+5HioFhNl2ZDq/PlcBVQMmZJoybr0eOCbAfM3UTkaCT330VrBYMaISH6hN6Olq97MWfMZI7CV+sEhds0ZucEeicTuZ1E9jIw4Gtbx+t5e5Bg8Ohd9MEfuj7OdMteH181Um1Qlk6tZtQ0trdq83UBA+YYpM2HZ7xLyAJtxHWqyK/HRG092zsITyV7xc9uB8ALzrEuPjVzkzLGCixfVXz2Cdjf2mYqBZZvcnpA54E4A4Kwg9+/oQbT7OtGgmukXSl0CEsLUf2oeNPCX63VWIeDfzgwoWm8oA6aqkc8MQiKLtSzAFEEnjjFCLRkvUXCd/4UV9f14SfmNOoujOaMmMA3hKWXIsF+Txd9/0BvBUv6+El35wsjurocLxcc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(3023799007)(13003099007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1k2dVhXTzg5Qy9TK25KK1NmaGRZS1Q0WjAxMGtNQ2ZZQUhOTFBwTDNaSXZX?=
 =?utf-8?B?c25aNUZnYk5MTHR4cTlSTHhGN1ZlSXZOYmxvdWNvMllsZVFrd3hudFNOUHY0?=
 =?utf-8?B?RkFzTEVadjF4amFTVkpkVm0rWTdrSWFmNWhMY3kvenpjMGV1K0ZrYTRBdFdU?=
 =?utf-8?B?ZmkyMUhuS2cyb0M3dXhDWTd1UldVTk5zUEF6NDRFQklDWXZoUEtJYWxtQW1y?=
 =?utf-8?B?K0hHYzFXVWZCNS9NeXdQT0hEMjgrS3NZWitHWW9JOHNja0Q4anJkTjMwQS8z?=
 =?utf-8?B?akxKSmE3WHFmOFlyOVJJVjBVZHpKM2RkZSs5U2t4ZjBBQ3Y1Myt1dUtqejEr?=
 =?utf-8?B?cWxHVldkNXRKUXVNR2ZHSWJSbFY0VGNKSkVmVm9GNHZsUWhUMTFITFUvUkp2?=
 =?utf-8?B?eFNyL3l1cVk0SUNIVUxGVG1tdC9mdUQzV1lqWFlmSnVnbTBWNzNPdHZjSWhT?=
 =?utf-8?B?R0RlRkdKcVZwRHl2ajdVNXBJOFpJMFgyTXR0NHZ1OGFSK1ZnSllqRytCSTJE?=
 =?utf-8?B?c1VCbkFsMWQ1Z3dmbUtuOE5ISit2SllCVUdtVEdXVFhRM01jOE1mWXQ0UWR0?=
 =?utf-8?B?aHhWbHpxT0tvdC9rdmRpdFBNaXIxK1VWeXg4SFFqRW5qM0pWRnloSzZYUjJt?=
 =?utf-8?B?Z3RScmVWTVAvbnRJMnJzWjRBRXZ2R3hOdFVHbDR2cU1UUEtlZm5SazdNcEtz?=
 =?utf-8?B?d3JnS043azFvV1FzejI3ZzljK2hsUkl0YTZSVGh5QWFUQWk4ZjFiOGh1SDBx?=
 =?utf-8?B?NWJHdWtzSzBIZHIxbCt5YlAzNFpnTjJGQXk3MmhGcWZqSE43U1BNNGszcStt?=
 =?utf-8?B?Qm5ZVEdudlRDVzlhaFBNTURZV2MrVHZFbDNqSkN0dmp5Q2dUaktCTnN0SDYy?=
 =?utf-8?B?dWU0ZFc3cmhFSWgwZzVJVEliUC82Y1ZxbVJ0U2hTR0cwZGJVSmhnOCsxOEx0?=
 =?utf-8?B?L2RxTC9OUC8xTFN4Nm1vYXlWMGRaZjMvZ1hMaFVWV0NWM2tPWi80YWJ4RkNi?=
 =?utf-8?B?L1dJUlNkNWpFby9HSXVreEVsdHBVQlFSTWlod2JSRGhISWlHZWxudnRSWWlB?=
 =?utf-8?B?STNveVlvWmNxNEFiaUNobDlKZ2R6YkFQYitYYUp3eDB3bGJDcjJzQ1pSbHls?=
 =?utf-8?B?OWhQd3A4U1g3bGUyVFlKRW9RRE16d081TVBPajM3S1ZYM1RVSGhMVHArRnJU?=
 =?utf-8?B?ek5NaGxKcTc0S3ZzM2wyN3VIWHQ3dGZNazhGMW8rUlNZRzQ3WmpPSnFjRTkw?=
 =?utf-8?B?cVlaQ0dzYTF3a0xPM3k1WGRqcEUrSmdSNjFoZ3pZZjcxS0NjcllIL01HODl0?=
 =?utf-8?B?SjBqWG5GZ1lKWjVNQVliL0pGZTdmMWdWc29UUk9mSnFUT0hSZVMwWERqY1dO?=
 =?utf-8?B?Z0hieUl4YjhoRmtYTWJsTTR4MFFPRmxjMVh0ZDdsYlUwc0ViMTNuSkVldTVZ?=
 =?utf-8?B?UUhUQzNxM0s1dFhBZGpuVHZxMkF2VkU3QmlSbkd4RjY1NnhIWU94emllM3hP?=
 =?utf-8?B?aXFYaTJleW9TSDZoeW84K3IzczlvL3J3eXpGak9qNGlWM2YwQ1Z3WEhWZGNC?=
 =?utf-8?B?aCt4TXZCQ3VCZEV4cVl2YWY3VUFkdDBUUFh1bE0wZFJRRXkvWlN6UXNHRThm?=
 =?utf-8?B?Zm5PVUlQbHJzbVBwQlk3b3k0M0c1S2I3TWVlOHg4Q1pzUXFhZjc5djU5cVRX?=
 =?utf-8?B?VGs2bnI1cHhmK0VYRDdRaUZEcmc2bVlTWWhtNjZBTUVPSEdMREhPWlpKN3NI?=
 =?utf-8?B?Y1p3Y1dWWWpaRlFDN2JuRUk0NmlRaFErbFlieXpRRVc2NEJtSkpCVUo3MUR6?=
 =?utf-8?B?VmdIeWJPbWljMnFCOWtvampHNU10VktYa0xNVm9Tc3d1YVdvVlBFbHVYVmE4?=
 =?utf-8?B?NXBhUlV0dW43NjFBZ3BjdGtVUDVBaHJtZmZybXVaRTJyTVBnUjltMHZpR29u?=
 =?utf-8?B?SWFnc2QzT0hBTUJDSDAxZHV3cUk4eTkvMytKYUwvSjdlT21seDJGeHp4ZTVZ?=
 =?utf-8?B?SzNpSWs3azFaanB0eDFSYnpaZS93V3NCa1hIQjhQMVZkVDh0bTUyWFZHRXVy?=
 =?utf-8?B?aFdqTDJjajJUN1BWK0pRaHMxRTZEZkVTOWVuaFpkTHZ0cVlObGxVVFpHeGs4?=
 =?utf-8?B?ZGJ2dklPS1U0YTM2d1NjYVRwTzAyb0hzTkhsaFE2VkpXMlVMSEtYWEpGdi83?=
 =?utf-8?B?VjFFRWozT3pCSFo4Z0thSzBoVnJIWnYwa2ZBazkrS2ZySEVRNDVpUUtxMFND?=
 =?utf-8?B?R2J0c0dHY1loYjNpTjg2eHkrRjV2SlhsTmpvM1cxcFZtZkpNbS9WQU5jNVp6?=
 =?utf-8?Q?2XpyYgwHxB+d7k0/E+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071a1950-2a47-424b-2b7c-08def86e2080
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:35:01.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDqbH+auhwt1BMKegRcbJYLeZJEwF/8c0Xsq9gdslNHrRWK5KwcNiEVYyqhZoJeT5w44xeeUrOlRaDsext01Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738



On 8/12/26 00:45, Hardik Prakash wrote:
> On Wed, 12 Aug 2026, Thorsten Leemhuis wrote:
>> While we wait for Mario a quick question: Should we revert
>> the culprit for 7.2 and reapply it later once we sorted this out? Of
>> course I'll continue to help debugging this.
>>
>> If it was just me I'd say "don't bother", but these kind of Thinkpads
>> are what some Linux users frequently buy, so I fear that other people
>> will run into this if the culprit makes it into 7.2.
> 
> I agreed, I'd rather have this reverted than ship a known regression.
> 
> Andi, WSA -- given 7.2 is close, could this go out as a revert now? I'll
> keep working the AMD bus-timing angle with Thorsten and Mario, and
> we can resubmit a corrected fix for a later release once it's actually
> understood.

Let's please revert for 7.2 final and keep working at this.

I've got a /hunch/ what's going on.

For both Dell and Lenovo I know a lot of designs have these I2C buses 
that have both the EC and the APU connected to them.  "Both" the EC and 
APU "can" operate as master.

The reason that this exists is so that when the system is in pre-boot 
the EC acts as master.  This lets you use the touchpad in the BIOS menus 
for example.  When the OS boots up there is some ASL called which sends 
an EC command that tells the EC to stand down.  At this point the APU 
takes over and acts as master.

So my theory here is that by changing this ordering the _DSM is not 
called at the right timing anymore.

This is a fairly similar issue as was seen that led to this commit:

https://git.kernel.org/torvalds/c/7d62beb102d6f
> 
> Thanks,
> Hardik
> 
> On Wed, 12 Aug 2026 at 10:51, Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> On 8/12/26 06:59, Hardik Prakash wrote:
>>> On Mon, 10 Aug 2026, Thorsten Leemhuis wrote:
>>>> Did a fresh boot and uploaded the dmesg again as well just in case:
>>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg2
>>>> https://www.leemhuis.info/files/misc/lsmod
>>>> https://www.leemhuis.info/files/misc/interrupts
>>>
>>> Thanks. Second boot reproduces the identical pattern: device_is_bound()
>>> =true at 1.132s, lost arbitration at 2.139s -- same ~1s gap as the first
>>> capture, so this is consistent and reproducible, not a one-off.
>>>
>>> interrupts rules out simple IRQ-line sharing: AMDI0010:01 has its own
>>> dedicated line (IRQ 11), separate from AMDI0010:00 (IRQ 10) and every
>>> amd_gpio ACPI:Event line. psp-1 exists (IR-PCI-MSIX-0000:c3:00.2) but
>>> shows zero recorded activity on any CPU.
>>>
>>> Since lost arbitration means an actual SDA/SCL-level collision (not an
>>> IRQ conflict), and there's no shared IRQ or visible PSP activity, if
>>> something else is touching this bus it's happening below what Linux's
>>> interrupt accounting can see -- which is why I wanted your take, Mario.
>>> Does this match a known pattern of firmware (PSP/EC) briefly taking
>>> this bus during boot on AMD platforms?
>>
>> Thx again. While we wait for Mario a quick question: Should we revert
>> the culprit for 7.2 and reapply it later once we sorted this out? Of
>> course I'll continue to help debugging this.
>>
>> If it was just me I'd say "don't bother", but these kind of Thinkpads
>> are what some Linux users frequently buy, so I fear that other people
>> will run into this if the culprit makes it into 7.2.
>>
>> Ciao, Thorsten
>>
>>> On Mon, 10 Aug 2026 at 12:18, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>>
>>>> On 8/10/26 07:54, Hardik Prakash wrote:
>>>>> On Sun, 9 Aug 2026, Thorsten Leemhuis wrote:
>>>>>> Sorry, picked the wrong file while preparing the mail, it's here:
>>>>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg
>>>>>
>>>>> Thanks, that's the one. Full timeline from that boot:
>>>>>
>>>>>    0.619s  AMDI0010:00 and AMDI0010:01 defer (AMDI0030:00 not registered)
>>>>>    1.136s  Retry succeeds: device_is_bound()=true for AMDI0030:00,
>>>>>            confirmed for all three children (XXXX0000:00, SYNA8018:00,
>>>>>            NXP1001:00)
>>>>>    2.222s  lost arbitration on AMDI0010:01 (x3)
>>>>>    3.260s  controller timed out, HID descriptor fetch fails
>>>>>
>>>>> The dependency check itself is behaving correctly here -- it defers,
>>>>> then correctly confirms AMDI0030:00 is bound before letting probe
>>>>> continue. The arbitration failure happens over a second *after* that,
>>>>> when the touchpad attempts its actual first transaction.
>>>>>
>>>>> So this doesn't look like a logic bug in the check itself. My read: by
>>>>> delaying dw_i2c_plat_probe() by ~500ms (correctly, for GPIO's sake),
>>>>> something else ends up contending for the AMDI0010:01 bus by the time
>>>>> the touchpad's first transaction actually happens -- a window that
>>>>> the original (undeferred, earlier) probe attempt apparently avoided.
>>>>>
>>>>> Mario -- does this look like a known AMD I2C/PSP semaphore contention
>>>>> pattern to you? Wondering if there's a shared bus/firmware consumer
>>>>> that could explain a ~1s-later collision like this, independent of
>>>>> the GPIO controller itself being ready.
>>>>>
>>>>> Thorsten, if you have it handy: /proc/interrupts and lsmod from this
>>>>> boot would help narrow down what else might be touching that bus
>>>>> around the 2.2s mark.
>>>>
>>>> Did a fresh boot and uploaded the dmesg again as well just in case:
>>>>
>>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg2
>>>> https://www.leemhuis.info/files/misc/lsmod
>>>> https://www.leemhuis.info/files/misc/interrupts
>>>>
>>>> Ciao, Thorsten
>>>>> On Mon, 10 Aug 2026 at 11:06, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>>>>
>>>>>> On 8/10/26 07:23, Hardik Prakash wrote:
>>>>>>> On Sat, 8 Aug 2026, Thorsten Leemhuis wrote:
>>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>>>>>>>>
>>>>>>>> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
>>>>>>>> [...]
>>>>>>>> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
>>>>>>>
>>>>>>> Thanks, this trace looks correct on its face (defer at 0.619s, retry
>>>>>>> succeeds at 1.122-1.136s), but the link above points to the same file
>>>>>>> you sent last round (the master+revert baseline, no debug patch, no
>>>>>>> i2c-dw-gpio-dbg lines in it at all) rather than this new capture.
>>>>>>>> Could you share the full, unfiltered dmesg from this exact boot (the
>>>>>>> one with the debug patch applied)? I need to see where
>>>>>>> "lost arbitration" falls relative to the trace above.
>>>>>>
>>>>>> Sorry, picked the wrong file while preparing the mail, it's here:
>>>>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg
>>>>>>
>>>>>> Ciao, Thorsten
>>>>>>
>>>>>>> Separately, from your DSDT: NFC1 (NXP1001), which shows up as a child
>>>>>>> of AMDI0010:01 in your trace, declares its _CRS as a raw resource
>>>>>>> buffer containing three GPIO resources referencing \_SB.GPIO -- one
>>>>>>> GpioIo and two separate GpioInt entries. Not sure yet if that's
>>>>>>> relevant, but it's a pattern I haven't seen on my hardware
>>>>>>> which I've tested against.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Hardik
>>>>>>>
>>>>>>> On Sun, 9 Aug 2026 at 21:49, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>>>>>>
>>>>>>>> On 8/8/26 22:25, Andy Shevchenko wrote:
>>>>>>>>> On Sat, Aug 08, 2026 at 10:31:28PM +0530, Hardik Prakash wrote:
>>>>>>>>>> On Fri, 7 Aug 2026, Thorsten Leemhuis wrote:
>>>>>>>>>>> This became 0a4bb2abc3e56d ("i2c: designware: defer probe if child
>>>>>>>>>>> GpioInt controllers are not bound") and causes a regression for me: the
>>>>>>>>>>> Touchpad in my ThinkPad T14s Gen 4 (AMD) stopped working. From the
>>>>>>>>>>> kernel log:
>>>>>>>>>>>
>>>>>>>>>>> i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
>>>>>>>>>>> i2c_designware AMDI0010:01: controller timed out
>>>>>>>>>>> i2c_hid_acpi i2c-SYNA8018:00: failed to fetch HID descriptor: -110
>>>>>>>>>>> i2c_hid_acpi i2c-SYNA8018:00: Failed to fetch the HID Descriptor
>>>>>>>>>>>
>>>>>>>>>>> Reverting this change in current mainline/master (f9a2394a23482) fixed
>>>>>>>>>>> things for me. Full dmesg of current master and master+revert can be
>>>>>>>>>>> found here:
>>>>>>>>>>>
>>>>>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master
>>>>>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>>>>>>>>>> [...]
>>>>>>>>>> Two things that would help narrow this down, whenever you have a moment:
>>>>>>>>
>>>>>>>> Thx for looking into this. Here we go:
>>>>>>>>
>>>>>>>>>> 1. A DSDT dump
>>>>>>>>
>>>>>>>> https://www.leemhuis.info/files/misc/dsdt.dsl
>>>>>>>>
>>>>>>>>>> 2. A dmesg with dynamic debug from a kernel built with the attached
>>>>>>>>>>     patch on top of current mainline/master
>>>>>>>>
>>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>>>>>>>>
>>>>>>>> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
>>>>>>>> [    0.619018] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
>>>>>>>> [    0.619076] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>>>>>> [    0.619079] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>>>> device=AMDI0030:00
>>>>>>>> [    0.619080] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
>>>>>>>> NULL, deferring
>>>>>>>> [    0.619082] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
>>>>>>>> [    0.619102] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
>>>>>>>> [    0.619104] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
>>>>>>>> [    0.619159] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>>>>>> [    0.619162] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>>>> device=AMDI0030:00
>>>>>>>> [    0.619162] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
>>>>>>>> NULL, deferring
>>>>>>>> [    0.619164] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
>>>>>>>> [    1.122517] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
>>>>>>>> [    1.122523] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
>>>>>>>> [    1.122625] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>>>>>> [    1.122636] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>>>> device=AMDI0030:00
>>>>>>>> [    1.122639] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
>>>>>>>> [    1.122642] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
>>>>>>>> [    1.135894] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
>>>>>>>> [    1.135898] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
>>>>>>>> [    1.135976] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>>>>>> [    1.135980] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>>>> device=AMDI0030:00
>>>>>>>> [    1.135983] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
>>>>>>>> [    1.135985] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
>>>>>>>> [    1.135987] i2c-dw-gpio-dbg: check_child_gpioint(adev=NXP1001:00)
>>>>>>>> [    1.136005] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>>>>>> [    1.136008] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>>>> device=AMDI0030:00
>>>>>>>> [    1.136009] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
>>>>>>>> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
>>>>>>>>
>>>>>>>> HTH, Ciao, Thorsten
>>>>>>>>
>>>>>>>>>> On Fri, 7 Aug 2026 at 19:37, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>>>>>>>>> On 7/28/26 10:30, Andi Shyti wrote:
>>>>>>>>>>>> On Sat, Jul 18, 2026 at 11:13:31AM +0530, Hardik Prakash wrote:
>>>>>>>>>>>>> I2C controllers may have child devices with GpioInt resources that
>>>>>>>>>>>>> depend on GPIO controllers being fully initialized. If the I2C
>>>>>>>>>>>>> controller probes and enumerates children before the referenced GPIO
>>>>>>>>>>>>> controller has completed probe, GPIO interrupts may not be properly
>>>>>>>>>>>>> configured, leading to device failures.
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
>>>>>>>>>>>>> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
>>>>>>>>>>>>> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
>>>>>>>>>>>>> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
>>>>>>>>>>>>> fail with lost arbitration errors:
>>>>>>>>>>>>>
>>>>>>>>>>>>>    0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
>>>>>>>>>>>>>    0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
>>>>>>>>>>>>>    0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
>>>>>>>>>>>>>    2.348157  lost arbitration
>>>>>>>>>>>>>
>>>>>>>>>>>>> Add a dependency check that walks ACPI child devices and defers probe
>>>>>>>>>>>>> until any referenced GPIO controller is bound.
>>>>>>>>>
>>>>>>>>> [...]
>>>>>>>>>
>>>>>>>>>>> #regzbot introduced: 0a4bb2abc3e56d
>>>>>>>>>>> #regzbot title i2c: designware: ThinkPad touchpad broke
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>

