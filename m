From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: Remove adapter name from debug print
 in i2c_dw_isr()
Date: Fri, 07 Aug 2015 14:17:38 +0300
Message-ID: <55C493D2.6070109@linux.intel.com>
References: <1438944208-16276-1-git-send-email-jarkko.nikula@linux.intel.com> <1438944208-16276-2-git-send-email-jarkko.nikula@linux.intel.com> <20150807111029.GB12206@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150807111029.GB12206@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 07.08.2015 14:10, Wolfram Sang wrote:
> On Fri, Aug 07, 2015 at 01:43:28PM +0300, Jarkko Nikula wrote:
>> Printing adapter name is irrelevant from this debug print and makes output
>> needlessly long. Having already device and functions names printed here is
>> enough for debugging.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>
> So much about the double space :) I think I'll squash those two.
>
Fine to me. Actually long "Synopsys DesignWare I2C adapter" printed 
bothered me most.

-- 
Jarkko
