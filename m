From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i801: Use managed devm_* memory and irq allocation
Date: Fri, 06 Feb 2015 17:02:58 +0200
Message-ID: <54D4D7A2.4030407@linux.intel.com>
References: <1423231013-29514-1-git-send-email-jarkko.nikula@linux.intel.com>	<1423231013-29514-2-git-send-email-jarkko.nikula@linux.intel.com> <20150206155138.348efaa3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150206155138.348efaa3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 02/06/2015 04:51 PM, Jean Delvare wrote:
> Hi Jarkko,
>
> On Fri,  6 Feb 2015 15:56:53 +0200, Jarkko Nikula wrote:
>> This simplifies the error and remove paths.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
> Looks good, but what about also converting pci_request_region to
> devm_request_region?
>
Yep, in progress but won't finish today so wanted to send these two 
first :-)

-- 
Jarkko
