From: Sasha Levin <sashal@kernel.org>
Subject: Re: 4.14/4.18: Please add "eeprom: at24: Add support for
 address-width property"
Date: Mon, 5 Nov 2018 18:51:21 -0500
Message-ID: <20181105235121.GW194472@sasha-vm>
References: <20181022083835.GA5315@localhost>
 <20181031142745.GK194472@sasha-vm>
 <20181031204959.GA3691@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181031204959.GA3691@localhost>
Sender: stable-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: stable@vger.kernel.org, Alan Chiang <alanx.chiang@intel.com>, Andy Yeh <andy.yeh@intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 31, 2018 at 10:49:59PM +0200, Adrian Bunk wrote:
>On Wed, Oct 31, 2018 at 10:27:45AM -0400, Sasha Levin wrote:
>> On Mon, Oct 22, 2018 at 11:38:35AM +0300, Adrian Bunk wrote:
>> > Please cherry-pick the following commit to 4.14 and 4.18:
>> >
>> >    commit a2b3bf4846e5eed62ea6abb096af2c950961033c
>> >    Author: Alan Chiang <alanx.chiang@intel.com>
>> >    Date:   Wed Jul 25 11:20:22 2018 +0800
>> >
>> >    eeprom: at24: Add support for address-width property
>> >
>> >    Provide a flexible way to determine the addressing bits of eeprom.
>> >    Pass the addressing bits to driver through address-width property.
>> >
>> >    Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
>> >    Signed-off-by: Andy Yeh <andy.yeh@intel.com>
>> >    Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>> >
>> >
>> > Confirmed to work on 4.14 with the Identification Page
>> > of an ST M24M02-DR (256 bytes but 16 bit addressing).
>>
>> This patch doesn't look like stable material. The hardware never worked
>> before, so this is not a regression and falls under new hardware
>> enablement, but the patch is more complex than what we usually allow for
>> hardware enablement (adding various IDs/quirks/etc).
>>
>> Am I missing something?
>
>IMHO it is a pretty straightforward quirk for hardware enablement.
>
>Note that the quirk will only be used if explicitely enabled in the
>device tree, for everyone else this code is a nop.

Fair enough. I've queued it for 4.18 and 4.14.
