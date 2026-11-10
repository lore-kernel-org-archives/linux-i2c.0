Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794334237;
	b=YqUhVvOhIbrPaVfkfOgJHTNylQOV2754r04oXWYTvUIP89K+tDk9sdfBzdx5TY/fAaSl
	 78rlK6/di2ngiBjJ9siqk0gABqBd1S2cEmkk7eUraqsAZTuAIKjlKZPs8GGt04pCha1Qk
	 ziRCKbjfdbZCdOYMbTIZj3hoFd0dicz+kQBFtUGO1pQgwGkvAhWxzOqhaXsFchnCl9vv7
	 Lgz7f3m+Hg/YdKL9oYjwD/hzKY063aReOaMZNPXs/ainS5TSHXLzRWudPU/yuwkYo6MBN
	 MvPwvEoYAG7L6sUdajm+1FStgphejfRqk7CgpMlvGsFRygLBkylxZvHVnbkh1TXlSBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334237;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dgtKLNtOFZA/T2Oadxwz9RiJm0XyuZlVr+ybRYgN+3M=;
	b=CSe7tWc9D3IFFEF7BnSPD3RYaK3fVgg1jTLXy4EyYtCvVjy5lTPoaE1jX1o2nB7l153f
	 maTI/GIGbgyFyf8kfGgYCLNlX/Wj4pHBcYp91FkCzCUnC8eYbrKcTSE93kO6lnJFJ/vFS
	 snXogdWF6UiB3U8jJ4hn0zVwOh1cRW1cFt3DDLBj7OfFrkV135iLcck1eBPSoWjUbb3XO
	 GOT0or92lZxd9WYS7SH5w+EhMqb0gyDYFLNjySOILHJTywguekUrnJWwIgjTw+0654C89
	 kCBF4G3N+cKTZrve6Qjx580SCjaTB4M5Q2w7nVmh+VBu9psqz0rhp8Zto6mY67ZSFLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=HTh7et7s;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=RiX7i7rm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D5606A323;
	Tue, 10 Nov 2026 18:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 212D5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=HTh7et7s;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=RiX7i7rm
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAEwGHM1618227;
	Tue, 10 Nov 2026 12:10:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=dgtKLNtOFZA/T2Oadxwz9RiJm0XyuZlVr+ybRYgN+
	3M=; b=HTh7et7sNreQB74qo13U07eBRBEB1D2JnewxmMktVsbKGg+XY1AiD4VLW
	Olk8KHHof6sfoktbFGHyRLTejUtAG/VKWsNDwRl5i/aX3K8b9rTiurigzwvOjz0m
	8opAd0445Ib0Go86j0Kj8iwGSzi/bN7Yt0XL3ROmaX0vCB9GVu0xekx7n7SMmeqF
	TLRRfLz9b1dvJsWL1HjDEjR6SLIpTjaJW506UxanSfpYeVwq5cCa7xjDMNnZH9HA
	YrGt6MiC0ac3oT9UE3tD+ijAqbRceC+M4DoevYbeDPFfctp+9TXOqJRhAUbt0+iF
	wF3TwsR+y6/3NoaiuPZ0KOfOgidPg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hv0kstyma-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 12:10:29 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmlg3+5KigfYPIKQTzlDLryA6t8/o6NRaKevJAIIex/ya2pS2+w3CeFxM5EW4LHRDWwa2i21rlD1peYrd/cT8rJMqCWg3xbhMNbwiwT30Q/V6wsZFdXKE8cUY0U6QkhNVdqetj7viBkhHv5TZQ1zZStd3YIYlwRL9SQ0UaSGRtGXYDFkZ2WO+PLf1zq1bvG4+YFRHyb3vjHD11zgMhYPgNekAoyoRN9OrnNQGiuG5iCzXKp7VCn+gj4R/xq34M7v0AwS85qvgBxKrYw47IcEzbt1Pn8k7AkBU56E2fkbBkazipAN4SY0zDEWDuiM3gf1H8MN7EItgGUJFfQWVP/iWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgtKLNtOFZA/T2Oadxwz9RiJm0XyuZlVr+ybRYgN+3M=;
 b=PzIloEhfDuOutbO6Pf9II2NKPBBDzlxc+Qkb5hoKbVIsiV6enRvJclUDFqgmqZDkdfa6uYNaUg86wZSabIsh+cYFBiX/kbRuRffRltWf6MthhLe1Meg6PuTYzE/LmpEfBbREdL3WvQ6JYaHTzfrPT26By8QB4OL1a5Afmk4FipQZWi+UQR1N2lNl1jYxl/NQFqjnSILeGWjsspgJqKHbcmEBxfEs9OOH277lZtjZfR5XiUNHrPnRIlkdx3te7IohsDPmIKqbqMGQUEV4gybZ6SdvNchHoX/09d/maQ6CzXuDVcE9aYwwAa9h1Eftd2nFhfniNBGMDHt7PyiMXWUzUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgtKLNtOFZA/T2Oadxwz9RiJm0XyuZlVr+ybRYgN+3M=;
 b=RiX7i7rmRZyaIyMma61W6+t7LsVUzKe3vmhXC9ylVF6/kwWR/JW6T7SPWLHFYp27imjnkh3i++vWix481StpSYlIpUcknRFUd7ILZsSblNxWacaW145UHN1Ow41Xhprec4htshTDo8S8qWwU7HsKAFZqrpyUKeUYl1AWBTVHtGY=
Received: from CH0PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:76::17)
 by DSAPR10MB648043.namprd10.prod.outlook.com (2603:10b6:8:51d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:10:25 +0000
Received: from CH01EPF000BE940.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::71) by CH0PR04CA0012.outlook.office365.com
 (2603:10b6:610:76::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 18:10:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH01EPF000BE940.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 18:10:24 +0000
Received: from DFLE20.ent.ti.com (10.64.6.57) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 12:09:51 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE20.ent.ti.com
 (10.64.6.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 12:09:51 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 10 Nov 2026 12:09:51 -0600
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AAI9mKN2308008;
	Tue, 10 Nov 2026 12:09:49 -0600
Message-ID: <71014ac2-6108-4d06-a1a2-54b2ee5435c7@ti.com>
Date: Tue, 10 Nov 2026 23:39:48 +0530
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: designware: preserve invalid SMBus block count
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>, Andi Shyti <andi.shyti@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg
	<mika.westerberg@linux.intel.com>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261107081108.1046163-1-pocj8ur4in@gmail.com>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20261107081108.1046163-1-pocj8ur4in@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE940:EE_|DSAPR10MB648043:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bfa145-4eb2-41cd-11d0-08df3f55e42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261022075727099003|261026140227099003|261021123027099003|261028144727099003|261009223027099003|261021121427099003|261022105027099003|10067099003|261102123227099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RPqjBGo48eRgCN7eT/oNM6THJJrKmttRwF/SV+wtxWOjpL3XAt5iIkJI8C5jc42hBSjbHER1O4YVY03mpdWJC/RyVqgl71zJ5T7/GlYRV3bgIxHty6GBtBp1Rw/sYpzDXkTfux6AJ9hWeyp3T6s2Aym8ck4WdB6jr3WpECZOuNRSAou4gtdOc03Tv24rm2EVgM1O35h+h56DkoyPmOzJD02v4grGxVWNSBKH9vRvuR95ry+y68Lma8CsMqaatflwpzw9mbwNwpxRKN4N2au+TsaGv8FODG2hBvnq68qMhBhkf26dDagrEzGOye9bFstUs1Bz1pj5HZn8mFexhqR8HESPej73jyHtLx+CKdgtG0o+2Z6V4hi1Vu8v5AJTX6uOT/FwAubD/QFyoFDRBoNDOBEHuYg1F7flgujR4ZBhC1jlFDIZmL+x9QoBfBTR7PIXUm8oHZve7PZucaHinAyzQgU+x0kMrt7kxY6s8rLJdkQHOc1gJ6p3nLmPNk9TsyS8LjhPvQpANO8+ILVH+NgwOaF6LHonqbIAEIu1i6uGUcDe5QjBBjIKtyPcH9hdPHreB8RX09/X+o2SXrzCt5KYlZYEk0zLW1Cx2vh3psl5IarAsPusHah+wPvoYSf83IQ7nY7Amg0MOwNY/QY84L1j1A==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261022075727099003)(261026140227099003)(261021123027099003)(261028144727099003)(261009223027099003)(261021121427099003)(261022105027099003)(10067099003)(261102123227099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OQppbgX7bZMZs6RS+rn3bCo08rsZC7s5JI1kzyfNjUSqIg32Il4iv3lVdTvxD1BHMCqp3S7h5N7oQP9lPeiHnfDjtmmin7tZKTfNKltjbY6BJqU7PRxczCcgPbrb+hgOvH+0mhMZ7JpMFKufMArlYe6NtyKdkpCCX7IdwhOpd4rN+c6/B63cl63+prhPtZQzaLoAZkzfa0RmcIX78jSPNxLBHkOCwKfHd7e0nV087oeDo42EKHLsqSvIOebuHLzZEHS+vpb4/NwDYt0ZAt2oXJpkAeUC+fq4tQxrQJNMNjuFuVrdKWFx7g/P6lPoxOnucvFxsRcN1CdflCJnwlPrLekPrC7gbFd/+d+WMtdCEy8dwAZEN0fraMusunLMGFhpY111uNTU4NNsi9OMGDmt2ZBSYr62rwkbQp+9fIiGSxadhpXotWFVb57TUw9R4kBm
X-Exchange-RoutingPolicyChecked:
	Zs+WgaSCbbfeQX6wy8ONrwOVa++8ue/20mNysZlXb2RdRC2eSZEMcQUUX6g34xWjFkBlV8JovbIYrvJcyXzaEpF/I7fE6lAm5hPNkRej/5MZm/9ARnlQVbkeL7Kj9I8rcs/y5N3G+Y/nwxLdyfeHGsZg5N3v8y3IhJTZcILBf5gTTWiUVaYhXvkBEonu6veWpa7yyGoK77MP8IVvLf/D/adTG889fpsJW/qDNqYzBOCVv8N+pY8E42kfFzzA9Odmnaeweazt/zJwRkXmp7ZB0Nmkj2PmFZG2sq42a/3a4u+1E6zNz6EFZ3GslOwC0IEWPFi4Z1I67QCQ8M253fMyRQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:10:24.1798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bfa145-4eb2-41cd-11d0-08df3f55e42d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE940.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSAPR10MB648043
X-Proofpoint-ORIG-GUID: uNiZ7ynU5_UR5oL6i3InvMESQBZ-XLk1
X-Authority-Analysis: v=2.4 cv=bcH+w+PB c=1 sm=1 tr=0 ts=6af35e15 cx=c_pps
 a=AgKHDJP192gAOy1PpHj/Qg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=gu6fZOg2AAAA:8 a=pGLkceISAAAA:8 a=sozttTNsAAAA:8
 a=5crRq0VK4Bkkj3JbUuMA:9 a=QEXdDO2ut3YA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA3MiBTYWx0ZWRfX6y2jWsmcANdx
 lp2u5fvWTeVx9Qt9Uga8LNorKfE8L6Du3+ZIahSC9k8bYM0QstxDq6si30068+3tX3WdWV5ati/
 Rkw+UEDRZyziXCVdky+gytsA3vP5clqcfzwNdlfDeZD4tT6jjsNqX1JCuXiFbASiMP3RsjzL9r4
 sPUQH+GpEsnq041XJ7yNSbNRm9chLlyPyIINLaxcrLuP3hUNEWgXAhEhy/LI6xfR1w0eCtaekDu
 4/UX2KdtO23N5TWZXp7HZCj4Xw4Msut7EMOvkrdmyxPXCBDvwj3s61dWE5de6sIjN3pmPVD8jgn
 Z0qD3QJhGjVYcfNmXh+SbW5zzCS6W8yiVu3WZ/Kcq7wY1QlXajsYtIb4jboKuUnPdmUXxjGSq0d
 fSm4lpHuD7892XcwN1canI6dZqQhxqnYp2DfBmUO3f01OS8UNw/YFuf6sM0d7vvIzFG8kOXX0As
 VFM8TVnyve5PTkyyxOA==
X-Proofpoint-GUID: uNiZ7ynU5_UR5oL6i3InvMESQBZ-XLk1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA3MiBTYWx0ZWRfX1Z1IRP1WAllX
 4jCNeUMtAT84W1QuoEidZHArmHZiAJqE4XfgiKPPt/PmtB13fkVCY231wQXHwW3RULJJGrc6w6s
 +zGIchBGjO60A1QcMnVAqjuyGCyphmQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100072



On 07/11/26 13:41, Baek Kyu, Kim wrote:
> When a slave reports an invalid SMBus block count, i2c_dw_read() uses
> one extra read to reach STOP. It currently replaces the received count
> with 1 for scheduling and also stores 1 in the message buffer. A count
> above 32 is therefore exposed as a valid one-byte response.
> 
> Keep the received byte in the buffer and limit only the count passed to
> i2c_dw_recv_len(). This preserves the extra read for STOP while retaining
> the invalid count for the caller to reject.
> 
> The DesignWare receive functions were exercised with stubbed register
> input for block counts 0, 1, 32, 33 and 255, with PEC both off and on.
> The original code replaced invalid counts in the message buffer with 1;
> v2 retains the received byte while scheduling the same extra read.
> The arm64 i2c-designware-master.o build passed with W=1.
> No physical controller or end-to-end SMBus result was measured.
> 
> Fixes: 69f035c480d7 ("i2c: designware: Handle invalid SMBus block data response length value")
> Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>

Reviewed-by: Aniket Limaye <a-limaye@ti.com>

> ---
> Changes in v2:
>    - Use a separate count variable for the extra read, as Mika Westerberg suggested.
> 
> Link to v1: https://marc.info/?l=linux-i2c&m=179344386454087&w=2
> 
>   drivers/i2c/busses/i2c-designware-master.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
> index a1bcc3797e4ff..49e9e36340c84 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -542,8 +542,9 @@ i2c_dw_read(struct dw_i2c_dev *dev)
>   		for (; len > 0 && rx_valid > 0; len--, rx_valid--) {
>   			regmap_read(dev->map, DW_IC_DATA_CMD, &tmp);
>   			tmp &= DW_IC_DATA_CMD_DAT;
> -			/* Ensure length byte is a valid value */
>   			if (flags & I2C_M_RECV_LEN) {
> +				unsigned int count = tmp;
> +
>   				/*
>   				 * if IC_EMPTYFIFO_HOLD_MASTER_EN is set, which cannot be
>   				 * detected from the registers, the controller can be
> @@ -553,10 +554,10 @@ i2c_dw_read(struct dw_i2c_dev *dev)
>   				 * another byte with STOP bit set when the block data
>   				 * response length is invalid to complete the transaction.
>   				 */
> -				if (!tmp || tmp > I2C_SMBUS_BLOCK_MAX)
> -					tmp = 1;
> +				if (!count || count > I2C_SMBUS_BLOCK_MAX)
> +					count = 1;
>   
> -				len = i2c_dw_recv_len(dev, tmp);
> +				len = i2c_dw_recv_len(dev, count);
>   			}
>   			*buf++ = tmp;
>   			dev->rx_outstanding--;
> 

