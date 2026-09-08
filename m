Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6053FD46;
	Tue,  8 Sep 2026 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871509; cv=fail; b=WpxshpKOsS6p7HFDv7itY5keL76anAW+gcxXF4SDWOv2g2qiE44hFBFipYp/ACehpOxGXGCmjGRphPfU83pdF+bZ9BStQZz5RPMlE+wQ4BpkLlxzBu3NiglfIrTzegqB2VdUe9Fjzdf8wttPh6bEGSw3N0/XDALIMMOAhV17fLY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871509; c=relaxed/simple;
	bh=yXZJitd7uTIxgPUMI9k0icr2nrVmtlA0ZYZScachyOI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=esEuryDiPnwEBLK9VoKjyCmmtwq2haZ2wAWszCHd/tNwhiHp/bBaPNT74GpSswSPlZE5bHWGkk26XRYrYen5P8KsomyNDDo9elLqv3lOw9ES4E9IaUHRY+29IEqeqspmIf9UqG9mvAoD87UgWL4RhcALZfj6/tsaIMOI7ZKvnp0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lyGHr5Da; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lyGHr5Da; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lyGHr5Da";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lyGHr5Da"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WIU0y2sTT8q83Xb1cmjF93rd3THFdB/HXzcy+9Z48HCDQGiHMgrx3qObCZiK8oDm7ZevzRYBbZ+5d7qvkJw5H6uq9laUHwzxPvqsE2yAivy/9y6C9zvDcAE2uOLC9JXMYyJCYF3xfgYxP//CDDp8e8Eb/pP84X8+n2bGTN9p57yLvDV9IObLureIoPjDZoDJIJXtI4N1xxfTj4Eln+SbJhaX/+h97xWUDmS6+wa9gZTRTayyK8NkDOziSqvWZ62SkNAxXDTttTvaTwLmhwM+lEFjOWmFPaXQNDcLVjFZGwi3Te/3kPGM8wied4VmVXjk9vUnaY+h04V8QEVYbollBg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXZJitd7uTIxgPUMI9k0icr2nrVmtlA0ZYZScachyOI=;
 b=ZKfZ+p1PtVJZQ7CvMULYyqfEbJF3Yjtdb3a/tnzf0p5Bk0EO655HjcFF+h94XlZH/xkKeE6/d6bx8T1CheCxDhBtxMwgqxJkeAtP2RSYbf9gecGcPkg7hR5xQOh2B0p3YkAeql4o+UcAvKxGA6KHGWOrTDSelznARC7ewplSHsxOM8qvwMrLL0NdkcMHE9EjhB6NuTMp6zMGzugwaBpBSVauL2Il9st4jqu1wQpNpC1FGJlllYXwQq5Lq99hYrGbG/UmWRFHyHtS4kfElfBSmV3eQd464trZMMTBvNZT8TyL/9bo6ER3a0QBC4TNgAHv/8V8uQs45KW1LgJsGIfU2g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=starfivetech.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXZJitd7uTIxgPUMI9k0icr2nrVmtlA0ZYZScachyOI=;
 b=lyGHr5DamWGRxHy0HHocjIw4YKlRAH4R0Nmhc8iY0YTOVjOQQVkcBIpEAtM9WGO0ow8/Jt4Rq1Friee3w2CLHFYRCociO7k9VAc235m0oht6gVrIAlI3hzj0jtvp8saFY0osPMzFFHJz3/blbxt2pyT8AjzEr5ULcNSZbMUnUhk=
Received: from AS4P250CA0020.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::9)
 by DU2PR08MB10160.eurprd08.prod.outlook.com (2603:10a6:10:496::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 12:45:02 +0000
Received: from CPH1EPF00000525.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::a1) by AS4P250CA0020.outlook.office365.com
 (2603:10a6:20b:5e3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 12:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000525.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Tue, 8 Sep 2026 12:45:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbBJ6vRezWM6RqeSTA8VlB8QacVWaTbBGkCveKvl5lX2ZpWeS/utmfc7vop1MDs3qjOtPR6EqlYO4vb+t4QDRlVfQVQpemkZHk/tcKpqgdC833E3zvJivq1pFlK8tWnWbTxhVPRIA6oNV4mWYo0FMqf6XPTbWkDWvrBtMKNZ1IMSbrbYzP/UXJra1bUHU/vCCdvZV1ifYxYvwjI/b33ajI1Ifb2t6WMUQ6msF+yVhEq860rgD3OCn1AAMNLy72JZERBvzDkqZM2alYlGMF+LPqKU26XonN2LIpbHtbtFqjU49P0ineJBGOccsGwUdJms/lQIcxggHsKbsnanWSQuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXZJitd7uTIxgPUMI9k0icr2nrVmtlA0ZYZScachyOI=;
 b=UnuH8dCRtFbStl8Pm5w8eECxb4Ly1iSNa5mNKrHN//zMhHRs6m/qB2npeeftoYl2cFpErAJ3hLFB9A5CkxslMXNguYajbNRdieKytpEqnt0E02dXAAbBBrhaaEXCqyTYlWWrXtMaOT0rlL7GZVDTBbIMgkVW0Kj4FdxK+AA3Jk9dq3VMTDAEVNgTFoFiIT3j2qJsrMa/3UF9o01uxr6vvtXBQ1ni2gj+pgLhiBPaqjiyF1w6BDVMuN8ahCxyzUEHLAlKjv2Ntim3haFoD3XYA3sQk0Bo/4gCInhffVxS9Q2Vrqj3M2i017tiuYSICSpoNQPuRSUQhE7faniJSRjyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXZJitd7uTIxgPUMI9k0icr2nrVmtlA0ZYZScachyOI=;
 b=lyGHr5DamWGRxHy0HHocjIw4YKlRAH4R0Nmhc8iY0YTOVjOQQVkcBIpEAtM9WGO0ow8/Jt4Rq1Friee3w2CLHFYRCociO7k9VAc235m0oht6gVrIAlI3hzj0jtvp8saFY0osPMzFFHJz3/blbxt2pyT8AjzEr5ULcNSZbMUnUhk=
Received: from AMBPR08MB11569.eurprd08.prod.outlook.com
 (2603:10a6:20b:6f1::18) by BR2PR08MB999862.eurprd08.prod.outlook.com
 (2603:10a6:2c8:9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 12:44:27 +0000
Received: from AMBPR08MB11569.eurprd08.prod.outlook.com
 ([fe80::5f1c:3cee:d582:fdd4]) by AMBPR08MB11569.eurprd08.prod.outlook.com
 ([fe80::5f1c:3cee:d582:fdd4%5]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 12:44:27 +0000
From: Ritwick Sharma <Ritwick.Sharma@arm.com>
To: "lianfeng.ouyang@starfivetech.com" <lianfeng.ouyang@starfivetech.com>
CC: "andi.shyti@kernel.org" <andi.shyti@kernel.org>,
	"andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mika.westerberg@intel.com" <mika.westerberg@intel.com>, "robh@kernel.org"
	<robh@kernel.org>
Subject: Re: [PATCH v2 0/3] i2c: Add Starfive JHB100 I2C master/slave support
Thread-Topic: Re: [PATCH v2 0/3] i2c: Add Starfive JHB100 I2C master/slave
 support
Thread-Index: Ad0/ipf1+jw87FKjTrCUGaA5OTV97A==
Date: Tue, 8 Sep 2026 12:44:27 +0000
Message-ID:
 <AMBPR08MB11569B5AB70EBB53C3165BB3198B12@AMBPR08MB11569.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AMBPR08MB11569:EE_|BR2PR08MB999862:EE_|CPH1EPF00000525:EE_|DU2PR08MB10160:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a70762-10fa-424b-bb09-08df0da6ff3f
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 kGC9yF4e164vnwoz/4NVZsFJr7stYhpi0KM8FTmKWydjt7gyKmQh1xv33AzRuwlCkiUNKMPzBFPTg2A5CEUoVmpqoWggaeAzsVZvFpvj4krOnHijEvVim0hLLTjUvmVyK1aN99N4qBYUFuChJhhGjklyEW1maXrZzN1sjDWi9f488Gtsh3qxe56LVLILhuRtsKGjBgpx0GYBt1LLezfZAeWNCu8Z37Rsv2V5K1fgHZ6dHAj1TQyaPol5EWjabBfDoz4i7AyKz3qAul2FKvyeQHE8aftv+Gje75V+4lpQrP53NPeiBki5T4fpFd3q5R1+PkQXyjRqlXEcXWIWYvQAJjexUBvi1cCV8rJj1ZyYXED6uU8acQbqM/f2Wac8MZUFuKevnDwCtBQ+SOk93dVayZfPIZv/8+scJbfYTLS/Z6fOoHYcXrCWI2zL3ZTgDIiVuWVDRdzbO2Abg/hZfmB0z0O/yTYHU1cZaDDZ7q7gIepI3Ng+S9lrvhFHyeX8ihWksUUzhU2dSjZmkN7qenYN91Few4lXdBv7Zu3r7FqkC/rC+a+0atk0FvmO1i6JjkhpOx++IxX80D7adR4O4C14OIC5pIgggM80BmvzqqGgSY9kMkyUKKApcySJq6jTPbOVNawFUk4MeumCa1sDvZT87hBSgYT9BSW0Gf4MAeUhtmE6iDkmbw/4UB+Fue/XF5sBPWXW55Bq6nUSzFslJ7BTb71Migi7wn2Qs687jHusRq4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR08MB11569.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 lJHa8gN9nlrSM+ffMC5u/dcesyNjiOvy1M0ZVB20g06cfHFiysYA7N7zNowCmBvF/yQE7Hu2aVRcsaG3qaeo3KjcuKATheSwAGr0t2+dBvjQI06YSKTjBUA5X2vskiNJXrsL0kLGp7+7uSXD7991kLrPChrImtAYJIz5GlAJJjhWe+KRQDEBKG92BKNaejZcaAg4gGzvCo96snX+UjPCHdj1z97KTPtkrToZRiwWqYhij3kIgJe7dvppRSK+Wpp1/Q3iLrE/dSm8QZqtKtbnhikoNj9IIXeiRYOJVKMF7bdLdxtfY6ldY1rYQ6HsVTeNCc7x6lS0oAqsLxqk+J/7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR08MB999862
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CPH1EPF00000525.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	608e85ec-c819-4e45-a18c-08df0da6eb7b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|14060799003|23010399003|35042699022|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	tkr0/umZJbun09AFYgtRqvrrauME8xVfVkwWH3w3e+1hVInRKZHmMixLgWf5DYKyeabr07JTDtN3aNJNd1/STIhqM1nY65Thd2QxY5+jA6abj065GvAT+c5a8bVqFXIFmKu1NleBjHlP5z1TqLOhD0/3UpGDpKExu/Oa2LgqS+h6AUILWKy4Ud+1rMaqsRF2sRipoOUxoeLA8o5IJpbmhPILjxPcLOBYoPOzsQSjzJPAfFqrwnvCFTFRrldqL1Lkos86vFGURbAi54VBf5ylS339bJIA3/REo5msOfUIGh7WyOCck9c6SBBpFMCyM3M2TQkVkKZH6nWTF3HqejM6mT8CcAH2z8HNJtXgWZR4enh7QELDsH2Y2KuGCamz7XaESVt0Cyz9VaC0yYyIoALCfSai2o7R9u04fOW+TdkWokIrZIt8j20apW7bdMmrdseZ24MwBc+wAp8KHY7vesfgCZpju1IeAap0sqObdx/ebZ7wSCKOcCD6USSwFUOH8dekuT+ClgBNy4DydnGPJWUSkB/g4bVqT11hQ9ow3F8osWifvUMu/4jBOIORcyzXvvYQzokbhO2P7zDnrQU0inTrMPprqIdvssVcpaTMqsCKPa4Nbv7GNflcIlQjYlkz42xNT6RcNhWwfcZyfHotzK4Ox39i0Q7LkITVp3sm4qPLTTf/58nxvz7fkBu5QyUckYeUDgWzqqcz0XR0TmwyFfBeJA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(14060799003)(23010399003)(35042699022)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9R3wZv80Hiy/xrqs16wsp96FOAuVU2BU143w6cEM4bInYyVqlmpXT/DWvtEUwjn5NKF7VSql9Vsg0dLddB4cnF7VOMEHeI85R4zMnoVlDVD+ZRl6eZ1B6XxWF7Il9QHC2RVBqf1GJo9/QEfl3pGGr+c4TLuUYjL6Yf4k0NXaD8Cebwi+8J7CLMZaLjDgUUWNMFU/gBIxpSjOTfHmVCv8N+S9G4GdbQi7Nl7619lV0dwGXcyAX7r7Ji38Q0JFaiVVgglaln41GfBePtYX/tIzqtXyeLJMfcRGZUwgCmRqbxpFDcp0uINQrRTYiDLlEDJEDYBUqIWQYOnjvhI5W/zyTRbic82j6COSfhoE3WYrbj7aUf0usThHpb4DaGvQ59DBsL+AQ1qkietQ/Lh/HjfcE91iLz+M7yYTC3MQv9T/ILhPaik7IQMExYP1IjsmHu35
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 12:45:00.6672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a70762-10fa-424b-bb09-08df0da6ff3f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000525.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10160

On Mon, Jun 08, 2026 at 09:48 AM, Lianfeng Ouyang wrote:
> Thank you for your idea. I will modify my code in this direction.

Hi Lianfeng,

I wanted to check if there has been any progress on this patch series,
or if you have a timeline for posting a v3 with the proposed refactoring.

Thanks,
Ritwick
