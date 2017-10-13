From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] i2c: mux: reg: use of_property_read_bool()
Date: Fri, 13 Oct 2017 15:13:03 +0300
Message-ID: <e418f5f1-ad50-ab1e-5af4-55217c105448@cogentembedded.com>
References: <20170820190656.846142358@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:56794 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757859AbdJMMNH (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 13 Oct 2017 08:13:07 -0400
Received: by mail-lf0-f46.google.com with SMTP id 90so9375372lfs.13
        for <linux-i2c@vger.kernel.org>; Fri, 13 Oct 2017 05:13:06 -0700 (PDT)
In-Reply-To: <20170820190656.846142358@cogentembedded.com>
Content-Language: en-MW
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

Hello!

On 08/20/2017 10:06 PM, Sergei Shtylyov wrote:

> Use more compact of_property_read_bool() calls for the boolean properties
> instead  of of_find_property() calls  in i2c_mux_reg_probe_dt().
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]

    This patch seems to be lost. Ping?

MBR, Sergei
