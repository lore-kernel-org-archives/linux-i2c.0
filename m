From: Cengiz Can <cengiz@kernel.wtf>
Subject: Re: [PATCH] i2c: pca954x: Add property to skip disabling PCA954x
 MUX device
Date: Sun, 29 Sep 2019 14:07:19 +0300
Message-ID: <2a3f9ec1955e8b785888994e2a9b7cc0d5800a71.camel@kernel.wtf>
References: <20190929103638.46038-1-biwen.li@nxp.com>
Reply-To: cengiz@kernel.wtf
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190929103638.46038-1-biwen.li@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Biwen Li <biwen.li@nxp.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, peda@axentia.se, leoyang.li@nxp.com, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Hello Biwen,

> +       /* Errata ID E-00013 on board LS2088ARDB and LS2088ARDB:
> +        * The point here is that you must not disable a mux if there
> +        * are no pullups on the input or you mess up the I2C. This
> +        * needs to be put into the DTS really as the kernel cannot
> +        * know this otherwise.
> +        */

Can you please explain what a "mess up" is?

And also, should we put this new DTS property in related default
bindings? 

If not, are you planning a documentation update for the users to notify
them about this?

-- 
Cengiz Can <cengiz@kernel.wtf>
