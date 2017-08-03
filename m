From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/2] i2c: mux: pinctrl: drop the idle_state member
Date: Thu, 3 Aug 2017 07:19:17 +0200
Message-ID: <0f8c5821-e6d3-5574-80e7-b7b2e2bb9f18@axentia.se>
References: <20170802072728.24586-1-peda@axentia.se>
 <20170802072728.24586-3-peda@axentia.se>
 <15488723-e0ef-62b3-e62f-e74d12d8328d@wwwdotorg.org>
 <cb3ecc9b-b26f-bb81-5836-ecd459ec3456@axentia.se>
 <ee71d80d-840c-a784-7fc7-a72b7cc2f453@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr00092.outbound.protection.outlook.com ([40.107.0.92]:13143
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750850AbdHCFTY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 3 Aug 2017 01:19:24 -0400
In-Reply-To: <ee71d80d-840c-a784-7fc7-a72b7cc2f453@wwwdotorg.org>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Stephen Warren <swarren@nvidia.com>, linux-i2c@vger.kernel.org

On 2017-08-03 00:50, Stephen Warren wrote:
> On 08/02/2017 03:25 PM, Peter Rosin wrote:
>> (and muxc->max_adapters == num_names)
> 
> Well, unless muxc->deselect is true...

No, deselect does not affect neither max_adapters nor num_names. They
are always equal.

Cheers,
Peter
