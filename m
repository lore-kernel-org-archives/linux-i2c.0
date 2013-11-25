From: Michael Lawnick <ml.lawnick@gmx.de>
Subject: Re: [PATCH] i2c-mux-pca954x: Disable mux after 200ms timeout
Date: Mon, 25 Nov 2013 15:54:36 +0100
Message-ID: <529364AC.8000305@gmx.de>
References: <1385387037-3710-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385387037-3710-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Am 25.11.2013 14:43, schrieb Mike Looijmans:
> Leaving the mux enabled causes needless I2C traffic on the downstream
> bus. De-selecting after every request causes excess I2C traffic and
> switching.
>
> This patch implements a hybrid solution: After 200ms of inactivity,
> the mux is disabled.
...

Have you checked against behavior on cascaded muxes?
At least your desired timing will not look as expected.
200 ms: disable mux1
201 ms: enable mux1 - disable mux2
202 ms: enable mux2 - disable mux3
401 ms: disable mux1
402 ms: enable mux1 - disable mux2
602 ms: disable mux1
And on full second temperature sensor behind mux3 is read again ...

KR
Michael
