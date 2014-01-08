From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v5 2/4] ARM: mvebu: Add quirk for i2c for the OpenBlocks
 AX3-4 board
Date: Wed, 08 Jan 2014 16:28:34 +0100
Message-ID: <52CD6EA2.1020107@free-electrons.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com> <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com> <20140108152224.GC15182@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20140108152224.GC15182@katana>
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 08/01/2014 16:22, Wolfram Sang wrote:
>> +		new_compat->name =  kstrdup("compatible", GFP_KERNEL);
>> +		new_compat->length =  sizeof("marvell,mv78230-a0-i2c");
>> +		new_compat->value =  kstrdup("marvell,mv78230-a0-i2c",
>> +						GFP_KERNEL);
>> +
> 
> Very minor again: Strange whitespacing after "="
> 
arg I missed it :(

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
