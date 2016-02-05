From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: Re: [PATCH V2] i2c: i801: Adding Intel Lewisburg support for iTCO
Date: Fri, 5 Feb 2016 13:56:02 -0800
Message-ID: <56B51A72.5020305@linux.intel.com>
References: <1454627215-2418-1-git-send-email-alexandra.yates@linux.intel.com>
 <20160204232746.GA2421@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27419 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbcBEVwV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 5 Feb 2016 16:52:21 -0500
In-Reply-To: <20160204232746.GA2421@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Wolfram,

On 02/04/2016 03:27 PM, Wolfram Sang wrote:
> On Thu, Feb 04, 2016 at 03:06:55PM -0800, Alexandra Yates wrote:
>> Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog
>> resources have been moved to reside under the i801 SMBus host
>> controller whereas previously they were under the LPC device.
>>
>> This patch adds Intel lewisburg SMBus support for iTCO device.
>>
>> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
>
> Please state what has changed in v2 of this patch?
>

The subject line changed I added i2c:i801 per your past request to match 
the subject format for the list.


-- 
Thank you,
<Alexandra>
