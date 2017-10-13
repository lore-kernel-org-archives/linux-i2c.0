From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: mux: reg: use of_property_read_bool()
Date: Fri, 13 Oct 2017 23:53:28 +0200
Message-ID: <0296e18d-91c2-ee56-9b78-4b3d18660f83@axentia.se>
References: <20170820190656.846142358@cogentembedded.com>
 <e418f5f1-ad50-ab1e-5af4-55217c105448@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0115.outbound.protection.outlook.com ([104.47.1.115]:44161
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752969AbdJMVxf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 13 Oct 2017 17:53:35 -0400
In-Reply-To: <e418f5f1-ad50-ab1e-5af4-55217c105448@cogentembedded.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On 2017-10-13 14:13, Sergei Shtylyov wrote:
> Hello!
> 
> On 08/20/2017 10:06 PM, Sergei Shtylyov wrote:
> 
>> Use more compact of_property_read_bool() calls for the boolean properties
>> instead  of of_find_property() calls  in i2c_mux_reg_probe_dt().
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> [...]
> 
>     This patch seems to be lost. Ping?

The patch arrived too late to hit the previous merge window (I had already
done the pull request). I had admittedly forgotten about this patch, but the
mail sits there with a "TODO" tag, so I think I would have found it when
digging through stuff for this merge window.

Anyway, thanks for the reminder, and sorry for the delay.

Cheers,
Peter
