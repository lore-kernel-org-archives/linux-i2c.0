From: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c designware make SCL and SDA falling time configurable
Date: Sun, 13 Oct 2013 20:36:54 +0900
Message-ID: <525A85D6.3090608@pobox.com>
References: <20130828153429.GB7066@ab42.lan> <1381244455-3836-1-git-send-email-romainba@abilis.com> <20131009075538.GQ3521@intel.com> <5255FAB5.7080803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5255FAB5.7080803-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10/10/13 9:54 AM, Ryan Mallon wrote:
> On 09/10/13 18:55, Mika Westerberg wrote:
>> On Tue, Oct 08, 2013 at 05:00:54PM +0200, Romain Baeriswyl wrote:
>>> @@ -307,15 +309,25 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>>>
>>>   	/* set standard and fast speed deviders for high/low periods */
>>>
>>> +	if (dev->sda_falling_time)
>>> +		sda_falling_time = dev->sda_falling_time;
>>> +	else
>>> +		sda_falling_time = 300; /* ns */
>>
>> I think this looks better:
>>
>> 	sda_falling_time = dev->sda_falling_time ? dev->sda_falling_time : 300;
>
> You can also use the gcc-ism, which is a bit more concise:
>
> 	sda_falling_time = dev->sda_falling_time ?: 300;

+1
