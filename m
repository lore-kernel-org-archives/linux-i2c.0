From: Peter Rosin <peda@axentia.se>
Subject: Re: Getting at gpio- and pinctrl-devices as a consumer
Date: Fri, 25 Nov 2016 10:24:33 +0100
Message-ID: <45787444-a237-7363-5f03-0cd207cb82c2@axentia.se>
References: <1479908035-18284-1-git-send-email-peda@axentia.se>
 <20161124151420.GF4271@katana>
 <46be889f-a558-0174-f638-c685b23c8ed9@axentia.se>
 <20161124195230.GA1666@katana>
 <b481ed92-c9d2-b4da-b484-6d8bec6038f0@axentia.se>
 <CACRpkdb0cdvxgnuOBNfdY+idVcTXMwzKRYfCsFpiRx2qaVrt=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdb0cdvxgnuOBNfdY+idVcTXMwzKRYfCsFpiRx2qaVrt=w@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa-dev@sang-engineering.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2016-11-25 00:29, Linus Walleij wrote:
> On Thu, Nov 24, 2016 at 10:35 PM, Peter Rosin <peda@axentia.se> wrote:
> 
>> The background is that the gpio- and pinctrl-based i2c-mux drivers
>> need to know if the device that is used to control the mux of the
>> i2c-bus is also sitting on that very same i2c-bus. If it is, the
>> locking has to be different and a bit more relaxed. This relaxed
>> mode cannot be used always, as that would change the mux behavior
>> in an unacceptable way for stuff expecting the (traditional)
>> stricter locking. See Documentation/i2c/i2c-topology for more
>> details if you need it.
>>
>> To check this, the i2c mux drivers dig out the device connected to
>> each gpio-pin (or pinctrl-state) and walks up the device tree to see
>> if the root i2c adapter that is muxed is in the loop.
>>
>> When I wrote this code, I could not find a clean way to go from a
>> struct gpio_desc * to the relevant device, short of doing
>>
>>         #include "../../gpio/gpiolib.h"
>>
>>         gpio_dev = &gpio_desc->gdev->dev;
>>
>> And similarly for pinctrl:
>>
>>         #include "../../pinctrl/core.h"
>>
>>         struct pinctrl_setting *setting;
>>         pinctrl_dev = setting->pctldev->dev;
>>
>> I'm not very proud of that, and wonder if there is a better way
>> to get at the needed struct device? If not, then perhaps there
>> should be?
> 
> Surely if I can be convinced that we need helpers for this
> in GPIO and/or pin control we can add them.
> 
> They just need to be named something reasonable and
> be generally useful for other situations of similar nature.
> 
> struct device *gpiod_get_backing_device(struct gpio_desc *d);
> 
> Is simple but is it really what you want?

Well, my first attempt was to simply have a property in the
devicetree stating that the mux was controlled from the same
i2c bus it was muxing, but that was shot down because it
should be possible to deduce this from the implementation (or
something of that meaning, it was a while ago), which to me
meant examining the "struct device"-tree.

For the gpio_desc it is easy. However, it is worse for the
pinctrl case. The pinctrl consumer currently deals in states,
but each state has a number of pinctrl_settings and it is
these settings that are backed by a device implementing that
state. It is in other words possibly several devices involved
with one pinctrl_state. This can be handled in in three ways
that spring to mind.

1. Return a single device connected to a pinctrl state, if it
is the same device backing all settings, and error out if more
than one device is involved. I mean, how silly would it me to
control a mux from pins not controlled by the same pinctrl?
That just seems extremely odd, like one pin each on two
different i2c-controlled io-expanders sitting on the same
i2c-bus that is also muxed using these two pins. The risk for
regression because of this should be ... low.

2. Return an array of devices, one for each pinctrl setting
connected to the state. This also needs to expose the number
of settings for a state.

3. Introduce some kind of list_for_each_entry wrapper (or
something) so that the consumer can iterate over the settings
connected to a state, coupled with a function to get the
struct device from a setting.

#1 is not as generally useful as #2 or #3, as it assumes
that the corner case is not interesting. But it might very
well be the case that the next user is looking for exactly
this corner case. But at the same time, the next user isn't
here yet, at least not that I know of...

#2 and #3 exposes more of the internals to the consumer, since
the consumer currently does not need to worry about neither
the number of settings connected to a state nor that fact
that there are settings at all. #3 would be closest to the
current implementation in i2c-mux-pinctrl (included below).

So, for the case in question I deem #1 good enough, and it
exposes less of the internals. But #2 or #3 might be better for
the next case, and also makes the current case not risk the
unlikely regression. Any preference?

Cheers,
Peter


static struct i2c_adapter *i2c_mux_pinctrl_root_adapter(
	struct pinctrl_state *state)
{
	struct i2c_adapter *root = NULL;
	struct pinctrl_setting *setting;
	struct i2c_adapter *pin_root;

	list_for_each_entry(setting, &state->settings, node) {
		pin_root = i2c_root_adapter(setting->pctldev->dev);
		if (!pin_root)
			return NULL;
		if (!root)
			root = pin_root;
		else if (root != pin_root)
			return NULL;
	}

	return root;
}
