Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794986207;
	b=gKYHpiDEYx1WEGRdHV46hpdUyA2/kvkWUlBE8qdlOMb2vx1jZZEv8pjVRGNrNZSVJjSs
	 WF06RsgiuGm6SWiyO9UO8vUa1o7oQbFIx70ssTFfTnS1sN9Fd1AMStGoiXU/QnL97unej
	 yvTurB9DoHMac/kLrrcXhpQzSAk9XPg6faup6+FDMGLn6FG7qNzDNmpQobte0/kDXic+s
	 hADTT7FGzn3d/VZy//UT7prOFR3aDEr3h9GPqeBUVwGxi0Tt54P42F0liRdPb26rKLYd4
	 QCIgKa4Su8jNI/cp8UspCo6OUxpOBPnJzUET7J6ktNiDPnEzYEEXTZKS8liQuDIYEBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986207;
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
	bh=jtSp0ZB7sgXukH75sBJBAz125XSdL/1mzf9dQU9FxRU=;
	b=DMKkyMj+vjrDQXWTaBULSYhyP6i70qCNlYZHvE+oQ4wrksukeuJhib4nOu+nKsHz7++D
	 FgKM4V+uCruiWsq/G8LHjzj992T2LJkfI61nqKzBBQJj+aBxXimIV8L2GgfnhnlQgPthM
	 0hCubdyYrQTNFiS7fktO82C+mJflcQhjNbt2uVFEAtEjRFrnenEpmb+hrGIAPpcYv9s0j
	 1cbtXRa+aMDKHSQq0ZCpDBUtGQb4m0u8KSCifj6/uZi/aQGuBTx+YPYI4m00QIvhdqwy6
	 gt+7JqFKAOd1wcZTDZ4RRxBL4fbdvCTtPs3tZBgb1C9z/5sBHeDHofxxeNhrAVrgPTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=jbTWAW23;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.112
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022112.outbound.protection.outlook.com [52.101.126.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF9606A31C;
	Wed, 18 Nov 2026 07:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EAF9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=jbTWAW23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NO9jaa0wwOOetdn8OJcupFMslSzTOSjSlf5r8eRhPBQstEm+QE/H5W86VR++BdNYmiNHE1hQ80hSjRChlOaCHS7qiLwAwk+Pq9WnWUjj/kL3FNPq8EcLPSORqpsiyt+sF+oxFEVAG2Bo4KyY+r9GpU3OnTrsZ6z8+LFXwnhICTEoGZE4G1dbqBZc9/i1TcPajPkYSrrSnDG0Ur79fstmvW0xazLrqSzYKERqVMA1tmXoZg90+Qg6is9MPvcFd2qzj7pKVA4xEf93iLKpUpUFz6twz4DhMF1SsMBXdfdQmhtmGcP0jva//pGkVxGrIUS3K/i7vnVM/0PUnirVHZuCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtSp0ZB7sgXukH75sBJBAz125XSdL/1mzf9dQU9FxRU=;
 b=XXOWW0IPk23ZJo/3fvZkkLWLY3rcVzu9S1WZ/IgUNPib7WABTSkiXBcmrRdOF2itaWlZVQbjB9ZAwDYGWPPu6iTyb5Oq6AphwwbH9gj4ikU1pI2CIZ7lPyxskP4vmF/vLUyM/zwc3MuImAxhySEl1/1mfJQUd0Pz6VxWgsv11/nJdyavd9XXhQzzv7sw7Zp0KnzWAs77/4dnXf2P31EGHZpFzkRJbUcGkHVQeZb0NobBLTxSZvJK0F4sNYW8lD1zY6y+b4cHNQAfMXKs/R2wFhyBhPJTuvR/qBpT0kfrZCm4BFJLdufROmBAP86CGE6S6LcX2fQIx9VmQbXW4r3xMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtSp0ZB7sgXukH75sBJBAz125XSdL/1mzf9dQU9FxRU=;
 b=jbTWAW23DwKT5m4DHyyx4H3DUyp68MaMFwiJFNTGtVmIH/iG/dDcem7t584ZtNOehC9nrpAcL5A3N3ir0jGSaHFnlaG1I4IkZpGrJ0TZ4tJFK4TEm6AkGin4wHfL7xvzNLkfVUNxaT/F7ekWSSEh6TKmlEXCIQprswaF7HTxbxVOlv2doQMuhKU4UClHLd9c/fYrlxrBwV8uiWIoz/WIvxA80M9hbhLVmC54eRjfZBCaY86/PP38q1O3abwt/qkefLtsUtXKGxlwDQhDjrGyxQ4Y2NI15rhhMX6bWNTNT4Ublx2nvvyU2va9Pibnz8PF2boI/6UEONOuz/puaXDsBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB7889.apcprd03.prod.outlook.com (2603:1096:101:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:16:43 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%7]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 07:16:42 +0000
Message-ID: <1282161c-f1fe-40fa-a539-f95fbdeb46e5@amlogic.com>
Date: Wed, 18 Nov 2026 15:16:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] i2c: amlogic: Add Amlogic A9 I2C controller
 driver
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>,
 Junyi Zhao <junyi.zhao@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20261117-a9-i2c-v10-0-33ea9aefce20@amlogic.com>
 <20261117-a9-i2c-v10-2-33ea9aefce20@amlogic.com>
 <23a72c5e-7eb7-4a4e-9f06-fdc4976b05bc@web.de>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <23a72c5e-7eb7-4a4e-9f06-fdc4976b05bc@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0200.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::6) To TYZPR03MB6896.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 773ada8c-fea2-469c-7c3c-08df4543e57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|4143699003|261026121527099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lHJ5pYciV/9IbPES7D4RCI0aDhU8CofcZdjKHlyovqF9AampdVa/a8qKhap4OOuQpNtwtpg5obPW4Fa3Tb/YNhFi6iunTtYN0KFNqNKFXYRAV4UCRqHjuOuXxWo4Nk3mNZI+eB+5yGO6AebVH1xxxTKp9KIoMSet9gOpmQzf4fXx0I9IYRkc9d7DRyLOV1KzSRhqUd2c4Q2qVVk86Y9QLNzIkVkMofSpSyDzTD57qt5lsrLX6ZV3dEIiH5jy/EU8xLD/G2jBOv8W5Kzn7i0FWR1zuTykvg3F7va3o1JgA9e5lD3jVIctiRD64CP5rJUXGZrLJv3rXOVkuM6sapr5u4CE//cCZvvZSiZhyZSmbgLOCKxHnIs7eSMqdjczFeOS88AgSBt/YhNwm/Hy4qkDHbR6uM8zEdShDrw8mBc4sdgdZdSX2Syzlxcncnkhz8PNwnTrkCSIZjUc7Nz5ILAfl8Qv3+5vheCRtBfSfXXbhlyc5QIGnSwXH6AXi0Ih1HN4sd2A9Ie7VlhR93k5i8liPt+ewI1b1sjaaqnSngoxrr5+RfQmaAFdW/jEZhUXUjELGyiB6g6Uf+YCNT4nVnLGv4L1Lub4bis/s25nDzo8ujkctkqp4TC0jmVo8Kwoaqvg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(261026121527099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmJYV1BzWStwYjhBWTRjOUdJWGMyeWg5RDBpS214V3ZqYmxzRURZeWNCMzVC?=
 =?utf-8?B?TmFNMEU0TEFoMUlCdVIyZHRzWVdUeE00cUoxRWZVL2MxeHEzcFlWNnN1V3pq?=
 =?utf-8?B?R1A5ZTBqTHRpZG5mVXVzN1RVZU5kQ2lnWTJ3am1ob3JiV0NlWnBpTVAxcmpu?=
 =?utf-8?B?emhkbjJzeklUbWswR1RYNkNac2tpdXhiZExmWHc2TWtzUzhoRTZRQ1BVeTVW?=
 =?utf-8?B?YURLWEJQUlV0NHRISnpjMnBLKzJ3WFNrYm55K2RBOGkxVDd0WHVWRnU4cUxw?=
 =?utf-8?B?bjArRFZVSXBDTlJDUG9aNFhtRC8vNlRIZzRaSjROQm5tN0hoNkpUdVpWeU1r?=
 =?utf-8?B?aW5EcTU4UW1yenR2bTdBMFJjdVVBMFhleGR0dTZ6K1B1dXhHdko5cUhNUHF6?=
 =?utf-8?B?NXA0YkhqNjVlZ2tmUFVRV0tZWEZHVGVIai81TDZpRmY0bCtXUXBac21RSWZp?=
 =?utf-8?B?VGFTNXUyRXI2S1ZBSmovRnQzeHRWNDBUUHRQR1V2VGx1aEFiWE1HZ0pDSDNJ?=
 =?utf-8?B?SURQNmt6Lzc5dHlDTzlnUlJUdkFRNGYra1hEL1BwckpOWFBvcVB6c3RHaU1X?=
 =?utf-8?B?NEMrOVZqV2dwVGdKMzRhSmVyZGlQc05Rd0N2R3BLeXYxZkRwTVQ4WmltYzdz?=
 =?utf-8?B?U3kzd0tpb2dONW90U2NPY3lQcU4wNW5EdVphcE96NzF6ZTUrZFR3RHVXUUpQ?=
 =?utf-8?B?ZVozMTU5WUJaUjlxb3ZBb1drM2V0M1MwNjBGMmsxOFRMenk1Nnh0dmhHOWlw?=
 =?utf-8?B?MlNEblhaY21QV0YrcEhyZzRZMlI3RFlGMzR1Z3FZb1NVWC9NMG13R0VMemZ6?=
 =?utf-8?B?Mk03c2FqWkd6Qk9PaUtNK2ZaNmM0Vk9aTnJDMGJaNUJIeU9rVzg4VVJ6SFFv?=
 =?utf-8?B?bVM0UU43cDlpTVZoYnR6WmYwOHQ4dEdkUUZOWExlODRDcm1XMWVQODdSNEpx?=
 =?utf-8?B?M2FFbldjV2FjUElQcW5hNWNGZ045UUxESWRrOSsydHFzSGNJcmpnZlVuU09K?=
 =?utf-8?B?bCtYSjc0UDdWLzZjSW1zazNuYmZxSFRaS1BndGlVTG5XSWdWZ2ljUkxFQWhR?=
 =?utf-8?B?S2RZSGQwVTFMclNqNk5mbEZ4dnVqTE9wVGpzU2doeTBwNG8yUkkxMTdReGNl?=
 =?utf-8?B?U0ZQOFdkSUJJR2hPU0syU01xV2hic2NuRlBFMzI1VGYwOVhoaUJwK2tjRTFr?=
 =?utf-8?B?NU1IYVJZYWZkeWNmYzRVeFRTRXhLQXlqOWJnQVBGaTBzOGxpTGsyUFQyekdT?=
 =?utf-8?B?eTJzUFB2YlJmVnhSZDBqL2oyaEwyZ1cwSDNsQzY1MFVzS2FLNU9tVERGak10?=
 =?utf-8?B?TEEwbzFVZE9SVjVMVVMwMm11cmVKcFR6N0doQ2RxUi9aY09aeFlhbDZzNkhp?=
 =?utf-8?B?dGxwNEFJc2RnNy9RVUVqcDFNMmVFa1NpUWtOWStBQmh5Vm9nVlZDVWhwbWlq?=
 =?utf-8?B?SVV0VmtnU0pXeDc2VS9NTlpNV3hrTUsycW9KWVdOenFJUTc5MDEwUmNOSncw?=
 =?utf-8?B?R2NKSW9CSkJDdVI1R3RITkJiNTF0MXF6c3krdnJVd3lOL0JPL0hrb09sOGhj?=
 =?utf-8?B?TnFYVUkycXg2Q1NzSkFhY1EwTVVkSGZ0Y1UrbXk3R3FMUytEK3ZQeFAvNGs1?=
 =?utf-8?B?eExzWWlDeDNyV2F0a1orSUF1b0VqS0gxTnlaQzMyTUxyS2o4MkNUc1dFeDhq?=
 =?utf-8?B?UjkxelhUNHEwdFY5bWp3bW9lN1daWjBzbldVc1FwZzhvMytacktlSXJWamxO?=
 =?utf-8?B?ZFZCc01NbmFncFB1N1JCbUZRWERtd0o2a211amNQUE1xYVJMN1ZxM21oeDkv?=
 =?utf-8?B?R01nY1BJUWlIT281ellNbGxHUGF6SlFldW1UTGlhTFhudmwzNGtHZTZ0Nk1y?=
 =?utf-8?B?WDloUmM1K1F0dHBCU2ZwNjFXa3EvWkZUb1ArYmp1b3NSODZUZmc1K1FDZnpp?=
 =?utf-8?B?eDBxWmtoaGJGU3p2aG5KVTJGR2k3amIweUxSZm5tZnZmR3JpSm1sY3g3T0tU?=
 =?utf-8?B?RlpwbUFsWnkva01vUGJad3pyb3NFZldYd0xZbWZnbEE5NkdLZk1OMi85Z3JI?=
 =?utf-8?B?c2dKMUIzZVpQK1MybXhrbUVPOEM0R0NSSDFvZjVycDBveVJobDY3dllvSnU2?=
 =?utf-8?B?WFlqOEpJQXRRTHZhS2cxSGsyWkdzZXI5ZzFkYWE5MnMzL3pOOXg0YmFUNDhq?=
 =?utf-8?B?WDhuOTJldTFHWjRGa043SnhPUjlXc1EwOGIvQllHTy8yQW9sNnVRTTV3NWFr?=
 =?utf-8?B?c3NOVGxFNldhcFN2dGEzQ243aURhZno5RkZTdTNYeE9FYUVqbGJVMkZ0Z3VH?=
 =?utf-8?B?M3R5d0V5WEZ1QWVKSVJzS1UyVVhBcC8vcGdOeS9ESk5renBPdHJMMzF4VG50?=
 =?utf-8?Q?BqbomX3WwNUf1b9A=3D?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773ada8c-fea2-469c-7c3c-08df4543e57e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 07:16:42.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ivnb1lWTgOt0u57gScIFRYKdL6o6rJXkn1sCTZcnj/P0dnEYaK0hdIGjy10bCX2QmN95fD2GdA1D+oPBL2wJAsZEfLzIMvtPn/hUsycEzjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7889

Hi Markus,

On 2026/11/17 21:21, Markus Elfring wrote:
> …
>> +++ b/drivers/i2c/busses/i2c-amlogic-a9.c
>> @@ -0,0 +1,428 @@
> …
>> +static int aml_i2c_xfer_msg(struct aml_i2c *i2c, struct i2c_msg *msg, bool last)
>> +{
> …
>> +     spin_lock_irqsave(&i2c->lock, flags);
>> +     i2c->state = (msg->flags & I2C_M_RD) ? A9_STATE_READ : A9_STATE_WRITE;
> …
>> +     /* Start the transfer */
>> +     aml_i2c_do_start(i2c, msg);
>> +     spin_unlock_irqrestore(&i2c->lock, flags);
> …
>> +     if (!time_left) {
>> +             guard(spinlock_irqsave)(&i2c->lock);
> …
>> +     }
>> +
>> +     return i2c->error;
>> +}…
> Will development interests grow also for the application of another scoped lock guard?
> https://elixir.bootlin.com/linux/v7.4-rc1/source/include/linux/cleanup.h#L325-L328
> 

Will do.

> Regards,
> Markus
