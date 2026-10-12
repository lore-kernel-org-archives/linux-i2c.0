Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D14749F2
	for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2026 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807375; cv=fail; b=rOkPY6gBHxEcEQJvgKZRohSE57hocJ8RZIBfsW0rzQLD3YR+DvqYp2nqRbXU+vfIR30dQnDAdpG8aftj8YyhQiSLIzn94MldigmuJMRBLaMg840n7/K+GkMWrp8sPV368RMFMYqGT+YpNXiiZKwxzalVtnmaMb1drRVzZrp6QGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807375; c=relaxed/simple;
	bh=Nq7ZPkqNpXGrHbdMc3wsG9LUC4GVHg9XuasIboC9/+0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VFQeu3GAIPKZ3EUD+1t0tNKuwY7dvG9rjyEtdxRdI5EjBSWptMDnR/BRNI2Tbxseopr3aa+BEuBkgyOYl/IQNHHV24lAvulV4F+v5NjBRg/Phcol3oILRYJkajFHUxBapYO6O71aYk9Vl94mFXA/++lSfWmvpmL+g5Xuj3KUQug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJEcV6Pw; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJEcV6Pw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791807375; x=1823343375;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Nq7ZPkqNpXGrHbdMc3wsG9LUC4GVHg9XuasIboC9/+0=;
  b=GJEcV6PwAWwG3ujuyvNVwgbegggzSf7vWfM/y1wR0YZXGEVNPYq+qqr/
   6dSn4gAt8sTIoKprMIdbcuLNDCXxMGPk4NODObzyr7U1KI0+XenciKgRm
   mF7JdiG05AxeaeKsobtDtiV4bry7B4wb4ldRnOYpFQcnM6X+KVecm2Eh9
   TVOOCP8NIXN959BxRp/y0O3o2njvIqcr3Qse6xW6IQggm1vZSAuw+Aeiu
   YopmsplyesWr1cAWqfggNU5h08bIVSqM+sRMpNmgqAIV8bLOl+YUvygXZ
   e9a3k5bNkfwf8f5myBApfOgkW4DGR+EE4TsU3VfLbQosOFKhaXbjRpYcA
   A==;
X-CSE-ConnectionGUID: vZ0o/WgISqqKJz9O72bOgA==
X-CSE-MsgGUID: w73HLXXmST6VOy1EBSQ08w==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="399329"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="399329"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 05:16:14 -0700
X-CSE-ConnectionGUID: lARC8YZ6Q5Wprz9T0TQDTw==
X-CSE-MsgGUID: SUaUDHB0T/eW2W3q/kr8Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="862836"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 05:16:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 05:16:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 05:16:13 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 05:16:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tb0oystaJlEBGZPBkoq3J+Ez+1IKkxKzZZYffbrwYBb8GL7fU5Ai8fR8C2zRyWoQLyJHXiHOTotg4/q4fYOUtk8J+t0UYxS9AJi5ldzv41NAlz7JdqvjU3Zh5SNfx2TgKSvDDADoRJFvhFN2E5NLooRlmlNvGUtNuMhyyD/vymEc/9ro82FX9BWn+YDFj2hRkI3nSS2kwDV/6qM2SYkalwNBGkbnefMtySzsq9jd6Yb0OoGazFRlQjn06oSWQt7EgAJt9FevmKU1/XM3LMdBJSGFsGgTp5KwmntK7/klr4MW2rN8vpuZpi5eHC4HFUPJfO1DVoPclkcY7C55B3dGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqluH+ATEGSx16/vPLX2fgEuDEMT+nU8ZRwtVUZCEUQ=;
 b=X5MhV5b8dNYZGqTIuqEjtc5Wy9P1+39JrhJgITGL2E+k36YTdboRvkxpWbQdv6b6BbqhK/uzazR3NWYJRGmtcO0R4l7PxNlX86gwW81reyAgnYKv0VB9aGP0CXZOGrqtcAEbnZzrbgldAYQnMVWHag1mldH14pepqqcFJ6JlCV6eWPy+EnBFc1kBNg6NVIPbLRKsRrAQc9/VPNszjVqV3sgRqktDV20rlu2hJsFd4Cz0xRiy7GVtLU4HUYNGQEA7XYomg4HxRYSwP2X9/9YseL++g/exPwF6yjV/VdzR/wYNl6D6yhzARUDH9cHc51jtuXlPnGHygojmQXlc7KmBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6974.namprd11.prod.outlook.com (2603:10b6:510:225::16)
 by SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 12:16:05 +0000
Received: from PH8PR11MB6974.namprd11.prod.outlook.com
 ([fe80::44a4:1ecf:f303:d08f]) by PH8PR11MB6974.namprd11.prod.outlook.com
 ([fe80::44a4:1ecf:f303:d08f%5]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 12:16:04 +0000
Date: Mon, 12 Oct 2026 17:45:56 +0530
From: "Vivekanandan, Balasubramani" <balasubramani.vivekanandan@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <rodrigo.vivi@intel.com>, "Bartosz
 Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>,
	<linux-i2c@vger.kernel.org>, <driver-core@lists.linux.dev>
Subject: Re: [PATCH] drm/xe/i2c: Fix use-after-free on driver unload
Message-ID: <aszPfDisXhURsPxl@bvivekan-mobl1>
References: <20261009164241.923756-2-balasubramani.vivekanandan@intel.com>
 <DM1FMM3KEYU9.1D26IINII93FO@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <DM1FMM3KEYU9.1D26IINII93FO@kernel.org>
X-ClientProxiedBy: MA5PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::13) To PH8PR11MB6974.namprd11.prod.outlook.com
 (2603:10b6:510:225::16)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6974:EE_|SA1PR11MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 724aff9d-2aee-45ee-981c-08df285a962b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|261009220027099003|261009221227099003|261009221727099003|261009223027099003|261009223327099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dJOdRHCskPqc8NSm8kfUJwLLJU/tB/AE2vOdv77acCWXTb4B7VThuHdm+utOibt+iP3uDDw+/uoMyLWIJjk3w71+emUbG8Wx3KGLwGFWuYCSy5pZ3Qh9Pnx1PW+jBCLlH8cGTdFTIct5N7n2PNIXB6skC7t8u3iPUHHOzMBmH91y1ATTunn9e+LihMC8SvRKhoN7EMs6oAop6qAQdtDxVn73xJi+fyRVZi/LuEacaMfDUIRt+SICuSsr45z/UiJAPqCCXzcFb4NLsg+mOI/VBHoh6sbs71v9R/20SEdnUnPpwgz1HxrHTNRmynKzp8ZD7ldkD9DxwFoJRuImE66cELsIavIGe7vQAhI9rWMG3neHfIERTeaxYqMSf3BNyc/+Z0DB+sIiqAsABTGWvkEmUnJyuGaZbvZmvIiK2GxMzuw6DLiFzGchk+MzzzmOjPlXyACH02blqtgth2CVotlr9tHsH86FqfUGmZ0j1fO5iDt60qcSgYJo6zULmVzOCDTEDcjH0aK8PPi2PGqU3/UaD5b8NML6K+5BquLF1+A0c1ztDlap9R4phaDUxbi+ogyj1J08KI9+6mJY5hEiqJQa/pwBjLxXQTVcX2cb8bCCPBs4MVj6N4E7sHzMqMZdy4swXQentctB4nN4opcdF2/4sKKBPZDj4FduA3tJNx29/XA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6974.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009223327099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzdBOW52MGhCUm55SDBiUXhiZjFBdGRlalNtd0RQWFNEOVhJTTFkNjM2ZzIw?=
 =?utf-8?B?QzJaQnN1cmdmaEEvUHBrcy83Q0MxcDAvTldsN0c2dUxRNFI0Z2hHS1B6Q3Fr?=
 =?utf-8?B?U1ViUlZWZUxVRm01R2s0dGdWZkJJOHo5SzVzTTU5Qmdwc3oydzJIOGJzbGk0?=
 =?utf-8?B?dlNpRTBsTENIT2dSM21oZ0VDOGduMk1NSzFMSlVVbGpIVVVMWGxNUG0xWmo5?=
 =?utf-8?B?STJpcDhpTlJrd3JadldTYjgvT1diM0FMT25yaGhFeTlKK01oUFZrSTZhOE1X?=
 =?utf-8?B?YzZIT01CUzlOWGZLOEF3RVJtUmdOMG1oOVVqV1YybDlBVU55aEdad3U1RnUv?=
 =?utf-8?B?YUdBQnkrR0Iwc21KS1VWWHBnMTYvZzhIa0tCbzhvcEJkTVhGaHRlaHhxbUFC?=
 =?utf-8?B?NkxpUk1vUXQvNFpwWDIxaHdXL2l0RC9wakJJZ2pEaW9YMVVSd0trR29CM1Ru?=
 =?utf-8?B?bUJGMVRJdHlKSU9QYVg0MXEzUWlta2hLTnNDckdEZWR1cnVWRUVDbTFIdnlt?=
 =?utf-8?B?bjN6S092T3RXRVYxZWd1bmgrbGxtMWpYd29yQVlndkk1MVhNL0dEYTA1MHpP?=
 =?utf-8?B?Z3pOU1ppNldrcDdCYWRpOVJ0dHZJaDhQQXc1QWMvTnExOWpXejExOFlydTcx?=
 =?utf-8?B?UnZVTVJ3a3N2aHJ4aWJVbDY1aXE1cFpFSFEybWJSQU1aMjdjZGIvemRXM2RB?=
 =?utf-8?B?OTRYU2xnd1JKVHdoYVg3bHRRc3FQK0RoV2VwNDFZQ1ZkeWJzOG5rY1FIMWRq?=
 =?utf-8?B?eE5hVXZicjBrZWg2aFJhNVdONUJvdnZRVTk5NGVBdEZmOVNIMWcza3MvbFVG?=
 =?utf-8?B?enBHalIyT3NvV0FQN0ZBRjRzWmlUSXg3cmVBQWVvUC9VMG0rWjllQ1hZWjI3?=
 =?utf-8?B?U3J0b1BrYnVmVjVjamJuckMwZUVrOEM0Z3RuUkRtOUVkODRTREEzeDJpRWF0?=
 =?utf-8?B?ZWsvdDBOTVp3MTJHWUlmcHk5WHFERWRWM2c2eVFTOG5aczExYVdsYjJEZ1d2?=
 =?utf-8?B?eXpsTzlwT082TzduZ1JoaEdHYXZLZWNGWUYxYlVGSi9qbytoT2x2UzZvYm96?=
 =?utf-8?B?by9LdUdoaitBNmRLemxjeEZ0RnVBMWl5R0pIL3ltVGtUU2JxVWgvVlcyYkVL?=
 =?utf-8?B?Q2NlSkhpNXZXUEJOZ3pvL3pOUmZFdEJ4ck9EcnBsOUxCbkFpczRkYlgwYzQ3?=
 =?utf-8?B?c2lFMXZ3ZHk3dGZwWmR1SUJ6Yi9XNUUzSTFPZGpEaFhtUERhc3hkNXZ4bjg5?=
 =?utf-8?B?S2owS1JGUUlZcDFYcU10UlFvVmkyNzhJSE1zVmE5UUU4TDJ6Mng4ZVFLUXMw?=
 =?utf-8?B?aC9yYzRFR1hURnh2cjhmYVlKcDZMbFdobEV6T2djQnJHN3FSOUlXMFMrYlFu?=
 =?utf-8?B?LzBMS1NZbnNwc3l4bTZSZm9HSXlKeTJnbWtCUDBFL0lHZmNFWS9ROTFOVGhB?=
 =?utf-8?B?QWM3QlVCNFNNd2NSdFlVdjNmNDhMVjM0WW1SaTZMbkk5MksrZXdPWWNmalRU?=
 =?utf-8?B?U1VLV3Y1T3pweGQraTFnVXpCV3hveEVaeWxGL1RRcWl1Y0VRZWRQbm5RV0Jm?=
 =?utf-8?B?T1F4VHF1U3VNM1RmWWNCSXVwNFVaUTFkb2F1czA3TlZPditHbzVJallUanJ6?=
 =?utf-8?B?MTBWQy9Qd0xTc1RxT2R4RlVXQkhEZVdFbnRIQ3BKSEdnMzBQTW9yUGpJN3U2?=
 =?utf-8?B?dm9TUmpLcFpQRnBNRkpzcy96Z0pNTUt6MEFmcHEzSVA4UGRUUWR4NXBJWStu?=
 =?utf-8?B?NGtQRlJQdm5YcG9kc0ZRVzlDNjhpOWxUMzFyTnhKSTFIZ08wQm56VTFhTXN0?=
 =?utf-8?B?QTJsbjc1cGVOQ2FuNUhETC9rb0tWaUZEODNNRXM4YUZUeUhtaUNCa3o2d21B?=
 =?utf-8?B?ZE1iWDFHQ0ZwWEIyeFQrYzI1MVd0T0hxNTg3T1Z3SU51eU5mS2MzZTM1aG5z?=
 =?utf-8?B?M0o5SDg4NWlkRVYxQWxoVjlPZFQrbHhxVkVZMDY3cWoxc2tWSGViNUJtV1VL?=
 =?utf-8?B?Rk5Bdi9FZ2YzaytBa0ZxT2hpOURTR09Fb3FCdU5kUEpQZGoxazV5c3ZIVkNU?=
 =?utf-8?B?bXRHdVBmVm02VVNXdXc5eS82dzkwcE1oaEVhYnpSclRPczJZWGhLamlmS09O?=
 =?utf-8?B?R21WeVdMZEMrQXRuN2VuajM2aHJIeDVrMTNhQmdRcGU5QmF4SXdDUmlPWUpV?=
 =?utf-8?B?NHIwQXBQZ1YwK0ZvMXphSlZrMFpEWmFST1Zqa28xUWJnaWE4R2JwS1QybS9W?=
 =?utf-8?B?MVZSUkRTT2JCbVU4WTAweTh4bGJOcExxNFlhQlQ1YmNQSlJ4RVZwUlhnNE1B?=
 =?utf-8?B?MGt5bXZ5akY2L3MxN3p1VytrRVVudDBNRzd6NUxFY1haRldjcEgxWmhON2VB?=
 =?utf-8?Q?2u8iXADuyYPATp9BKHGlDPv5xF4UCkxFvbeEh?=
X-Exchange-RoutingPolicyChecked: wMrZ1ev3Xwujx3M5/QJMWQPpsXEKFvNe4QkwlYesYgkWsRKmI9cfIu5JnqpY8nnZaMoCG/5JWYyAaG6vGEP8Muu8dJdQubd68MdiGPetJ3nZfALdCRZ3JE9YkT/oheTNwBBuy/dwM8sgyHlodap/BpL3UrfXAFFan7pXBdlSiS8RQ4j/TC4QVye9DFmBYf0L5p5vDR1LquFwEgRwUYBp5StXOjUWQobzShEA96fRn/bb2BHeVdRw6ZLbvtG+FPy5ZbTWQd21S5CXLrcpm1XtDHACnW+7J9b0HcKpfCdwghGOC/mv5ohOO9Xnl5QOzoEh1TWmne33U0zskryDIFyybw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 724aff9d-2aee-45ee-981c-08df285a962b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 12:16:04.4790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCSpuL3k/CeCda+xbqk7TcdRe6zKdJDa+TkMBLCchIbKVVT3fNn7ZMv6NLpA/prVNzA4DPoUwba54OqILuSgFvwl3NzcBHWZJ1WiyOGvDBR6rddz6GPND0MsZ8WqGdnh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8253
X-OriginatorOrg: intel.com

On 10.10.2026 22:14, Danilo Krummrich wrote:
> (Cc: i2c, driver-core)
> 
> On Fri Oct 9, 2026 at 6:42 PM CEST, Balasubramani Vivekanandan wrote:
> > The kernel crashes when unloading the xe driver on CRI:
> >
> >  Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b73
> >  RIP: 0010:platform_device_release+0x80/0x90
> >  Call Trace:
> >   device_release+0x44/0xa0
> >   kobject_put+0x9b/0x250
> >   put_device+0x13/0x30
> >   platform_device_unregister+0x29/0x40
> >   xe_i2c_remove+0x80/0xa0 [xe]
> >   devm_action_release+0x16/0x30
> >   release_nodes+0x3d/0x140
> >   devres_release_all+0x96/0xd0
> >
> > This started after commit 0f485f88656af ("drm/xe/i2c: use
> > device_create_managed_software_node()"), which attaches a managed
> > software node to a platform device created with platform_device_alloc().
> >
> > Comment above the device_create_managed_software_node function cautions
> > that the software node created by it should not be shared or reused as
> > the lifetime of the node is linked to the device.
> 
> Yes, it does not distinguish between provider and consumer and hence always
> calls swnode_put() in the managed path of software_node_notify_remove().
> 
> This seems to be a bit of a footgun, and I think we should address this.
> 
> > But the DesignWare i2c driver which creates an adapter device as a child
> > of the platform device reuses the software node as its fwnode.
> > (device_set_node() in i2c_dw_probe()).
> >
> > During module unbind, when the adapter device is deleted, it drops the
> > reference count for the software node and frees the software node.
> > Later when the platform device is removed, it tries to dereference the
> > software node pointer and results in use-after-free.
> >
> > Instead of managed software node use a static struct software_node
> > passed through platform_device_info.swnode to
> > platform_device_register_full().
> > But we have a blocker which doesn't allow to use
> > platform_device_register_full() simply.
> 
> I think this works out as the I2C adapter and hence its children are destroyed
> when the platform device is unregistered.
> 
> But also note that technically this approach has some friction in its lifetime
> model: The software node pointer stored only lives as long as the Xe module and
> becomes invalid after module unload. The structures this pointer is shared with
> are reference counted though and could technically be longer lived.

Agree that it is technically possible. Apart from Designware i2c driver,
no other driver is sharing this software node. Xe module removes the
platform device during unload and it leads to Designware i2c driver
unbound from the platform device. At this stage, all reference held by
i2c driver on software node are released.

We can switch back to the managed software node once the above issue is
addressed.

Regards,
Bala

> 
> Thanks,
> Danilo
