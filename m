Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF5308F05;
	Mon, 27 Apr 2026 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330118; cv=fail; b=Xwpd+uot1uvR9dckHxX440e2K5ATTWvxzs3GF+jUkoR/D41Tm5Ia27obvvuIkRzlLSCmYGrC1KsC+TeZP5/N0Tfy5mNIN9KF3VCCJ+aSswgkzJxiyZy/B/CrCmbOrHWnUp5+XOyH9R/ZZjluNhoAm4JxTY3V/sRV7JY6BfZkMds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330118; c=relaxed/simple;
	bh=FxNexgL3MFwD2RbWvWMGUvUMLYQHRC0dGr48okVjjKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=URfYa2jKAKKOsH5sZ/rqwtP2jBd+HBRdyNqGMl1kEQCJyAPfS0ONw3fNnhhC5kzky8wD31GF/gY8RMt9037GZbrj/3CBoUD37OZmxyuFd+CMQRweVehfuOrimu9yE4OL9eVcXrMhRlmpouvydczjWVG+TsFVymPCLp8mdUl7GIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Buei6tmt; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Buei6tmt"
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RKWOG33926637;
	Mon, 27 Apr 2026 22:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=Fx
	NexgL3MFwD2RbWvWMGUvUMLYQHRC0dGr48okVjjKw=; b=Buei6tmtYZKiWR7qJp
	4HXPejpxXRdtjNfWBRD4OkeMhqSfa1Xtnv8dVq5X8Z5jCWoYJV8uWnNezUrUkUeU
	N1tyy2rmAu/0Yt5tyGiwqcQwd/Lkz2UjCwBHzmtvEDCSw0sFlFiouKdyQLlusTJj
	KKthm5bJjJSE9Zt4A5p66G/zVgHsYxu1q8dKgidzUDZYfHVHdZZZPSoxuVNTJXfU
	gzxjPpVRjjJtGkBkgvHpFYps56pwcJXVQCkIqE0Q8tIwcOO7JDpt74fyFJfiO5qi
	WlIglVS6ZY7MxSUMwihomhyKJoOPmmz+O1wmJqNfQq4zrONV6pGlhxfkp8fH5Sqb
	vFyQ==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dtcnxjebj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 22:34:25 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 070962FCF4;
	Mon, 27 Apr 2026 22:34:24 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 27 Apr 2026 10:34:16 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 27 Apr 2026 10:34:16 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 27 Apr 2026 10:34:16 -1200
Received: from CH4PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:34:16 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmxx1NPFT+D8PbE3RajREX05Hpe1JMmBbNLDCJbR4pDPP/mitcTligo2ykkY1aVKp/cWnRV69I6qT1K5bEPNaARaTQ3hNj9uZH8WOu74qNA4WmtHHFmdQCLHghaDVYLsLi02iptKp4eC8OziXHUzdKie44VH8y0ANaAyFClloMnaa8aVxnfPn/v1Ipe9jwxXtyDzhEw52ffv1EE6EZ/eEDOeYmdpZtiKArZ2Ah8rwnWxWzWBPnDMx6w9HfeNWNp6ZFY/c7Hutn8s4ZPfTDrTJVRs/qpgJytK1IegEvUZB71ltfovtsnNbTD3+maL904LeKKLrrXJdb8MxFsDxX1+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxNexgL3MFwD2RbWvWMGUvUMLYQHRC0dGr48okVjjKw=;
 b=R0Z28agpb7iFTYzImELFk/CYWW78fF0jL2tyWuGnCLGCUxKqeZOmR8h4TicT4B5wWzfhPhWAsksEChLVkSOlPs1HxBunFy15W0ggzQPVuPddjVvVI4Ui6xKuekKVjrAj8+2gIHHYw/IxRWXDPayv5OiG7bz8YxMu9RYpF6XaBUkUwE9UDuwnZ8JaeQCylO61JCDLsDcNOQ4PsnLe5chP2NdJLg3xCC095G8EHKg+dMmSY8csWaMy2KpBlWZcLZha1WPr5Jb9KRO9XuB0WbrJdIEDAOZd7FHrKyvbgur1KqgIJWGqweh60e1yWoIrShaN4xussV/ECgZhMgd4GnwlYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by SJ0PR84MB1532.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 22:34:14 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 22:34:13 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "peda@axentia.se" <peda@axentia.se>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>
Subject: Re: [PATCH 0/4] i2c: muxes: pca954x: bug fixes and cleanups
Thread-Topic: [PATCH 0/4] i2c: muxes: pca954x: bug fixes and cleanups
Thread-Index: AQHczPkkEjYtjOazvUa1I4CDVPXIVLXzkfIA
Date: Mon, 27 Apr 2026 22:34:13 +0000
Message-ID: <20260427223402.836582-1-sanman.pradhan@hpe.com>
References: <20260415165846.43926-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260415165846.43926-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|SJ0PR84MB1532:EE_
x-ms-office365-filtering-correlation-id: f4aa4857-e3ea-45a5-5817-08dea4ad1bf2
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 3HISIUbOzHabGZ3v7HuAnzlTn51uL5faLMuvV1daxPfAQ5QyKzfDT1tnTJ41EQJeah1KI2wRBfVVnBsmolW9DyyfYEq+D+AWAtR+A4oBpX79fGyaonYhHdKiyfs/xvaLbzaT2rvsmB1cmSuGDcw+DKKx7umlkzhLCOVERUMWZHiSJmErCggXzQUmnObMfbvAEUluhbT5NRBkFS4toX+6zC1BerTuJmsAyYVDN7ECcQ8pLJGkjV9IVSktTuKQnxfqNzDHJnsHgA2NE7fv3kOEiIjQ5yfyKt58PVtGpMp8pUCNHYS2BxJZHPd8veBypAZIhbJUi2dpy4FoIuhRsfCZkuztYVX5sOIpUN4jYDYIt/UaNJw8nbCfE+2j9LX/M69/T10ad1rZgZ0FQOT0BZZwtgr066Xon2mm7Rs5An1YhbJhfmtCZfimXEqwjho/Kn2cyD89PEZAjqWhwvnhEFK0XBUD5oVVqzO/Hr7qQN40KMFbenLdE8gpcOk2kXJ/1iqsTkPM44TqyFB9iT5YLusFVT38p+u6j569fBFiWz3qpn44FeMQIQjngcBXlrpZUlCbmU8I74rccrTw00HKcNGhV8KS4XRXxlRJlDaTyLhTnl5/2oljuHSZVFP+8fqxhIky3DOpEb2tp1br+oHNcd2yopk0Xl3nx21BaqF5sI6zJlgNmrL5N0ZrIrcafbQB4Le6Pu/OJFQ+K6dWBuwh83txLtk0g2TO0damF9vHjGjbgscK3xtkQkqtZouusVWy39aYKZUwuVSqhYUVcdAGmSLOy887JV6RxWPK/q1IIf6JH+w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3tLNut3wy7itd7+NV6kSOK+0e7wCnQOk7hLKabJtke049NBCPFE4KDACn1?=
 =?iso-8859-1?Q?u5hoCBgZE40KdeIp4lxzyk2lKHiip8cxzJRFriY+68/y4njgXEiwNIKXld?=
 =?iso-8859-1?Q?VUFZB6FNXoKq2YmJi3wK4jL9pxPaB/36+q9vkqiPllZ/n8jJIFp/9BYoC/?=
 =?iso-8859-1?Q?ZYlqc+5v06TQGSGDDkaX1E77SLkcon3NVtHjpgQPzHfglof2IkGSWCRxzR?=
 =?iso-8859-1?Q?eVZoKo3oA0qvaWzfNLasDsAKJRsimCR+UFv97+/vYzINUmmBMIJWlkjYju?=
 =?iso-8859-1?Q?uZAE+vaxWBgRyKLMSklWGRXk0ZIUB/Rd80bjuGeAwt0olZH3G9/2rUZkmJ?=
 =?iso-8859-1?Q?s9M0ExXcdaBwkzzxb3WNdmxsOJFyUULmfkvM2hqL7P/6wg0PTc6ikRwxaE?=
 =?iso-8859-1?Q?7EdhzRgDqtuNe42Yzf32A+hylAC9wruHgZX9/oMEbwC6StGmcDIu8oDpZF?=
 =?iso-8859-1?Q?pvYmH5AKg7ELJUrJ9N1UZH82DMr/7xXs7gYLctZG0BhBfYpGoRFerokwsi?=
 =?iso-8859-1?Q?evMm5LFzxiPjPPyQ/eVuHVqqJnJcEST4ztaS4CwFymQUr9uWxzrrlcgqke?=
 =?iso-8859-1?Q?/dH1awJPADlLi2pEzxwhH7bgqxEnqUPFfd7+d3VyeMHDr6JopRB4KpQkSO?=
 =?iso-8859-1?Q?0v7a5UimMPK5lpMxcpCKS/0tPeHYcIykNNOzGZ57ydxxb1CzOAjbQVkrcw?=
 =?iso-8859-1?Q?yEVztIG5yGKfyb5uh14HtnuaqGH9JN0oCVP4mx19HoNuejFABKj2F7Ec4z?=
 =?iso-8859-1?Q?vfQNWEDPBY4CclSZk8w7djF5zbzBQUNcaLf2I3e21jzO9hMdpwtdrhgs+I?=
 =?iso-8859-1?Q?3oeRG92fNF/AEQfi36N1ZqyJtMLq/n2hJ3Ah5IK0NFpq2dcL4JKyFOysLF?=
 =?iso-8859-1?Q?4TsnQ85y6qNyNpewTtxjSaKuQ7s6ivvkN6/MjdzacmpKmMm55hV3m4Y4JN?=
 =?iso-8859-1?Q?6J6nWosgWVSYBl2zBdDQhEg4cm7aIxF60L13Nv2hlnFYthQpPkDu9dG8dt?=
 =?iso-8859-1?Q?h80ceHEov9LoQmgYvlm18vOR5l6kE23nyKGxn/zgSTdqTA2SZ/goktrB4q?=
 =?iso-8859-1?Q?orTkHeX73394MHRMQk/ALgox/xsAg73HRtJBS8+3BSI8G6rPFNhhO9R/ND?=
 =?iso-8859-1?Q?xNKORFnwDdVORx45WVF75aUyzZVn8sGJCYshCYwtbt4+bnzDLnfBGXfgYG?=
 =?iso-8859-1?Q?yWjhIMRny0VJv2CuZPrN/Txns51eJoOxv5maNeBmzWWdgrwgpWyDZmXqNT?=
 =?iso-8859-1?Q?XUfGtPArWrBhCk7oTHvqFRePpO9mx04zl9Bofu5zjVgmb7jDVqL0qlkvlo?=
 =?iso-8859-1?Q?HfheeqCFXX/aRkR9vQPxYO9UCztoHozxkvh5rkx2/hFkIctQVz+3hh5MBE?=
 =?iso-8859-1?Q?nG+0n0dl1Kb+FdJNkWv1Yp0htWV1solsAISBnazmsjpogNFlkF/mALuj0o?=
 =?iso-8859-1?Q?DvxFT8H+91waUIGs49VOG0yy3/6vyxusqruet/vtJZoh/TDU0wklUPaCix?=
 =?iso-8859-1?Q?MQpkNhf6qleG8duZWslc2p3avbizVp7uy9IC4BN1mHcrU97hDNgqI6GL7P?=
 =?iso-8859-1?Q?BLzRNc6G4yU922tPy037JOs/xedEgIRL6/6sJDDp7+DYxC5nlEmaJUc2YV?=
 =?iso-8859-1?Q?Q5G8VlACb+otn4FDLp+qzCl1NV1+dZYD/zFIqI969mgV+qioEchZnmfJbj?=
 =?iso-8859-1?Q?FSyGhwFzs4iMYrlFesmZgiPwn0wllVl+YjSW7wNTw/6MXtPzaRyISRUGXw?=
 =?iso-8859-1?Q?u1EqBCQSce/FtVN4SLifUWEVIfbLfa5qrpUxTw4wTFMEvF1GVNhlb6abBw?=
 =?iso-8859-1?Q?oUwuhtgkoA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YzF1RBi33o/XPrcaHyFhHbxhJX/DNAyJ066MSrvJnu71nWK52g2Bu/oW+Ys76eL9OAOdVljrlm1/TI+cEhefcZIYJZrROQtZCuktKYxY1RzdHXCXedbHvIYOpaJMHc18ZXIuGhVU5WwJRvU0OF6O7QAHhORE/NK30JXKI1VXyODMYNYDWY4lNnnpSn1Omry/27mD+wDU0z4sFXIr6acAL9JMJ2NKrMvOcj5EcHdKEIg1RstPJ3zPLtHiOorq2JfFtBO3rC5kF7H3AwHea4FZOhDfPJQ3vzgTPgJrbn9aECr3wKTTBxgE23CWEY49Uf5kUJ+R58GaFI4y94evDg68rA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f4aa4857-e3ea-45a5-5817-08dea4ad1bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 22:34:13.7877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGSJ7AA0Xvxv0ClerRtABRAmUpEC60H/r/U0pQ0wWUogcXj4iAV5SSvsK5qPhO7mZN16/BcbhzMAwL5qgYM+Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1532
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 7iBkzuXKyesDK7zO61OG1L3jYBpmg8i6
X-Authority-Analysis: v=2.4 cv=YKCvDxGx c=1 sm=1 tr=0 ts=69efe471 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=k7r4yCLl9DVLXMiQTbtC:22
 a=OUXY8nFuAAAA:8 a=KyPsgCzmAKN4q_A7SL0A:9 a=wPNLvfGTeEIA:10 a=q5mp2vxMLvQA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: 7iBkzuXKyesDK7zO61OG1L3jYBpmg8i6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIzOSBTYWx0ZWRfX/kl5jkYCngY4
 kWzdKOFXpCy5L2M5nrRkrQ/H3My9KZiXrn2S7BD4FZrQW9gbFVLhG2J1VpIthGAWAb2dvKAUmzy
 NEyGky8iPgqQOH5aAOGZ8NZcrR/KxnEAlDRxmS6KtAdmTC/fhU/AuWOlQJ1WkQdD/KL2SaLU1zg
 BKXD3rxxo1XXtFrDyxeUQXrv9qMxU64bQuRY3kD8CPe/iPdAnz99Z8B+uldT2yM0fXMorH++KS1
 LnSzVJttaImUo1Js4dtGidofXlsLwJ8sT2DsVVgZWQJYpTziftfR0xJ9z/LbYBQaKhzW//BWHHy
 +tuliVV962CimCXKUgk7QHmf/BHlYQrJgHN7P0Lj8sr7WpAvdyV/aAIsZSfV2aBo4a3J7JxEULh
 iSkwS3k4x6SuKx/M7KtWEGf98v39DXlyNX4rzFPHtcogryaFn7XcDyS64IcyDerCSBSyM4sNZOy
 isNrTsfdPQ07M6HxLrg==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270239

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
Hi Peter,=0A=
=0A=
Gentle ping on this series. Please let me know if you have any=0A=
feedback or if there's anything I should rework.=0A=
=0A=
Thank you.=0A=
=0A=
Regards,=0A=
Sanman Pradhan=0A=
