From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v1 0/2] i2c: Stop i2c modules being unloaded while in use.
Date: Fri, 9 Sep 2016 22:40:37 +0200
Message-ID: <51c45bae-aa5d-bfad-e9d0-d95deb3dc380@axentia.se>
References: <1473278729-16329-1-git-send-email-jim_baxter@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473278729-16329-1-git-send-email-jim_baxter@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jim_baxter@mentor.com, linux-i2c@vger.kernel.org
Cc: Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2016-09-07 22:05, jim_baxter@mentor.com wrote:
> From: Jim Baxter <jim_baxter@mentor.com>
> 
> This patchset adds a new i2c_mux_add_reparented_adapter API to the i2c
> that allows owning modules to use module_get/module_put and stop the
> i2c bus module being removed whilst in use.
> 
> This was tested on an ARM i.MX6 Sabre board with the pca953x gpio module.
> 
> Joshua Frkuska (2):
>   i2c-mux: add i2c_mux_add_reparented_adapter api
>   i2c-mux-gpio: call i2c_add_reparented_mux_adapter

nitpick: Patch subjects for the second patch is wrong.

"reparented" is a bit dual when dealing with i2c adapter trees.
i2c_mux_add_owned_adapter is perhaps clearer?

Aside from that, I'm not using modules much and need some enlightenment
as to why the i2c_del_mux_adapter() call in i2c_mux_gpio_remove() is not
sufficient and what exactly the problem is? Why would someone/something
unload the i2c-mux module prematurely?

Would it be an alternative to make i2c-mux a proper kernel object of
some kind? I mean, why do not all other mux users also need to modify
the owner? Why is i2c-mux-gpio special?

CHeers,
Peter
