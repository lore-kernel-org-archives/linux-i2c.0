From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [Patch v2] driver/clk/clk-si5338: Add common clock framework
 driver for si5338
Date: Tue, 16 Jun 2015 08:38:14 -0700
Message-ID: <558042E6.2090100@freescale.com>
References: <1434388051-23814-1-git-send-email-yorksun@freescale.com> <1434442897.2069.66.camel@x220> <55803E29.2040800@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55803E29.2040800-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Andrey Filippov <andrey-MoRZu3FOBbXQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 06/16/2015 08:18 AM, York Sun wrote:
> Paul,
> 
> Thanks for reviewing.
> 
> On 06/16/2015 01:21 AM, Paul Bolle wrote:
>> One question and a few nits follow.
>>
>> On Mon, 2015-06-15 at 10:07 -0700, York Sun wrote:
>>> SI5338 is a programmable clock generator. It has 4 sets of inputs,
>>> PLL, multisynth and dividers to make 4 outputs. This driver splits
>>> them into multiple clocks to comply with common clock framework.
>>>
>>> See Documentation/devicetree/bindings/clock/silabs,si5338.txt for
>>> details.
>>>
>>> Signed-off-by: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>> CC: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> Apparently that's now mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org .
> 
> Thanks. Will change.
> 
>>
>>> CC: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> CC: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
>>> CC: Andrey Filippov <andrey-MoRZu3FOBbXQT0dZR+AlfA@public.gmane.org>
>>
>>> --- a/drivers/clk/Kconfig
>>> +++ b/drivers/clk/Kconfig
>>
>>>  config COMMON_CLK
>>> -	bool
>>> +	tristate "Common Clock"
>>>  	select HAVE_CLK_PREPARE
>>>  	select CLKDEV_LOOKUP
>>>  	select SRCU
>>
>> Why? The commit explanation doesn't mention this. Did you use an unclean
>> tree? If not, you just created over a dozen of new modules:
> 
> Thanks for catching this. I was testing building the driver within and outside
> of kernel tree for another kernel version. If this driver is built-in, I don't
> need to make it tristate. Will revert in next version.
> 

Now I remember why I did this. COMMON_CLK wasn't an option users can select,
because it is a bool and only selected by some platforms. I think it should be a
tristate so one can build a driver with it. When it is selected, some drivers
are built, either into kernel or as modules, up to user's choice. They are
needed by common clock framework.

I should add explanation in commit message. Or separate it into an individual
patch. Which one is preferred?

York
