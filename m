From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: i2c-mux-pca954x: retry updating the mux selection on
 failure
Date: Fri, 16 Sep 2016 09:01:17 +0200
Message-ID: <1821185f-d97b-5394-a90e-d6b67545e06f@axentia.se>
References: <1473859452-8069-1-git-send-email-peda@axentia.se>
 <20160915195235.GD7863@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0118.outbound.protection.outlook.com ([104.47.2.118]:51232
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751549AbcIPJem (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 16 Sep 2016 05:34:42 -0400
In-Reply-To: <20160915195235.GD7863@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

[Resend, with lists added back...]

On 2016-09-15 21:52, Wolfram Sang wrote:
> On Wed, Sep 14, 2016 at 03:24:12PM +0200, Peter Rosin wrote:
>> The cached value of the last selected channel prevents retries on the
>> next call, even on failure to update the selected channel. Fix that.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Looks good. Is this 4.8 material or rather 4.9?

I have no real-world event or report backing the change, but it is
simple enough and fixes problems that are potentially very hard to
detect/reproduce. Certainly fodder for 4.8 and probably stable as
well (if you care). But no biggie, so personally I don't mind if
you wait until 4.9, but then again I don't depend on the driver...

Cheers,
Peter
