Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E03403F6;
	Tue,  9 Jun 2026 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016078; cv=fail; b=sTaezFJd9fhtRCRkbYquygG66nILDe2rz4STt48AP++sTX+SJDlMFQk0l7sUBIoVugCjR3p+br2dBP07OJrYqHysinUUux2tbaqPfv+ktaQlXHvBqd/JSK06M2vHwbfC5Ao4gyrgrUPaITxQ2NUrkZtqaJcwpmcTaRSsJBhC+dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016078; c=relaxed/simple;
	bh=OkREM93OLahUv7/YX+CvdklKnx90tYqLSZIjJmx30wQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M1dIN5AwNAgHQivzRjmFtoRQ62dN8/r3pV+JtuR7Si3yEm04PAm3esl5Lel+w8TlMPibxfdW0Z5iUcpP/xOqmR9GNLKjG3iH3YMX3jH6p4x5GSO4XZLtQ1iQwOxE34tOmsbCxNy6sG57h+scZ9e7SQAnja7x4VzPtwxeuNaCVNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G+bxKDI1; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G+bxKDI1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHUgnHumBUVFFZzL6hS/IZg0Nlx1xnoeUfpu17IrLMDZ4fCQjFFHVVh7ohvOWpWjIaxE22AywsKkBr7KXNTSalymBPMJyVLhwFeLydVBi0gl5xY4ozVi44Dlx/rCkkzlNGWwx2QW32rTzsvC8Dt3tp/gusFjpPacFB7bzsp58DYN2ip7uTESrJ/pRTWHiuR6ayWAJKdF8eXvZ15+/YUYR8pVqdIQspyf1NpYmudhQFjsplvgO7BTtQLGqVLFQVjHVgprjNxsRz0e8ZVo/PQN0NxWptWbRg3IsVqRdfhbZbMs45I2l1epv6d6QRgTXv5mGupBWVFaWhBt94YcQeitGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9p947EpXdLBLnxvkUq1mHyACBcp2/wFFY0rITk0xHQ=;
 b=NnjhM4hzAkoaHSWbpBskEsfYyoR5DYYuVW72L2RruKi0AfVgBXl8rp2IKcSWFMKlFnYv1BS6dKTlg9KdHyiflqEiiS6tLwkXgi7mLMGkKDRVvpUkPZh7icsQWlHzFodkJICJWTM6nig1vDfPocfwMbE50eIXld5SUbdEDdvMiRZ+hwi804rG4oNUzg+6tvlQKEJzSRO1zP7OA+2gu55bFrHkWLzksqqM09ObEoyXVtDEa+NUI+3HyMKITQyt3BXpYM2xeaTzrjkvBQjqFnh+095+gdy1N3BsPRUDIlqmqmK+FSieMYPYurtQ5f5MJH9yndr1tV6XjAtmVJ1BuDSyTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9p947EpXdLBLnxvkUq1mHyACBcp2/wFFY0rITk0xHQ=;
 b=G+bxKDI1BGxHDkM7XCRw/0Fv9+wxHz93LbFyLSE8ZlUaabeymD8UP8EyIId/5D+D6XkTX63oJZFyEof220liAX7eV4QmRzJMrrxicvB5Am+aChrPV7K22fym60x8bVfoJW9dpqcfQtGjAOiHz8UxiZKv84JKOIL9VNVMRbBdSR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 14:41:12 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:41:11 +0000
Message-ID: <7a967984-9979-4874-b636-94014487ea11@amd.com>
Date: Tue, 9 Jun 2026 16:41:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] i2c: xiic: fix SMBus block read and PEC support
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
 Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260513-i2c-xiic-v3-0-ccb3cf70ba03@nexthop.ai>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260513-i2c-xiic-v3-0-ccb3cf70ba03@nexthop.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::25) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9cf3db-70f3-424f-d5b4-08dec63526a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ylbY2AA6wbYOB27DLmJtD35S0hYVQ86Yu+15RwLZC2Ai/eYgrihziZDjeF33QcqyWkuQp82d+xS4SllUyJ1UDIoUsrg9ANV+rk2Jnr/1EGJY+yfQSGIuZuImqcsFCNu+/TzdGa3ZQcA47WEB3vDrt0A22eNyEazJHCUP0XAJhKfTNau7mBNJ3wUJDT0na53+WSXl6RcF0v2jXWzCnru9PoyQzhoz49R/tmPk4ZEkLc6ibwaA+Hke5DjaoSfqLWzAFLBMG4aO3aMaiY7y6vMH7NNfHiG/PQ1TrzoOxWqQUcIBadBCcMBPFUoiv8PHr4G5r9wpnsBxMJYf2qkv7iv8vU0FkX2X6t387gYp+KEGxCtkY6VpKCUk2DId9VdmJfG9hfiMyUnMkeNtaiHgQ1qw5Nj9CkMPLlQsCcP27e5p/WEIRatPi8Tcuq3SxXGoa8PBketQomUA63dpVNXq9NLoiebf9BWzAiGiIGyOULwEZue5G3bSrvT2a1jydLloOrpF0lHnG4jpxIl+7lPKoDQFrvXaLAT6hlJ93WTWwbNP30EO/XaWdnGdQGlHzlcSBTUGWzDoXXMja0Cwgm9GopM1J/2+mhZg/ocFYWM0eX9PdHbDvkHTbWD93eKClKT/uF0a9/UsL0qBIlMJr83SybfV6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUVmMWM0dnRJZXVDbXZEeVZqSnNQdHhUdWVRZll5TCt1cnExaFRzWmh6b1Ri?=
 =?utf-8?B?SnM0UHhxWGVNRXVlZEp3THdCdWErTitPU1pqdlJPQkZXWkZZYVRwVG9LNEd5?=
 =?utf-8?B?bEFpYmhTSERzMWxHeG40VWxJM2VCU3ZIODRtdCs1STZQQ1JPRlh1RTNCY0pa?=
 =?utf-8?B?cTVTTE1ORnRpT2swSWdETlNMTnNsTEcwdXdLeG1qVDc2M1lUTkFqelpQNUtS?=
 =?utf-8?B?c0tKaFo2ODJRcmxrUnhKd2V0OUxsZjYwKzV1elFmaHJoZzJoTFhQenl0U3NZ?=
 =?utf-8?B?S3ZWbGZ2bGtqSGxBTlNFSjFKWXdIeWI2NDlLQitUa1NFWVluYVFHWS96MGV5?=
 =?utf-8?B?dC9PanFPNXo3Umphbmx3TXhGdFhIQ3NGTTJpOHZNZHRzRTN6SFYxWDdJY1A3?=
 =?utf-8?B?aDg0M2t0SUlid3FWOFlzb0VtMXErdXA0d2o0VmNhbXBBNXp5UmJsYjJEL3gx?=
 =?utf-8?B?TjVaK3JIcU9aMnZUZ3NMV1k1OVNWZk5xQWRVRC9DbVNmSUNRa1ZnZnNiaHZv?=
 =?utf-8?B?SEFJSWdiS0h1VjBjL2c2SjQwMm1xaTZVNkFCNVl4MmlPNEw1cDV6NEo3L2dZ?=
 =?utf-8?B?STI1K2E4Qy9relFUN0hWUU90SUhmUVJmY0RrOVAvUUd5L2F4K3NIMlhycVhE?=
 =?utf-8?B?Y1A2dStZUHQxRW1FQ2dyM1dmUGJ5RWE3MlN6VkhjSk5SRUU2SFA3SzZiUUgz?=
 =?utf-8?B?UU8xNUVEQTkvZEt3TXdTRHFVY1N2aXJ2RU5sSFd2akRUU2syUkhRSVkzcG1P?=
 =?utf-8?B?Ymx2RVduYVBDbHBuYXNKeHQ4T0QvN0plUjVoWUk0TmlZN3VFLzVFRUpVQkJs?=
 =?utf-8?B?Y2UrQnBaSmN2bjVvSGpsdXN3MzNoZTJsQzkyajN6TnVEYzZPRU5SM1YvNFov?=
 =?utf-8?B?a2Q2MlAyM3NoSjY4WmdKRm5sT2pvMmJNNDgrQ2EvUmQxd0o5QVl0MjU1WE9t?=
 =?utf-8?B?ay9CdmhLZENZRDdvR2xYV2c5eDN1MGJESzhCNjRTaFlRTDJmaWYyQnY5WldI?=
 =?utf-8?B?YmhDb01ydWRTZzY0MmdKYmVubi9MTGRXZUlTUCs0dGxheDhSOEMxbHRvcEdD?=
 =?utf-8?B?SjFEZ0d0SXZtUVd2eTNZVXFJOXpFUWhFelBzbE4zUE1PSDBZU1lxd2t4Wk4w?=
 =?utf-8?B?QWM4ZEhhYzlacTl1MkpmRkxwcmJaTHpQTHd5N01ycldEdXNjMjg4SElrczZE?=
 =?utf-8?B?QnJzU0Y1dnFLYVdqVFFHUXdZVTRJT1ZuU28rYm11SmNJZ2FzVHpDM3F4T2xk?=
 =?utf-8?B?aHMyVDJYbHhzOWpGQUJVNEQ4aGVvMEtYSlJ0OUpSMis2OWVTNXN3cWlPSlRX?=
 =?utf-8?B?bmNpbUtWaEJMQldsc1lsZjFibGtuT1BuSDhBWXJXNlFDNmR3dDZ3L2ZUSGd4?=
 =?utf-8?B?WStMYzVmNTFYdXFnLzg2a25ObHFTaDY2RVN0SmZkMExnZEtTUXBaTEJMU3RX?=
 =?utf-8?B?b0lVeTdpdnpRMk5zT2duN3R3NUU1VUhQUi9JaGFtYkRvMHl4Mm8vTHpqZ3dU?=
 =?utf-8?B?djZESEdpTXlTZ1NlNklnTzFXK01WN0VlYkF0WkRUSWdaY1JHcloxL1gxOW5n?=
 =?utf-8?B?SE5NL2ErdmV5TlovcEF6Yk42OHJVRW1qZ2pJaFRtRnRCVW1Va1dPamlFS2lC?=
 =?utf-8?B?Q05ZdFlESkpkcDNlaS9YMDZ3enlMUXhkcUxyMEM0b2V3UVUvZ1ZJckJSMkNi?=
 =?utf-8?B?NzhCTXFKU0QvSElkODN2aDl3MkRJVHBQek5pbVpXZm9EUSt3Sk5lb20vRS9Q?=
 =?utf-8?B?RUk3UU42ZHkrejIyQWU4QUtFYUMvSWRFdUVkZzE5dVhxdXdOeDdZVStLUlBI?=
 =?utf-8?B?eWtpMFJLWlhXekgyWDEvY2RyT3ptd2k5VU9VQWQrdzZBZFFoVWZvdDJZbmta?=
 =?utf-8?B?RWw3UlRBdTJNL2thdVVYSGNTVHpLWE5pS3BqaE5FR1haM0JId3dNZXhHdlNh?=
 =?utf-8?B?MU9vNm9VN0lsZ1NkOXM2aVdVVkRnVkZyUXVoM1htZVc4dEdLUVZUcXV3RFo3?=
 =?utf-8?B?SHFXMzVlcUdqaWdQdGFpS2ZDSlczTHlnS0Y3Wkc1akpNMHUwRklqVjRhYnpt?=
 =?utf-8?B?dFRHOGkxc2dwa1Rtc2NiQ3R2UnVCazJHblRKcFgyOUFldndZMUliNDdxYXNk?=
 =?utf-8?B?RVIzcUJpOG9UKzIybUN0SVkvS240Z2NQOEd0YXo3dUFHaXR1UjZLSE01bkl6?=
 =?utf-8?B?RFlpRXFOcEJGV0cwcEY4T1JZL244eDBHNHEzL1FEbXdoaG1ob2l5NkNHZDlN?=
 =?utf-8?B?UGpCejFSMnRxb1BxNFp3d2RMZFlmNmx0NnF6SjhRbXZLOG9VS2kwUWxyL2xu?=
 =?utf-8?B?ZTF5UVg3VGtUcmdRQzdNc3lkMW10Q3VEMmNNQXNWOEs5RXhjQWgzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9cf3db-70f3-424f-d5b4-08dec63526a2
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:41:11.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YD4D7UHN04LWMcHdDE3SqIKjVjCAASEOHgAPcffUwEPDgvX3vRzel2q1Q/oR57QV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168



On 5/13/26 12:09, Abdurrahman Hussain wrote:
> This series fixes three independent bugs in the Xilinx AXI IIC driver
> that together make SMBus block reads with PEC return -EBADMSG or -EIO
> on otherwise clean transfers. They only surface when the client has
> I2C_CLIENT_PEC set; non-PEC block reads happen to mask each issue in
> turn.
> 
> The problems were uncovered driving an adm1266 PMBus device behind a
> Xilinx AXI IIC FPGA block and reading its 64-byte blackbox record.
> 
> Patch 1 stops xiic_smbus_block_read_setup() from truncating rx_msg->len.
> The i2c core appends a byte to msg->len when PEC is enabled, so
> overwriting the length to "block size + 1" silently drops the PEC byte
> and i2c_smbus_check_pec() then reads the last payload byte as the PEC.
> 
> Patch 2 raises the RX_FULL threshold so the interrupt only fires once
> every remaining byte (payload plus optional PEC) is already buffered in
> the FIFO. The previous threshold of rxmsg_len - 2 caused the
> bytes_rem == 1 path in xiic_read_rx() to NACK a byte still on the wire.
> The chunk-vs-defer guard now also accounts for the PEC byte so a
> rxmsg_len == IIC_RX_FIFO_DEPTH PEC-enabled read does not push
> XIIC_RFD_REG_OFFSET past its 4-bit range.
> 
> Patch 3 stops the BNB handler from forcing tx_msg->len = 1 to signal
> completion. tx_msg and rx_msg alias the same i2c_msg during a receive,
> so this also clobbered rx_msg->len; and because tx_pos is already at 2
> in the PEC case, the unsigned subtraction in xiic_tx_space() underflowed
> and the STATE_DONE check fell through to STATE_ERROR. Advancing tx_pos
> up to msg->len drives tx_space to zero without touching the length.
> 
> All three patches are pure bug fixes; non-PEC behaviour is unchanged.
> Tested on real hardware -- a Xilinx AXI IIC controller talking to an
> adm1266, where 64-byte PEC-checked block reads now complete cleanly.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
> Changes in v3 (addresses the sashiko automated review of v2):
> - Patch 1: handle short SMBus block reads where the controller pads
>    rx_msg->len up to SMBUS_BLOCK_READ_MIN_LEN for its end-of-message
>    workaround. In v2 this branch left the PEC byte at the padded
>    offset rather than the actual end-of-payload, so the i2c core's
>    PEC validator read past the chip data. Track the on-wire length
>    in a new smbus_actual_len field populated in the minlen branch
>    of xiic_smbus_block_read_setup(), and trim rx_msg->len back at
>    RX_FULL completion before passing the message up. Addresses
>    sashiko's v2 note about the pec_len adjustment missing the
>    rxmsg_len < 3 padding branch; that branch was indeed the cause
>    of pmbus_check_block_register() silently failing on zero-length
>    MFR_* fields and skipping debugfs auto-discovery on affected
>    hardware.
> - Patch 3: defensively reset smbus_actual_len in the BNB completion
>    handler so a subsequent non-SMBus transfer cannot see a stale
>    trim value from a completed short block read.
> - Patch 2 is unchanged from v2. sashiko's two other v2 notes were
>    investigated and judged not to require code changes: the concern
>    about removed padding in the chunked-vs-deferred drain misread
>    the patch (the padding survives via the else branch and the new
>    PEC-aware guard preserves the original semantics), and the
>    flagged unsigned underflow in xiic_tx_space() is unreachable
>    because tx_pos is bounded by tx_msg->len at the call site.
> - Link to v2: https://patch.msgid.link/20260511-i2c-xiic-v2-0-c16380cb1594@nexthop.ai
> 
> Changes in v2:
> - Patch 2: widen the chunk-vs-defer guard in xiic_smbus_block_read_setup()
>    to include pec_len, so a 16-byte PEC-enabled block read routes through
>    the chunked drain rather than writing 16 into the 4-bit
>    XIIC_RFD_REG_OFFSET register. No tree-level change to patches 1 or 3.
> - Link to v1: https://patch.msgid.link/20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai
> 
> To: Michal Simek <michal.simek@amd.com>
> To: Andi Shyti <andi.shyti@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
> Abdurrahman Hussain (3):
>        i2c: xiic: preserve PEC byte length in SMBus block read setup
>        i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
>        i2c: xiic: don't clobber msg->len to signal block-read completion
> 
>   drivers/i2c/busses/i2c-xiic.c | 67 ++++++++++++++++++++++++++++++++-----------
>   1 file changed, 50 insertions(+), 17 deletions(-)
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260427-i2c-xiic-2aeb501ec02a
> 
> Best regards,
> --
> Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
