From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] Documentation: i2c: Fix example in instantiating-devices
Date: Sat, 17 Aug 2013 21:52:45 +0530
Message-ID: <CAK9yfHwm3+Z=DnBbWqy1N=cYgXhi4FeD2yuBvKtsGnV2SpLQHg@mail.gmail.com>
References: <1375939511-7590-1-git-send-email-sachin.kamat@linaro.org>
	<20130815130333.GH17155@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130815130333.GH17155@katana>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, Rob Landley <rob@landley.net>
List-Id: linux-i2c@vger.kernel.org

On 15 August 2013 18:33, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Aug 08, 2013 at 10:55:11AM +0530, Sachin Kamat wrote:
>> __initdata should be placed between the variable name and equal
>> sign for the variable to be placed in the intended section.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> Did this become a rule? Where? When?

The correct usage has been documented in the header file init.h where
the macros have been defined.
I quote it below for reference:

For initialized data:
* You should insert __initdata between the variable name and equal
* sign followed by value, e.g.:
*
* static int init_variable __initdata = 0;
* static const char linux_logo[] __initconst = { 0x32, 0x36, ... };



-- 
With warm regards,
Sachin
