From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [RFC,v2 2/6] i2c: add I2C Address Translator (ATR) support
Date: Tue, 3 Sep 2019 10:48:41 +0200
Message-ID: <8482d1e2-b1d9-3da5-5b1f-b7e492a87368@lucaceresoli.net>
References: <20190723203723.11730-1-luca@lucaceresoli.net>
 <20190723203723.11730-3-luca@lucaceresoli.net> <20190902204208.GA7253@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190902204208.GA7253@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-media@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>, Vladimir Zapolskiy <vz@mleia.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 02/09/19 22:42, Wolfram Sang wrote:
> Hi Luca,
> 
>> + * Topology:
>> + *
>> + *                       Slave X @ 0x10
>> + *               .-----.   |
>> + *   .-----.     |     |---+---- B
>> + *   | CPU |--A--| ATR |
>> + *   `-----'     |     |---+---- C
>> + *               `-----'   |
>> + *                       Slave Y @ 0x10
>> + *
>> + * Alias table:
>> + *
>> + *   Client  Alias
>> + *   -------------
>> + *      X    0x20
>> + *      Y    0x30
> 
> Great that you already provided docs for this driver!
> 
> One huge drawback for me is the attach/detach callbacks. One year ago, I
> removed a similar callback from the I2C core ("[PATCH 0/2] i2c: remove
> deprecated attach_adapter callback") because some drivers did a lot of
> crazy things there. It took years to remove all that.

Oh dear, I was completely unaware, apologies! :-)

> What I could imagine here: the adapter (B and C each in the picture
> above) gets a flag like NEEDS_ATR before registering to the core. The
> flag means all clients on that bus will have their address translated.
> The core will figure out a free alias when a device is registered. We
> can then have an ATR specific callback with the original and translated
> address as arguments, so one can setup the HW as needed.

Do you mean moving the alias selection code from i2c-atr.c to the i2c
core? And the rest of the ATR core too?

> Do you think that would work?

Yes.

-- 
Luca
