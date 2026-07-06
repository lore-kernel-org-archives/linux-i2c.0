Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011026.outbound.protection.outlook.com [52.103.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE91C5D72
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 05:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783315168; cv=fail; b=Q4bWfsKzcgHZmD76Kc+uYwWqxHbLBqNtEvk0MdHoyEDtQgCWgM/NndWACIXr83uBanb6BKnmhkMQLmprua9MBuS06FieDMuAo4/b/vf6MPaQd2qklAiF1/FwbzHGe2stE9Tg9VoCnvtkWHEAt2Hd+Nf0xXPNsnj8H1denesnrzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783315168; c=relaxed/simple;
	bh=9YhB2dOiL9zLhmzaS32VprOdIC+4jGzHO+OR1ZTkPQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LlkoPT+9280PHfDOw76K2g2BaR7yMt6d96qjADwKsb4pwzOom0TjIBfBTZooFk2uc1IFfuFVcvSC0A82m63Smn8+7L/PAqyB8necPs+vEeZ1iZRnaLb0E91VfVCZqRtL5tFxHuO9s4HKt1Vu53ToVtmo6S+Gj52ICHC66gjp8qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=TvACO0nP; arc=fail smtp.client-ip=52.103.72.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="TvACO0nP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIoF40GGypLzsDwAfLYbgeMC1bBOnFWvhzb4JcXMLsPiD0jlKSI0PKhzXd9uniZDg3baRjfObWGp9lbX4W4lBKEzQqZfaCDxOYAfdC+dw0aQ3J6Zx4SFrOWmTO0YtM5o6SfdNsisBqamzIkSVWzoUTxikD5EexjhvrMgStTifgXArJ7WtZaKQAN4kMcnhLnu3u2bjwFZTjE7BgSL958+cG0uQfMyXnH9VLC+dwHUJty8XhMzrvT87j+41ehNkMOceZzKvDPZZIGEmgDDMui4cIL7TClXZHQdNxe4B1C+av/QylVtEgJHT6DdspsjwB2syWWu5VLY4qF+lIqkPPmghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YhB2dOiL9zLhmzaS32VprOdIC+4jGzHO+OR1ZTkPQc=;
 b=fC2F3mVYge9/gXvQDJ730cEH2NreKyiIumTLC51TU3YjEF42DcH60aVtcUwQcvwUflv7zdj+z9mYEyj5U5Q8x/F5Qe7eMFm8epmFmF85I0VvGHU2AZmoPeEz2FhaaW3+Ll2luP3Sfi5QXP95yI/S1rVgPdaMjn5fYX02KVn02lOI2iNXlcvyUdIjqQyVqhlg6HNbEkwALk2lGeO2sOoJia7TBwH2WvqO9jULgt2bKOO05HRjO7Ew0wjrKVSSj/LxjVo+8hXNYOhuhEUqOg7FxbrW2v0g4ARomDEBGzFrZTr5ORZNt3YmC1WkpH3gdWx2GASZ0tyqCkzV4/iNRSjK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YhB2dOiL9zLhmzaS32VprOdIC+4jGzHO+OR1ZTkPQc=;
 b=TvACO0nP1RICKPRId3grlBtCAtWIBA3nIZdQgiwSRmkDrOIiKdqkPFJUwAnNccWZgcYn0QWnur/jOS+1VJe8HtQrMxWjPfrCpnlK9I+XHWtOjSPfcg8tQcYCUdAfpjj9YMg8veVL76QBoRThh0MA1Tmlyff/qyK6FWkPo1SlBezKp+s81S6lcICvsGn+Hu1ee8HFbBk+xq7dUg58gO+gdm3dGt/LXnBe3jzX00KKwynvwy1jY3lWgceJRseEgyLeziP2Ou2vJAqY86WfNuk1NprzOQYX97FAlw8jpIQ6LpzT5SjUkvtlZJ2DxL4RZnDiQCHHDsSNdrQmCDDqE/QMcg==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by MEWPR01MB9153.ausprd01.prod.outlook.com (2603:10c6:220:1f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 05:19:22 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 05:19:22 +0000
Message-ID:
 <SYBPR01MB4586AD69D431CAD2D26ADD68C5F12@SYBPR01MB4586.ausprd01.prod.outlook.com>
Date: Mon, 6 Jul 2026 15:19:20 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i2c-tools] TODO: add file and describe items for the 4.5
 release
To: Brigham Campbell <me@brighamcampbell.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>
References: <20260705181043.3757-1-wsa+renesas@sang-engineering.com>
 <DJR7QS1LOHU0.2PNA54ULDF2PF@brighamcampbell.com>
From: Stephen Horvath <s.horvath@outlook.com.au>
Content-Language: en-AU, en-US, en-GB
In-Reply-To: <DJR7QS1LOHU0.2PNA54ULDF2PF@brighamcampbell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0001.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::13) To SYBPR01MB4586.ausprd01.prod.outlook.com
 (2603:10c6:10:59::12)
X-Microsoft-Original-Message-ID:
 <90b7c3cd-0a03-470a-9eb2-0b8a1891691b@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB4586:EE_|MEWPR01MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: e19cf4dd-d239-4762-d9dd-08dedb1e230e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|37011999003|6090799003|8060799015|41001999006|23021999003|15080799012|24021099003|4140399003|5072599009|25010399006|40105399003|52005399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEZIKzBtN09qTmpBbE5NRW9YRDV5MEQ3VG5tTnJlRTJNZTYwOVBsMW50M2pF?=
 =?utf-8?B?V3dvTVExdHAwWTRpL0tUc1R2aGtkY0l6aXhoS2RTRDdSa2g0MmQ4d3V1OTlD?=
 =?utf-8?B?Mlk5bkpERnVHRGRvUUNQanhoYkFOdVI1b2xBWGhrb2J1b0tZNW9MeERvaXJE?=
 =?utf-8?B?T29hTnZoNVV5N2NEcm82OG5NSVRqa0hvU0Q2MHZCbDRYRzdBZzFybUNQZlA2?=
 =?utf-8?B?QS95T2RvLzhGS2R6QXo4RDFXQlEzK0pFS2hmSXJRWjNhaUJwS2pucU0vWXIx?=
 =?utf-8?B?NzJYc0FTVk1idG5abTgxb3h2N2hsWjNQclB4RERvU2pVWGRpZW5Id01JbTcy?=
 =?utf-8?B?M2dUY29rR1BVWGUvT0xBT0NPZG5ZaVhnMlVxMXdJZlFGVUtoU1pjaWI1dURt?=
 =?utf-8?B?RkxPd1VLK2NrVHF3amxianYvZ2NyeHJLZE9FNmxzdnFyQllLZ0NCeDdyZldn?=
 =?utf-8?B?WFJxKzlFZ0VxQmJIQTUxcER4d1pBN3hkaG8wYzMwN1BSR0g0OVpqblU0d0lz?=
 =?utf-8?B?WHkrOGoxZHpPV1YzbGMrY3hnRFlMMkx4WGdXc0xKaG4xRUY5VFpYbWQ3S25B?=
 =?utf-8?B?blJKNUYzTHBSTHh0cmdpdzNNK3Zsa21vZlZlSWZUSCtJeGhVdjNWdjVPRVJU?=
 =?utf-8?B?ZXhFZHJzaVB1UDdpa1Rsa1lnUXhKS1hydFZQaGdVbVJ0c3BKSnREa0E4Y2V3?=
 =?utf-8?B?TUZucldLQlR6VTRWQW5IaGM4blJ2SDkrWjIxeTlJT1BhRGxwQm95eXVhdVd0?=
 =?utf-8?B?bDVLMk9BQWNKTDZxdEhiSDlNZ2NRWVVmY2FwYmM1NTQrSmpjRjFONXJ4aWRV?=
 =?utf-8?B?cW9ucjhtTC9zVnY5TDRjUHVxY2lnVnI1Yk1HZWxHSWk5RGtrb0MyZlBFRGFY?=
 =?utf-8?B?U21WTGVpRUtXQzRwL1BKWjRsSC9kUWdDSjVOeHhvdllGYnBDSXN0ZDFRK2Jn?=
 =?utf-8?B?OURoL3N4RUliUzYvTEV1b1VEWlc1WUxnT3EyMVJUNWJKdE04OEgzcGdWMnM1?=
 =?utf-8?B?UlY3WS82TXZLS0hrSmY3YzIweXlSd3lteVZpeWlqL01VNjRFeExlSnNOTGdl?=
 =?utf-8?B?UU96QW11WUJyVTZSUnJ2WGlZaERoZXcvcnhUTGFRWjR1Mm84RHNaV294RDFU?=
 =?utf-8?B?RkFxL1Q5Y1czQ1RBZjV3MjZFbHIzSDBaYndhQlFURHV3ckJWdVJaMGJ0V3BX?=
 =?utf-8?B?WnJtSXVnaFBFbHd4RHhUbzlRUHdaSWpPemJOSzBvK3piMzlGNk5iV05BSjcv?=
 =?utf-8?B?VmovZ0NsRVRtZUhGZDJvdXJobEJxM1gxekI2Nkg3UUNsN1JZZGczSnZBWlBO?=
 =?utf-8?B?ejRhRlZsKytCNlVoSVphaExjTUtnaUtVTVRvdWRJYWR6MGIxcEo5NytsQzNV?=
 =?utf-8?Q?SHh300tzqXNf6XaqIYpUD+icbswGMC1g=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEltTkI2ZHVxK2l3NFc1MUJDSVBQNFlkSGM5blRNYkpYUkdvYWpqRDJWSDAy?=
 =?utf-8?B?ajdIZnRraFZsRmJWSmltSG9ycEw2N2QwbVdpM3c0Y2R1VHhDU2pTOVlReGYx?=
 =?utf-8?B?L1ZRU21Jc2hOQjJrMzVjdmp0SHBWQWROdjVIZmx2N1JJSFhxb01qWDMyZFpK?=
 =?utf-8?B?MWwvNlZQTy9YT1puaTE3RU4vL3psSFlvTXBLZVJPTzltSVNNOXJDR05BbHNu?=
 =?utf-8?B?Z1RLTDZUWDhZYys3aEEvUHk4czJJQTRNYnVSM0pIMzFnaG1nZFpNOEF6UUZ5?=
 =?utf-8?B?OC9uSkY1dlE4RmdzTFhJOEQzRVowZkpMaFI4UUczN2JxNXZZbjJ5aThDbXFs?=
 =?utf-8?B?dEJWWHZWWUEyNm5RNWQ2Q3FIZEp1ZVhoZmdrYk9RaWFuWTZ5OUtBT0dxRXF2?=
 =?utf-8?B?RlpaWXRhc3JVUjZ5WEFGdFdLbTJYOEp3S3NBMURkSzZCWWN6bTVXMTBsUkRi?=
 =?utf-8?B?WVZTZ3Y0VStqYm0wMjJrMFdobGdjQm02RnNxNVpqVmtJK2FybDA3cGp5QlJB?=
 =?utf-8?B?UDNJR25hcVNUcG5DQ2o3dFVaMUs0QmJEWWpoY3dWT0owSWtFM0prMlVYTTll?=
 =?utf-8?B?b0VTMG8zN1Z3MWtwVmx3U3dsWkdINk96ajdTVlgveFFXcHZ4OUhOMnRrUGdI?=
 =?utf-8?B?WEVGRXJlY2FoNHhXY0xTTFN0T2RXcDdxOWRLeDZoQnNqMXlZaVdhMGtqWUR5?=
 =?utf-8?B?VTM4Y0FXb0FKMzFrUVh2T3MxbTZEWjJ2dXRjeGxKUEtsVXRnN3FCbFU0bm5H?=
 =?utf-8?B?dDBCN2tjVUtoU2pNMUdIQ1gwWVlXQzk4Uk5kNjh1Z29UM1RwSzhvY29hd2FF?=
 =?utf-8?B?enM3RWpzYzd3TlhTZnBMREViZEFmOVFna0xPWi9lUmVFL2t1OTlSUGtEVjNl?=
 =?utf-8?B?QzBDbmlkVkk4YkFFS0VRK0kvQ3NhaE9ZRHo5RW9zMTlNNTJISUtGbm4zSTFh?=
 =?utf-8?B?S1FxU3VwNjMyUmlUY1JpUTAwVkIrQzgrZHhNVmdrMlp5MnhKWWxZY0RjWVdR?=
 =?utf-8?B?SXJyd1RKMU5yRk80WHNid3N0M1RwQTRJL3hRUmRreWg1R1B0bDBISlkrb2hQ?=
 =?utf-8?B?QWx0NEdQd3VKQXJwMFNTRXBrMGFDL0NJd245bkFCbGZJY21iSnlIRmxtY0xi?=
 =?utf-8?B?TzVqNUtFbWtFZWVsaW9GaTgxNW9XRDh3VG9YdGhpSC9wS24rQ0ZMdVVjUUZ0?=
 =?utf-8?B?UEMxeGdRaVJxeDJPU0dlV2ZoY2Z6VVdzZmNMZ3FualR4RytuZWNpWlZkTHVS?=
 =?utf-8?B?VW1xa3JXMndFUk5ja0xzWXdWT2xJbHJ5MVRzWmRESUNpTGo4TTdSUkh1NlR3?=
 =?utf-8?B?bmV3cC9qYjVZV3hJVnh1R1dRbk1nSjk1L2hiYndoMzdYaGYwNVR4d0xrL25w?=
 =?utf-8?B?RFl0OFV3dXlCODFyZnNCNDdsb3RGSlEwMm9rbzlFdkN0Ui81WWkyWUNuYldH?=
 =?utf-8?B?MWVsV2l6MGFHZ3UvQUZnZ1ZJSEJOKy9hSVlnMmJzYS9mZEgrY3dtbERRb0RK?=
 =?utf-8?B?dDlXOGpvZE5PbFdtN1ZIdFpVWGpGTG0ra0VQM3lBVnJ5TUd2a3h6WWVGMk1B?=
 =?utf-8?B?MUZlUG4rV0VyR2JSOTRnVmRXcU8wVFVGS2gzMzlvWHZFZmpvdFJwdHVIT2VO?=
 =?utf-8?B?V2FSQWVSd05PenV0clo1UmsxOUNvNkxaOWVORUFGb2dTUFBYYnhMeDZKWFJk?=
 =?utf-8?B?MnQzUXRYNDhzcG1qUlUzZEFpU2tKbWlhZ1k2M1dEQVFMRUI4SjdJU1ZhSkkr?=
 =?utf-8?B?ZmNlYmQ1V3VXbGVPL3dkQU9teXhMVkhQbk1zd2dmcENRS3ZlbW5wQ1Z6Ym11?=
 =?utf-8?B?S2JPK3k2cERQcC9WeTJEVm5aYVFqWGZmckFPdy8yUlFha2l2eTA0NHFhcUw5?=
 =?utf-8?B?MHN6THB0MjZpd0JPZWovMVhOSmFBOXcwZmhzRW9ELzJvSnk0a1REUTRPNGNO?=
 =?utf-8?B?UVNrMlcxTE9jR1FQcGdNbzY3NXlYeWpsbXhoUHBvN1JuTGc5cXQxdk5TNTRW?=
 =?utf-8?B?T0FNZWlVeGNBPT0=?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-feddd.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e19cf4dd-d239-4762-d9dd-08dedb1e230e
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB4586.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 05:19:22.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEWPR01MB9153

Hi Brigham,

On 6/7/26 14:45, Brigham Campbell wrote:
> Stephen, it looks like your series applies cleanly on top of my v4. I'm
> not familiar with decode-dimms, but I do have a laptop with DDR5 memory.
> If you can provide some instructions for testing, I'd be happy to
> exercise this new code and report back.

If you've got the spd5118 kernel module loaded (which usually happens
automatically), you just have to run `sudo ./decode-dimms`. You can
manually bind spd5118 if it isn't autodetecting, your dimms should be on
your i801 bus (or PIIX4 for AMD), usually with an address between 0x50
to 0x57.

If you're willing to dump the eeprom too, the location is usually at
`/sys/bus/i2c/drivers/spd5118/<fill with bus-addr>/eeprom` and run it
through `hexdump -C` just to make it plain text.

Thanks!
Steve.
