From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH V2] i2c: Add generic I2C multiplexer using pinctrl API
Date: Tue, 24 Apr 2012 15:02:44 -0600
Message-ID: <4F9714F4.2060400@wwwdotorg.org>
References: <1335289664-21383-1-git-send-email-swarren@wwwdotorg.org> <20120424200929.GC30172@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120424200929.GC30172-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 04/24/2012 02:09 PM, Wolfram Sang wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/pinctrl-i2cmux.txt
>> @@ -0,0 +1,79 @@
>> +Pinctrl-based I2C Bus Mux
>> +
>> +This binding describes an I2C bus multiplexer that uses pin multiplexing to
>> +route the I2C signals, and represents the pin multiplexing configuration
>> +using the pinctrl device tree bindings.
>> +
>> +Required properties:
>> +- compatible: pinctrl-i2cmux
> 
> From what I know, compatible-properties should not be linux-specific
> since devicetrees are OS independent. pinctrl-i2cmux sounds
> linux-specific to me.
> 
> So, is such a binding acceptable meanwhile?

To my mind, "pinctrl" has two meanings: (1) is the Linux internal API
(2) is the pinctrl bindings in
Documentation/devicetree/bindings/pinctrl, which were admittedly
developed strongly based on Linux's pinctrl API needs, but I believe
should be completely agnostic to the pinctrl API, SW, OS, etc., and
hence can be considered a pure representation of hardware.

As such, the "pinctrl" in "pinctrl-i2cmux" above refers to (2) above,
and can be considered a pure HW/binding term.
