Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F13314AE;
	Wed, 28 Jan 2026 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612442; cv=fail; b=Ugb2fCN36nMw8XMvyzQLjYy5Kz2zBffI5Qp0+FIqLFLMBufaWCLpjaDSh41RpdCspLRLQ3o7lPG289z4b6V7NrnHZy0/v2dSPP5SNn4juiWMDQudB21TUUWN+FzkBicIxonQERX6FKMTQ5hLA+NuaMZeuADtk6pkiRgPFbml3b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612442; c=relaxed/simple;
	bh=/5PA/agc7mT5z1Uh/PPTlO4BD2eofsLlbe7GZuameiY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hp4LaY4ZqI/colUM83BKR1PLnaG4VToj+pLm4OCcTwB+YOamBm6+IPWo9RnT7Lv5579kFwc6k1HIDA0OQo+dDmHRcY1dusW+3t+SIzG7cuqHZMea6FBi+SwAfB8LiS7NsQzPJD0CQGyQUOliYledLWxBMxZENTvaxTYw1+DZxN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YBAJSf3v; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YBAJSf3v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBcN7CW1sgu6oDWvEMyZoH80TRlLHYe2Aepp1DlMHYzvkEBePIWO1pcBmaLfxm+tk/P6EtLL8/nWgBh7P9CcBwI2rZtBy2Lev7q2U3vZgCeaPyGl8h35/dsXCjbfg3L59BihF2jspHd0VRuoSnt2FEaOvRKWOcvM5WCP5uXVpwsU9nKMfTDprgk7Q8v7va6GNDLO3LHE12toTDRFj3VAYFw8GmHPdllXMMcc/f5rfZIPhJNeerIFb9aCAZq9h5RfUHA6UUOJph2i4dfdPPBZf63uRV6lC0Mf4BLAgiwYWJGQ8A7c/88PHNi2Q4T4TL0cyOTTxOHh/mymmN3NbRtWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqzIDyZoRweZP0pc33Bwsflhm0Uh9r4mzQDZraYgGJc=;
 b=y4F6SuoJ2Zes98J+ZBhCDXpVcCNJ9+gbWmDBL7aBwuDsAIcYLdxXbek4Rbr2NqHpfK2dl854ldHL7b6kEA4acAbnGNxqqwYloJRjcWZGiTcDCOFO5mNqYVctF3subz5P6lWn7Clfmd4fA/oqPEUq9M1vCJ7RbLjcYGPs8KBToQPO98dGtyzOjMNsCKUQzGmSD0OeIUtZDlTvaBOqOy37CX9foo+Sq65fpt6+quQQp8t2kl/3hecGB6qZBjRgBlb8A0ackmMY98xFmhHshevt//mnJZZCRQC2MnDXPR1o+2e1nnEh6EkyvzE+OXrWTWtlhXQJfXUxbMARH3wp+tpdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqzIDyZoRweZP0pc33Bwsflhm0Uh9r4mzQDZraYgGJc=;
 b=YBAJSf3vZ4mZaJuKxCIF7lXu1NttLXwxe1DW2UCFRlECBS9wP4jJ9Hd6abO8gVYtRRPSoupoNPuf69rcS1tPXkSgVw9mS2zy0Fvna7RdNm7YkK5k1NntsAjH05ye3gQOXepWmvpvVeq/FeFmTlvjEBOogBx8We8IjXSNYNSsslE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 15:00:35 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 15:00:35 +0000
Message-ID: <5dc423be-c1f4-4a59-abcc-807f63b25f3f@amd.com>
Date: Wed, 28 Jan 2026 16:00:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] dt-bindings: i2c: xiic: make clocks optional
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Abdurrahman Hussain <abdurrahman@nexthop.ai>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, info@mocean-labs.com,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
 <20260127-i2c-xiic-v6-1-e82e2f6f657c@nexthop.ai>
 <20260128-remarkable-airborne-chihuahua-a1a16c@quoll>
 <66c7435c-a936-413e-a016-c860d448c971@amd.com>
 <fc00f8cf-b566-4694-82fe-76010d2f7c78@lunn.ch>
 <aXog-KBw7Bp-VEC4@smile.fi.intel.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <aXog-KBw7Bp-VEC4@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::27) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 97677a77-6678-4b6d-0b2d-08de5e7dfdad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDFEQVBjMHhCeTQwTGVNV01BMXR1UUNVRXRqbmF0cTVjamxuSmI2czV6YktF?=
 =?utf-8?B?ZGtiS2Rzc3FzTUFLbVI5MXFzTDR3Sm9XY2xIVEVmdktCRCtPdXFFZCt1UTYw?=
 =?utf-8?B?UGgrWjZXY2ZRa2hBa1REU2VzTlFGUXFqQlZTOThBMUE3U0ZPMXBPcDNQTndi?=
 =?utf-8?B?blJhbFFZTVVjamZlUlZPVjRJQi9ER2NPQ1pST3cranNNMHpyWDRqbXIvUXRp?=
 =?utf-8?B?UDlySVBZWjF0dHpkWktUd25reDE0czBMbEZ0Slh4czB6RTJQODF5UjNzdFpE?=
 =?utf-8?B?azhoOExjVWQ4dXY2Zzlxd3lyUVlqNVNSMFh6WVoraEFWdGNHbFVoK0trbTky?=
 =?utf-8?B?bkR6QnB3ZEM1c2Z3YWxxWEtkY1FFc2tUQkZDVWF5R2NRMG5QTDNFVE90SElG?=
 =?utf-8?B?ZjRxMDZZRDhKL3BLRFJ1R1FuTFZHOThqTGhPeTJYTWg0MzVZK1p4Si9QdmU5?=
 =?utf-8?B?azZBc3NNVzFvaWQwSlo2WGZ5VGFOTGtpMkdPRnVFY1RJcmJER0M3YTNUMkRU?=
 =?utf-8?B?SnNjcjRSSkNISHYyVVV5TTRrRzQrb2MwTGJHTStaRlFYa0VmYmJ4S0dUQUQx?=
 =?utf-8?B?eE9NQktsM1Z4ME9Ja2pTVmhmcFFSWmFxM1UydlVsQTlscC8rb2xPTnkxR3Y1?=
 =?utf-8?B?TkRwRkdpSWN4WUwySDU4cHF6TUNMTTFldGlFN1BHQVZ6T0N4emdzMjU2dXdJ?=
 =?utf-8?B?c0kwTFo0RnBuc2Vaa3dvcElTMGRYOU5zb3ZlcXNMMC9Oa1RzWk5qOEZTeU05?=
 =?utf-8?B?SGJRTWpJOXA2b0VJRCtCRXJ3b0swai9mK3dBZXpiOHFNQjVwbkcvOWRFSXVm?=
 =?utf-8?B?ZEpreXJ0WUczcU9qWTB1SXJIZ2JMN3NZNU15bXgzNFEyZXNBMWpsQUUrVEw5?=
 =?utf-8?B?Q0h3RkZ3WnJleVVpTkt2bnNzWksrbmpQSkdjN250enZueHhjbEsrL2VQNWJR?=
 =?utf-8?B?YWpOdXU3bVN5cHlFRVBEQ3VGb1g2K2lSYUdRaGRTcndKQVZHdllYc1E0ME85?=
 =?utf-8?B?SWN3dnVVS2JyQ25VdEZOSFcraFpWSlNWcHZJOUV0Um5zNU9zVWNpTXdKbTZt?=
 =?utf-8?B?Q1FUeXlQcEd4bDVjcGxFelg2SHIvSEY4d25ORVExSWVQd1Rqc3Z1b2Z2OWx3?=
 =?utf-8?B?ZTNaRDRvTENoTjhQTW0vSWpKbllDYzB6cUJhNHNkYjJqd1ROOUdzUVJ3Z3VC?=
 =?utf-8?B?Y3lXSExDUFg3Mm1ZNlZTTVhVYzN4RkFwZ1Ftd1k1TGh0MGlpcEhabisrdjg4?=
 =?utf-8?B?TkhSK1Z3dHZPUlFuS0cwZWdlSG5XcTlTa01xSEdGUFZPM1hBQnFNOW9oTEFJ?=
 =?utf-8?B?Y28xSVYwQ3VKY1lDTVEzclYxSitwUmwwU21UUTArVVZBdDduR2VTVzBYazYz?=
 =?utf-8?B?cGtZNDFsdzZ2RnVqY3FqRjZOUWw3cTBOSGgxeXNQTzcybEpwTW1RcHViazdO?=
 =?utf-8?B?Mzl3NUxIQnFqT3A5YTFhemFXNmEyL0dYL0hZcW5pU1Njelllb01VL0UvbC92?=
 =?utf-8?B?Wk9KeUIxV29UNGx1bTJ6NVp3TElQaFV0bVRzQUptL0F2WDVDcE1ka2d3RlV5?=
 =?utf-8?B?S2FpdXMxazBEZGpBdnY5MUxsckFncXBJSFI4L1BFYzNVR2czRHVDSk5DczdP?=
 =?utf-8?B?K2E1THF1YmJGZlhGV3JZV0FnVCtvZU9xOFR1bkZjYVFtaVlnZUJDaHR4MVNL?=
 =?utf-8?B?RFptd0xUa2hXTnNDZGNvQzdZb3BHWmllc0pMeDRGdDcydWx3S29DR2VEOXhE?=
 =?utf-8?B?UDMvRTdaUGFCanh5NjltaEE3TWtxM2U2WEJuUkpRS0ZHMzVFSUxSNFpqUU1B?=
 =?utf-8?B?TWc4RzNUUVcrSG5IVWRPZTNNYzVuZmErQUZPcXhIaEpqamlYNjVUOCs5V2N0?=
 =?utf-8?B?RUJmOW84YW4waGpjWC9YU3c0RGp0TVZ1b3hwVlA1VHp6MWtJUHlKQkorbXRX?=
 =?utf-8?B?NkFJODZiRE5tUVA4QnBjeHg0Nk9nUHlmWFNXU0t5RmtiNUExc2Ztcmd5emUz?=
 =?utf-8?B?UkhTUERQZSs5Sk1HRzFnbTRaalRkT3hVd3F5Q3dGTEUxV2l1OTludnRXRG1n?=
 =?utf-8?B?WkZsZ05iS2xnaXY5UEF4S2hvWFJJUk1KQUhmMjNlblNHTm9ONXFTOEREYnlo?=
 =?utf-8?Q?zCP8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6939.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1ZNbldlKzVHUzVFWjJIYi9HTHZwOUN1SHVsTzM3NEl6eEFkaHBVd3d2QllL?=
 =?utf-8?B?cTZiSVJKNEVLUUdZQTBtWkZRZWcvRjdjT1VlUGt0bGxxeC9FenV2UE96Sjdl?=
 =?utf-8?B?UG1XenM4dzlPREdUNFpmWVRXdzZtell6eXhlUE5rTVE2bDVNK2JpcE5HRXFa?=
 =?utf-8?B?RDMya3dTSU9sV1FlaDFjdWJIeFZrN2xlRFdGck1ncDdITGxNOTFOQUUwVmtu?=
 =?utf-8?B?dENmWExIRzdWMkhpUW84ME5nZVM3VFhLL3U1SDc2d0luZ29mZm9QOU1ic0Rx?=
 =?utf-8?B?dUFMajY5ODlBWk8vWG9senR1RDZJTU9wR01nRkNQZGU0TGtlYTllZ0VncmpO?=
 =?utf-8?B?VWkrOTI0Q0trdUdnRGdpRExIN282VkxiT1k0Y1l6ZUJvWUc3OFZUeW5qUUhY?=
 =?utf-8?B?Z09sY3lXbnBDUzhhbE83T2U4RzdzWmZCK1Z0MUV6SlBZUUplT1dvSEtIcUxV?=
 =?utf-8?B?UG9UcnkrQTVnbFJ0a3hlblp3NWlOTW5ISmlzbmFMdjMrbEloN2RHRFgzWjNh?=
 =?utf-8?B?OWd6MDBXVWY4ckd3bXJ4NjhtN1Z6cEVXTStmZTFsWEFWbE9iei8vN0hJczF5?=
 =?utf-8?B?QjJYc3huNkdOc2xKQTlIaVFESUFuTWRueW1DUGNBVHJPRmdIakVhVUdTd2pL?=
 =?utf-8?B?V1g0OHdsZnlUaGtZRkQ5UTBXaGNDcEhONlUvL2VBOEIxNFNXQ29iS2NveVRJ?=
 =?utf-8?B?cmVTdGloL3VpS3hxUHRhNGZIRGFHM09HbFJ6Sk5BcVRrR1RacGlESnM1cVlz?=
 =?utf-8?B?bXQ4TFV5Z3p2ZkpZZXYwQVdLYmdMQzRXek1WQzFRb0NITnlDYWppYzFBVVVK?=
 =?utf-8?B?Mnh5YVF6UGtqTkZ0ZXVsNjhjWXN4WVVJMzhEbjhjYWd5SVpKVGNqck5YaUtj?=
 =?utf-8?B?bTQxTW1ueDBGODg0R3lKU1ZzOTZnYnBvKzlVL0dvdHprUXYrbk82ckNUaUVO?=
 =?utf-8?B?UDgzcFpXVDd3MlpoVUtOYkRIcEV1MlFERVIzdzkraHdqM2svNncreWpqODNi?=
 =?utf-8?B?dnVMUGdPc3gzTDI2ODNBQXg5ZWw2Y3RGbWVtSnVzNTJEdFBDZmlFSEtlSVlZ?=
 =?utf-8?B?bEdwaVVDZ0JHVm02ekt3WFBERGFxL3B0MytsSkRhVVNEa2piK2hIYjRqRWRZ?=
 =?utf-8?B?WXlUdko1VktvZjNySHhObTY5VTFFYmNWaGs5emludUh2VUwzZ3JpSjM4d0dW?=
 =?utf-8?B?cG5CcU1Ua0E1eU5VamxlTmJ1d3FMdkErZGI2OU5GOEE3U09UL2trczJOY3l2?=
 =?utf-8?B?UHN1MzkwYXlTcFIrWTJJUlNvU24rVEt3aHVPeUx0eW9pSGVETG16YXB5dEJv?=
 =?utf-8?B?WFV1NGpLTzlHaGVZTjFRbjMvdDNpOEZHdnUyN1grRE0zd0IvdlB0S3FYVCtN?=
 =?utf-8?B?ekUrcTRDY1VwQkdoRmkvVDloazBlMWd6NCs0YjRVTnlYM3ZoU2d1Slp4L29R?=
 =?utf-8?B?ZlI4WDd5SHJ1ekZyRkZlVlBySHJ0OUJiUEd0UGY1Qk1JdnNZckJBVDA3U0hM?=
 =?utf-8?B?dlBoTVJLTDFnOWw0dzFGU3QrMWFHOHlDU0pIVkJDUkVvdzBvWk1NUTk0eXRQ?=
 =?utf-8?B?aTYrcktiUFpVUVFQbDh6c21ObVZ3WXZlOCtCb3VCSGU3RHpGQk45SEdNQUtO?=
 =?utf-8?B?WFlQOUtBZ3lyVkJzRzhZTGp2Rlk3dkc2cHluaFozSFVaQVFUb3FINWFEVktj?=
 =?utf-8?B?WWpjZm93RTVlZkE3eGxKR0ZPc1krTHVESUlDcFFERWlRbTcvRlhaL1FRMHpr?=
 =?utf-8?B?S29zaVhjcDBWVGxVUUI2cVVHb1VjRHVOa1RmRXNIRnpmdU9LbUJkUjRQdk9a?=
 =?utf-8?B?aTdJNDgvSU4yMUlVQWI1ZXE0YzZKMy83THpEZ2p1T1B6ZCs0UDNQbzdVTG1i?=
 =?utf-8?B?YWdKaHhVTFI4NGlnd216dmZuQVZ4RXpTTzN2MjlrM1RTUmVTNk1jaGF3c2lt?=
 =?utf-8?B?Z2h6cXNnd2RxcnBmN1B3UjZQOHE0b2Y4NkNaY0VoRVBRSUNXa0Z4cFZnSUJa?=
 =?utf-8?B?L3FTcVVHVDE2Wk90K3I3M0xRaXhDLy8yNlVlbjRZSGd0OUo2YkFkL3hCTE01?=
 =?utf-8?B?S3BFRlcxUG9ZWXhpL2JLeCs5V2Y5WTdGVVZNMUdzdGx1UWVJeTFhWld2Q0xZ?=
 =?utf-8?B?YkxSUGZkZ2FBOHA1UWtNK1ptMFplSzgrd3dhaTc0ek9SZVFCUjBOZmdoODZG?=
 =?utf-8?B?SXNLS2h2U0hYaGU0VXV2QndzcXg4cjYybUpyaENxYVVDb3ZtOE1zTjhJMGlF?=
 =?utf-8?B?eVpqUXpwYllLMXk2VmJpSXNYVk1kUDY5WERyNVhDK2N0UlJSWmpGVnVyNEts?=
 =?utf-8?B?emhUbDBXN2poUEV3dFNadUt1cDBVTlpWeFUrNlhGKy9BM240Q1FKZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97677a77-6678-4b6d-0b2d-08de5e7dfdad
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 15:00:35.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cqQ3EYSBrsYiUQGWsGyTrBg9YnO394q2Nes6eBwWFccHbGQSoLNsyetDO1yKqQW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733



On 1/28/26 15:45, Andy Shevchenko wrote:
> On Wed, Jan 28, 2026 at 03:34:02PM +0100, Andrew Lunn wrote:
>> On Wed, Jan 28, 2026 at 12:21:41PM +0100, Michal Simek wrote:
>>> On 1/28/26 11:37, Krzysztof Kozlowski wrote:
>>>> On Tue, Jan 27, 2026 at 09:03:55PM +0000, Abdurrahman Hussain wrote:
>>>>> The xiic driver is designed to operate without explicit clock configuration
>>>>
>>>> And if you change this in the driver, then you change bindings?
>>>>
>>>> You miss here explanation based on hardware - how does the hardware work
>>>> if nothing ticks it clocks?
>>>
>>> Hardware obviously have clock input which needs to be connected. Without it
>>> it won't work.
>>
>> Should ACPI potential limitations be making the DT description less
>> accurate?
>>
>> Would it not be better that the driver has an DT binding and an ACPI
>> binding? Where there are common properties, common functions can be
>> used to retrieve them. However, if ACPI lacks usable clocks, use the
>> of_ method to get the clock from DT, and skip it for ACPI.
> 
> Why should we use of_ methods? If this is required we can check the type of
> fwnode and act accordingly, but I think this should go deeper into some
> treewide available helpers, because now some drivers repeat the mantra.
> 
> But how do the driver get the clock frequency (if needed for some register
> settings and/or calculations)? DT seems to have well established property
> 'clock-frequency' for that. Can we consider it as "ACPI binding" as well?

"clock-frequency" property in i2c is used for selecting i2c speed 100/400kHz.

Clock frequency in this driver is about describing clock coming to IP itself.
Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml

Thanks,
Michal

