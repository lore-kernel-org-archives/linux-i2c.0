From: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Subject: Re: [PATCH v5] i2c-gpio: add devicetree support
Date: Wed, 16 Feb 2011 14:13:06 +0800
Message-ID: <4D5B6AF2.8060104@wytron.com.tw>
References: <1297304967-3759-1-git-send-email-thomas@wytron.com.tw>
	<1297650610-12400-1-git-send-email-thomas@wytron.com.tw>
	<20110216054956.GD11684@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110216054956.GD11684-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Grant,

On 02/16/2011 01:49 PM, Grant Likely wrote:
> On Mon, Feb 14, 2011 at 10:30:10AM +0800, Thomas Chou wrote:
>> From: Albert Herranz<albert_herranz-mRCrAkd8dF0@public.gmane.org>
>>
>> This patch adds devicetree support to i2c-gpio driver. The allocation
>> of local data is integrated to a private structure, and use devm_*
>> helper for easy cleanup.
>>
>> It is base on an earlier patch for gc-linux from
>> Albert Herranz<albert_herranz-mRCrAkd8dF0@public.gmane.org>.
>>
>> Signed-off-by: Thomas Chou<thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
>> CC: Albert Herranz<albert_herranz-mRCrAkd8dF0@public.gmane.org>
>> Acked-by: Haavard Skinnemoen<hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> One minor nitpick below, but I'd be fine with cleaning that up via a
> followup patch.  This one looks correct to me.
>
> Acked-by: Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>
> Ben, this one depends on a patch in my devicetree/next tree.  How do
> you want to handle it?
>
> g.
>

Thanks a lot.

>> +#ifdef CONFIG_OF
>> +#include<linux/of_gpio.h>
>
> Instead of putting the include here, please add #ifdef CONFIG_OF
> protection around the contents of linux/of_gpio.h itself.  I fully
> support that change so that includes can remain at the top where they
> belong.

Then, my earlier patch on Jan 31, might be another solution. This way 
of_gpio.h can be included at the top, and those of_gpio users will be 
optimized out when of or of_gpio is not configured.

[PATCH 2/3] of: of_gpiochip_add is needed only for gpiolib

Cheers,
Thomas
