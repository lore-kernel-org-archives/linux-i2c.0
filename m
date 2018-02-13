From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Fix failure on baytrail
Date: Tue, 13 Feb 2018 16:36:41 +0200
Message-ID: <f327b50c-04a9-41b6-dbbc-0ea4f2376e3a@linux.intel.com>
References: <1518450764-6652-1-git-send-email-gardner.ben@gmail.com>
 <CAE7DoPZmS8S8TD7+jM-ipcMMKx+6eZ=N7qwHS73NshXf0YY5kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:11306 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933697AbeBMOgV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 13 Feb 2018 09:36:21 -0500
In-Reply-To: <CAE7DoPZmS8S8TD7+jM-ipcMMKx+6eZ=N7qwHS73NshXf0YY5kw@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On 02/12/2018 05:56 PM, Ben Gardner wrote:
> I didn't make it clear in the subject line, but this patch is intended
> for the 4.9 kernel.
> The earlier patch (Feb 9, 2018) was for 4.14, 4.15 and future.
> 
I think we need to handle this patch once earlier patch is applied by 
following the Option 3 rule in 
Documentation/process/stable-kernel-rules.rst.

-- 
Jarkko
