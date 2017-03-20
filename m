From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 03/15] extcon: cht-wc: Add Intel Cherry Trail Whiskey
 Cove PMIC extcon driver
Date: Mon, 20 Mar 2017 15:00:41 +0200
Message-ID: <1490014841.19767.106.camel@linux.intel.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
         <CGME20170317095544epcas5p42dd4115627c9cf9de3911b433024ac93@epcas5p4.samsung.com>
         <20170317095527.10487-4-hdegoede@redhat.com> <58CF3183.4090101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <58CF3183.4090101@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2017-03-20 at 10:33 +0900, Chanwoo Choi wrote:
> On 2017년 03월 17일 18:55, Hans de Goede wrote:

> > +static const struct platform_device_id cht_wc_extcon_table[] = {
> > +	{ .name = "cht_wcove_pwrsrc" },
> 
> You use the 'cht_wc' word instead of 'cht_wcove_pwrsrc'.
> So, To maintain the consistency, you better to use the 'cht-wc' as the
> name.
> - I prefer to use '-' instead of '_' in the name.
> 	.name ="cht-wc"

I would keep as Hans did for the sake of consistency among all Whiskey
Cove device drivers (and predecessors like Crystal Cove).

I understand your point from extcon subsystem view, but PMICs like
Whiskey Cove are multi-functional devices, and thus naming across them
(same prefix in use to be precise) is better idea.

> 
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(platform, cht_wc_extcon_table);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
