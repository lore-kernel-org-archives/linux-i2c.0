From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: struct i2c_mux_pinctrl_platform_data for the i2c-mux-pinctrl
 driver
Date: Mon, 22 May 2017 09:51:46 -0600
Message-ID: <71dc13f9-f723-fb4b-a101-f7be8caacf1c@wwwdotorg.org>
References: <264eee82-8e0f-7d63-5c2f-e4070bf56c63@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <264eee82-8e0f-7d63-5c2f-e4070bf56c63@axentia.se>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Stephen Warren <swarren@nvidia.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 05/22/2017 02:24 AM, Peter Rosin wrote:
> Hi Stephen,
> 
> I was looking at the i2c-mux-pinctrl driver and noticed that it has
> code to feed it platform data from C code. There has never been any
> in-kernel users of this interface and I would like to remove it. I
> wonder if you added it way back when just because the i2c-mux-gpio
> driver have such an interface or if, to your knowledge, any external
> platform exists that depends on this?
> 
> I.e. I'm talking about removing include/linux/i2c-mux-pinctrl.h and
> the code supporting it in the driver, thus only allowing devicetree
> as source for the platform data.

I'm not aware of any in- or out-of-tree users of that structure/feature.

I added it because at the time I wrote that driver, it was common place 
to support both DT-based and platform-data-based 
instantiation/configuration of devices, so I did the same. If you're 
removing pdata-based configuration, it would make sense to do a blanket 
removal across the entire I2C subsystem (and other subsystems too) I 
suspect, but that's LinusW's call in the end.
