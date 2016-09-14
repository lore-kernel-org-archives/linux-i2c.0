From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v1 0/2] i2c: Stop i2c modules being unloaded while in use.
Date: Wed, 14 Sep 2016 14:57:50 +0200
Message-ID: <0b0402e3-6092-330e-afa9-375ab8166fcb@axentia.se>
References: <1473278729-16329-1-git-send-email-jim_baxter@mentor.com>
 <51c45bae-aa5d-bfad-e9d0-d95deb3dc380@axentia.se>
 <91828685-c7ba-b5b2-f128-240fdf9ebb44@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <91828685-c7ba-b5b2-f128-240fdf9ebb44@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Baxter, Jim" <jim_baxter@mentor.com>, linux-i2c@vger.kernel.org
Cc: Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, "Frkuska, Joshua" <Joshua_Frkuska@mentor.com>, jiwang <Jiada_Wang@mentor.com>
List-Id: linux-i2c@vger.kernel.org

Hi Jim!

On 2016-09-13 18:55, Baxter, Jim wrote:
> Hi Peter,
> 
>> nitpick: Patch subjects for the second patch is wrong.
>>
>> "reparented" is a bit dual when dealing with i2c adapter trees.
>> i2c_mux_add_owned_adapter is perhaps clearer?
> 
> Agreed, I will update that.
> 
>>
>>
>> Aside from that, I'm not using modules much and need some enlightenment
>> as to why the i2c_del_mux_adapter() call in i2c_mux_gpio_remove() is not
>> sufficient and what exactly the problem is? Why would someone/something
>> unload the i2c-mux module prematurely?
> 
> It is not a normal operation to remove the i2c gpio mux, however systemd
> could unload modules out of order if users are restarting services
> incorrectly and cause unintended side-effects. This change would stop an
> i2c-mux that maybe controlling a voltage regulator from being unloaded
> and disabling power to parts of the system unexpectedly.

I don't see how that can happen. The voltage regulator that sits behind
the mux should be a user of one of the child adapters on the mux, so that
child adapter can't be removed as long as the voltage regulator is there.
And the i2c-mux can't be unloaded as long as the child adapter is there,
since it is the owner. So what's going on?

Simply changing the owner of the child adapter will break this chain
leaving the i2c-mux as owner of nothing, thus *making* it a target for
premature unloading.

I must be fundamentally misunderstanding something.

BTW, was this solving a real issue, or is it all theory?

Cheers,
Peter

>> Would it be an alternative to make i2c-mux a proper kernel object of
>> some kind? I mean, why do not all other mux users also need to modify
>> the owner? Why is i2c-mux-gpio special?
>>
> 
> i2c-mux-gpio is not special, the code inserted by
> [PATCH v1 1/2] i2c-mux: add i2c_mux_add_reparented_adapter api could be
> used by other muxes if required.
