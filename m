Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1483236C9DC;
	Wed, 11 Mar 2026 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220612; cv=fail; b=j0Bokt8hOdvCLLueuYuiCan3cgBUKNRbtb48jJzBZsBZZOOu4blJeMuSAfZKQzzN5k0AAXNA8uay/tqIZNUO7Rq5va+HRf85iCDTvK52uF3z3Ih/IS3qEaq3lJN6MaQTl42L0UlgS8iQifqhbH8EhvvNDLd8fA6oGxxIPHCTJAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220612; c=relaxed/simple;
	bh=OjikAtyLwOQGq4xIFqaoNPxTymvsxYRtz2TshbbcNIA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ov0d6ervKhexRkWVn3/s21RHSCSiX8cijpj5eY+ca5jFngXMHkN69XnTc5wMsrcz+C2EnrDc6OCKMk3j7lqgu2mjxhJwo1sudtDcUxUNjVINSgwY7nD2XPnMIFD1yKFUE3ERH1B5N6SWf7XypPr/GgfcBOot1DxJo7m1oP2UBEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=PDa0QK6f; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="PDa0QK6f"
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B7m71i1836212;
	Wed, 11 Mar 2026 05:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=smtpout1; bh=OjikAtyLwOQGq4xIFqaoNPx
	TymvsxYRtz2TshbbcNIA=; b=PDa0QK6fhUjF+QQSRFV0N4eiIXvMjDHLN+ugTbt
	dyg/McrfzUgIMUcbUuU6+uR0pMQtDH5XDo5tHxD2INVuE6/O/NoKdTQRih6DwC5j
	kfn7FR6fg19COjf79oZshxVMvizKvTEMcPEngdE6pFENGucJNx9a4gQ2qkq4eBso
	huhARnOT0I6jb26opZJFIPAZg+FDQEHoKCGD37n/7GDX+thi7p/sxEOh5YrC1jwm
	lLWVzgyxL9z7yuqH9PpK7gs2PJHPuaQe/rJWBneQLrb/lErz82+WZUz50TdXQbTg
	SUYV2cOoia6lYt5rnrRmFmXPAIzxVvkqiwEpOFja0tFb/iQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4crfy3qsb3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 05:16:36 -0400 (EDT)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B9FUF62065419;
	Wed, 11 Mar 2026 05:16:35 -0400
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4cu5kur0p5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 05:16:35 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcH6jtrUHe/dG8Oej8dgDHABNa2NfmXw94Jxgm6VZFpqDQr/24I6os1UciErG2VPlMup/jjwk1F9aDdrRYAr/5PzYZ+OJIUNSrUmpExaRc3Bz9swO2zMTlJRYqlPgXDBTsVQAoYz20GxO+x+zTX+5Bi9aiT4mMyGwAH/UzYgPIcH5Zj48zlnGZYl3gyYpaxtCm0rnMhheIKC50A0esTBM8LarN8ofXgQLc7GBCzO9WJSwi54NScnwjoibeG0LK1pE4ghoztjciBRECQKAxZ66GghKTkjVFSJlQcW6BCMKQVl+Rpqm2hN+rYIYJPUaZQaCkhugTD5EpY8LbWI2Qj2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjikAtyLwOQGq4xIFqaoNPxTymvsxYRtz2TshbbcNIA=;
 b=d/Z1sJYJELcqQo0yQLHGZL7+TD8yUlOilq9WbJPZ/Jj4823Q23UCt/6e9nJ1T0t/NTHGhtdirbsQ2XNDf0P1XI315QrWs3Rs5dQyLMr0s/G+fCAnCm1ilbzG+u5aXrtjwedgbcEvl1ifOsYD1zNMCrtBudhz6woyHLHbiGzY9Xb5vOXjIrKPoQtfcO93CbX5mRpwYdem0PQ6l9P2BMHc/8cOpwWRPbRAfL0mbq72GwIDzscR35zIMHPGKePyfCSBnyKD/IqqLvAbVKD1wVShM8eaEuUoFRtRJDHGydWVHrNwKq87d1rT2Pz8WqfMENJkP2MwIJFxuzVGLcaE5kAWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from MW5PR19MB5577.namprd19.prod.outlook.com (2603:10b6:303:19d::6)
 by SA6PR19MB8550.namprd19.prod.outlook.com (2603:10b6:806:414::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 09:16:32 +0000
Received: from MW5PR19MB5577.namprd19.prod.outlook.com
 ([fe80::faed:5dbe:5bd5:3b86]) by MW5PR19MB5577.namprd19.prod.outlook.com
 ([fe80::faed:5dbe:5bd5:3b86%6]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 09:16:32 +0000
From: "Mani, Aravind" <Aravind.M1@dell.com>
To: "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "jdelvare@suse.de" <jdelvare@suse.de>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] i2c-smbus: Add disable_spd module parameter to skip automatic
 SPD EEPROM instantiation
Thread-Topic: [PATCH] i2c-smbus: Add disable_spd module parameter to skip
 automatic SPD EEPROM instantiation
Thread-Index: AQHcsTVEQF2N7CbAFEmNQj2bru0K0g==
Date: Wed, 11 Mar 2026 09:16:32 +0000
Message-ID:
 <MW5PR19MB557770C007916BED20EAA81BA147A@MW5PR19MB5577.namprd19.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-03-11T08:59:25.896Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=Visual
 Label;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=1;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
undefined:
drawingcanvaselements: []
composetype: newMail
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR19MB5577:EE_|SA6PR19MB8550:EE_
x-ms-office365-filtering-correlation-id: 8d15c6cc-92fe-4814-a8aa-08de7f4ee2c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|786006|366016|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info:
 Q6YqVawvMWaZj53EfQeWKslWRXHv94PsecZQ6Hu+e+qjMqC2EsdM0p4zJere9+kQ9vpZ/zS/nzeJSGdOOt37aJHWet4YyuDns019a9GF+n7N/WU7lnv/iqAvlV4TmHwnybxfbF7XPfyrCMA8yyE+J5kqbkPPii376mF30IL6xoLobTy2iX6zRVD2abqcexvobo8xuaiaZ/C4BHgbGh3rFAQ0ASBVPtIuXntUAy4ord/w3jBsqisrf9GLftl2IBIzN9aSU1+qkTiyCKaCGLsWFlTBoHafnMKBjkvW8P1SvKACDrrMHymdLJ1XHuivRMwKn+IMeum9twu+xgVsDoAu8y5j5gm5KxWRY47zghestw0I+TVbd1asaFBmt+FvmtXfirshDHkWgdS3jNFmzcMuYcIeOCOfxBB+UJkTKXEOeImY1PbMoHepElmaQxgOVkeKPUay7I869FPkSoN3p1+RIVQhO0psn0umBC7ZuUmMmjvx5pwZQpTTixlAZ6+dfm7PwsOAwalW8Im4TGCN7ddvqy0IVK3AxcxsVQch0uQSGRd3UG0H4AgUxEDnIQqwvpurrGqJhQx6BMHuaq7+rLzs5rHEiM/2e7J1kd6KOgCfOC4GFH8yHQEaTuisj24x+XP1cDlaS1WixOJxavaXcRZqczOnO733tM6lIzSW0Tr0r7UR7Lx9qS0n9xMfP+nMCBBpo2OvfDlpkCBpKpQBsWQaeO2/S6B0jsog//KOQeei+68U+y5I2WbcNfgsWJM+jyLTHCLdEk7k4Fapmp83OBXZC1rr32VMawFzvQJDW3gq6Nw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR19MB5577.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(786006)(366016)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXFzTlU0WWtlUDhZeHNwNW41NURNWHEwQlZTemxGWTU2WklMZzJSOVA3YjN6?=
 =?utf-8?B?TFozNkIvcU43NFMzZFAvNGdnOTZvV25UYzFKcTlmVjZXU21XTi9Zbk5aSjkz?=
 =?utf-8?B?Ym1EOHU2QkIwVlFBY2tiMkNDSHhZSTA3dHgxazhrcnh0bjc2N3VVOU15NE9r?=
 =?utf-8?B?STk5UzJxMU9KRU85SFg2RXUrWEdKWFNCV3FyS1ByNFhnYzdvRVAvMzFsdUtY?=
 =?utf-8?B?bkFteTdaQ3lyVi9ocHNibDMrQ21YS3JCYUVDS3k2MzVvY0dMK2RIR3FFcEFE?=
 =?utf-8?B?bFpvZFBwQ3hCaC9oYkRSNkhuOS9TTmttSHNiaWRGUHhxQmViTzUyMm1Nd0ow?=
 =?utf-8?B?M0IrcHowSW02NmJkRHFwcmtwQmZ5b3grUTdMRS9YWkk5TjNzaFYxTFZiZ250?=
 =?utf-8?B?VTZsUmpuM2w2aXhQdHJiaUxnN3U0NkE0NTdlTEZ6a3FDekN3WGQ3S2FHZkxx?=
 =?utf-8?B?QnhHMkVGM1VsL0RYQjBpWjdBOGdTak5ORmMrSFRoTUlyeEhZVjJBdjNjNWNw?=
 =?utf-8?B?NjAvVjNLOWpnOWxyMVdMOHB3SXNreUE2dHBKY3hpV2kvNmpRWXc0NjA5UVRu?=
 =?utf-8?B?M3NFNXNHWU9jQWh1aERMVGVPZk0yMWZhRG1tVzdKcFY5NU9XTWhMYytMT0xw?=
 =?utf-8?B?UkV5a0NyenkvZGRuVUxwMmE3VGtYWlZtNHQvMzJDdEUxR0FjTGpsUTExalFp?=
 =?utf-8?B?UGxaM1RUWDNqOENjbWMzS2RKbGFEMWc1ZmR4a2h6L3F1MXlkeUNYQWlIbUdE?=
 =?utf-8?B?L2ZJS3NzMmlVcXZmWHFtSllYaUcvK3RzTlhRUFQ2M0hGdDJtamc3Mi9ZZ3pk?=
 =?utf-8?B?RDhUTDBiT3lyVG44cDdIMmpsRXVjRjBJdndQVDYzNXdUaTZFeEVmN0E0YnR4?=
 =?utf-8?B?RXgzaVZKVlVIbm5yK0J0aDAzRFVhL2ZScXpkRUVFNlhmOVhUWjVrVXlNcWtk?=
 =?utf-8?B?ajhQZ2UxTWYzWnd5ejdJYXhOcEIxZEVKTCtJZUFSZHFGUXhVL1lvK0lTSXhH?=
 =?utf-8?B?OGd3UkFoM2xDMWZsTkJ1cE03eUJHcCtqYkNKbExMMkRuMWZESDlsSUY5cEl2?=
 =?utf-8?B?QUN0NlJwajREeUJ0YlJHNENiS0JlaWVsdU1wZjJFbWZjTGRvODMraGFxM1Nm?=
 =?utf-8?B?ZzlmK1hRZU93MzZ5VENtajBPbU9XcU9pZk55T3QyQkZYUXJDS081eC9wS2JN?=
 =?utf-8?B?Y2RwK0FWeENRMmpTQ1JGNlpjbmI5OXExZzNmRTkyUXBnemR5MWxGUnBSa1pD?=
 =?utf-8?B?bzR0TUJndk1xSmwzVWNvcVlRWURhWHJQU0pDVFVNckNtT2UzeU5aN3Excm1j?=
 =?utf-8?B?R01hc0NZRmtGK1VGK3FiWHR5THpvbDRHMlR4TS9QL2o2OEZkV3F1enRmMDAx?=
 =?utf-8?B?L2pYSTFHa1lna0RlTzFodlFSSC91TURpajdIRjdHM0E2d0thQkN1eEVneDFp?=
 =?utf-8?B?YXlWRGdZVTUxaHNYMEE2bC9kUnJ6RHFkQy9lZHlPQVd1QTV3TUVMQXEyMHAv?=
 =?utf-8?B?THQ0M3pXckZmRzU5SHRSTm1TOEVFZXpDdnQ2bXZkUzBTU2xOclhlWHN6Szl0?=
 =?utf-8?B?TE5tbFF3bThXTGxlOVpmZmVadVM0Z3puOXJkMWFQV2FheGxpdVNJMkFzVkpX?=
 =?utf-8?B?aE5xeUhLblRXVUNyWkpnQUFSWDVOekcycnMxNHB0WDRBV2FCeWFJL0JIOE5q?=
 =?utf-8?B?L1pEVkR5b1hBWHNEdU12L1B4RzVtbGRVQzRvNHNiME05ejZXWElhR2sxVlJl?=
 =?utf-8?B?ZUlVRFRuRXZwZ3VoTVJKS3p6UEJWejdtMXJXY2NVaWdEb3I2Zk9SdWlHS3lx?=
 =?utf-8?B?THhvdzMvMHoybXpJNm9ZdWlzemIxczBvQTVxSEFqak5zU3JkWlBrdjMwYkhR?=
 =?utf-8?B?L29nRFdSVzVRdFA2a0x1d05WRFBEUGJET1BtUmwxdFp2dnU0czJrNzQzVC9V?=
 =?utf-8?B?ZklJYUw1VGU3dzZYeGExVUtDL1AxWVY3T3picC9DVWdzQndGTndCemg0Zi9i?=
 =?utf-8?B?UndPeCtSdGpxZDB6Z0VwcUJFOTVoOXlob2ZJU3dMVjBwODVSL2ZEOUlQZ0ow?=
 =?utf-8?B?WlBEYWd5cTFWQ0pSVXY5QkRTNUFueDgxUjVkNkhKRTdMTUxNekVlK3VHOFdM?=
 =?utf-8?B?bEJVL29rZXk3cStvWnRmQUJYanRWK00xay9oMXJmVU94UUF1LzVjQS83YUpJ?=
 =?utf-8?B?VHFOK01DejNhMGtFSlVyV3k4akdWQng5RndhYVg1WUNxeWJVemNwSjlObTVj?=
 =?utf-8?B?ODlHb1FYZFJicWdhL1NUVjZwYzlRY2VuVzhjNXRNSFpoOHB6ems2bWdXNFRF?=
 =?utf-8?Q?/Bjm2eyiOLP0sEQzrU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	evpXiVGJKVoLhq5UF8GCgpzDKjQ2jDkhuB6GxkZRI5WKwcpEqzgWqFvpvB3uWHNVYsF3904ssdRIk7hUfy28hsRncbSTHGm1wHaFG54xjgLB+Bh2eNpokZ8IDklHb4CuAFhksGxY+mSGlWvV6UZ8suF0GEBWPcZY4GSDI3zBoMnjQ/1rxWcX/ScZJKQOL54GuKuXQ6hnQ6qB+SgiB7j1Jo+e0lDk5c20LYAZfFMiZPCjdNnGo44qXAvOaT7VmgJaVv0bhv0G8pMOJKxWYtrrsBzTEqTgzo8yrVGPrFTxUjCtc7G6lZflTw4EchtgxShrBJV3aCTYcadQ640Zx4L8LA==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR19MB5577.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d15c6cc-92fe-4814-a8aa-08de7f4ee2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:16:32.1343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MlYc2OHRJFGFKAnDE+aoHQff6/6RM3xBZlkWLPwSoNGdNXTGcvriO3yMoR1iRGflDvgXy6HkuoYpE2l7qo8zTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR19MB8550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110077
X-Proofpoint-ORIG-GUID: 4bCIjZQaATA_SMoCmx-87jVwhvl18V05
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA3OCBTYWx0ZWRfX2SxZ4XSpQWov
 FtXhr+lUQnw/9DmYMwzjqjzZ2Da5Pfptf8764VgVDY7NOX7/AvH4Y++KohUAZ27I4BaUlkVHlvO
 BzTWUyFi6RIJw/zrKvcfyOYNoQOjYiUINczck0/j3IAJWqTqzDlbSvzbKPYeBS1z0ON7iN7oxRJ
 m6nu65h83833l+F16gE6SIqn78nbPORnVixABHcYHTDbk4bav73S7ibc78ddjNsyi0mybOvfY+z
 3982opwe5MN+qtiv/9KDcvbDqPW/V1eFb0B7Ds9HtKB1RWPkTkRY1XUGP8BYFwwbHrYKjollJmG
 nA2ad5i1E/eIbALWZoPqJTdiHds7gZi4j0m/kXm8XqKQmxZw/eraptN+8rYOgX11XsZShUEnPOm
 EyE7pGDsFEn8pk8GwJLkiDzKQ1VJtXiBJjgqh1JtM/yc4NDShOacrwTL0bscHnIyn3Rs+Q8Ke8D
 OiSMgggXkAAyT/VkR8A==
X-Proofpoint-GUID: 4bCIjZQaATA_SMoCmx-87jVwhvl18V05
X-Authority-Analysis: v=2.4 cv=E6TAZKdl c=1 sm=1 tr=0 ts=69b132f4 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=sEWawkeXllE7TocFc0N_:22 a=iLNU1ar6AAAA:8 a=gWCqfJ3wDJn6iq9ZkroA:9
 a=QEXdDO2ut3YA:10 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110078

RnJvbTogQXJhdmluZCBNYW5pIDxhcmF2aW5kLm0xQGRlbGwuY29tPgpEYXRlOiBNb24sIDAzIE1h
ciAyMDI2IDAwOjAwOjAwICswMDAwClN1YmplY3Q6IFtQQVRDSF0gaTJjLXNtYnVzOiBBZGQgZGlz
YWJsZV9zcGQgbW9kdWxlIHBhcmFtZXRlciB0byBza2lwIGF1dG9tYXRpYyBTUEQgRUVQUk9NIGlu
c3RhbnRpYXRpb24KClNvbWUgc3lzdGVtcyB1c2UgYWRkcmVzcyAweDUwIG9uIGEgbm9u4oCRRElN
TSBTTUJ1cyBjaGFubmVsIGZvciBzeXN0ZW0gRUVQUk9NLgpUaGUgYXV0b21hdGljIFNQRCBwcm9i
aW5nIGluIGkyY19yZWdpc3Rlcl9zcGQoKSBjbGFpbXMgdGhpcyBhZGRyZXNzIHZpYSBlZTEwMDQg
ZHJpdmVyIGJlZm9yZSB0aGUgcGxhdGZvcm0gZHJpdmVyIGJpbmRzIHdpdGggYXQyNCBkcml2ZXIg
YW5kCml0IGJyZWFrcyBzeXN0ZW0gRUVQUk9NIGFjY2Vzcy4KClRvIGFkZHJlc3MgdGhpcyBpc3N1
ZSwgaW50cm9kdWNlIGEgbmV3IG1vZHVsZSBwYXJhbWV0ZXIgJ2Rpc2FibGVfc3BkJyAoZGVmYXVs
dCAwKS4KV2hlbiBkaXNhYmxlX3NwZCBtb2R1bGUgcGFyYW1ldGVyIGlzIHNldCwgYXV0b21hdGlj
IFNQRCBFRVBST00gaW5zdGFudGlhdGlvbiBpcyBza2lwcGVkLCBhbmQgaXQgYWxsb3dzIHBsYXRm
b3JtIGRyaXZlcnMgdG8gY2xhaW0gYWRkcmVzcyAweDUwLgoKVGhpcyBjaGFuZ2UgcHJlc2VydmVz
IGN1cnJlbnQgYmVoYXZpb3IgZm9yIGFsbCBzeXN0ZW1zIHVubGVzcyBkaXNhYmxlX3NwZCBmbGFn
IGlzIHNldC4KClVzYWdlOgrCoCDCoCBtb2Rwcm9iZSBpMmMtc21idXMKICAgIG9yIArCoCDCoCBt
b2Rwcm9iZSBpMmMtc21idXMgZGlzYWJsZV9zcGQ9MQpvcjoKwqAgwqAgZWNobyAib3B0aW9ucyBp
MmMtc21idXMgZGlzYWJsZV9zcGQ9MSIgPiAvZXRjL21vZHByb2JlLmQvaTJjLXNtYnVzLmNvbmYK
ClNpZ25lZC1vZmYtYnk6IEFyYXZpbmQgTWFuaSA8YXJhdmluZC5tMUBkZWxsLmNvbT4KLS0tCsKg
ZHJpdmVycy9pMmMvaTJjLXNtYnVzLmMgfCA3ICsrKysrKysKwqAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvaTJjLXNtYnVzLmMgYi9kcml2
ZXJzL2kyYy9pMmMtc21idXMuYwppbmRleCAxMjM0NTY3Li44OTAxMjM0IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2kyYy9pMmMtc21idXMuYworKysgYi9kcml2ZXJzL2kyYy9pMmMtc21idXMuYwpAQCAt
MzcwLDYgKzM3MCwxMCBAQArCoCAqIMKgLSBPbmx5IHdvcmtzIG9uIHN5c3RlbXMgd2l0aCAxIHRv
IDggbWVtb3J5IHNsb3RzCsKgICovCsKgI2lmIElTX0VOQUJMRUQoQ09ORklHX0RNSSkKK3N0YXRp
YyBib29sIGRpc2FibGVfc3BkOworbW9kdWxlX3BhcmFtKGRpc2FibGVfc3BkLCBib29sLCAwNjQ0
KTsKK01PRFVMRV9QQVJNX0RFU0MoZGlzYWJsZV9zcGQsICJEaXNhYmxlIGF1dG9tYXRpYyBTUEQg
RUVQUk9NIGluc3RhbnRpYXRpb24gKGRlZmF1bHQ6IGZhbHNlKSIpOworCsKgc3RhdGljIHZvaWQg
aTJjX3JlZ2lzdGVyX3NwZChzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXAsIGJvb2wgd3JpdGVfZGlz
YWJsZWQpCsKgewrCoOKAguKAguKAguKAguKAgmludCBuLCBzbG90X2NvdW50ID0gMCwgZGltbV9j
b3VudCA9IDA7CkBAIC0zNzgsNiArMzgyLDkgQEAgc3RhdGljIHZvaWQgaTJjX3JlZ2lzdGVyX3Nw
ZChzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXAsIGJvb2wgd3JpdGVfZGlzYWJsZWQpCsKg4oCC4oCC
4oCC4oCC4oCCdTY0IG1lbV9zaXplOwrCoOKAguKAguKAguKAguKAgmJvb2wgaW5zdGFudGlhdGUg
PSB0cnVlOwrCoOKAguKAguKAguKAguKAgmNvbnN0IGNoYXIgKm5hbWU7CisKK+KAguKAguKAguKA
guKAgmlmIChkaXNhYmxlX3NwZCkKK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgnJl
dHVybjsKwqAKwqDigILigILigILigILigIJ3aGlsZSAoKGhhbmRsZSA9IGRtaV9tZW1kZXZfaGFu
ZGxlKHNsb3RfY291bnQpKSAhPSAweGZmZmYpIHsKwqDigILigILigILigILigILigILigILigILi
gILigILigIJzbG90X2NvdW50Kys7Ci0tCjIuMzkuMgo=
