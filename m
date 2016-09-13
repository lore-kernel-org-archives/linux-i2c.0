From: "Baxter, Jim" <jim_baxter@mentor.com>
Subject: Re: [PATCH v1 0/2] i2c: Stop i2c modules being unloaded while in use.
Date: Tue, 13 Sep 2016 17:55:50 +0100
Message-ID: <91828685-c7ba-b5b2-f128-240fdf9ebb44@mentor.com>
References: <1473278729-16329-1-git-send-email-jim_baxter@mentor.com>
 <51c45bae-aa5d-bfad-e9d0-d95deb3dc380@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:37916 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755321AbcIMQzz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 13 Sep 2016 12:55:55 -0400
In-Reply-To: <51c45bae-aa5d-bfad-e9d0-d95deb3dc380@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
Cc: Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, "Frkuska, Joshua" <Joshua_Frkuska@mentor.com>, jiwang <Jiada_Wang@mentor.com>

Hi Peter,

> nitpick: Patch subjects for the second patch is wrong.
>
> "reparented" is a bit dual when dealing with i2c adapter trees.
> i2c_mux_add_owned_adapter is perhaps clearer?

Agreed, I will update that.

>
>
> Aside from that, I'm not using modules much and need some enlightenment
> as to why the i2c_del_mux_adapter() call in i2c_mux_gpio_remove() is not
> sufficient and what exactly the problem is? Why would someone/something
> unload the i2c-mux module prematurely?

It is not a normal operation to remove the i2c gpio mux, however systemd
could unload modules out of order if users are restarting services
incorrectly and cause unintended side-effects. This change would stop an
i2c-mux that maybe controlling a voltage regulator from being unloaded
and disabling power to parts of the system unexpectedly.

>
>
> Would it be an alternative to make i2c-mux a proper kernel object of
> some kind? I mean, why do not all other mux users also need to modify
> the owner? Why is i2c-mux-gpio special?
>

i2c-mux-gpio is not special, the code inserted by
[PATCH v1 1/2] i2c-mux: add i2c_mux_add_reparented_adapter api could be
used by other muxes if required.

Best regards
Jim
