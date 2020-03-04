From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH v2 2/2] i2c: smbus: remove outdated references to irq
 level triggers
Date: Wed, 4 Mar 2020 17:48:31 +0100
Message-ID: <66ee4375-91a8-9286-629a-cd1fdef2b71e@lucaceresoli.net>
References: <20200228171221.5412-1-wsa+renesas@sang-engineering.com>
 <20200228171221.5412-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:55272 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388084AbgCDQse (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Mar 2020 11:48:34 -0500
In-Reply-To: <20200228171221.5412-3-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Phil Reid <preid@electromag.com.au>, Robert Richter <rrichter@marvell.com>

Hi,

On 28/02/20 18:12, Wolfram Sang wrote:
> IRQ levels are now handled within the IRQ core. Remove the forgotten
> references from the documentation.
> 
> Fixes: 9b9f2b8bc2ac ("i2c: i2c-smbus: Use threaded irq for smbalert")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

-- 
Luca
