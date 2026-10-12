Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93E39DBF4;
	Mon, 12 Oct 2026 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826841; cv=fail; b=hREPqJeohTB3g4a/93dCnmvIRleSojaicBpPUo8WkxIm6mEYD3W0iGaeYWia1J/t3U6a/o6vKtWzNAbYqkdvBkFFTCP80HkYtIak/1ziEA1RTXHZNq0by0tEYBCtxA1MqEq5WqFcESc1ZMdz4UfCvR0o2w6w9YWDXmtvNm/cels=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826841; c=relaxed/simple;
	bh=ZbmvPR1HPzLx43r3nFHyB4xSm+vrHppxxeJHs3ynM38=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IO1MkJ7r8FZwpapmK+x5j6lkh0MAYqxxTlf4aGsfl2PmJ3Lh2dtLWG/8KMBxENl0zCTQxtt1ywr3BEnKlLWdJUvCntL3RPFqOjCePd5VGx/9rSNKi+s1OQ0th1rhhQYAJqpYSwmZihDOf8WIGX7lekCe4QOdgOfB+WsH3GnCIoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=acluh5M4; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="acluh5M4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6p2bqLY6HrqHtCFDsOEr1Xlqq+R80CJXheHM7w2r5fI4SN2zr6jc7KkH3eWpieLN5QFYg8jI6MKx1SHf+/ZgDhMjhsmVCYhMZ/+rxdRCXbv5eRclojE4THE34J3T9Nb2OrtzlDdIQCJRvtkmNxfhMIOIr2a+VjxiCM/EjTZC56FUvIE+UVS8ia3hzrCOwMzbmyF1YdQ+9fFvrl9whAtt/vZYRnDWARtxl5EYh8K/70EZRLXo5Jhy+CkSAf6GRFsPaPkRtWjwdavunD4OEpBLCutgUD2uVkfL1x1xyMQ4qupMPYiBQJfHCqtmzxY/pPVC6cxyeSkCsvMzoWMKHNPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe2iANi7T5IaT+aqwG4sM399c++FzPsevCrtlLUpkHM=;
 b=wm2d/MayErx6/7wq0ZGjE1aGk4v32/uIMtjDPw6ZbthwF+/jenGpW4BA4r+gaprxdGOcJOCCOy95bZce0pcpmxtky7p1vpwLEydMU7Tc1BZ2gVDnqaSXV0wv9OdkS4zuhwmrWXboratve0ketifHe9r2itct4wngS9hhRgF+iRLY/ObLVRxL6+jfqU/lqTK30Y+8MVWybKODOqF1DrYE2l6dPqLRwkgKi95IOV38fSLmNatSRCP/TVuICTpb8tTQUU7hfHwvoRdGntNCdcUCrUBiyEcjp2bBvym3jDTkCU677LK/39Egb/YPxatycg1HfMn0oqEkSi3swOwvmpcVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe2iANi7T5IaT+aqwG4sM399c++FzPsevCrtlLUpkHM=;
 b=acluh5M4pc5Uf5/GWT4v6gQUHsDIi26sK7XbNGPp0Z22psu3T/GtCQHynwODcgtPyuEBjUC6yTB2L8ZF/tEMtASvs44EDJG0CBbWlO+EVv72gaiMK0N9mJQ7fp1hGCU6Cf1YkXvIIAi2IrUzWrqdljKlts8JJk1NyyazQ6F8rx9oPZgs/z3yFcGeszsB19SxBzxzxPXryExFCsHLEiCHnjBKxpahE8jOrcoIIMprqjis7neEtQ51FAMfLBZ/nF/ifRpWsn4XEbEW8GT0JOIB5dGEJE8hhF3gzUaIDGAsdBKHqPyp7p6oZVy6AumNAIn6Ntg2qDFRv9w5Y5+P7RKX6g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 17:37:59 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 17:37:57 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Donald Shannon <donalds@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] dt-bindings: NVIDIA LSTP USB adapter: shape of the channel nodes
Date: Mon, 12 Oct 2026 20:37:36 +0300
Message-ID: <20261012-lstp-dt-rfc-v1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0044.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::21) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 3844c4fb-757a-4888-8c66-08df28878d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|10067099003|3023799007|261009223027099003|11063799006|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	JGXxQpggx5TPcwx6hSqVak5iuVgldhWYEq0Wy0P9lcBf9bfvq+zooRoC1mRaa020KdJuL3I0PtQflQBwVFXIz8tVFsGJv6azp3ZikyDhBoij9DJSmW2RBeoHSpWbhOkNh50n/tcTWyvfz5tuvTugDFJbv4Y3B8E40xc9c611d7U82HfePXCzh+RH22UirEwxiwotgOlaUvIj5NrzZq0EWiQlGB3RBH/nFq/pxz+NgxSG5o3BrwLUWrV5C4mAqYRqpVktImDVJbfMFg5Y1rO5mcLaHXy6dR7aUAMCxAhun8QNWPlOIqIqvj/xQkYwae5rhzGrB1w3ul9mFvv6iv+3oajFsWSti6eUrINL9IZ28ujCnYjdgtRhwfi1tHKDnpdW7VQogy2yy2FsE9PXWivqcKdCWwV0iYm8m/Yg+coUd5MCK0deL/mJG928HbdT1AszqyubPYN7S+9cgGDPLE8ahhVN9XpoLRlztsl7y8PJaEq3SwGHqnHnV6DMlCx+Ld0Ufpu5lOxR/LSH1pJb3H1QQV4s5ugONYuZQb9H0GEzX4Tu5tLc2Z0QGwJMD1+mQL0lUQIcWLWmjFcmfUbYIUlOEV9M6onUHyY75ZMGRg3aIuNZGGRKSZeJFGZLsgUdb+sOtPdIKbeaiGFxwLyEESDVjBvsoN+94Tml/9isXzu8NVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(3023799007)(261009223027099003)(11063799006)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C6LYpOeHbHm8crCw08TA2hKgzRif75V3Pdo4t6HseaMRYI7ook0JDlRUPwQs?=
 =?us-ascii?Q?qFGbr2FUxNQ6zCe7l+JlFtwlaxWidUnZaneU+1K1Q/Rp2s45xJL3DZi7YLCX?=
 =?us-ascii?Q?5OsFNkF7SARxYDGb4BA26fijS0R5r6TTz7Ygrex7/VlrJ9HfyO2G5y7Ik8ji?=
 =?us-ascii?Q?IcRc9wlnaMexy/elP2YMQS7ANQ1smQZpFzKbHc7d7l7e+fN3N0MFwYk+LxuF?=
 =?us-ascii?Q?Ogw4LVB9fQYfOd6VtcKcVgt06LBM39UkG775dsgHxY064j8aCapOYt8OkEql?=
 =?us-ascii?Q?k23AiovACWJ44oaDn/EDdrBpGLwT5UX4PmawYzZtnVlSfu6FVN8pv8Q2bqcr?=
 =?us-ascii?Q?DtahjEJxzhtKgnmc8SzKah1OL7x+9G/3PjMShQM2nkzRSJrlRZa6pt2NOkS2?=
 =?us-ascii?Q?Fc4R7OWGIbgKnbvIR2DdLnhdqhGEL4fWn6fdHxXs3UVJ8CL+dWl1WpnSsZfm?=
 =?us-ascii?Q?xAAfFLJOa3CkEZqcjkISEEb2Vqwh+8tG8dTRxxgWxLv29HsVd5BIqR+JXd7P?=
 =?us-ascii?Q?SiGaNc4QKrG0Pzz0zxZUKR2CgYc2+rC2ICT0I8tx2r3nYzen7JT2cE1SWOqz?=
 =?us-ascii?Q?dvUycBI1Wyt7WRV1JpmYXcwGo0ero8CkG8gQEicFW7b1nl7S/qgFYGeqDmsR?=
 =?us-ascii?Q?ipiFSemNmemftLcN8DlLkplqh+8Hq+r4Ey52e+rCL/b7F+AQH5WNd61E5nXB?=
 =?us-ascii?Q?WI9me1t0HZE9un6im/+OKeCn7UndUfSAIOc0ofdlmIT+tnu+rQvMpvTVX2ZG?=
 =?us-ascii?Q?oKaWyuyGVVX3O77cykXXSP0VZ9316VSlk9yBrSdD6rZbpX2+ca92LCbJUIEm?=
 =?us-ascii?Q?crlrMYFLG0KChnzeE+qnBalKskdLw0zthFSLuAFL9rwMEW7mmMWDrYheMFfB?=
 =?us-ascii?Q?rFLJcWS+CWB0eflb2/wEKvXqJGHCz748aPujr44uzclfg9HztYlSc8f/AXHN?=
 =?us-ascii?Q?zN1tqcZOO7U+wi89y4TucD7NNdjBwceba4ktWS2HVJqi+aWNnArVneuaZDZh?=
 =?us-ascii?Q?cLNPS5chtjanbw/OhJcyJah2WnXdKlGqawmOTMcxug5M6sVFMIfqjbST8uxj?=
 =?us-ascii?Q?nca5Q28r293Sx1JLYgKTSwQLLhJjZHz/YF0glGeAGAfMeeTzlbcYkYxj3JWs?=
 =?us-ascii?Q?6y1Lv7AxGtoxa5hE7HDIByQdvDKxipmCvd8k4INpOC5nTrhk7LDubA/dtt6c?=
 =?us-ascii?Q?sUvB5QfyG+2iOb4tWKtwARxThj3OFXAGYCVVKm0Akz+pxPtEIxTxfYLNeKDI?=
 =?us-ascii?Q?55ZtsiLCbEK51Z3NgqHRQiq75hjzSU73jhNV+4H5DdrWUudxJ30KlDmt88ky?=
 =?us-ascii?Q?3RiC3YvEB+DKPvzLGohgDspg6kQw1wMbm0vqPnCVriaus0FU9/MZdDw4Z9AZ?=
 =?us-ascii?Q?EQPXm+VzCQ/RHd1KVCuLPVWi0kTsgACZnh3ytVvitkqptwfPHwRXdy0JO5AN?=
 =?us-ascii?Q?wjDzSontOr190fJ0q5LlNAdDmpEsGl9xCY8tQAjghzffVHBPVOeeH5Bje2/3?=
 =?us-ascii?Q?kcjcgX2BJy/puoXzsHF1RfLJ20z8HJs+Pm5g02ouWJ0eCpZ5Y3Ap0Gcw6Rr/?=
 =?us-ascii?Q?4ckpma22i6QOljMbGP2FUNFvVEnkMc3kmTUTGbl9xiY/BpN+A+y0109tGD9Q?=
 =?us-ascii?Q?2g0N+9Tthj9vm6gMgyRI3iDUs7NpdG7lPLZhzx+UZ8XFxMRMGt7BytMKOCA4?=
 =?us-ascii?Q?nyQqzPon+nmgs4m4Zd69ectE7nCepgqbux6zpD5cgY91q6FcBv3Z0IAvRg9n?=
 =?us-ascii?Q?UqvtopcK0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3844c4fb-757a-4888-8c66-08df28878d8b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:37:57.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8iwuqXgALoXzWe2E/dwUqsYjFt6SHXNN7lUY4TIy/dX7wtCd+yqvsBfLyOf3R2RlHA3TNc8i7QU91Q0EgB2VaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378

Hi Rob, Krzysztof, Conor,

Together with this mail I am posting the driver series for the NVIDIA
LSTP USB adapter ("[PATCH 00/11] Add NVIDIA LSTP USB adapter drivers",
https://lore.kernel.org/r/20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com);
patches 1-4 are its bindings. Here I would like your view on the binding
shape, in particular on the child nodes, and on one vendor property of
the I2C channel, without making you dig through the series for the
reasons. The schema excerpts and an example are below; the full bindings
are in patches 1-4 and in the out-of-tree repository, under
devicetree/bindings/ at
https://github.com/NVIDIA/lstp_module/tree/public-next-v1

What the device is
------------------

LSTP is a vendor-specific USB interface that carries several "channels"
over one pair of bulk endpoints. The channel types are SPI host, I2C
host, GPIO (with interrupts and LED pins), UART and an IPMI message
channel. It is implemented by NVIDIA's SMA, an MCU (0955:cf11), and by
other vendors' parts: two hub/bridge chips have it built in (0424:4940,
174c:2214).

The device reports its channels itself: their number, each one's ID
(1-255) and its type. Firmware decides the set, so one VID:PID carries
different channel sets on different boards, and one interface can carry
several channels of the same type. Boards in production have up to eight
I2C channels and two IPMI channels on one interface.

The DT is therefore optional. It is only for an adapter hard-wired on a
board, and it adds only what the device cannot report: peripherals on
the SPI and I2C buses, GPIO line names, hogs, consumers by phandle, and
LEDs.

Proposed shape
--------------

The device and interface nodes follow usb-device.yaml:
- a device node with compatible "usbVID,PID";
- under it, an interface node with a two-cell reg = <interface config>;
- for a class 0 device with one configuration and one interface, a
  combined node instead.

Each channel is a child of the interface (or combined) node:
- named after its type: spi@N, i2c@N, gpio@N, serial@N, ipmi@N;
- with reg = <channel ID>;
- with a compatible naming the channel type.

A channel matches its node on reg plus compatible; node names are not
used. A channel without a node is still usable. A channel whose node has
status = "disabled" is not used at all.

The spi, i2c and gpio channel schemas are separate files in their
subsystem directories, each $ref'ing the generic controller schema. The
serial and ipmi channel schemas are defined inline in the USB binding,
which $refs the other three.

Example (from the binding, with nvidia,retries added to the I2C channel
and status added to the UART channel):

    usb {
        #address-cells = <1>;
        #size-cells = <0>;

        hub@1 {
            reg = <1>;
            #address-cells = <1>;
            #size-cells = <0>;

            /* Three interfaces; the LSTP channels are on interface 2. */
            device@3 {
                compatible = "usb955,cf11";
                reg = <3>;
                #address-cells = <2>;
                #size-cells = <0>;

                interface@2 {
                    compatible = "usbif955,cf11.config1.2";
                    reg = <2 1>;
                    #address-cells = <1>;
                    #size-cells = <0>;

                    spi@1 {
                        compatible = "nvidia,lstp-spi";
                        reg = <1>;
                        #address-cells = <1>;
                        #size-cells = <0>;

                        flash@0 {
                            compatible = "jedec,spi-nor";
                            reg = <0>;
                            spi-max-frequency = <18750000>;
                        };
                    };

                    i2c@2 {
                        compatible = "nvidia,lstp-i2c";
                        reg = <2>;
                        #address-cells = <1>;
                        #size-cells = <0>;
                        nvidia,retries = <5>;

                        temperature-sensor@48 {
                            compatible = "ti,tmp102";
                            reg = <0x48>;
                        };
                    };

                    gpio@3 {
                        compatible = "nvidia,lstp-gpio";
                        reg = <3>;
                        gpio-controller;
                        #gpio-cells = <2>;
                        gpio-line-names = "LED", "INT";
                    };

                    ipmi@4 {
                        compatible = "nvidia,lstp-ipmi";
                        reg = <4>;
                    };

                    serial@5 {
                        compatible = "nvidia,lstp-uart";
                        reg = <5>;
                        status = "disabled";
                    };
                };
            };
        };
    };

Schema excerpt (usb/nvidia,lstp.yaml):

    allOf:
      - $ref: /schemas/usb/usb-device.yaml#
      - $ref: "#/$defs/channels"
      - if:
          properties:
            "#address-cells":
              const: 1
        then:
          patternProperties:
            "^interface@": false
        else:
          patternProperties:
            "^(spi|i2c|gpio|serial|ipmi)@": false

    properties:
      compatible:
        enum:
          - usb955,cf11
          - usb424,4940
          - usb174c,2214

    patternProperties:
      "^interface@[0-9a-f]{1,2}(,[0-9a-f]{1,2})?$":
        type: object
        $ref: "#/$defs/channels"
        properties:
          compatible:
            pattern: "^usbif[0-9a-f]{1,4},[0-9a-f]{1,4}\\.config[0-9a-f]{1,2}\\.[0-9a-f]{1,2}$"
          reg:
            maxItems: 1
        ...

    $defs:
      channels:
        patternProperties:
          "^spi@[0-9a-f]+$":
            $ref: /schemas/spi/nvidia,lstp-spi.yaml#
          "^i2c@[0-9a-f]+$":
            $ref: /schemas/i2c/nvidia,lstp-i2c.yaml#
          "^gpio@[0-9a-f]+$":
            $ref: /schemas/gpio/nvidia,lstp-gpio.yaml#
          "^serial@[0-9a-f]+$":
            type: object
            properties:
              compatible:
                const: nvidia,lstp-uart
              reg:
                maxItems: 1
            required: [compatible, reg]
            additionalProperties: false
          "^ipmi@[0-9a-f]+$":
            type: object
            properties:
              compatible:
                const: nvidia,lstp-ipmi
              reg:
                maxItems: 1
            required: [compatible, reg]
            additionalProperties: false

The gpio schema (gpio/nvidia,lstp-gpio.yaml) defines:
- gpio-controller, #gpio-cells = <2> and gpio-line-names (up to 255);
- interrupt-controller with #interrupt-cells = <2>;
- hog children;
- a "leds" child holding led@N nodes on leds/common.yaml, for the pins
  the device reports as LEDs.

The i2c schema (i2c/nvidia,lstp-i2c.yaml) is the generic controller plus
one property:

    allOf:
      - $ref: /schemas/i2c/i2c-controller.yaml#

    properties:
      compatible:
        const: nvidia,lstp-i2c

      reg:
        description: Channel ID reported by the device firmware.
        maxItems: 1

      nvidia,retries:
        description: |
          Number of times the host re-issues a transfer that fails on
          arbitration loss or a busy bus before giving up.

          Ignored when the channel config reports non-zero bus arbitration
          retries.  Such a device is expected to retry both arbitration loss and
          a busy bus itself before reporting failure, so the host adds no
          attempts on top.
        $ref: /schemas/types.yaml#/definitions/uint32
        maximum: 255
        default: 3

    required:
      - compatible
      - reg

    unevaluatedProperties: false

The spi schema (spi/nvidia,lstp-spi.yaml) is the generic controller with
compatible and reg only.

Questions
---------

1. Per-channel child nodes with their own compatible.

   The channel type is discoverable, so the compatible does not choose a
   driver for an unknown device. Instead it checks that the node written
   for channel N describes the kind of channel the firmware put at N. The
   alternative is to imply the type from the node name, which
   writing-bindings.rst says not to treat as ABI. Is a compatible per
   channel type acceptable here, or would you rather have a different
   property, or no type at all?

2. gpio@N in particular.

   I know the CP2112 review moved its GPIO controller off a subnode and
   onto the USB device node (silabs,cp2112.yaml). That works because
   CP2112 has exactly one GPIO block. Here a GPIO channel is one of
   several channels behind one interface, at an ID the firmware assigns,
   and the protocol does not limit an interface to one GPIO channel.
   Putting gpio-controller on the interface node would need:
   - a three-cell specifier (channel, line, flags);
   - gpio-line-names, hogs, interrupts and the leds child keyed per
     channel.
   We think gpio@N, like i2c@N and spi@N, is the cleaner way to describe
   that. Do you agree, or do you prefer the interface node as the
   provider?

3. ipmi@N and serial@N have no resources of their own.

   They allow only compatible, reg and status. writing-bindings.rst says
   not to create nodes just to instantiate drivers, and these do not:
   each channel is used whether or not it has a node. Their purpose is
   status = "disabled", which keeps the channel from being used at all.
   A board uses it when a channel the firmware reports must not be
   exposed to the host OS on that board. Is that a sufficient reason for
   the nodes?

   If not, would you prefer a property on the interface node listing the
   channel IDs not to use, or dropping the two node types (and
   disabling) altogether?

4. Device and interface nodes.

   The device node lists the three VID:PIDs in one enum, since the
   channel layer is the same on all three. The interface node allows the
   optional "usbifVID,PID.configC.I" compatible from usb-device.yaml.
   - Is one binding for three USB devices from three vendors acceptable,
     given that the LSTP interface is what is described?
   - usb-device.yaml's interface pattern
     "^interface@[0-9a-f]{1,2}(,[0-9a-f]{1,2})$" makes the ",C" suffix
     mandatory. Its description, and ours, say the suffix is omitted for
     configuration 1, so our pattern has "(...)?". Which is intended?

5. File layout.

   The series has gpio/, i2c/ and spi/ schemas, each with its own patch,
   ahead of usb/nvidia,lstp.yaml, which $refs them and defines serial@N
   and ipmi@N inline. Would you rather have everything in usb/?

6. nvidia,retries on the I2C channel.

   The channel config tells the host whether the device itself retries
   a transfer that loses arbitration or finds the bus busy. When it
   does, the host adds no attempts. When it does not, the host re-issues
   such a transfer, three times by default. nvidia,retries sets that
   count per board, for example for a bus shared with another master.

   It is a property rather than something the OS sets later because the
   peripherals described under the channel are probed as soon as the bus
   is registered, before anything in userspace could change the count.
   The nearest precedents I found are device properties, not controller
   properties: sbs,i2c-retry-count (power/supply/sbs,sbs-battery.yaml)
   and adi,overcurrent-retries (hwmon/adi,ltc4283.yaml).

   Existing boards use the property without the vendor prefix, as
   "retries"; our out-of-tree driver keeps reading that name, and the
   upstream binding and driver would know only nvidia,retries. Is a
   vendor property for this acceptable, or would you rather keep it out
   of the binding and leave the count to the host default?

Thanks,
Adrian
