From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c: designware: report short transfers
Date: Wed, 23 Nov 2016 16:13:31 +0200
Message-ID: <a42061c7-22fd-d897-ffb3-946812c0761f@linux.intel.com>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
 <E1c7p12-0000R0-S8@rmk-PC.armlinux.org.uk>
 <20161121103200.GG1446@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:62373 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938699AbcKWONg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 23 Nov 2016 09:13:36 -0500
In-Reply-To: <20161121103200.GG1446@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 21.11.2016 12:32, Mika Westerberg wrote:
> On Fri, Nov 18, 2016 at 07:40:04PM +0000, Russell King wrote:
>> Rather than reporting success for a short transfer due to interrupt
>> latency, report an error both to the caller, as well as to the kernel
>> log.
>>
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
