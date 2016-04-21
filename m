From: Antti Palosaari <crope@iki.fi>
Subject: Re: [PATCH v7 00/24] i2c mux cleanup and locking update
Date: Thu, 21 Apr 2016 04:10:59 +0300
Message-ID: <571828A3.7090007@iki.fi>
References: <1461165484-2314-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461165484-2314-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Jiri Slaby <jslaby@suse.com>, Daniel Baluta <daniel.baluta@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Adriana Reus <adriana.reus@intel.com>, Matt Ranostay <matt.ranostay@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Hans
List-Id: linux-i2c@vger.kernel.org

On 04/20/2016 06:17 PM, Peter Rosin wrote:

Retested all the previously tested + now I tested also cx231xx with 
Hauppauge 930C HD device having eeprom other mux port and demod on the 
other port.

>    [media] si2168: change the i2c gate to be mux-locked
>    [media] m88ds3103: convert to use an explicit i2c mux core
>    [media] rtl2830: convert to use an explicit i2c mux core
>    [media] rtl2832: convert to use an explicit i2c mux core
>    [media] si2168: convert to use an explicit i2c mux core
>    [media] cx231xx: convert to use an explicit i2c mux core
>    [media] rtl2832: change the i2c gate to be mux-locked
>    [media] rtl2832_sdr: get rid of empty regmap wrappers
>    [media] rtl2832: regmap is aware of lockdep, drop local locking hack

I really hope that this whole patch series will arrive asap to mainline.

regards
Antti

-- 
http://palosaari.fi/
