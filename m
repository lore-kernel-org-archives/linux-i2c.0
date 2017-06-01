From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2] i2c: i2c-mux: Fix channel parent node assignment
Date: Thu, 1 Jun 2017 20:58:20 +0200
Message-ID: <bd856a68-aa3b-2a51-a6a7-a95e6b3f6c8a@axentia.se>
References: <1496134457-19573-1-git-send-email-jacopo+renesas@jmondi.org>
 <5de6a678-e646-3acb-2346-8a1d76ebbf9d@axentia.se>
 <20170531075126.GC19019@w540>
 <ef5b3b0a-52c7-785f-6faf-47d9b40f89cc@axentia.se>
 <20170601021924.GB13970@w540>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170601021924.GB13970@w540>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: jmondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2017-06-01 04:19, jmondi wrote:
>> But why do you need to identify them? What problem are you trying to solve?
>>
> I want to be able to walk all children devices of an i2c-adapter,
> not including the mux channel i2c-adapters. I'm sure I can work around it.
> While doing that I stumbled upon this and thought it was wrong.

Hey, I'm not saying that the current (ab?)use of dev->parent for the
i2c hierarchy is "right". But fixing things is simply just more involved
than what you proposed.

Some random thoughts on this topic:

- I'm not sure it is sane to rearrange the device hierarchy the way the
  i2c mux code does, and the i2c hierarchy is available by other means
  as parent in struct i2c_mux_core. The trouble is getting to that struct
  from outside the owner driver. Maybe make i2c_mux_alloc create a
  separate device? Then all i2c muxes could store their copy of struct
  i2c_mux_core in a way that could be easily found by generic code.
- Is it ok to add children to unsuspecting(?) devices? (I.e. the parent
  adapter of an i2c mux gets extra children.)
- I think the current scheme prevents the parent adapter from going away
  before the mux child adapter during tare-down, which is a good thing,
  but I think that can be solved with these new device links that I read
  about?
- The i2c hierarchy also needs to be visible in sysfs, which it is with
  the current scheme (but not with your patch) so some kind of new
  i2c-parent attribute is needed for i2c mux child adapters.
- Changes in this area feel subtle, and needs testing...

Cheers,
peda
