From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: mux: reg: use of_property_read_bool()
Date: Fri, 20 Oct 2017 17:40:33 +0200
Message-ID: <264492cb-a294-378e-a609-7d48ce2ad2fb@axentia.se>
References: <20170820190656.846142358@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr50118.outbound.protection.outlook.com ([40.107.5.118]:3310
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751018AbdJTPkj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 20 Oct 2017 11:40:39 -0400
In-Reply-To: <20170820190656.846142358@cogentembedded.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On 2017-08-20 21:06, Sergei Shtylyov wrote:
> Use more compact of_property_read_bool() calls for the boolean properties
> instead  of of_find_property() calls  in i2c_mux_reg_probe_dt().
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against Wolfram Sang's 'linux.git' repo's 'i2c/for-next' branch.

Patch applied. For the next time, please use "git format-patch" to generate
your patches (or rather, read and follow the latest incarnation of [1]).
I fixed it up along with a couple of white-space issues this time, since
I was bored and had so little for this merge window. But you generally
can't expect maintainers to do this for you.

Cheers,
Peter

[1] https://www.kernel.org/doc/html/v4.13/process/submitting-patches.html
