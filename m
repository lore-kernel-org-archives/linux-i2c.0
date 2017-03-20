From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c-designware: increase timeout of semaphore transfer
Date: Mon, 20 Mar 2017 15:52:12 +0200
Message-ID: <4ddb7df4-774a-904a-eabd-3c02f419b9fe@linux.intel.com>
References: <20170320133730.23041-1-oneukum@suse.com>
 <704db0f5-7951-3d07-1d0b-4c742dd562d0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:24984 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754068AbdCTNwQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 20 Mar 2017 09:52:16 -0400
In-Reply-To: <704db0f5-7951-3d07-1d0b-4c742dd562d0@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Oliver Neukum <oneukum@suse.com>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org

On 03/20/17 15:39, Hans de Goede wrote:
> Hi,
>
> On 20-03-17 14:37, Oliver Neukum wrote:
>> Our testing shows the semaphore failing to be transferred on CherryTrail
>> in about 0.5% of all cases. The existing timeout needs to be lengthened
>> to accomodate the worst cases.
>>
>> V2: Rebased on
>> https://cgit.freedesktop.org/drm-intel/commit/?h=topic/designware-baytrail
>>
>>
>> Signed-off-by: Oliver Neukum <oneukum@suse.com>
>
> Looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
