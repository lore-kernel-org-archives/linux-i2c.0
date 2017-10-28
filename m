From: Ed Blake <ed.blake@sondrel.com>
Subject: Re: [PATCH] i2c: img-scb: Add runtime PM
Date: Sat, 28 Oct 2017 12:42:42 +0100
Message-ID: <61f0e41e-3c99-50f7-edc5-746f6445e999@sondrel.com>
References: <1506937741-32748-1-git-send-email-ed.blake@sondrel.com>
 <20171027200429.cq565fpkedc7luls@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0047.outbound.protection.outlook.com ([104.47.1.47]:3872
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750930AbdJ1Lmu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 28 Oct 2017 07:42:50 -0400
In-Reply-To: <20171027200429.cq565fpkedc7luls@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On 27/10/17 21:04, Wolfram Sang wrote:
> On Mon, Oct 02, 2017 at 10:49:01AM +0100, Ed Blake wrote:
>> The i2c-img-scb driver already dynamically enables / disables clocks to
>> save power, but doesn't use the runtime PM framework. Convert the
>> driver to use runtime PM, so that dynamic clock management will be
>> disabled when runtime PM is disabled, and so that autosuspend can be
>> used to avoid unnecessarily disabling and re-enabling clocks repeatedly
>> during a sequence of transactions.
>>
>> Signed-off-by: Ed Blake <ed.blake@sondrel.com>
> I get on build-testing:
>
> drivers/i2c/busses/i2c-img-scb.c:1164:10: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>
> ?

Sorry, I didn't have that warning enabled.  I'll fix in v2.

Ed.
