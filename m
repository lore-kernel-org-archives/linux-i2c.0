From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_1=2F1=5D_at24=3A_Fix_I=C2=B2C_device_selection_for_?=
        =?UTF-8?Q?runtime_PM?=
Date: Fri, 1 Dec 2017 17:29:27 +0100
Message-ID: <CAMRc=Me6b7aRWFg-DPtNq5TKNwwr_oRO8ip7Nn9LosivOZKjGA@mail.gmail.com>
References: <1512068603-12378-1-git-send-email-svendev@arcx.com>
 <20171130223524.31716-1-sakari.ailus@linux.intel.com> <CAGngYiUktfXOU64Uo-O=01OWJrT8fQ7icxS6m4mQO+6UAkGUsA@mail.gmail.com>
 <20171201153538.fgwc4h4lbgnhabs3@paasikivi.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171201153538.fgwc4h4lbgnhabs3@paasikivi.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, Sven Van Asbroeck <svendev@arcx.com>, linux-kernel@vger.kernel.org, divagar.mohandass@intel.com
List-Id: linux-i2c@vger.kernel.org

2017-12-01 16:35 GMT+01:00 Sakari Ailus <sakari.ailus@linux.intel.com>:
> Hi Sven,
>
> On Fri, Dec 01, 2017 at 10:20:41AM -0500, Sven Van Asbroeck wrote:
>> Thank you, it fixes the issue on the multi-address eeprom that I have access to.
>>
>> Tested-by: Sven Van Asbroeck on a 24AA16/24LC16B <svendev@arcx.com>
>>
>> One very minor remark:
>>
>> +       struct device *dev = &at24->client[0]->dev;
>>
>> It is sufficiently clear to others (and us a few months down the line)
>> why we are
>> using only client[0] for power management? Could it benefit from a separate
>> function with comments?
>>
>> struct device *dev = get_pm_device(at24);
>>
>> static struct device *get_pm_device(struct at24_data *at24)
>> {
>>     /* explain why we use client[0] and not any of the dummies */
>>     return &at24->client[0]->dev;
>> }
>
> There are no comments in assigning at24->client[0] either (or a helper
> function). I think it should be rather evident when looking at the code
> when you think about it. I certainly don't object adding a comment if you
> insist or someone else thinks it's a good idea.
>
> Thanks for testing!
>
> --
> Kind regards,
>
> Sakari Ailus
> sakari.ailus@linux.intel.com

Pushed to at24/fixes, thanks!

@Saraki: there were some conflicts with the previous fixes queued for
4.15. Could you take a look if my rebase didn't break anything? You
can find my tree at
git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git

Best regards,
Bartosz
