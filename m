From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v3 0/3] i2c: mux: move include files out of
 include/linux/i2c
Date: Tue, 15 Aug 2017 08:55:27 +0200
Message-ID: <2178e0d9-6a9b-02fc-f09a-c0ec6533a548@axentia.se>
References: <20170814082326.9835-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0130.outbound.protection.outlook.com ([104.47.1.130]:49333
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753138AbdHOGze (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 15 Aug 2017 02:55:34 -0400
In-Reply-To: <20170814082326.9835-1-wsa@the-dreams.de>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On 2017-08-14 10:23, Wolfram Sang wrote:
> include/linux/i2c is to be deprecated, so move these header files only
> including platform_data to the better suited platform_data directory.
> 
> v3 makes sure includes keep sorted correctly. For PCA9541, a patch which does
> the initial sorting has been added.

Excellent, applied to my i2c-mux/for-next branch.

Cheers,
Peter
