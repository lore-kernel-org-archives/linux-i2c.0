From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH v3 3/3] i2c/busses/i2c-icy: Add LTC2990 present on 2019
 board revision
Date: Mon, 19 Aug 2019 13:22:54 +0200
Message-ID: <c7997f14-dd3e-11c6-4ab8-8e7fbf4e926a@enpas.org>
References: <20190815125802.16500-1-max@enpas.org>
 <20190815125802.16500-3-max@enpas.org> <20190816115112.GA3507@kunai>
 <513d49dd-70fc-a226-fdfd-598aadcfec05@enpas.org>
 <20190816160916.GA5858@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816160916.GA5858@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

On 08/16/2019 06:09 PM, Wolfram Sang wrote:
> 
>>> Braces for both blocks. Did you run checkpatch?
>>
>> I did, and it didn't say anything.
> 
> Hmm, strange, does is complain when you use '--strict'?

Yes, --strict catches it. Thanks, I didn't know about that parameter.

I'll send a v5 with all requested fixes.


Max
