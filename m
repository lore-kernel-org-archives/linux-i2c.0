From: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c designware add support of I2C standard mode
Date: Sun, 13 Oct 2013 20:46:52 +0900
Message-ID: <525A882C.3030905@pobox.com>
References: <20130828153429.GB7066@ab42.lan> <1381244455-3836-2-git-send-email-romainba@abilis.com> <20131009075632.GR3521@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131009075632.GR3521-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10/9/13 4:56 PM, Mika Westerberg wrote:> On Tue, Oct 08, 2013 at 05:00:55PM +0200, Romain Baeriswyl wrote:
>> Some legacy devices support ony I2C standard mode at 100kHz.
>> This patch allows to select the standard mode through the DTS
>> with the use of the existing clock-frequency parameter.
>>
>> When clock-frequency parameter is not set, the fast mode is selected.
>> Only when the parameter is set at 100000, the standard mode is selected.
>>
>> Signed-off-by: Romain Baeriswyl <romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
>> Reviewed-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
>
> Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

I don't have build environment for these patches right now, but both
changes 1/2 and 2/2 look good.

It's quite reasonable and makes the code readable to convert
{3 => 300} into nsec based one.  I should have done so from the
beginning, thanks for doing this.

   Shinya
