From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 1/1] at24: Fix =?iso-8859-1?Q?I?= =?iso-8859-1?Q?=B2C?=
 device selection for runtime PM
Date: Fri, 1 Dec 2017 17:35:38 +0200
Message-ID: <20171201153538.fgwc4h4lbgnhabs3@paasikivi.fi.intel.com>
References: <1512068603-12378-1-git-send-email-svendev@arcx.com>
 <20171130223524.31716-1-sakari.ailus@linux.intel.com>
 <CAGngYiUktfXOU64Uo-O=01OWJrT8fQ7icxS6m4mQO+6UAkGUsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGngYiUktfXOU64Uo-O=01OWJrT8fQ7icxS6m4mQO+6UAkGUsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: linux-i2c@vger.kernel.org, svendev@arcx.com, linux-kernel@vger.kernel.org, divagar.mohandass@intel.com, brgl@bgdev.pl
List-Id: linux-i2c@vger.kernel.org

Hi Sven,

On Fri, Dec 01, 2017 at 10:20:41AM -0500, Sven Van Asbroeck wrote:
> Thank you, it fixes the issue on the multi-address eeprom that I have access to.
> 
> Tested-by: Sven Van Asbroeck on a 24AA16/24LC16B <svendev@arcx.com>
> 
> One very minor remark:
> 
> +       struct device *dev = &at24->client[0]->dev;
> 
> It is sufficiently clear to others (and us a few months down the line)
> why we are
> using only client[0] for power management? Could it benefit from a separate
> function with comments?
> 
> struct device *dev = get_pm_device(at24);
> 
> static struct device *get_pm_device(struct at24_data *at24)
> {
>     /* explain why we use client[0] and not any of the dummies */
>     return &at24->client[0]->dev;
> }

There are no comments in assigning at24->client[0] either (or a helper
function). I think it should be rather evident when looking at the code
when you think about it. I certainly don't object adding a comment if you
insist or someone else thinks it's a good idea.

Thanks for testing!

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
