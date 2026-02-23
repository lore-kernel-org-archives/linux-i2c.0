Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6CE26FA77
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867857; cv=none; b=CoW3psRpWIxfZcw282u9OLgoDBp3TYpPbguOm2Tl5uok+MInK0cDNq/ywEEbVhtNVupfusiX2n2FhKAxBoxkCKLktUmZKNJ/xoSxo/iLPABKn3/pd/O7YBqJDg+Y5QY73tKaqB0R5lqWKyPdfXzQE2/qtWPqDflGbItKj+A2jeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867857; c=relaxed/simple;
	bh=Qzxxfb7kEku2747lmzT1fwRiAYJSGvUIx6A0aGIdbAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6vQtHFF+flEYI+ymIDEwhac5MYGWfluhxCEenpiim2U3ecwmN1nsArcp5GtKpWVA65yYYd9Iud5a3WPWx+kcwS4ScXTD09KEv1GXgK6yUB2rj/YY9X9u+NTwI8T6BBUmBAMbOHLgnzwvjFO/Axtt8IlR30ZG9vFZ+mzxoQe/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YYjvRE4H; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YYjvRE4H"
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8c711959442so402359585a.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867855; x=1772472655;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y8V8psmXfo8hyIGZcjW58KCT42psor/P8r1YSImT3V8=;
        b=lK2K8xoxEUOFMLcvFPh1cNZkhyqC/NxJ4p34S/xewK/HL1sloaVyohVak5SBfK2Yx6
         qgG/jNo5Mgi3AHVPRU5YdF4Jf+mGJPuGlhmoVmCmsWUh14RZvKSfiMjYuhrS1kdp2Zlj
         j1spGyxV9y3DnPVkATn+15jKsiCth7Or8Udlvd1GltF+tvqCVwx08N421iLZ/roP1bSF
         I920Pf2wJUS8kvl7VkgpFVx43QQYR/zJnFppjgmbIQXCL8TvLz9iYT5nl9An81F+DnsD
         y9GWgxYm+h0or9HblUwHepXPxDjrHAcJuW++fbw1KhCleIaWmdF+Aj/3kKf7CRmKRWPV
         FHYA==
X-Forwarded-Encrypted: i=1; AJvYcCVFUPs8NBnhfl2xw1i8MDRigJ1s0ZWBbbq55K5wFCQEaQlXpaYoIcrag/Vc2dIxPnWjlMIsoS7togU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkuoMkD44ENzFfXaNZaamIKyuvWg65UlLq/R4DyqKZ0+V2FPH
	DZf565P2j0XnMX8GDXCE+vjacmVLFfSrDIUaU888LeFDIkTF0AzGOGFg+qCHVK9uDpFGiNf5sA5
	WgZTbxz0mMudL2jZDs5iB2k+hGTGQew11UfZzFreQSgeFY/bsYPtqAHsKFdbavQCGmZYC4nl5XZ
	6+DYASY22JQrcQCgKXIzp1r03V+5Zbm0UymnLrI9uIZzNL04YpPeJvl5w8yGtPLYsq6+41N6u2L
	bE2m/vc0+Ot0y0aUAo+
X-Gm-Gg: AZuq6aItqDsb8toMHW95pHG9qwIeHYwyqd72WbUCFpJDNeRDLxvTHjgH7yBMG31utP1
	cO/Ix22Z6ZiSTxsVubIPZBONYrkWtWsGGjxXB0QMfBbL97KvcoUs3xUP1WaNrUjyQvrwMoUgWTY
	im99CkBbZi5P9UY+YXyelTY5ThWyprcxTAHS8YgiRAvMGB68YT8MenHtpF+xDcNfb3Ez28SiEhC
	yuTps+iPB+TBO4D5E8Zl+Y7pJMrBqNP+SEEbg3IydEm7pA4/c5xtpoFSKqBJmVQ7rZLidLUpZts
	o4yHU/uhc2fN+NMUSDQcwWPI9GtORjtkRr5aiTs90CLB0xHH9KsbAyOg+sgavWB1bXIPldPs2b2
	4DCHtgcjJI5BwiJzF3VVPEo20lw2OA1aATuHVoatiwbrsFBn+zbNmlrfUyDUFBVvT+gg1TQn0t1
	EFBTHlJId65ff1dtDrglKU7vJ+jmKWMQ2QKuvKU4J6d61wXL9UOX5U+0KVuZvRiXIi
X-Received: by 2002:ac8:7d8c:0:b0:506:6d1b:6e88 with SMTP id d75a77b69052e-5070c2f0895mr124425491cf.27.1771867855128;
        Mon, 23 Feb 2026 09:30:55 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5070d505151sm10649621cf.2.2026.02.23.09.30.54
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 09:30:55 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1270c88d3a8so3984945c88.1
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771867854; x=1772472654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y8V8psmXfo8hyIGZcjW58KCT42psor/P8r1YSImT3V8=;
        b=YYjvRE4HruAu5OzT7QZgqGW7g70xXAhKcDsBNonHu2yW0hARBd8aBGgcAEuairOtRX
         NRSCf9n0jFz6aPCuDkXlrWTLY8R6a7zt5D/OueQbP5AFFsbUTm/Gxl6l1ZMFhr42tiVE
         8kXPbEOKedaAjG4vVc3XX+RafSvKOijAw4ssM=
X-Forwarded-Encrypted: i=1; AJvYcCU+/LCkBgAfkhiSEFtUhHn1ia6PKwd8ImrwADoIaWVqqFM0gKFgo+aajW4ebGDgrYwYzeh0ahSDvCk=@vger.kernel.org
X-Received: by 2002:a05:7022:6b98:b0:122:154:7826 with SMTP id a92af1059eb24-1276ab5845dmr3541882c88.3.1771867853478;
        Mon, 23 Feb 2026 09:30:53 -0800 (PST)
X-Received: by 2002:a05:7022:6b98:b0:122:154:7826 with SMTP id a92af1059eb24-1276ab5845dmr3541858c88.3.1771867852486;
        Mon, 23 Feb 2026 09:30:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167d3sm5627944eec.24.2026.02.23.09.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 09:30:51 -0800 (PST)
Message-ID: <73a783ed-ac77-4d4e-b1f8-6114c33ac33e@broadcom.com>
Date: Mon, 23 Feb 2026 09:30:48 -0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] i2c: bcm-kona: set device parent and of_node
 through the adapter struct
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vignesh R <vigneshr@ti.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Frank Li <Frank.Li@nxp.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
 <20260223-i2c-adap-dev-config-v2-3-d78db0a6fcf7@oss.qualcomm.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260223-i2c-adap-dev-config-v2-3-d78db0a6fcf7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 2/23/26 01:05, Bartosz Golaszewski wrote:
> Configure the parent device and the OF-node using dedicated fields in
> struct i2c_adapter and avoid dereferencing the internal struct device.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
