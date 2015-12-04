From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH RESEND] i2c: Remove setting for 1 second timeout from
 adapter drivers
Date: Fri, 4 Dec 2015 10:01:01 +0200
Message-ID: <5661483D.2040503@linux.intel.com>
References: <1449054154-32273-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20151203205228.GC8509@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:38202 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659AbbLDIBU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 4 Dec 2015 03:01:20 -0500
In-Reply-To: <20151203205228.GC8509@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On 12/03/2015 10:52 PM, Wolfram Sang wrote:
> On Wed, Dec 02, 2015 at 01:02:34PM +0200, Jarkko Nikula wrote:
>> I2C adapter drivers that are using 1 second timeout can leave the timeout
>> unset and let the i2c-core.c: i2c_register_adapter() to set it instead.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>
> My take on this is that I prefer the explicit (and thus visible)
> assignment. What the core does was intended as a fallback to prevent
> strange things happening with a 0 value.
>
Fair enough. It's hard to say if some of these really needs to be 1 
second instead of being stetson guessed or copy-pasted. Now if we ever 
change the fall back value from HZ to HZ/10 or similar we might get a 
regression.

-- 
Jarkko
