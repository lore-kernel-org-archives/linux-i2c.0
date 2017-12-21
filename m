From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: at24: consistently document the
 compatible property
Date: Thu, 21 Dec 2017 11:24:22 -0600
Message-ID: <f5d14ee3-1f80-6709-c5e5-36f65c1a9b84@lechnology.com>
References: <20171221134842.31287-1-brgl@bgdev.pl>
 <20171221134842.31287-2-brgl@bgdev.pl>
 <0c2455ae-2f68-5342-14c6-14706d6f0e66@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c2455ae-2f68-5342-14c6-14706d6f0e66@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Peter Rosin <peda@axentia.se>, Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, Divagar Mohandass <divagar.mohandass@intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 12/21/2017 10:20 AM, Peter Rosin wrote:
> On 2017-12-21 14:48, Bartosz Golaszewski wrote:
>> Current description of the compatible property for at24 is quite vague.
>>
>> Specify an exact list of accepted compatibles and document the - now
>> deprecated - strings which were previously used in device tree files.
> 
> Why is it suddenly deprecated to correctly specify what hardware you
> have, e.g. "nxp,24c32". In this case the manufacturer is nxp, damnit.
> Sure, it happens to be compatible with "atmel,24c32", but that is
> supposed to be written with a fallback as
> 
> 	"nxp,24c32", "atmel,24c32"
> 
> if I understand correctly. So, why is that deprecated in this case?
> 
> What if (a few years down the line) it is discovered that some weird
> quirk is needed that is only appropriate for nxp chips?
> 
> nxp is of course just an example, pick any manufacturer of eeproms
> (supposedly) compatible with the atmel interface.
> 

So now I am supposed to change my device tree from "microchip,24c128" to 
"atmel,24c128"?

Also, at,24c08 is listed in 
Documentation/devicetree/bindings/trivial-devices.txt. It should 
probably be removed.
